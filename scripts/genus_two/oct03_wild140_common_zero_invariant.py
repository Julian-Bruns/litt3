#!/usr/bin/env -S sage -python
"""Exact finite quotient polynomial for the common-zero Cartier boundary."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

signal.alarm(6)
out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
data=json.loads((out/'common_zero_receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();gb=[R(p) for p in data['basis']]
leading=[next(iter(p.lm().dict())) for p in gb]
def divides(a,b):return all(x<=y for x,y in zip(a,b))
seen={(0,0,0,0,0)};todo=list(seen)
while todo:
    a=todo.pop()
    for j in range(5):
        b=tuple(x+(i==j) for i,x in enumerate(a))
        if b not in seen and not any(divides(e,b) for e in leading):
            seen.add(b);todo.append(b)
            assert len(seen)<100
exponents=sorted(seen,key=lambda a:(sum(a),a));index={a:i for i,a in enumerate(exponents)}
monomials=[R.monomial(*a) for a in exponents]
mu=Q**6*Z*T # inverse S = ZQT
cols=[]
for m in monomials:
    nf=(mu*m).reduce(gb);col=[GF(5)(0)]*len(exponents)
    for a,c in nf.dict().items():col[index[tuple(a)]]=c
    cols.append(col)
M=matrix(GF(5),cols).transpose();poly=M.minimal_polynomial()
assert R(poly(mu)).reduce(gb)==0
Rp=PolynomialRing(GF(5),'r');r=Rp.gen()
n=4*r**20;d=(r**4-1)**4
cleared=sum(Rp(poly[i])*n**i*d**(5-i) for i in range(6))
assert cleared.degree()==100 and cleared.leading_coefficient()==4
backup_remainder=cleared.quo_rem((r-1)**3+(r-1)+1)[1]
assert backup_remainder==r**2+r+3
signal.alarm(0)
receipt={'scope':'exact common-zero quotient invariant only',
         'quotient_dimension':len(exponents),'standard_exponents':exponents,
         'multiplication_matrix':[[int(c) for c in row] for row in M.rows()],
         'invariant':'Q^5/S = Q^6*Z*T',
         'minimal_polynomial':str(poly),
         'normal_form':str(R(poly(mu)).reduce(gb)),
         'cleared_parameter_polynomial':str(cleared),
         'cleared_degree':100,'backup_remainder':str(backup_remainder)}
(out/'common_zero_invariant_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'dimension':len(exponents),'polynomial':str(poly)}))
