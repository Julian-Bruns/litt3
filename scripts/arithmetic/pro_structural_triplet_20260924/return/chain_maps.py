"""Experimental constant chain-map calculation; no support theorem by itself."""
from pathlib import Path
import sys,numpy as np,time,json
root=Path(__file__).resolve().parents[1];sys.path.insert(0,str(root/'upstream'/'src'))
import compute as c
D=np.load(root/'data'/'equivariant.npz');T,Q=D['T'],D['Q']
# Q(v) A = B T(v); A is 9x15, B is 14x23.
M=np.zeros((6*14*15,9*15+14*23),np.uint8)
for k in range(6):
 for r in range(14):
  for j in range(15):
   row=(k*14+r)*15+j
   for h in range(9):M[row,h*15+j]=Q[k,r,h]
   for h in range(23):M[row,135+r*23+h]=c.NEG[T[k,h,j]]
t=time.time();K=c.kernel(M);print('constant chain maps',K.shape,'seconds',time.time()-t,flush=True)
A=K[:135].T.reshape(-1,9,15)
print('joint A rank',len(c.rref(A.reshape(-1,15))[1]),flush=True)
np.savez_compressed(root/'data'/'constant_chain_maps.npz',kernel=K,A=A,B=K[135:].T.reshape(-1,14,23))

