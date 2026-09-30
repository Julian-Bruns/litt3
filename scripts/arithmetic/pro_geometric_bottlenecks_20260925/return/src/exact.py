"""Exact arithmetic for F_25 and Laurent representatives; no symbolic black boxes."""
from __future__ import annotations
import numpy as np
from numba import njit
ADD=np.zeros((25,25),dtype=np.uint8)
MUL=ADD.copy()
for a in range(25):
 for b in range(25):
  a0,a1=a%5,a//5;b0,b1=b%5,b//5
  ADD[a,b]=(a0+b0)%5+5*((a1+b1)%5)
  MUL[a,b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
NEG=np.array([next(b for b in range(25) if ADD[a,b]==0) for a in range(25)],dtype=np.uint8)
INV=np.array([0]+[next(b for b in range(1,25) if MUL[a,b]==1) for a in range(1,25)],dtype=np.uint8)

@njit(cache=True)
def rref(A, ncols=-1):
 A=A.copy(); m,n=A.shape
 if ncols<0:ncols=n
 piv=np.empty(min(m,ncols),dtype=np.int64); rank=0
 for j in range(ncols):
  ii=rank
  while ii<m and A[ii,j]==0:ii+=1
  if ii==m:continue
  for c in range(n):
   A[rank,c],A[ii,c]=A[ii,c],A[rank,c]
  v=INV[A[rank,j]]
  for c in range(j,n): A[rank,c]=MUL[A[rank,c],v]
  for i in range(m):
   if i==rank:continue
   v=NEG[A[i,j]]
   if v!=0:
    for c in range(j,n):A[i,c]=ADD[A[i,c],MUL[v,A[rank,c]]]
  piv[rank]=j;rank+=1
  if rank==m:break
 return A,piv[:rank]

@njit(cache=True)
def rank(A):
 A=A.copy(); m,n=A.shape;rank=0
 for j in range(n):
  ii=rank
  while ii<m and A[ii,j]==0:ii+=1
  if ii==m:continue
  for c in range(j,n): A[rank,c],A[ii,c]=A[ii,c],A[rank,c]
  v=INV[A[rank,j]]
  for c in range(j,n):A[rank,c]=MUL[A[rank,c],v]
  for i in range(rank+1,m):
   v=NEG[A[i,j]]
   if v!=0:
    for c in range(j,n):A[i,c]=ADD[A[i,c],MUL[v,A[rank,c]]]
  rank+=1
  if rank==m:break
 return rank

@njit(cache=True)
def mm(A,B):
 m,k=A.shape;k2,n=B.shape
 assert k==k2
 C=np.zeros((m,n),dtype=np.uint8)
 for i in range(m):
  for s in range(k):
   if A[i,s]:
    for j in range(n): C[i,j]=ADD[C[i,j],MUL[A[i,s],B[s,j]]]
 return C

def kernel(A):
 R,p=rref(A);free=[j for j in range(A.shape[1]) if j not in p]
 N=np.zeros((A.shape[1],len(free)),dtype=np.uint8)
 for l,j in enumerate(free):
  N[j,l]=1
  for i,c in enumerate(p): N[c,l]=NEG[R[i,j]]
 return N

@njit(cache=True)
def pencil(T,z):
 a,m,n=T.shape
 out=np.zeros((m,n),dtype=np.uint8)
 for l in range(a):
  if z[l]:
   for i in range(m):
    for j in range(n):out[i,j]=ADD[out[i,j],MUL[z[l],T[l,i,j]]]
 return out

P_ROW=[11,22,18,5,19,20,15,16,9,22,1]
C_ROW=[2,16,16,7,1,2,7,1,24,11]
P={(i,0):c for i,c in enumerate(P_ROW) if c}

def add(*args):
 out={}
 for p in args:
  for k,c in p.items():
   d=int(ADD[out.get(k,0),c])
   if d:out[k]=d
   else:out.pop(k,None)
 return out

def neg(p):return {k:int(NEG[c]) for k,c in p.items()}
def scale(p,c):return {k:int(MUL[c,v]) for k,v in p.items()} if c else {}
def mon(i,j=0,c=1):return {(i,j):int(c)} if c else {}

def mul(p,q):
 out={}
 for (i,j),a in p.items():
  for (h,l),b in q.items():
   v=int(MUL[a,b])
   if j+l<3:
    k=(i+h,j+l);d=int(ADD[out.get(k,0),v])
    if d:out[k]=d
    else:out.pop(k,None)
   else:
    for (s,_),pc in P.items():
     k=(i+h+s,j+l-3);d=int(ADD[out.get(k,0),MUL[v,pc]])
     if d:out[k]=d
     else:out.pop(k,None)
 return out

def power(p,n):
 out=mon(0)
 while n:
  if n%2:out=mul(out,p)
  p=mul(p,p);n//=2
 return out

def positive(p):return {k:c for k,c in p.items() if k[0]>=0}
def negative(p):return {k:c for k,c in p.items() if k[0]<0}
def basis(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def obstruction_basis(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def vector(p,bs):return np.array([p.get(k,0) for k in bs],dtype=np.uint8)
def from_vector(v,bs):return {k:int(c) for c,k in zip(v,bs) if c}
def encode(p):return [[i,j,c] for (i,j),c in sorted(p.items(),key=lambda z:(z[0][1],z[0][0]))]
def decode(p):return {(i,j):c for i,j,c in p}

e={(i,2):c for i,c in zip(range(-1,-11,-1),C_ROW)}
u_basis=[(-1,1)]+[(i,2) for i in range(-5,0)]
v_basis=[(-2,0),(-1,0)]+[(i,1) for i in range(-5,0)]+[(i,2) for i in range(-6,0)]

def frob25(p):
 out={}
 for (i,j),c in p.items():
  out=add(out,scale(mul(mon(i*25,(j*25)%3),power(P,(j*25)//3)),c))
 return out
