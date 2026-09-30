from exact import *
from macaulay import independent_equations,macaulay
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1];grades=json.loads((root/'data/grades.json').read_text());za,zb,zc=grades['z_groups']
B=np.load(root/'data/fonly_char0.npz')['B']
rng=np.random.default_rng(201)
for maxdeg in range(2,6):
 print('maximum polynomial degree',maxdeg,flush=True)
 for name,zidx in [('A',za),('B',zb),('C',zc)]:
  A=independent_equations(B[zidx,:,:maxdeg+1].transpose(1,0,2))
  common=kernel(A.transpose(0,2,1).reshape(-1,len(zidx)))
  ranks=[]
  for it in range(20):
   f=rng.integers(0,25,maxdeg+1,dtype=np.uint8);f[-1]=1
   ranks.append(rank(mm(A.reshape(-1,maxdeg+1),f).reshape(A.shape[:2])))
  print(name,'shape',A.shape,'common kernel',common.shape[1], 'random ranks',sorted(set(ranks)),flush=True)
  if maxdeg==2:
   # annihilator of common kernel; target all its products with f_l^d.
   targets=kernel(common.T).T if common.shape[1] else np.eye(len(zidx),dtype=np.uint8)
   for d in range(1,6):
    M,mons,_=macaulay(A,d);RR,piv=rref(M);miss=0
    for v in targets:
     for w in range(maxdeg+1):
      t=np.zeros(M.shape[1],dtype=np.uint8);t[np.arange(len(zidx))*len(mons)+mons.index((w,)*d)]=v
      for r,p in enumerate(piv):
       if t[p]:t=SUB[t,MUL[t[p],RR[r]]]
      miss+=bool(np.any(t))
    print('  d',d,'matrix',M.shape,'rank',len(piv),'miss',miss,flush=True)
    if not miss:
     np.savez_compressed(root/f'certificates/j0_low2_{name}.npz',A=A,common=common,targets=targets,d=np.array(d));break
