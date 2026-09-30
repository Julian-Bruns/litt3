"""Exact finite-degree module tests, not a finite-field point search."""
from algebra import *
from numba import njit
import numpy as np,time,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
@njit(cache=True)
def rank_fast(A,addtab,multab,negtab,invtab):
 A=A.copy(); m,n=A.shape; r=0; piv=np.empty(min(m,n),dtype=np.int64)
 for c in range(n):
  h=r
  while h<m and A[h,c]==0: h+=1
  if h==m:continue
  if h!=r:
   for j in range(c,n):
    v=A[r,j];A[r,j]=A[h,j];A[h,j]=v
  inv=invtab[A[r,c]]
  for j in range(c,n):A[r,j]=multab[A[r,j],inv]
  for h in range(r+1,m):
   co=negtab[A[h,c]]
   if co:
    A[h,c]=0
    for j in range(c+1,n):A[h,j]=addtab[A[h,j],multab[co,A[r,j]]]
  piv[r]=c;r+=1
  if r==m:break
 return r,piv[:r]
def mons(n,d):
 if n==1:return [(d,)]
 return [(a,)+b for a in range(d+1) for b in mons(n-1,d-a)]
def macaulay_tensor(A,d):
 """A[var, equation, unknown]. Coker A^t degree d as rows."""
 nv,neq,nu=A.shape; target=mons(nv,d); source=mons(nv,d-1)
 ix={m:i for i,m in enumerate(target)}
 M=np.zeros((nu*len(target),neq*len(source)),dtype=np.uint8)
 for k,m in enumerate(source):
  for v in range(nv):
   dest=list(m);dest[v]+=1;h=ix[tuple(dest)]
   for e in range(neq):
    for u in range(nu):
     M[u*len(target)+h,e*len(source)+k]=A[v,e,u]
 return M
if __name__=='__main__':
 D=np.load(ROOT/'data'/'line_incidence.npz'); S=D['S'];W=D['W']
 pos=json.loads((ROOT/'data'/'positive_line.json').read_text());b={(i,1):v for i,v in enumerate(pos['B']) if v}
 _,piv=rref(D['A']);free=[j for j in range(W.shape[0]) if j not in piv]
 C=np.stack([vec(mul(b,{(i,0):1}),L(151))[free] for i in range(4)],axis=1)
 Spos=np.stack([mm(Sj,C) for Sj in S])
 # These zero blocks are essential: no cancellation between coordinate groups.
 for jj in [0,6,7]: assert not Spos[jj,:7,:].any() and not Spos[jj,18:,:].any()
 for jj in [1,2,3,4,5,8,9,10,11,12]: assert not Spos[jj,:18,:].any()
 for jj in range(13,19): assert not Spos[jj,7:,:].any()
 # rows in the three y characters have sizes7,11,14.
 AA=Spos[[0,6,7],7:18,:].transpose(2,1,0)
 BB=Spos[[1,2,3,4,5,8,9,10,11,12],18:32,:].transpose(2,1,0)
 np.savez_compressed(ROOT/'data'/'filtration_matrices.npz',C=C,Spos=Spos,A=AA,B=BB)
 results=[]
 for name,A,ds in [('A',AA,[2,3]),('B',BB,[7,8,9,10])]:
  for d in ds:
   M=macaulay_tensor(A,d);start=time.time();r,p=rank_fast(M,ADD,MUL,NEG,INV)
   result=dict(name=name,degree=d,rows=M.shape[0],columns=M.shape[1],rank=int(r),seconds=round(time.time()-start,3));print(result,flush=True);results.append({k:v for k,v in result.items() if k!='seconds'})
   if r==M.shape[0]:
    np.savez_compressed(ROOT/'data'/('macaulay_'+name+'.npz'),degree=d,pivots=p)
    break
 (ROOT/'data'/'macaulay_results.json').write_text(json.dumps(results,indent=2)+'\n')
