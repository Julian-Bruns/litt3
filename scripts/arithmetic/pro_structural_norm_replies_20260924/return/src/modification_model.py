"""Compute the seven-dimensional linear system controlling the new degree-18 modification."""
from algebra import *
from pathlib import Path
import json,numpy as np
ROOT=Path(__file__).resolve().parents[1]
D=np.load(ROOT/'data'/'line_incidence.npz');W=D['W'];E=powp(e,25)
pos=json.loads((ROOT/'data'/'positive_line.json').read_text())
a0={(i,0):c for i,c in enumerate(pos['A']) if c};b0={(i,1):c for i,c in enumerate(pos['B']) if c}
images=[];polys=[]
for i in range(11):
 b=matpol(W[:,i],L(151));a=plus(mul(E,b))
 delta=sub(mul(a0,b),mul(b0,a))
 assert all(ix>=0 and 3*ix+10*j<=18 for ix,j in delta)
 images.append(vec(delta,L(18)));polys.append(delta)
J=np.stack(images,axis=1)
assert len(rref(J)[1])==7
V=J[:7,:4]
assert len(rref(V)[1])==4
assert not J[7:,:4].any() and not J[:7,4:].any()
assert len(rref(J[7:,4:])[1])==3
_,piv=rref(V);Vbasis=V[:,piv]
Vr,_=rref(Vbasis.T)
print('quotient image J',J.shape,'rank7; polynomial image V:')
print(Vr)
print('linear constraints on polynomial coefficients d0..d6:')
constraints=kernel(Vr)
print(constraints.T)
np.savez_compressed(ROOT/'data'/'modification_model.npz',J=J,polynomial_basis=Vr,polynomial_constraints=constraints.T)
(ROOT/'data'/'modification_model.json').write_text(json.dumps({'basis_L18':L(18),'J':J.tolist(),'polynomial_basis_rows':Vr.tolist(),'polynomial_constraints_rows':constraints.T.tolist(),'equation':'delta = sum d_i*x^i + y*(h0+h1*x+h2*x^2); constraints_rows @ d = 0 over F25'},indent=2)+'\n')
