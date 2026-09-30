"""Build the complete q*t-localized incidence ideal, not a generic fiber."""
from algebra import ROOT,t,neg
import json
D=json.loads((ROOT/'data/incidence.json').read_text())
with (ROOT/'data/gb_qt_input.txt').open('w') as f:
    f.write('4 4\n')
    for name in ['E1','E2','E3']:
        rows=D[name];f.write(str(len(rows))+'\n')
        for h,q,x,c in rows:f.write(f'{c} {h} {q} {x} 0\n')
    f.write(str(len(t)+1)+'\n1 0 0 0 0\n')
    for j,c in enumerate(t):f.write(f'{neg(c)} 0 1 {j} 1\n')
print('built ideal (E1,E2,E3,1-s*q*t(x)) over K[H,q,x,s]')
