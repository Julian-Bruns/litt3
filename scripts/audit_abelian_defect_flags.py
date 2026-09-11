#!/usr/bin/env sage-python
"""Bounded independent audit of the abelian flag input receipts.

Rebuilds the actual H1(O) Frobenius matrix directly from F and S, checks
all geometric AS directions/planes against the audited quadratic jets,
and recomputes the symbolic obstruction without importing either producer.
Does not recompute the upstream Picard four-jets.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    tic = time.monotonic()
    data = Path(__file__).resolve().parents[1] / 'Research/computations'
    receipt_path = data / 'backup_bad_double_cyclic_directions.json'
    receipt = json.loads(receipt_path.read_text())
    prime = GF(5)
    pr = PolynomialRing(prime, 'z')
    ext = GF(5**12, name='b', modulus=pr(receipt['coefficient_field_modulus']))
    beta = ext.gen()
    dec = lambda coeff: sum((ext(c)*beta**i for i,c in enumerate(coeff)), ext.zero())
    alpha = dec(receipt['alpha_embedding'])
    assert alpha**3 + alpha + 1 == 0
    assert alpha not in prime
    dec3 = lambda coeff: sum((ext(c)*alpha**i for i,c in enumerate(coeff)), ext.zero())
    pol = PolynomialRing(ext, 'u')
    u = pol.gen()
    f = u*(u-1)*(u-2)*(u-3)*(u-alpha)
    fsq = f*f
    fixed_directions = []
    for vec in itertools.product(range(5), repeat=3):
        if any(vec) and next(c for c in vec if c) == 1:
            fixed_directions.append(vec)
    assert len(fixed_directions) == 31
    cases = []
    for rec in receipt['cases']:
        path = data / ('backup_bad_double_jet_%d.json' % rec['case'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == rec['input_sha256']
        raw = json.loads(path.read_text())
        rr = pol([dec3(c) for c in raw['R']])
        ss, rem = f.quo_rem(rr)
        assert not rem
        # Exact Laurent H1(O): v/u, v/u^2, ell/u. No jet engine.
        frob = matrix(ext, [[fsq[4],fsq[9],0],
                           [fsq[3],fsq[8],0],
                           [0,0,(ss*ss)[4]]], implementation='generic')
        assert frob == matrix(ext, [[dec3(c) for c in row]
                                    for row in raw['H1O_frobenius']],
                              implementation='generic')
        assert frob.det()
        basis = [vector(ext, [dec(c) for c in row]) for row in rec['as_basis']]
        assert matrix(ext, basis, implementation='generic').det()
        assert all(frob*vector(ext,[c**5 for c in v]) == v for v in basis)
        quad = {tuple(map(int,key.split(','))):dec3(c)
                for key,c in raw['scalar_jet'].items()
                if sum(map(int,key.split(','))) == 2}
        def evaluate(v):
            return sum((c*ext.prod(v[i]**power[i] for i in range(3))
                        for power,c in quad.items()),ext.zero())
        def ash(coords):
            return sum((ext(c)*v for c,v in zip(coords,basis)),vector(ext,[0,0,0]))
        recorded = {tuple(rec['coefficients']):rec for rec in rec['directions']}
        assert set(recorded) == set(fixed_directions)
        positive = negative = 0
        for coeff in fixed_directions:
            v = ash(coeff)
            vv = vector(ext,[c**5 for c in v])
            value = evaluate(vv)
            assert value and value == dec(recorded[coeff]['quadratic'])
            assert list(v) == [dec(c) for c in recorded[coeff]['ash']]
            assert list(vv) == [dec(c) for c in recorded[coeff]['picard']]
            assert vv == matrix(ext,3,3,lambda i,j:frob[i,j]**5,
                                implementation='generic')*vector(ext,[c**5 for c in vv])
            positive += int(v[2] == 0)
            negative += int(v[0] == 0 and v[1] == 0)
        assert (positive,negative) == (6,1)
        ranks = {1:0,2:0}
        for normal in fixed_directions:
            vv = [vector(ext,[c**5 for c in ash(v)])
                  for v in matrix(prime,[normal]).right_kernel().basis()]
            # Polarization directly from the quadratic, independent of
            # the producer's stored Hessian matrix and rank calculation.
            bil = matrix(ext,2,2,lambda i,j:
                         evaluate(vv[i]+vv[j])-evaluate(vv[i])-evaluate(vv[j]),
                         implementation='generic')
            rank = bil.rank()
            is_base = all(v[2] == 0 for v in vv)
            assert (rank == 1) == (raw['kind'] == 'branch' and is_base)
            assert rank in ranks
            ranks[rank] += 1
        cases.append(dict(case=rec['case'],directions=31,
                          original_base_directions=positive,
                          original_anti_direction=negative,plane_ranks=ranks))

    generic = json.loads((data/'abelian_defect_flag_checks.json').read_text())['generic_cyclic_test']
    kk = GF(25,name='a',modulus=pr([3,0,1]))
    aa = kk.gen()
    tt = PolynomialRing(kk,'t')
    t = tt.gen()
    ff = tt.fraction_field()
    c = aa/(t+1)
    ma = 3*t*t+4*t+1
    mb = 3*t+3
    mc = 3*t*t+3*t
    md = t*t+4*t+3
    me = t*t+2*t+3
    # Clear the fixed-vector equations in one polynomial elimination.
    # s^5=A/B, s=C/D; then C^5 B-A D^5 must vanish.
    s5 = ff((me**5*c-ma**5*c**5)/mb**5)
    s1 = ff((mc**5*c**5+md**5*s5)/me**5)
    a,b = s5.numerator(),s5.denominator()
    cc,dd = s1.numerator(),s1.denominator()
    eliminated = ff((cc**5*b-a*dd**5)/(dd**5*b))
    num,den = eliminated.numerator(),eliminated.denominator()
    saved_num = tt([kk(c[0])+aa*kk(c[1]) for c in generic['numerator']])
    saved_den = tt([kk(c[0])+aa*kk(c[1]) for c in generic['denominator']])
    assert num == saved_num and den == saved_den
    assert num.degree() == 76 and num
    assert all(((t+1)*me) % factor == 0 for factor,_ in den.factor())
    # A stronger harmless observation: all numerator coefficients are
    # multiples of the SAME sqrt(2), so the criterion is over F5.
    normalized = tt(num/aa)
    assert all(c**5 == c for c in normalized)
    factored = [(str(g),int(e)) for g,e in normalized.factor()]

    lengths = []
    for s in (2,4):
        for q in (1,5,25,125):
            for r in (1,5,25,125):
                if r > q:
                    continue
                # Explicit semigroup enumeration, no quotient algebra.
                count = sum(1 for i in range(s*q) for j in range(i%s,s*q,s)
                            if i<r or j<r)
                claimed = 2*q*r-(r*r+s-1)//s
                assert count == claimed
                lengths.append(dict(s=s,q=q,r=r,length=count))
    result = dict(status='PASS',receipt_sha256=hashlib.sha256(receipt_path.read_bytes()).hexdigest(),
                  actual_direction_checks=372,actual_plane_checks=372,cases=cases,
                  symbolic_numerator_degree=int(num.degree()),
                  normalized_numerator_over_F5=str(normalized),
                  normalized_factorization=factored,semigroup_counts=lengths,
                  seconds=time.monotonic()-tic,
                  scope='Independent actual H1(O)/AS and flag replay; no re-audit of upstream Picard jets.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({key:result[key] for key in ('status','actual_direction_checks',
          'actual_plane_checks','symbolic_numerator_degree','seconds')},indent=2))


if __name__ == '__main__':
    main()
