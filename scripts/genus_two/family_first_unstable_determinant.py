#!/usr/bin/env sage-python
"""Exact norm determinant of the five first-unstable family tests."""
from sage.all import GF, PolynomialRing, matrix
from pathlib import Path
import argparse
import itertools
import json
import time

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--theta',type=Path,required=True);ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--bareiss',action='store_true',help='independent scalar fraction-free elimination')
args=ap.parse_args()
if args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2]):raise ValueError('external output required')
start=time.monotonic();d=json.loads(args.tensor.read_text());theta=json.loads(args.theta.read_text())
R=PolynomialRing(GF(5),'a');a=R.gen();RT=PolynomialRing(R,'T');T=RT.gen()
psi=RT([R(s.replace('^','**')) for s in theta['extension_polynomial']])
qs=[[RT([R(c.replace('^','**')) for c in value]) for value in row] for row in d['first_unstable_quadrics']]
exponents=lambda n:[tuple(word.count(i) for i in range(4)) for word in itertools.combinations_with_replacement(range(4),n)]
m2,m3=exponents(2),exponents(3)
B=matrix(R,100,100)
for row in range(5):
    for variable in range(4):
        for j,exp in enumerate(m2):
            output=list(exp);output[variable]+=1;index=m3.index(tuple(output))
            for col in range(5):
                value=(qs[row][j]*T**col)%psi
                for h in range(5):B[5*index+h,5*(4*row+variable)+col]=value[h]
print('polynomial matrix reconstructed; degree',max(x.degree() for x in B.list()),flush=True)
print('computing exact polynomial determinant',flush=True)
if args.bareiss:
    entries=[list(row) for row in B.rows()]; previous=R.one(); sign=R.one()
    for step in range(99):
        pivotrow=next(row for row in range(step,100) if entries[row][step])
        if pivotrow!=step:
            entries[step],entries[pivotrow]=entries[pivotrow],entries[step];sign=-sign
        pivot=entries[step][step]
        for row in range(step+1,100):
            coeff=entries[row][step]
            for col in range(step+1,100):
                value=pivot*entries[row][col]-coeff*entries[step][col]
                if value:
                    quotient,remainder=value.quo_rem(previous)
                    assert not remainder
                    entries[row][col]=quotient
                else:entries[row][col]=R.zero()
            entries[row][step]=R.zero()
        previous=pivot
        if step%10==0:print('Bareiss step',step,'seconds',time.monotonic()-start,flush=True)
    det=sign*entries[99][99]
else:det=B.det()
assert det==2*(a*(a-1)*(a-2)*(a-3))**430
print('degree',det.degree(),'seconds',time.monotonic()-start,flush=True)
factors=det.factor()
print('factorization',factors,flush=True)
result={'determinant':str(det),'degree':int(det.degree()),'factorization':[[str(f),int(e)] for f,e in factors],
        'unit':int(factors.unit()),'seconds':time.monotonic()-start,
        'source':'independent scalar Bareiss with all divisions verified' if args.bareiss else 'exact100x100 polynomial determinant over F5[a]'}
args.output.write_text(json.dumps(result,indent=2)+'\n')
