from incidence import *
from algebra import pexact,ppow
import json
inc=json.loads((ROOT/'data/incidence.json').read_text())
A5=exactx(U[5]-BB*U[4]+BB**2*U[3]-BB**3*U[2],ppow(P,2))
B5=exactx(V[5]-BB*V[4]+BB**2*V[3]-BB**3*V[2],ppow(P,2))
C5=exactx(ZZ[5]-BB*ZZ[4]+BB**2*ZZ[3]-BB**3*ZZ[2],P)
C0=pexact(psub(Q,ppow(B0,5)),ppow(P,2))
inc.update({'A5':A5.data(),'B5':B5.data(),'C5':C5.data(),'C0':pol(C0).data(),'P':PP.data(),'t':tt.data()})
names=['Z','A3','B3','C3','A4','B4','C4','A5','B5','C5','C0','P','t']
with (ROOT/'data/residual_functions.txt').open('w') as f:
    f.write(str(len(names))+'\n')
    for name in names:
        rows=inc[name];f.write(name+' '+str(len(rows))+'\n')
        for h,q,x,c in rows:f.write(f'{c} {h} {q} {x}\n')
shape=json.loads((ROOT/'data/shape.json').read_text())
H=shape['coordinates']['H']
(ROOT/'data/shape_H.txt').write_text(str(len(H))+'\n'+' '.join(map(str,H))+'\n')
(ROOT/'data/residual_functions.json').write_text(json.dumps({name:inc[name] for name in names},indent=2)+'\n')
print('all g5 and Qbar polynomial divisions verified')
