from exact import *
import json,pathlib,time
ROOT=pathlib.Path(__file__).resolve().parents[1]
a=np.load(ROOT/'data/pencils.npz');T=a['T'];Q=a['Q']

def tangent(z):
 """Tangent condition for rank <= observed rank, NOT rank <= 34 in general."""
 A=pencil(T,z);K=kernel(A);N=kernel(A.T).T
 D=np.stack([mm(N,mm(T[i],K)).ravel() for i in range(19)],axis=1)
 return kernel(D)

if __name__=='__main__':
 rng=np.random.default_rng(625)
 for j in range(35):
  Z=kernel(T[:,:,j].T)
  if Z.shape[1]:
   print('w',j,'dimZ',Z.shape[1], 'support',np.flatnonzero(np.any(Z,axis=1)).tolist(),flush=True)
   for zz in Z.T:
    A=pencil(T,zz);r=rank(A);s=rank(pencil(Q,zz));K=kernel(A)
    tan=tangent(zz)
    print(' z',zz.tolist(),'ranks',r,s,'ksup',np.flatnonzero(np.any(K,axis=1)).tolist(),'tandim',tan.shape[1],'tansup',np.flatnonzero(np.any(tan,axis=1)).tolist(),flush=True)
