"""New dual line incidence S(z): H^0(F^2 K(O)) -> H^1(O(-24O))."""
from algebra import *
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]
E=powp(e,25)
# A section (a,b) of F^2 K(O) has transformed orders >=124,-151.
# b belongs to L_151; a=(E b)_+; [E b]_-124=0.
bs=L(151); bad=forbidden(-124)
A=np.stack([vec(mul(E,{ij:1}),bad) for ij in bs],axis=1)
W=kernel(A)
sections=[]
for j in range(W.shape[1]):
 b=matpol(W[:,j],bs); a=plus(mul(E,b)); sections.append((a,b))
# Lift into F^2 R(O): top transformed coordinate n-Ua-Vb has
# infinity order >=24. n polynomial; hence n=(Ua+Vb)_+,
# [Ua+Vb]_-24=0. No free polynomial part as L_-24=0.
out=forbidden(-24)
S=[]
for u,v in UV:
 U,V=powp(u,25),powp(v,25)
 S.append(np.stack([vec(add(mul(U,a),mul(V,b)),out) for a,b in sections],axis=1))
S=np.stack(S)
np.savez_compressed(ROOT/'data'/'line_incidence.npz',A=A,W=W,S=S)
print('A',A.shape,'rank',A.shape[1]-W.shape[1])
print('W dimension',W.shape[1], 'S shape',S.shape)
print('S joint row rank',len(rref(np.concatenate(S,axis=1))[1]))
print('section support sizes',[(len(a),len(b)) for a,b in sections])
print('constant common kernel',kernel(np.concatenate(S,axis=0)).shape)
