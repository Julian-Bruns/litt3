"""Exact arithmetic in F_25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
Field elements: integers sum c_i*25**i, c_i in 0..24. No floating-point arithmetic.
Polynomials: ascending one-dimensional integer NumPy arrays; curve elements: triples.
"""
import numpy as np
from pathlib import Path
SIZE=390625; ORDER=SIZE-1
class Field:
 def __init__(self,table_path):
  data=np.fromfile(table_path,dtype='<i4'); assert tuple(data[:2])==(SIZE,ORDER)
  self.primitive=int(data[2]); self.log=data[3:3+SIZE];self.exp=data[3+SIZE:];assert len(self.exp)==ORDER
  a=np.arange(625,dtype=np.int64)[:,None];b=a.T
  self.addsmall=sum(((a//5**i+b//5**i)%5)*5**i for i in range(4)).astype(np.int32)
  self.ad=self.addsmall.ravel().tolist();self.ex=self.exp.tolist();self.lg=self.log.tolist()
  self.negtable=self.mul(np.arange(SIZE,dtype=np.int64),4)
 def add(self,a,b):
  return self.addsmall[np.asarray(a)%625,np.asarray(b)%625]+625*self.addsmall[np.asarray(a)//625,np.asarray(b)//625]
 def sub(self,a,b): return self.add(a,self.negtable[b])
 def mul(self,a,b):
  a,b=np.asarray(a),np.asarray(b)
  return np.where((a==0)|(b==0),0,self.exp[(self.log[a].astype(np.int64)+self.log[b])%ORDER])
 def inv(self,a):
  if np.any(np.asarray(a)==0):raise ZeroDivisionError
  return self.exp[(-self.log[a])%ORDER]
 def pow(self,a,n):
  if n==0:return np.ones_like(a) if isinstance(a,np.ndarray) else 1
  if n<0 and np.any(np.asarray(a)==0):raise ZeroDivisionError
  return np.where(np.asarray(a)==0,0,self.exp[(self.log[a].astype(np.int64)*n)%ORDER])
 def A(self,a,b):return self.ad[(a%625)*625+b%625]+625*self.ad[(a//625)*625+b//625]
 def M(self,a,b):return 0 if not a or not b else self.ex[(self.lg[a]+self.lg[b])%ORDER]
 def N(self,a):return int(self.negtable[a])
 def I(self,a):
  if not a:raise ZeroDivisionError
  return self.ex[(-self.lg[a])%ORDER]
 def P(self,a,n):return (1 if n==0 else (0 if a==0 else self.ex[self.lg[a]*n%ORDER]))
F=None
def init(table):
 global F
 F=Field(table)
 return F

def trim(a):
 a=np.asarray(a,dtype=np.int32).reshape(-1); inds=np.flatnonzero(a)
 return a[:int(inds[-1])+1].copy() if len(inds) else np.zeros(0,dtype=np.int32)
def poly(a=()):return trim(a)
def add(a,b):
 n=max(len(a),len(b));out=np.zeros(n,dtype=np.int32);out[:len(a)]=a;out[:len(b)]=F.add(out[:len(b)],b);return trim(out)
def neg(a):return F.negtable[a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return trim(F.mul(a,c))
def mul(a,b):
 if not len(a) or not len(b):return poly()
 if len(a)>len(b):a,b=b,a
 out=np.zeros(len(a)+len(b)-1,dtype=np.int32)
 for i,c in enumerate(a):
  if c:out[i:i+len(b)]=F.add(out[i:i+len(b)],F.mul(b,c))
 return trim(out)
def power(a,n):
 assert n>=0
 out=poly([1])
 while n:
  if n&1:out=mul(out,a)
  n>>=1
  if n:a=mul(a,a)
 return out
def divmodp(a,b):
 if not len(b):raise ZeroDivisionError
 a=poly(a)
 if len(a)<len(b):return poly(),a
 out=np.zeros(len(a)-len(b)+1,dtype=np.int32);inv=F.I(int(b[-1]))
 for d in range(len(out)-1,-1,-1):
  c=F.M(int(a[d+len(b)-1]),inv);out[d]=c
  if c:a[d:d+len(b)]=F.sub(a[d:d+len(b)],F.mul(b,c))
 return trim(out),trim(a[:len(b)-1])
def rem(a,b):return divmodp(a,b)[1]
def exactdiv(a,b):
 q,r=divmodp(a,b)
 if len(r):raise ArithmeticError('inexact polynomial division')
 return q
def derivative(a):return trim(F.mul(a[1:],np.arange(1,len(a))%5))
def evaluate(a,x):
 v=np.zeros_like(x) if isinstance(x,np.ndarray) else 0
 for c in a[::-1]:v=F.add(F.mul(v,x),c)
 return v

def czero():return (poly(),poly(),poly())
def cone():return (poly([1]),poly(),poly())
def cadd(a,b):return tuple(add(x,y) for x,y in zip(a,b))
def cneg(a):return tuple(neg(x) for x in a)
def csub(a,b):return cadd(a,cneg(b))
def cscale(a,c):return tuple(scale(x,c) for x in a)
def cpoly(a,p):return tuple(mul(x,p) for x in a)
def cmul(a,b,P):
 out=list(czero())
 for i in range(3):
  for j in range(3):
   term=mul(a[i],b[j]);k=i+j
   if k>=3:term=mul(term,P);k-=3
   out[k]=add(out[k],term)
 return tuple(out)
def cpow(a,n,P):
 out=cone()
 while n:
  if n&1:out=cmul(out,a,P)
  n>>=1
  if n:a=cmul(a,a,P)
 return out

def monomial(i,j,c=1):
 out=list(czero());out[j]=np.zeros(i+1,dtype=np.int32);out[j][i]=c;return tuple(out)
def Lbasis(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1)]
def coeff(g,i,j):return int(g[j][i]) if len(g[j])>i else 0

def rref(A,B):
 """Return reduced A, RHS B and pivot columns, with exact consistency checks."""
 A=A.copy().astype(np.int32);B=B.copy().astype(np.int32);row=0;piv=[]
 for col in range(A.shape[1]):
  choices=np.flatnonzero(A[row:,col])
  if not len(choices):continue
  k=row+int(choices[0]);A[[row,k]]=A[[k,row]];B[[row,k]]=B[[k,row]]
  inverse=F.I(int(A[row,col]));A[row]=F.mul(A[row],inverse);B[row]=F.mul(B[row],inverse)
  ix=np.flatnonzero(A[:,col]);ix=ix[ix!=row]
  factors=A[ix,col].copy()
  A[ix]=F.sub(A[ix],F.mul(factors[:,None],A[row][None,:]))
  B[ix]=F.sub(B[ix],F.mul(factors[:,None],B[row][None,:]))
  piv.append(col);row+=1
  if row==A.shape[0]:break
 if np.any(B[row:]):raise ArithmeticError('inconsistent affine system')
 return A,B,piv

def solve_affine(A,B):
 A,B,piv=rref(A,B);free=[i for i in range(A.shape[1]) if i not in piv]
 sol=np.zeros((A.shape[1],B.shape[1]+len(free)),dtype=np.int32)
 sol[piv,:B.shape[1]]=B[:len(piv)]
 for k,j in enumerate(free):
  sol[j,B.shape[1]+k]=1;sol[piv,B.shape[1]+k]=F.negtable[A[:len(piv),j]]
 return sol,piv,free
