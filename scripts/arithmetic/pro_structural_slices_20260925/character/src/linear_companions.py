from exact import *
from pathlib import Path
from macaulay import independent_equations, macaulay
import json,time
root=Path(__file__).resolve().parents[1]
D=np.load(root/'data/pencils.npz');T=D['T'];Q=D['Q']
g=json.loads((root/'data/grades.json').read_text());zA,zB,zC=g['z_groups']
# Test all constant linear companion operators into Hom(-,L).
for j in range(3):
 idx=[i for i,ij in enumerate(basis_L(31)) if ij[1]==j]+list(range(23,35))
 m=len(idx); B=T[:,:,idx].transpose(1,0,2).reshape(80,-1)
 N=kernel(B).reshape(19,m,-1); k=N.shape[-1]
 S=np.zeros((0,16*m),dtype=np.uint8);start=time.time()
 for r in range(43):
  A=np.concatenate([mm(N[:,w,:].T,Q[:,r,:]) for w in range(m)],axis=1)
  R,p=rref(np.concatenate((S,A),axis=0));S=R[:len(p)]
  if len(p)==16*m:break
 C=kernel(S)
 print('j',j,'companion_dim',C.shape[1],'eqrank',S.shape[0],'seconds',time.time()-start,flush=True)
 np.savez_compressed(root/f'data/linear_companions_j{j}.npz',operators=C,columns=np.array(idx))
# actual alpha1 map for pure C.
rows=g['row_groups'][1]
J=independent_equations(T[zC][:,rows,30:34].transpose(1,0,2))
for d in [2,3,4]:
 M,mons,_=macaulay(J,d);R,p=rref(M)
 print('j1_J',J.shape,d,M.shape,len(p),flush=True)
 if len(p)==M.shape[1]:
  np.savez_compressed(root/'certificates/j1_pureC_alpha1.npz',A=J,d=np.array(d));break
