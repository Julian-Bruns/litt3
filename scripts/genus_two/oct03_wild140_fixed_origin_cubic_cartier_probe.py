#!/usr/bin/env -S sage -python
"""Fresh six-second fixed-origin family Cartier dimension probe only."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R=PolynomialRing(GF(5),names=('Q','B','L','T','Z'))
Q,B,L,T,Z=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3-L
Phi=w**5+Q*w**4+L*w+Q*L;bb=w-T
E=3*A**2*bb+Phi*bb**3
H=(A**3+3*A*Phi*bb**2)*Phi**2
assert E[4]==0 and H[19]==0
I=R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*L-1])
gb=I.groebner_basis();dim=int(I.dimension())
signal.alarm(0)
receipt={'scope':'fixed-origin cubic Cartier dimension ONLY',
         'generators':[str(p) for p in I.gens()],
         'dimension':dim,'basis':[str(p) for p in gb],
         'basis_count':len(gb),'max_degree':max(int(p.total_degree()) for p in gb)}
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
out.mkdir(parents=True,exist_ok=True)
(out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({k:receipt[k] for k in ('dimension','basis_count','max_degree')}))
