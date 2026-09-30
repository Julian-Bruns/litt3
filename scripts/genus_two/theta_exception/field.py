"""Exact F_125, alpha^3+alpha+1=0, using the question's codes."""
import numpy as np
Q=125
DIG=np.array([[i%5,(i//5)%5,i//25] for i in range(Q)],dtype=np.int16)
ADD=np.sum(((DIG[:,None,:]+DIG[None,:,:])%5)*np.array([1,5,25]),axis=2).astype(np.int16)
NEG=np.sum((-DIG%5)*np.array([1,5,25]),axis=1).astype(np.int16)
SUB=ADD[:,NEG]
MUL=np.zeros((Q,Q),dtype=np.int16)
for i,a in enumerate(DIG):
 for j,b in enumerate(DIG):
  c=[0]*5
  for n in range(3):
   for m in range(3): c[n+m]+=int(a[n]*b[m])
  for n in (4,3): c[n-2]-=c[n];c[n-3]-=c[n]
  MUL[i,j]=sum((c[n]%5)*5**n for n in range(3))
INV=np.zeros(Q,dtype=np.int16)
for i in range(1,Q): INV[i]=np.where(MUL[i,:]==1)[0][0]
def add(a,b): return int(ADD[a,b])
def sub(a,b): return int(SUB[a,b])
def neg(a):return int(NEG[a])
def mul(a,b):return int(MUL[a,b])
def inv(a):
 if a==0: raise ZeroDivisionError
 return int(INV[a])
def div(a,b): return mul(a,inv(b))
def power(a,n):
 if n<0:return power(inv(a),-n)
 r=1
 while n:
  if n&1:r=mul(r,a)
  a=mul(a,a);n//=2
 return r

def peval(f,x):
 r=0
 for c in reversed(f):r=add(mul(r,x),c)
 return r

def trim(f):
 f=list(map(int,f))
 while f and f[-1]==0:f.pop()
 return f

def padd(a,b):
 c=[0]*max(len(a),len(b))
 for i in range(len(a)):c[i]=a[i]
 for i in range(len(b)):c[i]=add(c[i],b[i])
 return trim(c)
def pneg(a):return [neg(x) for x in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([mul(x,c) for x in a])
def pmul(a,b):
 c=[0]*(len(a)+len(b)-1)
 if not a or not b:return []
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
 return trim(c)
def pdivrem(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 c=[0]*max(0,(len(a)-len(b)+1))
 while len(a)>=len(b):
  j=len(a)-len(b);t=div(a[-1],b[-1]);c[j]=t
  for i in range(len(b)):a[i+j]=sub(a[i+j],mul(t,b[i]))
  a=trim(a)
 return trim(c),a

def pmod(a,b):return pdivrem(a,b)[1]
def pexact(a,b):
 q,r=pdivrem(a,b);assert not r,(a,b,r)
 return q

def pmonic(a):return pscale(a,inv(a[-1])) if a else []
def pxgcd(a,b):
 x0,x1=[1],[];y0,y1=[],[1]
 while b:
  q,r=pdivrem(a,b);a,b=b,r
  x0,x1=x1,psub(x0,pmul(q,x1));y0,y1=y1,psub(y0,pmul(q,y1))
 c=inv(a[-1]);return pscale(a,c),pscale(x0,c),pscale(y0,c)

def rref(A,aug=0):
 A=np.array(A,dtype=np.int16,copy=True)
 m,n=A.shape; piv=[]; r=0
 for c in range(n-aug):
  nz=np.flatnonzero(A[r:,c])
  if not len(nz):continue
  j=r+int(nz[0]);A[[r,j]]=A[[j,r]];A[r]=MUL[A[r],INV[A[r,c]]]
  rows=np.flatnonzero(A[:,c]);rows=rows[rows!=r]
  if len(rows):A[rows]=SUB[A[rows],MUL[A[rows,c,None],A[r,None,:]]]
  piv.append(c);r+=1
  if r==m:break
 return A,piv

def nullspace(A):
 R,piv=rref(A);m,n=R.shape
 free=[i for i in range(n) if i not in piv]
 B=np.zeros((len(free),n),dtype=np.int16)
 for j,f in enumerate(free):
  B[j,f]=1;B[j,piv]=NEG[R[:len(piv),f]]
 return B

def solve(A,b):
 A=np.array(A,dtype=np.int16);b=np.array(b,dtype=np.int16)
 if b.ndim==1:b=b[:,None]
 R,piv=rref(np.concatenate((A,b),axis=1),aug=b.shape[1]);n=A.shape[1]
 assert not np.any(R[len(piv):,n:]),'inconsistent'
 assert len(piv)==n,'underdetermined'
 return R[:n,n:]

def matmul(A,B):
 A=np.asarray(A,dtype=np.int16);B=np.asarray(B,dtype=np.int16)
 C=np.zeros((A.shape[0],B.shape[1]),dtype=np.int16)
 for k in range(A.shape[1]):C=ADD[C,MUL[A[:,k,None],B[None,k,:]]]
 return C

def dot(a,b):
 r=0
 for x,y in zip(a,b):r=add(r,mul(x,y))
 return r

def normalize(x):
 a=next((a for a in x if a),0)
 if not a:raise ValueError('zero vector')
 return tuple(mul(b,inv(a)) for b in x)

def polystr(f,var='a'):
 return '+'.join((str(d) if j==0 else f'{d}*{var}'+(f'^{j}' if j>1 else '')) for j,d in enumerate(DIG[f]) if d) or '0'

if __name__=='__main__':
 assert power(5,3)==neg(add(5,1));assert all(power(x,125)==x for x in range(125))
 print('F125 checks pass, alpha^5 =',power(5,5))
