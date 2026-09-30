"""Exact F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
Portable integer code c0+25*c1+625*c2+15625*c3, ci in the user's F25 code.
Lookup files are generated, not external input. All scalar arithmetic exact.
"""
from pathlib import Path
import array
import numpy as np
ROOT=Path(__file__).resolve().parents[1]
def _read(name, typ):
 a=array.array(typ); a.frombytes((ROOT/'data'/name).read_bytes()); return a.tolist()
LOG=_read('field_log.bin','i');EXP=_read('field_exp.bin','i');ADD=_read('field_add.bin','H')
ORDER=390625

def add(a,b):return ADD[(a%625)*625+b%625]+625*ADD[(a//625)*625+b//625]
def mul(a,b):return EXP[LOG[a]+LOG[b]] if a and b else 0
def neg(a):return mul(4,a)
def sub(a,b):return add(a,neg(b))
def inv(a):
 if not a:raise ZeroDivisionError('F_(5^8) inverse of zero')
 return EXP[390624-LOG[a]]
def div(a,b):return mul(a,inv(b))
def powf(a,n):
 if n==0:return 1
 if a==0:
  if n<0:raise ZeroDivisionError
  return 0
 return EXP[(LOG[a]*n)%390624]
def sumf(xs):
 z=0
 for x in xs:z=add(z,x)
 return z
AD=np.array(ADD,dtype=np.int32).reshape(625,625); LG=np.array(LOG,dtype=np.int32);EX=np.array(EXP,dtype=np.int32)
def vadd(a,b):return AD[a%625,b%625]+625*AD[a//625,b//625]
def vmul(a,b):
 a=np.asarray(a,dtype=np.int32);b=np.asarray(b,dtype=np.int32)
 out=EX[np.maximum(0,LG[a]+LG[b])]
 return np.where((a==0)|(b==0),0,out)
def vsub(a,b):return vadd(a,vmul(4,b))
def rref(matrix):
 A=np.array(matrix,dtype=np.int32,copy=True);m,n=A.shape;i=0;piv=[]
 for j in range(n):
  ids=np.flatnonzero(A[i:,j])
  if not len(ids):continue
  q=i+ids[0];A[[i,q]]=A[[q,i]]
  A[i,j:]=vmul(A[i,j:],inv(int(A[i,j])))
  ids=np.flatnonzero(A[:,j]);ids=ids[ids!=i]
  if len(ids):A[ids,j:]=vsub(A[ids,j:],vmul(A[ids,j,None],A[i,None,j:]))
  piv.append(j);i+=1
  if i==m:break
 return A,piv

def kernel(matrix):
 A,piv=rref(matrix);n=A.shape[1];free=[j for j in range(n) if j not in piv];B=np.zeros((len(free),n),dtype=np.int32)
 for i,j in enumerate(free):
  B[i,j]=1
  for k,p in enumerate(piv):B[i,p]=neg(int(A[k,j]))
 return B,piv

def solve(A,b):
 A=np.array(A,dtype=np.int32);b=np.array(b,dtype=np.int32)
 if b.ndim==1:b=b[:,None]
 m,n=A.shape;R,piv=rref(np.concatenate([A,b],axis=1))
 if any(j>=n for j in piv):raise ValueError('Inconsistent linear system')
 X=np.zeros((n,b.shape[1]),dtype=np.int32)
 for k,p in enumerate(piv):X[p]=R[k,n:]
 return X

def dot(a,b):return sumf(mul(int(x),int(y)) for x,y in zip(a,b))

def trim(p):
 p=list(p)
 while p and p[-1]==0:p.pop()
 return p

def padd(a,b):
 c=list(a)+[0]*max(0,len(b)-len(a))
 for i,x in enumerate(b):c[i]=add(c[i],x)
 return trim(c)
def pneg(a):return [neg(x) for x in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,s):return trim([mul(x,s) for x in a])
def pmul(a,b):
 if not a or not b:return []
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b):
    if y:c[i+j]=add(c[i+j],mul(x,y))
 return trim(c)
def ppow(a,n):
 if n<0:raise ValueError
 z=[1]
 while n:
  if n&1:z=pmul(z,a)
  a=pmul(a,a);n>>=1
 return z

def pdivmod(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 if len(a)<len(b):return [],a
 q=[0]*(len(a)-len(b)+1);bi=inv(b[-1])
 while len(a)>=len(b):
  s=mul(a[-1],bi);d=len(a)-len(b);q[d]=s
  for j,x in enumerate(b):a[d+j]=sub(a[d+j],mul(s,x))
  a=trim(a)
 return trim(q),a

def pdiv(a,b):
 q,r=pdivmod(a,b)
 if r:raise ValueError('inexact polynomial division')
 return q

def pmod(a,b):return pdivmod(a,b)[1]
def peval(a,x):
 z=0
 for u in reversed(a):z=add(mul(z,x),u)
 return z

def pgcd(a,b):
 while b:a,b=b,pmod(a,b)
 return pscale(a,inv(a[-1])) if a else []
def pder(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
