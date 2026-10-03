#!/usr/bin/env -S sage -python
"""One <=30-second quotient arithmetic probe; pseudo-gcd needs branch care."""
import json
import signal
from functools import lru_cache
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(30)
out=Path('../litt3-computation-data/oct03_wild140_quotient_pseudo_remainder_gate')
out.mkdir(parents=True,exist_ok=True)
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;bb=w-T
H=(A**3+3*A*Phi*bb**2)*Phi**2
I=R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1])
gb=I.groebner_basis()
receipt={'scope':'Pseudo-remainder probe ONLY; vanishing leading-coefficient branches unexcluded',
         'basis_count':len(gb),'basis_max_degree':int(max(p.total_degree() for p in gb)),
         'original_generators':[str(p) for p in I.gens()],'steps':[]}
print(json.dumps({'basis_count':len(gb),'basis_max_degree':receipt['basis_max_degree']}),flush=True)
@lru_cache(maxsize=4096)
def nf(p):return R(p).reduce(gb)
def trim(a):
    while a and not a[-1]:a.pop()
    return a
def prem(a,b):
    a=list(a)
    while len(a)>=len(b):
        da=len(a)-len(b);la=a[-1];lb=b[-1]
        a=[nf(lb*c) for c in a]
        for j,c in enumerate(b):a[j+da]=nf(a[j+da]-nf(la*c))
        trim(a)
    return a
N=A**2-Phi*bb**2
a=trim([nf(R(co)) for co in N.list()])
b=trim([nf(R(co)) for co in N.derivative().list()])
for index in range(8):
    if not b:break
    step={'index':index,'degrees':[len(a)-1,len(b)-1],
          'leading_coefficient':str(b[-1]),
          'leading_degree':int(b[-1].total_degree()),
          'leading_terms':len(b[-1].monomials())}
    receipt['steps'].append(step)
    (out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps({k:step[k] for k in ('index','degrees','leading_degree','leading_terms')}),flush=True)
    a,b=b,prem(a,b)
receipt.update({'last_degree':len(a)-1,'zero_remainder':not b,
                'last_polynomial_coefficients':[str(co) for co in a]})
signal.alarm(0)
(out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'last_degree':len(a)-1,'zero_remainder':not b}),flush=True)
