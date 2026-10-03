#!/usr/bin/env -S sage -python
"""One six-second same-completion probe after two analytical eliminations."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
data=json.loads((out/'completion_rows.json').read_text())
R0=PolynomialRing(GF(5),names=('L','a','b','d','m'))
R=PolynomialRing(GF(5),names=('L','u','v','d','M','Z'))
L,u,v,d,M,Z=R.gens();K=R.fraction_field()
hom=R0.hom([L,L**2*u,L*v,d,M/L],K)
rows=[R(hom(R0(p))/L**e) for p,e in zip(data['rows'],(4,4,4,4,4,3,3))]
eu=L+d**2-2*d+L*v*(2*d-1)+2*u+3*v-1
assert rows[1]+rows[2]+rows[4]==eu
up=3*(-L-d**2+2*d-L*v*(2*d-1)-3*v+1)
em=L*(3*d**2-3*d+1)-1+4*v*d+v**2-3*u*d-2*u+2*u*v-3*M
assert rows[5]+rows[6]==em
mp=R((2*(em+3*M)).subs({u:up}))
subrows=[R(p.subs({u:up,M:mp})) for p in rows]
assert all(p.degree(u)==0 and p.degree(M)==0 for p in subrows+[mp])
S=PolynomialRing(GF(5),names=('L','v','d','Z'))
sL,sv,sd,sZ=S.gens();drop=R.hom([sL,S(0),sv,sd,S(0),sZ],S)
gates=[drop(p) for p in subrows]
mp=drop(mp)
I=S.ideal(gates+[sZ*sL*(sL+1)*mp*(sd-3)-1])
gb=I.groebner_basis();dim=int(I.dimension())
signal.alarm(0)
receipt={'scope':'analytically reduced fixed-origin completion gate ONLY',
         'normalized_rows':[str(p) for p in rows],
         'u_elimination':str(up),'M_elimination':str(mp),
         'remaining_generators':[str(p) for p in I.gens()],
         'basis':[str(p) for p in gb],'dimension':dim,
         'opens':'L*(L+1)*M*(d-3) != 0'}
(out/'completion_probe_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'dimension':dim,'basis_count':len(gb),
                  'max_degree':max(int(p.total_degree()) for p in gb)}))
