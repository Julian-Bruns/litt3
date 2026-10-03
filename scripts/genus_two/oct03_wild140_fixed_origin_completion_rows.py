#!/usr/bin/env -S sage -python
"""Extract seven exact fixed-origin same-completion rows, no solving."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R=PolynomialRing(GF(5),names=('L','a','b','d','m'))
L,a,b,d,m=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
N=-w**7+2*L*w**3-L*w**2+L**2
D=w**5+2*L*w+L
G=2*D**2+a+b*w**5+d*w**10
raw=G**2-m*D**5
remainder=raw.quo_rem(N)[1]
rows=[R(remainder[j]) for j in range(7)]
signal.alarm(0)
receipt={'scope':'seven SAME-base completion equations, no solution decision',
         'norm':str(N),'D':str(D),'G_on_fiber':str(G),
         'rows':[str(p) for p in rows],
         'open_conditions':'L*(L+1)*m*(d-3) != 0'}
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
out.mkdir(parents=True,exist_ok=True)
(out/'completion_rows.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('\n'.join('row'+str(j)+': '+str(p) for j,p in enumerate(rows)))
