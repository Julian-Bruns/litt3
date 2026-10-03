#!/usr/bin/env sage
"""Fraction-free relative Mumford chart for the saved correct d=0 gauge.

No new Groebner basis, sample or net/source decision. Records the exact
sheet pivot; its zero locus remains an explicit exceptional stratum.
"""
import argparse
import itertools
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--gauge',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(30)
start=time.monotonic()
R,Rx,G,H,ann,U,N,pair,branch_remainders,norm_quotient,C4,flat_numerators,cross=load(args.gauge)
assert all(p==0 for p in branch_remainders)
assert all(p==(Rx.zero(),Rx.zero()) for p in cross)
k=R.base_ring();alpha=k.gen();vs=dict(zip(R.variable_names(),R.gens()))
RX=C4.parent();X=RX.gen()
def nf(c):return R(c).reduce(G)
def pn(p):return RX([nf(c) for c in p.list()])
assert C4.degree()==4 and C4[4]==alpha*vs['a2']^6
monic=pn(C4*(1/alpha)*vs['inv_a2']^6)
assert monic.is_monic()
def rem(p):
    p=pn(p)
    while p.degree()>=4:
        p=pn(p-p.leading_coefficient()*monic*X^(p.degree()-4))
    return p
def fifth(c):
    # Exact coefficient Frobenius; no polynomial expansion or conversion.
    return nf(R({tuple(5*j for j in e):z^5 for e,z in c.dict().items()}))
E5=rem(RX([fifth(c) for c in pair[0].list()]))
O5=rem(RX([fifth(c) for c in pair[1].list()]))
H1=(1+4*alpha)^5*X^5+(2+4*alpha)^5*X^4-1
assert rem(E5^2-H1*O5^2)==0
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
save((R,RX,G,monic,E5,O5,H1),str(out/'relative_remainders.sobj'))
columns=[rem(O5*X^j) for j in range(4)]
M=[[columns[j][i] for j in range(4)] for i in range(4)]
def det(A):
    n=len(A);z=R.zero()
    for p in itertools.permutations(range(n)):
        term=R.one()
        for i in range(n):term=nf(term*A[i][p[i]])
        sign=(-1)^sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))
        z=nf(z+sign*term)
    return z
pivot=det(M)
inverse_numerator=[]
for j in range(4):
    minor=[[M[i][l] for l in range(4) if l!=j] for i in range(1,4)]
    inverse_numerator.append(nf((-1)^j*det(minor)))
J=RX(inverse_numerator)
assert rem(O5*J-pivot)==0
sheet=rem(-E5*J)
assert rem(O5*sheet+pivot*E5)==0
assert rem(sheet^2-pivot^2*H1)==0
save((R,RX,G,monic,E5,O5,H1,pivot,J,sheet),str(out/'mumford_chart.sobj'))
(out/'mumford_chart.txt').write_text('C4 monic = '+str(monic)+'\n'+
    'sheet pivot = '+str(pivot)+'\n'+
    'sheet numerator = '+str(sheet)+'\n'+
    'sheet leading numerator = '+str(sheet[3])+'\n')
summary={'scope':'relative degree4 sheet chart on open pivot!=0 only; no divisor/source decision',
         'threads':1,'recomputed_groebner_basis':False,
         'C4_leading_unit':'alpha*a2^6',
         'pivot_is_zero_in_parameter_ring':bool(pivot==0),
         'pivot_parameter_degree':int(pivot.degree()),
         'pivot_monomials':len(pivot.monomials()),
         'sheet_numerator_degree':int(sheet.degree()),
         'sheet_leading_numerator_zero':bool(sheet[3]==0),
         'relative_curve_sheet_identity':'PASS',
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n');print(json.dumps(summary,default=int))
