#!/usr/bin/env -S sage -python
"""One bounded exact division step for the shifted-cubic subresultants."""
import json
import signal
from functools import lru_cache
from pathlib import Path
from sage.all import GF, PolynomialRing, singular

signal.alarm(6)
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen();l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;bb=w-T;H=(A**3+3*A*Phi*bb**2)*Phi**2
I=R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1]);gb=I.groebner_basis()
@lru_cache(maxsize=4096)
def nf(p):return R(p).reduce(gb)
def trim(a):
    while a and not a[-1]:a.pop()
    return a
def prem(a,b):
    a=list(a)
    while len(a)>=len(b):
        shift=len(a)-len(b);la=a[-1];lb=b[-1]
        a=[nf(lb*co) for co in a]
        for j,co in enumerate(b):a[j+shift]=nf(a[j+shift]-nf(la*co))
        trim(a)
    return a
N=A**2-Phi*bb**2
r7=[nf(R(co)) for co in N.list()];r6=[nf(R(co)) for co in N.derivative().list()]
r5=prem(r7,r6);r4=prem(r6,r5);raw3=prem(r5,r4)
assert len(raw3)==4 and r5[-1]==Q*(Q-T-1)
divisor=r5[-1]**2
J=R.ideal(list(I.gens())+[divisor])
lift=singular.lift(singular(J),singular(R.ideal(raw3))).sage()
quotients=[R(lift[4,j]) for j in range(4)]
for j,p in enumerate(raw3):assert sum(R(lift[i,j])*J.gens()[i] for i in range(5))==p
normalized=[nf(p) for p in quotients]
assert all(nf(raw3[j]-divisor*normalized[j])==0 for j in range(4))
signal.alarm(0)
receipt={'scope':'ONE normalized degree3 step ONLY, no common-root conclusion',
         'original_generators':[str(p) for p in I.gens()],
         'divisor':str(divisor),'degree5':[str(p) for p in r5],
         'degree4':[str(p) for p in r4],'raw_degree3':[str(p) for p in raw3],
         'quotients':[str(p) for p in quotients],
         'normalized_degree3':[str(p) for p in normalized],
         'lift_columns':[[str(R(lift[i,j])) for i in range(5)] for j in range(4)]}
out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
out.mkdir(parents=True,exist_ok=True)
(out/'degree3_certificate.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'normalized_degree3_sizes':[(int(p.total_degree()),len(p.monomials())) for p in normalized]}))
