#!/usr/bin/env -S sage -python
"""Bounded normalized raw subresultant probe; no generic conclusion implicit."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R = PolynomialRing(GF(5), names=('Q','B','S','T','Z'))
Q,B,S,T,Z = R.gens()
Rw = PolynomialRing(R, 'w'); w = Rw.gen()
l = 3+2*Q+2*T
A = w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi = w**5+Q*w**4+S
H = (A**3+3*A*Phi*(w-T)**2)*Phi**2
I = R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1])
gb = I.groebner_basis()
N = A**2-Phi*(w-T)**2
subs = N.subresultants(N.derivative())
target = [p for p in subs if p.degree()==3]
assert len(target)==1
raw = target[0]
reduced = [R(p).reduce(gb) for p in raw.list()]
signal.alarm(0)
out = Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
out.mkdir(parents=True,exist_ok=True)
receipt = {'scope':'degree3 raw subresultant reduction ONLY',
           'subresultant_degrees':[int(p.degree()) for p in subs],
           'cartier_generators':[str(p) for p in I.gens()],
           'groebner_basis':[str(p) for p in gb],
           'lower_raw_subresultants':{str(p.degree()):[str(c) for c in p.list()]
                                     for p in subs if p.degree()<3},
           'raw_degree3':[str(p) for p in raw.list()],
           'reduced_degree3':[str(p) for p in reduced]}
(out/'raw_degree3_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'sizes':[(int(p.total_degree()),len(p.monomials())) for p in reduced]}))
