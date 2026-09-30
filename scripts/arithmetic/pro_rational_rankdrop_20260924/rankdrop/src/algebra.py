"""Exact GF(25), reduced Laurent algebra, and exact linear algebra.
Elements c0+5*c1 encode c0+c1*a, with a*a=a+3. No floating point.
"""
import numpy as np
from dataclasses import dataclass
from numba import njit

ADD=np.empty((25,25),np.uint8); MUL=ADD.copy()
for x in range(25):
 for y in range(25):
  x0,x1=x%5,x//5; y0,y1=y%5,y//5
  ADD[x,y]=(x0+y0)%5+5*((x1+y1)%5)
  MUL[x,y]=(x0*y0+3*x1*y1)%5+5*((x0*y1+x1*y0+x1*y1)%5)
NEG=np.array([(-x%5)%5+5*((-(x//5))%5) for x in range(25)],np.uint8)
INV=np.zeros(25,np.uint8)
for x in range(1,25): INV[x]=next(y for y in range(1,25) if MUL[x,y]==1)

def conv(a,b):
 a0=a.astype(np.int64)%5; a1=a.astype(np.int64)//5
 b0=b.astype(np.int64)%5; b1=b.astype(np.int64)//5
 c11=np.convolve(a1,b1)
 return ((np.convolve(a0,b0)+3*c11)%5+5*((np.convolve(a0,b1)+np.convolve(a1,b0)+c11)%5)).astype(np.uint8)
P=np.array([11,22,18,5,19,20,15,16,9,22,1],np.uint8)

@dataclass
class LP:
 c: np.ndarray
 lo: int=0
 def __post_init__(self):
  self.c=np.asarray(self.c,dtype=np.uint8)
  assert self.c.ndim==2 and self.c.shape[0]==3
  nz=np.flatnonzero(np.any(self.c,axis=0))
  if len(nz):
   self.lo+=int(nz[0]); self.c=self.c[:,nz[0]:nz[-1]+1].copy()
  else: self.c=np.zeros((3,1),np.uint8); self.lo=0
 @staticmethod
 def zero(): return LP(np.zeros((3,1),np.uint8))
 @staticmethod
 def mon(i,j=0,k=1):
  assert 0<=j<3
  a=np.zeros((3,1),np.uint8);a[j,0]=k
  return LP(a,i)
 def __add__(self,o):
  lo=min(self.lo,o.lo); hi=max(self.lo+self.c.shape[1],o.lo+o.c.shape[1])
  a=np.zeros((3,hi-lo),np.uint8);a[:,self.lo-lo:self.lo-lo+self.c.shape[1]]=self.c
  sl=slice(o.lo-lo,o.lo-lo+o.c.shape[1]);a[:,sl]=ADD[a[:,sl],o.c]
  return LP(a,lo)
 def __neg__(self): return LP(NEG[self.c],self.lo)
 def __sub__(self,o): return self+-o
 def scale(self,k): return LP(MUL[k,self.c],self.lo)
 def __mul__(self,o):
  n=self.c.shape[1]+o.c.shape[1]-1
  a=np.zeros((5,n),np.uint8)
  for i in range(3):
   if not np.any(self.c[i]):continue
   for j in range(3):
    if np.any(o.c[j]):a[i+j]=ADD[a[i+j],conv(self.c[i],o.c[j])]
  c=np.zeros((3,n+10),np.uint8);c[:,:n]=a[:3]
  for j in (3,4):
   if np.any(a[j]):c[j-3]=ADD[c[j-3],conv(a[j],P)]
  return LP(c,self.lo+o.lo)
 def __pow__(self,n):
  assert n>=0
  a=LP.mon(0);b=self
  while n:
   if n&1:a=a*b
   n//=2
   if n:b=b*b
  return a
 def plus(self):
  c=self.c.copy();c[:,:max(0,min(c.shape[1],-self.lo))]=0
  return LP(c,self.lo)
 def minus(self): return self-self.plus()
 def coeff(self,i,j):
  return int(self.c[j,i-self.lo]) if 0<=i-self.lo<self.c.shape[1] else 0
 def terms(self):
  return [[int(i+self.lo),int(j),int(self.c[j,i])] for j,i in zip(*np.nonzero(self.c))]
 def iszero(self):return not np.any(self.c)
 def vec(self,bas):return np.array([self.coeff(i,j) for i,j in bas],np.uint8)
 def equal(self,o):return (self-o).iszero()


def B0(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def B1(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def linear_comb(coeffs,polys):
 p=LP.zero()
 for c,q in zip(coeffs,polys):
  if c:p=p+q.scale(int(c))
 return p

@njit(cache=True)
def mm(A,B):
 m,n=A.shape;n2,p=B.shape;assert n==n2
 C=np.zeros((m,p),np.uint8)
 for i in range(m):
  for k in range(n):
   if A[i,k]:
    for j in range(p):C[i,j]=ADD[C[i,j],MUL[A[i,k],B[k,j]]]
 return C

@njit(cache=True)
def rref(A):
 A=A.copy();m,n=A.shape;piv=np.empty(min(m,n),np.int64);r=0
 for c in range(n):
  pr=r
  while pr<m and A[pr,c]==0:pr+=1
  if pr==m:continue
  for j in range(n):A[r,j],A[pr,j]=A[pr,j],A[r,j]
  iv=INV[A[r,c]]
  for j in range(c,n):A[r,j]=MUL[iv,A[r,j]]
  for i in range(m):
   if i!=r and A[i,c]:
    a=NEG[A[i,c]]
    for j in range(c,n):A[i,j]=ADD[A[i,j],MUL[a,A[r,j]]]
  piv[r]=c;r+=1
  if r==m:break
 return A,piv[:r]

def nullspace(A):
 R,p=rref(np.asarray(A,dtype=np.uint8));free=[i for i in range(A.shape[1]) if i not in p]
 N=np.zeros((len(free),A.shape[1]),np.uint8)
 for j,f in enumerate(free):
  N[j,f]=1;N[j,p]=NEG[R[:len(p),f]]
 return N

def rank(A):return len(rref(np.asarray(A,dtype=np.uint8))[1])
