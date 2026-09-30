#!/usr/bin/env python3
"""Experimental extension of the audited cubic arithmetic through source15625.

The lower-stage source is preserved unchanged as witt_cubic.py. This
version adds the sixth coefficient modulus and the corresponding fifth
nilpotent-inverse term. It is not a sixth-obstruction certificate.

Exact cubic unramified Witt/Laurent arithmetic for reference reconstruction.

Adapted from the independently replayed rank25 fifth engine's witt.py,
preserved in litt3-computation-data/rank25-w5-fresh-replay-20260911-j8b7nf2m.
Only arithmetic is imported from that method, not its curve or marking.
The present ring is (Z/5^m)[T]/(T^3+T+1). Series precision is absolute
exclusive; every division by5 is checked. No fifth result is asserted.
"""
import os
import numpy as np
from functools import lru_cache

DEG=3
MOD=int(os.environ.get("LITT3_REFERENCE_MODULUS","25"))
MAX=int(os.environ.get("LITT3_REFERENCE_PRECISION","500"))
assert MOD in (5,25,125,625,3125,15625)
assert MAX>=150
Q=np.array([1,1,0,1],dtype=np.int64)

def ca(x):
 if isinstance(x,(int,np.integer)): return np.array([x%MOD]+[0]*(DEG-1),dtype=np.int64)
 a=np.zeros(DEG,dtype=np.int64); x=np.array(x,dtype=np.int64).ravel(); a[:len(x)]=x;return a%MOD
ONE=ca(1); T=ca([0,1]); ZERO=ca(0)
def cm(a,b):
 c=np.convolve(ca(a),ca(b))%MOD
 for i in range(2*DEG-2,DEG-1,-1):
  for j in range(DEG):c[i-DEG+j]-=c[i]*Q[j]
  c%=MOD
 return c[:DEG]
def cp(a,n):
 a=ca(a);o=ONE
 while n:
  if n&1:o=cm(o,a)
  a=cm(a,a);n//=2
 return o
@lru_cache(None)
def _ci(a):
 a=ca(a)
 if not np.any(a%5):raise ZeroDivisionError(a)
 x=cp(a,5**DEG-2)
 for _ in range(3):x=cm(x,(ca(2)-cm(a,x))%MOD)
 assert np.array_equal(cm(a,x),ONE)
 return x

def ci(a):return _ci(tuple(ca(a)))
def cdiv(a,b):return cm(a,ci(b))
def trim(a):
 a=np.array(a,dtype=np.int64)%MOD
 if a.ndim==1:a=a.reshape(DEG,1)
 ix=np.flatnonzero(np.any(a,axis=0))
 return a[:,:ix[-1]+1] if len(ix) else np.zeros((DEG,1),dtype=np.int64)
try:
 from neutral5_gmp_convolution import conv as gmp_conv
except (ImportError,OSError,AttributeError):
 gmp_conv=np.convolve

def exact_conv(a,b):
 return np.convolve(a,b) if min(len(a),len(b))<48 else gmp_conv(a,b)

def pm(a,b):
 a=trim(a);b=trim(b);c=np.zeros((2*DEG-1,a.shape[1]+b.shape[1]-1),dtype=np.int64)
 for i in range(DEG):
  for j in range(DEG):c[i+j]+=exact_conv(a[i],b[j])
 c%=MOD
 for i in range(2*DEG-2,DEG-1,-1):
  for j in range(DEG):c[i-DEG+j]-=Q[j]*c[i]
  c%=MOD
 return trim(c[:DEG])
def padd(a,b):
 n=max(a.shape[1],b.shape[1]);c=np.zeros((DEG,n),dtype=np.int64);c[:,:a.shape[1]]+=a;c[:,:b.shape[1]]+=b;return trim(c)
def pneg(a):return (-a)%MOD

def pscale(a,b):return pm(a,ca(b).reshape(DEG,1))

def pdiv(a,b,field=False):
 mod=5 if field else MOD
 a=trim(a%mod).copy();b=trim(b%mod);d=b.shape[1]-1
 if not np.any(b):raise ZeroDivisionError
 q=np.zeros((DEG,max(1,a.shape[1]-d)),dtype=np.int64)
 bi=ci(b[:,-1])%mod
 while np.any(a) and a.shape[1]>d:
  j=a.shape[1]-1-d;c=cm(a[:,-1],bi)%mod;q[:,j]=c
  a[:,j:j+d+1]=(a[:,j:j+d+1]-pscale(b,c))%mod
  a=trim(a)
 return trim(q),trim(a)

def pxgcd(a,b):
 a=trim(a%5);b=trim(b%5);s0=ca(1).reshape(DEG,1);s1=ca(0).reshape(DEG,1);t0=s1.copy();t1=s0.copy()
 while np.any(b):
  q,r=pdiv(a,b,True);a,b=b,r
  s0,s1=s1,padd(s0,-pm(q,s1))%5;t0,t1=t1,padd(t0,-pm(q,t1))%5
 c=ci(a[:,-1])%5
 return pscale(a,c)%5,pscale(s0,c)%5,pscale(t0,c)%5

def pd(a):return trim(a[:,1:]*np.arange(1,a.shape[1]))
def ppow(a,n):
 o=ca(1).reshape(DEG,1)
 while n:
  if n&1:o=pm(o,a)
  a=pm(a,a);n//=2
 return o

def peval(a,b):
 if isinstance(b,Ser):
  o=Ser(0)
  for c in a.T[::-1]:o=o*b+Ser(c)
  return o
 o=ca(0).reshape(DEG,1)
 for c in a.T[::-1]:o=padd(pm(o,b),c.reshape(DEG,1))
 return o

# Laurent series, truncation up to a common high order, chosen large for low-order computations.
INF = 10**9
class Ser:
 """Laurent series over the unramified coefficient ring, with z-adic precision.

 ``prec`` is an absolute, exclusive precision: all coefficients below it
 are certified. Finite Laurent polynomials have infinite precision until
 the configured workspace truncates them. Arithmetic propagates precision.
 """
 def __init__(self,a=0,l=0,prec=INF):
  if isinstance(a,Ser):
   self.a=a.a.copy();self.l=a.l;self.prec=min(a.prec,prec);return
  ar=np.array(a,dtype=np.int64)
  if ar.ndim==0:ar=ca(int(ar)).reshape(DEG,1)
  elif ar.ndim==1:ar=ca(ar).reshape(DEG,1)
  ar=ar%MOD; self.prec=int(prec)
  ix=np.flatnonzero(np.any(ar,axis=0))
  if not len(ix):self.a=np.zeros((DEG,1),dtype=np.int64);self.l=0;return
  if ix[-1]+l>=MAX:self.prec=min(self.prec,MAX)
  first=int(ix[0]);last=min(int(ix[-1])+1,MAX-l,self.prec-l)
  if last<=first:self.a=np.zeros((DEG,1),dtype=np.int64);self.l=0;return
  self.a=ar[:,first:last].copy();self.l=int(l+first)
 @property
 def valuation(self):return self.l if np.any(self.a) else self.prec
 def __add__(self,b):
  b=Ser(b);lo=min(self.l,b.l);hi=max(self.end,b.end)
  ar=np.zeros((DEG,hi-lo),dtype=np.int64)
  for s in [self,b]:ar[:,s.l-lo:s.end-lo]+=s.a
  return Ser(ar,lo,min(self.prec,b.prec))
 __radd__=__add__
 def __neg__(self):return Ser(-self.a,self.l,self.prec)
 def __sub__(self,b):return self+-Ser(b)
 def __rsub__(self,b):return Ser(b)+-self
 def __mul__(self,b):
  b=Ser(b)
  precision=min(self.prec+b.valuation,b.prec+self.valuation,INF)
  return Ser(pm(self.a,b.a),self.l+b.l,precision)
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  a=self;o=Ser(1)
  while n:
   if n&1:o=o*a
   a=a*a;n//=2
  return o
 def as_poly(self):
  """Treat a finite Newton approximation as a Laurent polynomial."""
  return Ser(self.a,self.l)
 def inv(self):
  if self.iszero():raise ZeroDivisionError('zero Laurent series')
  if not np.any(self.a[:,0]%5):
   # A nilpotent polar tail can precede the first unit coefficient.
   # Invert the mod-5 part and use the finite nilpotent geometric series.
   base=self.mod(5);iv=base.inv();e=(self-base)*iv
   level=0;power=1
   while power<MOD:level+=1;power*=5
   series=Ser(1);term=Ser(1)
   for _ in range(1,level):term=-term*e;series=series+term
   return iv*series
  a=Ser(self.a,0,self.prec-self.l)
  work=min(MAX,self.prec-self.l)
  if work<=0:raise ArithmeticError('Insufficient precision for inversion')
  out=Ser(ci(self.a[:,0]));n=1
  while n<work:
   n=min(2*n,work)
   out=(out*(2-a*out)).cut(n).as_poly()
  precision=min(self.prec-2*self.l,work-self.l)
  return Ser(out.a,-self.l,precision)
 def __truediv__(self,b):return self*Ser(b).inv()
 def __rtruediv__(self,b):return Ser(b)*self.inv()
 @property
 def end(self):return self.l+self.a.shape[1]
 def iszero(self):return not np.any(self.a)
 def shift(self,n):return Ser(self.a,self.l+n,min(INF,self.prec+n))
 def cut(self,n):return Ser(self.a,self.l,min(self.prec,n))
 def coef(self,n):
  if n>=self.prec:raise ArithmeticError(f'Coefficient {n} requested at precision {self.prec}')
  return self.a[:,n-self.l].copy() if self.l<=n<self.end else ca(0)
 def deriv(self):return Ser(self.a*np.arange(self.l,self.end),self.l-1,self.prec-1)
 def mod(self,n):return Ser(self.a%n,self.l,self.prec)
 def divint(self,n):
  if not np.all(self.a%n==0):raise ArithmeticError(f'Nonintegral division by {n}')
  return Ser(self.a//n,self.l,self.prec)
 def sigma(self):return Ser(SIGMAT@self.a%MOD,self.l,self.prec)
 def frob(self):
  ar=np.zeros((DEG,5*(self.a.shape[1]-1)+1),dtype=np.int64)
  ar[:,::5]=SIGMAT@self.a%MOD
  return Ser(ar,5*self.l,min(INF,5*self.prec))
 def sqrt1(self):
  assert self.l==0 and np.array_equal(self.coef(0),ONE)
  out=Ser(1);n=1;work=min(MAX,self.prec)
  while n<work:
   n=min(n*2,work)
   out=((out+self/out)*Ser(ci(2))).cut(n).as_poly()
  return Ser(out.a,0,work)
 def __repr__(self):
  terms=[]
  for i,c in enumerate(self.a.T):
   if np.any(c):terms.append(f'{tuple(map(int,c))}*z^{i+self.l}')
   if len(terms)>6:terms.append('...');break
  return ' + '.join(terms) or '0'

SIGT=cp(T,5)
for _ in range(3):
 qq=sum((cp(SIGT,i)*Q[i] for i in range(DEG+1)),start=ca(0))%MOD
 dq=sum((cp(SIGT,i-1)*(i*Q[i]) for i in range(1,DEG+1)),start=ca(0))%MOD
 SIGT=(SIGT-cdiv(qq,dq))%MOD
SIGMAT=np.array([cp(SIGT,i) for i in range(DEG)]).T
Z=Ser(1,1)

def linear_solve(A,b):
 # coefficients: A rows x cols x DEG, b rows x DEG
 A=np.asarray(A,dtype=np.int64)%5;b=np.asarray(b,dtype=np.int64)%5
 nr,nc,_=A.shape;M=np.concatenate([A,b[:,None,:]],axis=1);pivs=[];r=0
 for c in range(nc):
  rr=next((j for j in range(r,nr) if np.any(M[j,c])),None)
  if rr is None:continue
  M[[r,rr]]=M[[rr,r]];iv=ci(M[r,c])%5
  M[r]=np.array([cm(x,iv)%5 for x in M[r]])
  for j in range(nr):
   if j!=r and np.any(M[j,c]):M[j]=(M[j]-np.array([cm(M[j,c],x)%5 for x in M[r]]))%5
  pivs.append(c);r+=1
 for j in range(r,nr):
  if np.any(M[j,-1]):raise ValueError(('inconsistent',j,M[j]))
 x=np.zeros((nc,DEG),dtype=np.int64)
 for j,c in enumerate(pivs):x[c]=M[j,-1]
 return x,pivs
