import numpy as np
from numba import njit
from functools import lru_cache
from pathlib import Path
import time
ROOT=Path(__file__).resolve().parents[1]/"data"
ADD=np.zeros((25,25),dtype=np.uint8); MUL=ADD.copy()
for x in range(25):
 for z in range(25):
  a,b=x%5,x//5; c,d=z%5,z//5
  ADD[x,z]=(a+c)%5+5*((b+d)%5)
  MUL[x,z]=(a*c+3*b*d)%5+5*((a*d+b*c+b*d)%5)
NEG=np.array([next(z for z in range(25) if ADD[x,z]==0) for x in range(25)],dtype=np.uint8)
INV=np.array([0]+[next(z for z in range(25) if MUL[x,z]==1) for x in range(1,25)],dtype=np.uint8)

def add(*args):
 r={}
 for p in args:
  for k,v in p.items():
   s=int(ADD[r.get(k,0),v])
   if s:r[k]=s
   elif k in r:del r[k]
 return r

def neg(p):return {k:int(NEG[v]) for k,v in p.items()}
def scale(c,p):return {k:int(MUL[c,v]) for k,v in p.items()} if c else {}
def mono(i=0,j=0,c=1):return {(i,j):c} if c else {}
P={(i,0):c for i,c in enumerate((11,22,18,5,19,20,15,16,9,22,1)) if c}

def mul(p,q):
 r={}
 for (i,j),c in p.items():
  for (h,l),d in q.items():
   w=int(MUL[c,d])
   if j+l<3:
    key=(i+h,j+l); v=int(ADD[r.get(key,0),w])
    if v:r[key]=v
    elif key in r:del r[key]
   else:
    for (n,_),cc in P.items():
     key=(i+h+n,j+l-3); v=int(ADD[r.get(key,0),MUL[w,cc]])
     if v:r[key]=v
     elif key in r:del r[key]
 return r

def power(p,n):
 r=mono()
 while n:
  if n&1:r=mul(r,p)
  n//=2
  if n:p=mul(p,p)
 return r

def pos(p):return {k:v for k,v in p.items() if k[0]>=0}
def tail(p):return {k:v for k,v in p.items() if k[0]<0}
def bas0(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def bas1(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def vec(p,b):return np.array([p.get(k,0) for k in b],dtype=np.uint8)
e={(-m,2):c for m,c in enumerate((2,16,16,7,1,2,7,1,24,11),1)}
E=power(e,25)
u_keys=[(-1,1)]+[(i,2) for i in range(-5,0)]
v_keys=[(-2,0),(-1,0)]+[(i,1) for i in range(-5,0)]+[(i,2) for i in range(-6,0)]

@njit(cache=True)
def rref(M, ncols=-1):
 M=M.copy(); nr,nc=M.shape
 if ncols<0:ncols=nc
 piv=np.zeros(min(nr,ncols),np.int64); r=0
 for c in range(ncols):
  p=r
  while p<nr and M[p,c]==0:p+=1
  if p==nr:continue
  if p!=r:
   for j in range(nc):M[r,j],M[p,j]=M[p,j],M[r,j]
  a=INV[M[r,c]]
  for j in range(c,nc):M[r,j]=MUL[a,M[r,j]]
  for i in range(nr):
   if i!=r and M[i,c]!=0:
    a=NEG[M[i,c]]
    for j in range(c,nc):M[i,j]=ADD[M[i,j],MUL[a,M[r,j]]]
  piv[r]=c; r+=1
  if r==nr:break
 return M,piv[:r]

@njit(cache=True)
def matmul(A,B):
 C=np.zeros((A.shape[0],B.shape[1]),np.uint8)
 for i in range(A.shape[0]):
  for k in range(A.shape[1]):
   if A[i,k]:
    for j in range(B.shape[1]):C[i,j]=ADD[C[i,j],MUL[A[i,k],B[k,j]]]
 return C

def kernel(A):
 R,pivs=rref(A); frees=[j for j in range(A.shape[1]) if j not in set(pivs)]
 K=np.zeros((A.shape[1],len(frees)),np.uint8)
 for i,j in enumerate(frees):
  K[j,i]=1
  for t,p in enumerate(pivs):K[p,i]=NEG[R[t,j]]
 return K

b31,b20,b131,b120=map(bas0,(31,20,131,120))
bm144,bm155=map(bas1,(-144,-155))
sections=[]
for k in b31:
 f=mono(*k); aa=pos(mul(e,f)); sections.append((aa,f))
for k in b20:sections.append((mono(*k),{}))

def column(aa,ff,g0,q0,U,V):
 pp=add(aa,neg(mul(e,ff)))
 uf=mul(U,ff)
 wt=tail(uf)
 cc=add(mul(e,g0),mul(e,wt),neg(mul(U,aa)))
 rhs2=add(mul(E,add(g0,wt)),mul(V,ff))
 hh=neg(pos(rhs2))
 rhs1=add(neg(mul(e,hh)),mul(E,add(q0,neg(tail(cc)))),mul(V,pp))
 return np.concatenate((vec(rhs2,bm144),vec(rhs1,bm155)))

def build():
 t=time.time(); print('start',flush=True)
 A=np.column_stack([column({},{},mono(*k),{},{},{}) for k in b131]+[column({},{},{},mono(*k),{},{}) for k in b120])
 print('A built',A.shape,round(time.time()-t,2),flush=True)
 aug=np.concatenate((A,np.eye(A.shape[0],dtype=np.uint8)),axis=1)
 R,piv=rref(aug,A.shape[1]); rank=len(piv)
 print('A rank',rank,round(time.time()-t,2),flush=True)
 assert rank==235
 L=R[rank:,A.shape[1]:]
 assert not matmul(L,A).any()
 B=np.zeros((19,315,35),np.uint8)
 for j,k in enumerate(u_keys+v_keys):
  U,V=(power(mono(*k),25),{}) if j<6 else ({},power(mono(*k),25))
  for i,(aa,ff) in enumerate(sections):B[j,:,i]=column(aa,ff,{},{},U,V)
  print('B',j,round(time.time()-t,2),flush=True)
 T=np.array([matmul(L,M) for M in B],dtype=np.uint8)
 np.savez_compressed(ROOT/'hom_tensor.npz',A=A,B=B,L=L,T=T,ADD=ADD,MUL=MUL,NEG=NEG,INV=INV)
 print('T',T.shape,'star rank',len(rref(ADD[T[13],MUL[18,T[15]]])[1]),round(time.time()-t,2),flush=True)
 print('basis ranks',[len(rref(x)[1]) for x in T],flush=True)
 return T

if __name__=='__main__':build()
