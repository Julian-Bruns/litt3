#!/usr/bin/env sage -python
"""Bounded algebra test for the trivial-determinant spectral cover.

This does not assert that a BT1 on the original curve exists, or that
all determinant characters are covered by this untwisted calculation.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--output', type=Path, required=True)
args = ap.parse_args()
root = Path(__file__).resolve().parents[2]
if args.output.resolve().is_relative_to(root):
    ap.error('Write computation artifacts outside the workspace')
started = time.monotonic()
F5 = GF(5)
U = PolynomialRing(F5, 'a')
aa = U.gen()
k = GF(125, name='a', modulus=aa**3+aa+1)
a = k.gen()
R = PolynomialRing(k, names=('q0','q1','q2','inv'), order='degrevlex')
q0,q1,q2,iv = R.gens()
P = PolynomialRing(R, 'x')
x = P.gen()
f = x*(x-1)*(x-2)*(x-3)*(x-a)
q = q0+q1*x+q2*x*x
expansion = f*f*q*q*q
eq = [expansion[5*i+4] - (q0,q1,q2)[i]**5 for i in range(3)]
g2 = (f*q)**2
cartier5 = matrix(R, 3, 3,
                  [g2[5*i+4-j] for i in range(3) for j in range(3)])
determinant = cartier5.det()
smooth = q2*(q1*q1-4*q0*q2)*f.resultant(q)
bad = R.ideal(eq+[determinant,iv*smooth-1])
print('Computing logarithmic/nonordinary smooth spectral-cover ideal', flush=True)
gb = bad.groebner_basis()
certificate = None
if list(gb) == [R.one()]:
    lift = list(R.one().lift(bad))
    if sum(c*g for c,g in zip(lift,bad.gens())) != 1:
        raise AssertionError('Lift is not an identity')
    def code(c):
        pp = list(k(c).polynomial())
        return sum(int(v)*5**i for i,v in enumerate(pp))
    def terms(p):
        return [[list(e),code(c)] for e,c in sorted(p.dict().items())]
    certificate = {'generators': [terms(g) for g in bad.gens()],
                   'multipliers': [terms(c) for c in lift]}
smooth_ideal = R.ideal(eq+[iv*smooth-1])
smooth_length = int(smooth_ideal.vector_space_dimension())
out = {'field': 'F5[a]/(a^3+a+1)',
       'equations': [str(e) for e in eq],
       'cartier_matrix_fifth_power': [[str(c) for c in row] for row in cartier5],
       'bad_groebner_basis': [str(c) for c in gb],
       'empty_bad_locus': list(gb)==[R.one()],
       'smooth_logarithmic_scheme_length': smooth_length,
       'bezout_certificate': certificate,
       'seconds': time.monotonic()-started,
       'scope': 'untwisted bicanonical spectral cover only; no BT1 existence'}
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(out,indent=2)+'\n')
print('empty bad locus:',out['empty_bad_locus'],'seconds',out['seconds'],flush=True)
