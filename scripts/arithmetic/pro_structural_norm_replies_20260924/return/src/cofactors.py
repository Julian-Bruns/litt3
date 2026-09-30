"""Exact polynomial cofactor coefficients, before imposing T(z)m=0.
B[l,j,a,b] is the (not symmetrized) coefficient of z_j*m_a*m_b
in the lower cofactor a*g-q*f at the l-th free W monomial.
"""
from algebra import *
from reconstruct import lower,free_basis,E
from pathlib import Path
import numpy as np
ROOT=Path(__file__).resolve().parents[1]
D=np.load(ROOT/'data'/'matrices.npz'); Rc=D['Rc']
Wdata=np.load(ROOT/'data'/'line_incidence.npz'); W=Wdata['W']
_,piv=rref(Wdata['A']); free=[j for j in range(len(L(151))) if j not in piv]
indices=[L(151)[j] for j in free]
fp=[]
for kind,ij in free_basis:
 f={ij:1} if kind=='f' else {}; a=plus(mul(e,f)) if kind=='f' else {ij:1}
 fp.append((f,sub(a,mul(e,f))))
rec=[]
for jj,(u,v) in enumerate(UV):
 U,V=powp(u,25),powp(v,25); raw=[]
 for kind,ij in free_basis:
  f={ij:1} if kind=='f' else {}; a=plus(mul(e,f)) if kind=='f' else {ij:1}
  raw.append(lower(f,a,U,V)[0])
 rec.append(NEG[mm(Rc,np.stack(raw,axis=1))])
rec=np.stack(rec)
B=np.zeros((11,19,35,35),dtype=np.uint8)
for j in range(19):
 for t in range(35):
  g0=matpol(rec[j,:123,t],L(131)); q0=matpol(rec[j,123:,t],L(120))
  for a,(f,p) in enumerate(fp):
   for l,(ix,jy) in enumerate(indices):
    # At weights >=133, the remaining raw terms have weight at most48.
    val=0
    for (i0,j0),c in p.items():
     for j1 in range(3):
      z=j0+j1
      if z<3:
       if z==jy: val=int(ADD[val,MUL[c,g0.get((ix-i0,j1),0)]])
      elif z-3==jy:
       for (ip,_),cp in P.items():
        val=int(ADD[val,MUL[MUL[c,cp],g0.get((ix-i0-ip,j1),0)]])
    for (i0,j0),c in f.items():
     for j1 in range(3):
      z=j0+j1
      if z<3:
       if z==jy: val=int(ADD[val,NEG[MUL[c,q0.get((ix-i0,j1),0)]]])
      elif z-3==jy:
       for (ip,_),cp in P.items():
        val=int(ADD[val,NEG[MUL[MUL[c,cp],q0.get((ix-i0-ip,j1),0)]]])
    B[l,j,a,t]=val
np.savez_compressed(ROOT/'data'/'cofactors.npz',B=B,recovery=rec,indices=np.array(indices))
print('free b monomials:',indices)
print('cofactor scalar polynomial nonzero counts:',[np.count_nonzero(x) for x in B])
