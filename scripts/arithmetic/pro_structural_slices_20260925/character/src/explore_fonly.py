from exact import *
from pathlib import Path
D=np.load(Path(__file__).resolve().parents[1]/'data/fonly.npz');At=D['At']
fs=basis_L(31); rng=np.random.default_rng(20260925)
for j in range(3):
 inds=[i for i,b in enumerate(fs) if b[1]==j]
 A=At[:,:,inds]
 # reduce constant row basis of the family, then show row support partition.
 R,p,H=rref(A.transpose(1,0,2).reshape(29,-1),True)
 B=np.stack([mm(H[:len(p)],a) for a in A])
 print('slice',j,'eq',len(p))
 for it in range(4):
  f=rng.integers(0,25,len(inds),dtype=np.uint8) if it else np.eye(1,len(inds),0,dtype=np.uint8)[0]
  M=mm(A.reshape(19*29,-1),f).reshape(19,29).T
  print('f=',f.tolist(),'rank',rank(M),'zker_support',np.flatnonzero(np.any(kernel(M),axis=1)).tolist(),'rankfirst13',rank(M[:,:13]),'rankpurev',rank(M[:,13:]))
 print('zsupport',[[a for a in range(19) if np.any(B[a,row])] for row in range(B.shape[1])])
 np.savez_compressed(Path(__file__).resolve().parents[1]/f'data/fonly_char{j}.npz',B=B)
