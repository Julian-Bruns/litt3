#!/usr/bin/env sage-python
"""Independent nested-quadratic Laurent replay of the twelve backup jets.

This does not import either jet producer. Cochains are elements of the
nested quotient Laurent algebra, and the scalar is obtained from a ratio
of full determinants rather than the producer's Schur-vector recurrence.
"""
import argparse
import hashlib
import json
from itertools import combinations
from math import comb, factorial
from pathlib import Path
import time

from sage.all import GF, LaurentPolynomialRing, PolynomialRing, PowerSeriesRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', required=True)
    ap.add_argument('--case', type=int, action='append')
    args = ap.parse_args()
    started = time.monotonic()
    root = Path(__file__).resolve().parents[2]
    data = root / 'Research' / 'computations'
    prime = GF(5)
    zz = PolynomialRing(prime, 'z')
    k = GF(125, name='alpha', modulus=zz([1, 1, 0, 1]))
    alpha = k.gen()
    base = PolynomialRing(k, 'u0')
    u0 = base.gen()
    F0 = u0*(u0-1)*(u0-2)*(u0-3)*(u0-alpha)
    finite_roots = [k(0), k(1), k(2), k(3), alpha]
    subsets = [(i,) for i in range(5)] + list(combinations(range(5), 2))
    pair = lambda index: base.prod([u0-finite_roots[j] for j in subsets[index]])
    decode = lambda a: sum((k(c)*alpha**i for i, c in enumerate(a)), k(0))
    encode = lambda a: [int(k(a).polynomial()[i]) for i in range(3)]
    taylor = PolynomialRing(k, 's')
    s = taylor.gen()
    series = PowerSeriesRing(k, 's', default_prec=5)
    results = []
    tablepath = data / 'backup_active_twist_table.json'
    table = json.loads(tablepath.read_text())
    pairs = [(r, tw) for r in table['bad_records'] for tw in r['bad_twists']]
    assert len(pairs) == 12
    files = {str(tablepath): hashlib.sha256(tablepath.read_bytes()).hexdigest()}
    selected = args.case if args.case is not None else range(12)

    for case_id in selected:
        tic = time.monotonic()
        record, twist = pairs[case_id]
        path = data / ('backup_bad_double_jet_%d.json' % case_id)
        expected = json.loads(path.read_text())
        files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        source = pair(record['source'])
        source_S = F0 // source
        if record['kind'] == 'branch':
            A0 = (source_S*source**2)[4]*source_S
        else:
            h = 3*alpha
            J = source.derivative()*source_S + 2*source*source_S.derivative()
            D = source*source_S**2
            K = base([k(comb(i, 6))*D[i] for i in range(6, D.degree()+1)])
            assert J(h) == 0 and K(h) != 0
            A0 = K(h)*source*(u0-h)**2
        R0 = pair(twist['target'])
        S0 = F0 // R0
        assert [decode(c) for c in expected['A']] == A0.list()
        assert [decode(c) for c in expected['R']] == R0.list()
        assert R0.gcd(S0) == 1 and R0.is_squarefree() and S0.is_squarefree()
        cartier = F0**2*A0**4
        assert all(cartier[5*i+4] == A0[i]**5 for i in range(5))

        # A different exact representation from the sparse four-component
        # dictionaries used by the producer: nested Sage quotient algebras.
        laurent = LaurentPolynomialRing(k, 'u')
        u = laurent.gen()
        eval_u = lambda f: sum((laurent(c)*u**i for i, c in enumerate(f)), laurent(0))
        R, S, A = eval_u(R0), eval_u(S0), eval_u(A0)
        pkap = PolynomialRing(laurent, 'K')
        kapring = pkap.quotient(pkap.gen()**2-R, 'kap')
        kap = kapring.gen()
        pell = PolynomialRing(kapring, 'L')
        curve = pell.quotient(pell.gen()**2-kapring(S), 'ell')
        ell = curve.gen()
        kapp = curve(kap)
        v = kapp*ell
        chars = [curve(1), kapp, ell, v]
        basis_indices = [(3,-1),(3,-2),(3,-3),(2,-1),(1,-1),(2,-2)]
        basis = [chars[i]*u**j for i,j in basis_indices]
        picard = [v/u, v/u**2, ell/u]
        direct_frobenius = [b**5 for b in picard]
        initial = [curve(A)*b**5 for b in basis]
        limits = [-1,-2,-3,-4]

        def components(value):
            outer = value.list() + [kapring(0)]*2
            result = [laurent(0)]*4
            for j in range(2):
                inner = outer[j].list() + [laurent(0)]*2
                result[2*j] = inner[0]
                result[2*j+1] = inner[1]
            return result

        def split(value):
            cs = components(value)
            cohom = [cs[i][j] for i,j in basis_indices]
            infinity = curve(0)
            for i in range(4):
                negative = sum((co*u**int(exp) for exp,co in cs[i].dict().items()
                                if int(exp) <= limits[i]), laurent(0))
                infinity += chars[i]*negative
            return cohom, infinity

        constant = matrix(k, 6, 6, lambda i,j: split(initial[j])[0][i], implementation='generic')
        expected_constant = matrix(k, [[decode(c) for c in row]
                                      for row in expected['matrix_jet']['0,0,0']], implementation='generic')
        assert constant == expected_constant and constant.rank() == 5
        second = constant*matrix(k, [[c**5 for c in row] for row in constant.rows()],
                                 implementation='generic')
        assert second.rank() == 5
        # Check H1(O) independently from actual fifth powers in the algebra.
        frob = matrix(k, [[components(f)[i][j] for f in direct_frobenius]
                          for i,j in [(3,-1),(3,-2),(2,-1)]], implementation='generic')
        assert frob.det() and frob == matrix(k, [[decode(c) for c in row]
                                                for row in expected['H1O_frobenius']], implementation='generic')

        goodrows, goodcols = expected['good_rows'], expected['good_columns']
        kr, kc = expected['exceptional_row'], expected['exceptional_column']
        assert constant.matrix_from_rows_and_columns(goodrows, goodcols).det() != 0
        # The actual hyperelliptic involution negates ell and fixes kap.
        # Its exceptional source and target characters coincide, so the
        # scalar determinant quotient is even in the Picard coordinates.
        characters = [-1,-1,-1,-1,1,-1]
        assert characters[kr] == characters[kc]
        for key, mat in expected['matrix_jet'].items():
            parity = (-1)**sum(map(int,key.split(',')))
            assert all(not decode(mat[i][j]) or characters[i]*characters[j] == parity
                       for i in range(6) for j in range(6))
        assert all(not decode(value) for key,value in expected['scalar_jet'].items()
                   if sum(map(int,key.split(','))) in (0,1,3))

        def direction_jet(direction):
            displacement = sum((curve(direction[i])*direct_frobenius[i] for i in range(3)), curve(0))
            exponentials = [curve(1)] + [displacement**n/k(factorial(n)) for n in range(1,5)]
            mats = [matrix(k, 6, 6, implementation='generic') for _ in range(5)]
            for col in range(6):
                residuals = []
                for n in range(5):
                    value = initial[col] if n == 0 else -sum(
                        (exponentials[j]*residuals[n-j] for j in range(1,n+1)), curve(0))
                    cohom, infinity = split(value)
                    residuals.append(infinity)
                    for row in range(6):
                        mats[n][row,col] = cohom[row]
            # Replay all full-matrix coefficients in each tested direction.
            for n in range(5):
                stored = matrix(k,6,6,implementation='generic')
                for key, mat in expected['matrix_jet'].items():
                    powers = tuple(map(int,key.split(',')))
                    if sum(powers) == n:
                        coefficient = k.prod(direction[i]**powers[i] for i in range(3))
                        stored += coefficient*matrix(k,[[decode(c) for c in row] for row in mat],
                                                     implementation='generic')
                assert mats[n] == stored, (case_id, direction, n, 'matrix mismatch')
            polynomial_matrix = matrix(taylor,6,6,lambda i,j:
                sum((mats[n][i,j]*s**n for n in range(5)),taylor(0)))
            determinant = polynomial_matrix.det()
            block = polynomial_matrix.matrix_from_rows_and_columns(goodrows, goodcols).det()
            scalar = ((-1)**(kr+kc))*series(determinant)/series(block)
            answer = [scalar[n] for n in range(5)]
            for n in range(5):
                predicted = k(0)
                for key, val in expected['scalar_jet'].items():
                    powers = tuple(map(int,key.split(',')))
                    if sum(powers) == n:
                        predicted += decode(val)*k.prod(direction[i]**powers[i] for i in range(3))
                assert answer[n] == predicted, (case_id, direction, n, 'scalar mismatch')
            assert answer[0] == answer[1] == answer[3] == 0
            return answer

        directions = [tuple(k(i==j) for i in range(3)) for j in range(3)]
        directions += [tuple(k(int(i==a or i==b)) for i in range(3))
                       for a,b in combinations(range(3),2)]
        directions += [(k(1),k(1),k(1)),(k(1),alpha,alpha**2)]
        values = [direction_jet(v) for v in directions]
        hess = matrix(k,3,3,implementation='generic')
        for i in range(3):
            hess[i,i] = 2*values[i][2]
        for index,(i,j) in enumerate(combinations(range(3),2)):
            hess[i,j] = hess[j,i] = values[3+index][2]-values[i][2]-values[j][2]
        assert hess == matrix(k,[[decode(c) for c in row] for row in expected['hessian']],
                              implementation='generic')
        assert hess.rank() == expected['hessian_rank']
        radial = None
        if hess.rank() == 2:
            radical = tuple(hess.right_kernel().basis()[0])
            radial = direction_jet(radical)[4]
            assert radial != 0 and radial == decode(expected['radial_quartic'])
            assert list(radical) == [decode(c) for c in expected['radical'][0]]
        else:
            assert hess.det() != 0
        result = dict(case=case_id, kind=record['kind'], source=record['source'],
                      target=twist['target'], degree_R=int(R0.degree()), degree_S=int(S0.degree()),
                      constant_rank=5, second_semilinear_rank=5,
                      hessian_rank=int(hess.rank()), hessian_determinant=encode(hess.det()),
                      radial_quartic=None if radial is None else encode(radial),
                      full_matrix_directional_replays=len(directions)+(radial is not None),
                      seconds=time.monotonic()-tic)
        results.append(result)
        print(json.dumps(result), flush=True)
    length_checks = []
    normal_ring = PolynomialRing(prime, names=('U','V','W'))
    U,V,W = normal_ring.gens()
    for exponent in (2,4):
        for q in (5,25,125):
            ideal = normal_ring.ideal([U*V+W**exponent,U**q,V**q,W**q])
            length = int(ideal.vector_space_dimension())
            predicted = (3*q*q-1)//2 if exponent == 2 else (7*q*q-3)//4
            assert length == predicted
            length_checks.append(dict(exponent=exponent,q=q,length=length))
    print(json.dumps(dict(normal_form_quotient_length_checks=length_checks)), flush=True)
    report = dict(status='PASS', method='nested quadratic Laurent algebra; scalar determinant quotient',
                  cases=results, source_sha256=files, normal_form_quotient_lengths=length_checks,
                  seconds=time.monotonic()-started,
                  scope='Independent arithmetic replay; geometric interpretation audited separately.')
    Path(args.output).write_text(json.dumps(report,indent=2)+'\n')
    print('ALL INDEPENDENT ASSERTIONS PASSED', flush=True)


if __name__ == '__main__':
    main()
