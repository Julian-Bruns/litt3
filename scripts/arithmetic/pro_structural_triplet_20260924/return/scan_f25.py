"""Exhaustive P5(F25) invariant quotient rank scan; NOT geometric completeness."""
from pathlib import Path
import sys,time,json,numpy as np
from numba import njit
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'upstream'/'src'))
from compute import ADD,MUL,INV,NEG,rref
D=np.load(ROOT/'data'/'equivariant.npz');T=D['T'];Q=D['Q']

@njit(cache=True)
def rank_fast(A):
 A=A.copy(); nr,nc=A.shape;r=0
 for col in range(nc):
  p=r
  while p<nr and A[p,col]==0:p+=1
  if p==nr:continue
  if p!=r:
   for j in range(col,nc):A[r,j],A[p,j]=A[p,j],A[r,j]
  inv=INV[A[r,col]]
  for j in range(col+1,nc):A[r,j]=MUL[inv,A[r,j]]
  for i in range(r+1,nr):
   if A[i,col]:
    neg=NEG[A[i,col]]
    for j in range(col+1,nc):A[i,j]=ADD[A[i,j],MUL[neg,A[r,j]]]
  r+=1
  if r==nr:return r
 return r

@njit(cache=True)
def scan_chart(T,j):
 # Canonical disjoint charts: preceding coordinates zero, coordinate j=1.
 nr,nc=T.shape[1:];N=25**(5-j)
 hits=np.zeros((10000,8),np.uint8);nh=0
 for code in range(N):
  v=np.zeros(6,np.uint8);v[j]=1;t=code
  A=T[j].copy()
  for k in range(j+1,6):
   v[k]=t%25;t//=25
   if v[k]:
    for rr in range(nr):
     for cc in range(nc):A[rr,cc]=ADD[A[rr,cc],MUL[v[k],T[k,rr,cc]]]
  rank=rank_fast(A)
  if rank<nc:
   assert nh<len(hits)
   hits[nh,:6]=v;hits[nh,6]=rank;nh+=1
 return hits[:nh]

def main():
 start=time.time();hits=[];summ=[]
 for j in range(5,-1,-1):
  t=time.time();H=scan_chart(T,j)
  for h in H:
   Z=np.zeros(Q.shape[1:],np.uint8)
   for k in range(6):Z=ADD[Z,MUL[h[k],Q[k]]]
   h[7]=rank_fast(Z)
  hits.extend(H.tolist())
  s={'chart':j,'points':25**(5-j),'quotient_rank_drops':len(H),'rank_distribution':{str(r):int(sum(H[:,6]==r)) for r in range(15) if np.any(H[:,6]==r)},'seconds':round(time.time()-t,4)}
  summ.append(s);print(json.dumps(s),flush=True)
  (ROOT/'data'/'f25_scan.partial.json').write_text(json.dumps({'complete':False,'charts':summ,'hits':hits},indent=2)+'\n')
 out={'complete':True,'scope':'P5(F25), not the full algebraic closure','point_count':sum(x['points'] for x in summ),'charts':summ,'hits':hits,'hit_columns':['v0','v1','v2','v3','v4','v5','rank_T_equivariant','rank_Q_equivariant'],'seconds':round(time.time()-start,4)}
 (ROOT/'data'/'f25_scan.json').write_text(json.dumps(out,indent=2)+'\n')
 print('DONE',out['point_count'],'points',len(hits),'rank drops',out['seconds'],'seconds',flush=True)
if __name__=='__main__':main()

