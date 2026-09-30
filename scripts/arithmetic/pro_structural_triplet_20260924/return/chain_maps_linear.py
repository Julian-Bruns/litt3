"""Experimental degree-one chain-map calculation, preserving exact F25 arithmetic."""
from pathlib import Path
import sys,numpy as np,time
root=Path(__file__).resolve().parents[1];sys.path.insert(0,str(root/'upstream'/'src'))
import compute as c
from numba import njit
D=np.load(root/'data'/'equivariant.npz');T,Q=D['T'],D['Q']
mons=[(i,j) for i in range(6) for j in range(i,6)];md={m:k for k,m in enumerate(mons)}
mi=np.array([[md[tuple(sorted((i,j)))] for j in range(6)] for i in range(6)],np.int64)
S=np.zeros((21*15,6*23),np.uint8)
for i in range(6):
 for j in range(6):S[15*mi[i,j]:15*(mi[i,j]+1),i*23:(i+1)*23]=c.ADD[S[15*mi[i,j]:15*(mi[i,j]+1),i*23:(i+1)*23],T[j].T]
start=time.time();R,piv=c.rref(np.column_stack((S,np.eye(S.shape[0],dtype=np.uint8))),S.shape[1]); L=R[len(piv):,S.shape[1]:]
print('Macaulay S rank',len(piv),'L',L.shape,flush=True)
@njit(cache=True)
def make(L,Q,mi):
 n=L.shape[0];E=np.zeros((14*n,6*9*15),np.uint8)
 for r in range(14):
  for i in range(6):
   for a in range(9):
    for j in range(6):
     q=Q[j,r,a]
     if not q:continue
     for z in range(15):
      for ll in range(n):
       rr=r*n+ll;cc=(i*9+a)*15+z
       E[rr,cc]=c.ADD[E[rr,cc],c.MUL[q,L[ll,mi[i,j]*15+z]]]
 return E
E=make(L,Q,mi);K=c.kernel(E)
print('linear chain A dimension',K.shape,'seconds',time.time()-start,flush=True)
A=K.T.reshape(-1,6,9,15)
print('joint coefficient rank',len(c.rref(A.reshape(-1,15))[1]),flush=True)
np.savez_compressed(root/'data'/'linear_chain_maps.npz',A=A,S=S,L=L)

