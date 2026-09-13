#!/usr/bin/env sage-python
"""Exact Picard four-jets for all twelve bad active doubles at the backup.

Reuses the already certified Laurent quotient, but rebuilds the actual
quadratic extension, injection and independent row/column Schur pivots.
The output is a finite local-germ computation, not a common-cover exclusion.
"""
import argparse
import importlib.util
import json
from itertools import combinations
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True)
    parser.add_argument('--twist', type=int, choices=[6, 10], default=6)
    parser.add_argument('--case-id', type=int, help='One of the 12 bad pairs in the complete backup table')
    args = parser.parse_args()
    start = time.monotonic()
    location = Path(__file__).with_name('parameterized_bad_double_four_jet.py')
    spec = importlib.util.spec_from_file_location('quartic', location)
    jet = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(jet)
    p = PolynomialRing(GF(5), 'z')
    k = GF(125, name='a', modulus=p([1, 1, 0, 1]))
    t = k.gen()
    ring = PolynomialRing(k, 'u')
    u = ring.gen()
    F = u*(u-1)*(u-2)*(u-3)*(u-t)
    roots = [k(0), k(1), k(2), k(3), t]
    pairs = [(i,) for i in range(5)] + list(combinations(range(5), 2))
    source, kind, target = 4, 'mixed', args.twist
    if args.case_id is not None:
        table = json.loads(Path('Research/computations/backup_active_twist_table.json').read_text())
        cases = [(record, twist) for record in table['bad_records'] for twist in record['bad_twists']]
        assert len(cases) == 12
        record, twist = cases[args.case_id]
        source, kind, target = record['source'], record['kind'], twist['target']
    root_pair = ring.one()
    for i in pairs[source]:
        root_pair *= u-roots[i]
    S0 = F//root_pair
    D0 = root_pair*S0**2
    J0 = root_pair.derivative()*S0+2*root_pair*S0.derivative()
    K0 = sum(k(D0[i])*k(comb(i, 6))*u**(i-6)
             for i in range(6, D0.degree()+1))
    if kind == 'mixed':
        assert source == 4
        h = 3*t
        assert J0(h) == 0 and K0(h) != 0
        A = K0(h)*root_pair*(u-h)**2
    else:
        assert kind == 'branch'
        A = (S0*root_pair**2)[4]*S0
    C = F**2*A**4
    assert all(C[5*i+4] == A[i]**5 for i in range(5))
    R = ring.one()
    for i in pairs[target]:
        R *= u-roots[i]
    S = F//R
    assert R.is_squarefree() and S.is_squarefree() and R.gcd(S) == 1
    encode_polynomial = lambda f: {int(i): f[i] for i in range(f.degree()+1) if f[i]}
    jet.P = jet.K = k
    jet.zero, jet.one = k.zero(), k.one()
    # SymPy's field.zero is a value; Sage's field.zero is a method.
    jet.mv = lambda matrix, vector: [sum((a*b for a, b in zip(row, vector)), k.zero())
                                    for row in matrix]
    jet.R, jet.S, jet.F, jet.A = map(encode_polynomial, [R, S, F, A])
    jet.factors = [{0: k.one()}, jet.R, jet.S, jet.F]
    jet.H = [jet.cmono(i, jet.conv(jet.A, jet.ppow(jet.factors[i], 2)), 5*j)
             for i, j in jet.basis]
    jet.D = [jet.cmono(3, jet.ppow(jet.F, 2), -5),
             jet.cmono(3, jet.ppow(jet.F, 2), -10),
             jet.cmono(2, jet.ppow(jet.S, 2), -5)]
    matrices = jet.all_matrices(4)
    origin = (0, 0, 0)
    M0 = matrices[origin]
    pivots = None
    for rows in combinations(range(6), 5):
        for cols in combinations(range(6), 5):
            B = [[M0[i][j] for j in cols] for i in rows]
            if jet.determinant(B):
                pivots = list(rows), list(cols), jet.inv(B)
                break
        if pivots:
            break
    assert pivots and not jet.determinant(M0)
    rows, cols, Bi = pivots
    kr = next(i for i in range(6) if i not in rows)
    kc = next(i for i in range(6) if i not in cols)
    repairs, scalar = {}, {}
    for m, M in matrices.items():
        rhs = [M[i][kc] for i in rows]
        for s, mat in matrices.items():
            if sum(s) and all(s[i] <= m[i] for i in range(3)):
                diff = tuple(m[i]-s[i] for i in range(3))
                extra = jet.mv([[mat[i][j] for j in cols] for i in rows], repairs[diff])
                rhs = [x+y for x, y in zip(rhs, extra)]
        repairs[m] = [-x for x in jet.mv(Bi, rhs)]
        value = M[kr][kc]
        for s, mat in matrices.items():
            if all(s[i] <= m[i] for i in range(3)):
                diff = tuple(m[i]-s[i] for i in range(3))
                value += sum((mat[kr][j]*repairs[diff][i] for i, j in enumerate(cols)), k.zero())
        scalar[m] = value
    assert scalar[origin] == 0
    enc = lambda a: [int(c) for c in k(a).polynomial().list()] + [0]*(3-len(k(a).polynomial().list()))
    key = lambda m: ','.join(map(str, m))
    hessian = [[k.zero() for _ in range(3)] for _ in range(3)]
    for i in range(3):
        for j in range(i, 3):
            exp = [0, 0, 0]
            exp[i] += 1
            exp[j] += 1
            hessian[i][j] = hessian[j][i] = scalar[tuple(exp)]*(2 if i == j else 1)
    Hess = matrix(k, hessian, implementation='generic')
    radical = Hess.right_kernel().basis()
    assert Hess.rank() in (2, 3)
    radial_quartic = None
    if radical:
        assert len(radical) == 1
        v = radical[0]
        radial_quartic = sum((co*v[0]**m[0]*v[1]**m[1]*v[2]**m[2]
                              for m, co in scalar.items() if sum(m) == 4), k.zero())
    obasis = [(3, -1), (3, -2), (2, -1)]
    Frob = matrix(k, [[jet.D[j][component].get(exponent, k.zero())
                      for j in range(3)] for component, exponent in obasis], implementation='generic')
    assert Frob.det() != 0
    Mconstant = matrix(k, M0, implementation='generic')
    simple_zero = (Mconstant*matrix(k, [[c**5 for c in row] for row in M0],
                                   implementation='generic')).rank() == 5
    result = {
        'status': 'executed exact finite four-jet',
        'parameter_modulus': [1, 1, 0, 1], 'twist_index': target,
        'source_index': source, 'kind': kind, 'case_id': args.case_id,
        'A': [enc(c) for c in A.list()], 'R': [enc(c) for c in R.list()],
        'basis': [[int(i), int(j)] for i, j in jet.basis],
        'good_rows': rows, 'good_columns': cols,
        'exceptional_row': kr, 'exceptional_column': kc,
        'constant_good_determinant': enc(jet.determinant([[M0[i][j] for j in cols] for i in rows])),
        'scalar_jet': {key(m): enc(v) for m, v in scalar.items()},
        'matrix_jet': {key(m): [[enc(v) for v in row] for row in mat] for m, mat in matrices.items()},
        'hessian': [[enc(v) for v in row] for row in hessian],
        'hessian_determinant': enc(jet.determinant(hessian)),
        'hessian_rank': int(Hess.rank()),
        'radical': [[enc(c) for c in v] for v in radical],
        'radial_quartic': None if radial_quartic is None else enc(radial_quartic),
        'H1O_frobenius': [[enc(c) for c in row] for row in Frob.rows()],
        'simple_zero': bool(simple_zero),
        'odd_degrees_vanish': all(not v for m, v in scalar.items() if sum(m) % 2),
        'seconds': time.monotonic()-start,
        'scope': 'Actual Laurent/Picard presentation using the existing geometric dictionary; no higher Witt claim or common-source conclusion.'
    }
    Path(args.output).write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({key: result[key] for key in ['status', 'case_id', 'kind', 'source_index',
        'twist_index', 'hessian_rank', 'hessian_determinant', 'radial_quartic',
        'simple_zero', 'odd_degrees_vanish', 'seconds']}, indent=2))


if __name__ == '__main__':
    main()
