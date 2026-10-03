#!/usr/bin/env -S sage -python
"""Exact d=3 cone identities from the original same-completion congruence."""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing

R0=PolynomialRing(GF(5),names=('L','a','b','d','m'))
pL,pa,pb,pd,pm=R0.gens();Rw=PolynomialRing(R0,'w');w=Rw.gen()
N=-w**7+2*pL*w**3-pL*w**2+pL**2;D=w**5+2*pL*w+pL
raw=((2*D**2+pa+pb*w**5+pd*w**10)**2-pm*D**5).quo_rem(N)[1]
R=PolynomialRing(GF(5),names=('L','u','v','d','M'))
L,u,v,d,M=R.gens();hom=R0.hom([L,L**2*u,L*v,d,M/L],R.fraction_field())
rows=[R(hom(R0(raw[j]))/L**e) for j,e in enumerate((4,4,4,4,4,3,3))]
assert rows[3]+rows[4]==v**2+(2*d-1)*(u-1)
assert R((rows[1]+rows[2]+rows[4]).subs({d:R(3),v:R(0)}))==L+2+2*u
assert R((rows[5]+rows[6]).subs({d:R(3),v:R(0),u:2*L+4}))==2*L-3*M
assert R(rows[4].subs({d:R(3),v:R(0),u:2*L+4,M:4*L}))==L*(L-1)
contradiction=R(rows[0].subs({L:R(1),d:R(3),v:R(0),u:R(1),M:R(4)}))
assert contradiction==1
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
out.mkdir(parents=True,exist_ok=True)
receipt={'scope':'fixed-origin d=3 exact cone contradiction, no GB',
         'normalized_rows':[str(p) for p in rows],
         'identities':['r3+r4=v^2 at d=3','r1+r2+r4=L+2+2u after v=0',
                       'r5+r6=2L-3M after u=2L+4',
                       'r4=L*(L-1) after M=4L',
                       'r0=1 at the forced L=1,u=1,M=4,v=0,d=3'],
         'checks':{'exact_original_congruence_identities':True}}
(out/'tame_cone_identity_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('Original cone completion identities and final 1=0 PASS.')
