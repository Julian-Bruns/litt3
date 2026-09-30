from exact import *
from macaulay import independent_equations
from pathlib import Path
root=Path(__file__).resolve().parents[1]
rng=np.random.default_rng(25)
for j in range(3):
 B=np.load(root/f'data/fonly_char{j}.npz')['B']
 for name,zi in [('A',[0,6,7]),('B',[1,2,3,4,5,8,9,10,11,12]),('C',list(range(13,19)))]:
  A=independent_equations(B[zi].transpose(1,0,2))
  print(j,name,A.shape,'ranks_monomials',[rank(A[:,:,w]) for w in range(A.shape[2])],flush=True)
  if A.shape[0]!=A.shape[1]:continue
  while True:
   f=rng.integers(0,25,A.shape[2],dtype=np.uint8)
   M=mm(A.reshape(-1,A.shape[2]),f).reshape(A.shape[:2])
   R,p,H=rref(M,True)
   if len(p)==A.shape[0]: break
  normals=[mm(H,A[:,:,w]) for w in range(A.shape[2])]
  comm=[rank(SUB[mm(a,b),mm(b,a)]) for i,a in enumerate(normals) for b in normals[i+1:]]
  print(' commutator ranks',comm,flush=True)
  np.savez_compressed(root/f'data/fonly_{j}{name}_independent.npz',A=A)
