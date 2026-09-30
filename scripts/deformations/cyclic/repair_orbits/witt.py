# Adapted locally21 September2026; original audited source preserved outside the repo.
# Adapted from the fully replayed returned neutral5 certificate, 2026-09-11.
#!/usr/bin/env python3
"""Exact arbitrary-degree unramified coefficient arithmetic modulo625.

Adapted from the audited Sep11 cyclic-five certificate; field modulus and
primary input are explicit. The embedded tau is Hensel lifted separately.

Precision is an absolute exclusive z-adic bound. All divisions by 5 or25
are checked for integrality. Frobenius is the unramified ring automorphism.
GMP convolution is optional; the exact NumPy convolution is a fallback.
"""
import numpy as np
from functools import lru_cache
import argparse
import json
from pathlib import Path
parser=argparse.ArgumentParser(description="Exact fourth-Witt obstruction for the cyclic-five genus-six source")
parser.add_argument("--input",required=True,help="Exact characteristic-five primary input JSON")
parser.add_argument("--precision",type=int,default=1500,help="Laurent workspace (default1500; minimum1200)")
parser.add_argument("--frobenius-variant",type=int,choices=[0,1],default=0,help="Use a different regular affine Frobenius lift")
parser.add_argument("--parameter-d",default="0,0,0,0",help="d coefficients in 1,t,t^2,t^3, modulo5")
parser.add_argument("--parameter-b",default="0,0,0,0",help="b coefficients in 1,t,t^2,t^3, modulo5")
parser.add_argument("--fourth-index",type=int,default=-1,help="optional tangent basis index 0..14 for fourth-digit sign check")
parser.add_argument("--fourth-coeff",default="0,1,0,0",help="coefficient for fourth-digit sign check")
parser.add_argument("--output",default=None,help="write machine-readable receipt")
args=parser.parse_args()
if args.precision<1200:parser.error("--precision must be at least 1200")
MOD=625
MAX=args.precision
DATA=json.loads(Path(args.input).read_text())
DIM=int(DATA["field_degree"])
Q=np.array(DATA["field_modulus"],dtype=np.int64)
assert len(Q)==DIM+1 and Q[-1]==1

def ca(x):
 if isinstance(x,(int,np.integer)):
  a=np.zeros(DIM,dtype=np.int64);a[0]=x%MOD;return a
 a=np.zeros(DIM,dtype=np.int64); x=np.array(x,dtype=np.int64).ravel(); a[:len(x)]=x;return a%MOD
ONE=ca(1); GENERATOR=ca([0,1]); ZERO=ca(0)
def cm(a,b):
 c=np.convolve(ca(a),ca(b))%MOD
 for i in range(2*DIM-2,DIM-1,-1):
  for j in range(DIM):c[i-DIM+j]-=c[i]*Q[j]
  c%=MOD
 return c[:DIM]
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
 x=cp(a,5**DIM-2)
 for _ in range(3):x=cm(x,(ca(2)-cm(a,x))%MOD)
 assert np.array_equal(cm(a,x),ONE)
 return x

def ci(a):return _ci(tuple(ca(a)))
def cdiv(a,b):return cm(a,ci(b))
def trim(a):
 a=np.array(a,dtype=np.int64)%MOD
 if a.ndim==1:a=a.reshape(DIM,1)
 ix=np.flatnonzero(np.any(a,axis=0))
 return a[:,:ix[-1]+1] if len(ix) else np.zeros((DIM,1),dtype=np.int64)
try:
 import sys
 sys.path.insert(0,str(Path(__file__).resolve().parents[4]))
 from scripts.deformations.cyclic.neutral5_gmp_convolution import conv as gmp_conv
except (ImportError,OSError,AttributeError):
 gmp_conv=np.convolve

def exact_conv(a,b):
 return np.convolve(a,b) if min(len(a),len(b))<48 else gmp_conv(a,b)

def pm(a,b):
 a=trim(a);b=trim(b);c=np.zeros((2*DIM-1,a.shape[1]+b.shape[1]-1),dtype=np.int64)
 for i in range(DIM):
  for j in range(DIM):c[i+j]+=exact_conv(a[i],b[j])
 c%=MOD
 for i in range(2*DIM-2,DIM-1,-1):
  for j in range(DIM):c[i-DIM+j]-=Q[j]*c[i]
  c%=MOD
 return trim(c[:DIM])
def padd(a,b):
 n=max(a.shape[1],b.shape[1]);c=np.zeros((DIM,n),dtype=np.int64);c[:,:a.shape[1]]+=a;c[:,:b.shape[1]]+=b;return trim(c)
def pneg(a):return (-a)%MOD

def pscale(a,b):return pm(a,ca(b).reshape(DIM,1))

def pdiv(a,b,field=False):
 mod=5 if field else MOD
 a=trim(a%mod).copy();b=trim(b%mod);d=b.shape[1]-1
 if not np.any(b):raise ZeroDivisionError
 q=np.zeros((DIM,max(1,a.shape[1]-d)),dtype=np.int64)
 bi=ci(b[:,-1])%mod
 while np.any(a) and a.shape[1]>d:
  j=a.shape[1]-1-d;c=cm(a[:,-1],bi)%mod;q[:,j]=c
  a[:,j:j+d+1]=(a[:,j:j+d+1]-pscale(b,c))%mod
  a=trim(a)
 return trim(q),trim(a)

def pxgcd(a,b):
 a=trim(a%5);b=trim(b%5);s0=ca(1).reshape(DIM,1);s1=ca(0).reshape(DIM,1);t0=s1.copy();t1=s0.copy()
 while np.any(b):
  q,r=pdiv(a,b,True);a,b=b,r
  s0,s1=s1,padd(s0,-pm(q,s1))%5;t0,t1=t1,padd(t0,-pm(q,t1))%5
 c=ci(a[:,-1])%5
 return pscale(a,c)%5,pscale(s0,c)%5,pscale(t0,c)%5

def pd(a):return trim(a[:,1:]*np.arange(1,a.shape[1]))
def ppow(a,n):
 o=ca(1).reshape(DIM,1)
 while n:
  if n&1:o=pm(o,a)
  a=pm(a,a);n//=2
 return o

def peval(a,b):
 if isinstance(b,Ser):
  o=Ser(0)
  for c in a.T[::-1]:o=o*b+Ser(c)
  return o
 o=ca(0).reshape(DIM,1)
 for c in a.T[::-1]:o=padd(pm(o,b),c.reshape(DIM,1))
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
  if ar.ndim==0:ar=ca(int(ar)).reshape(DIM,1)
  elif ar.ndim==1:ar=ca(ar).reshape(DIM,1)
  ar=ar%MOD; self.prec=int(prec)
  ix=np.flatnonzero(np.any(ar,axis=0))
  if not len(ix):self.a=np.zeros((DIM,1),dtype=np.int64);self.l=0;return
  if ix[-1]+l>=MAX:self.prec=min(self.prec,MAX)
  first=int(ix[0]);last=min(int(ix[-1])+1,MAX-l,self.prec-l)
  if last<=first:self.a=np.zeros((DIM,1),dtype=np.int64);self.l=0;return
  self.a=ar[:,first:last].copy();self.l=int(l+first)
 @property
 def valuation(self):return self.l if np.any(self.a) else self.prec
 def __add__(self,b):
  b=Ser(b);lo=min(self.l,b.l);hi=max(self.end,b.end)
  ar=np.zeros((DIM,hi-lo),dtype=np.int64)
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
   return iv*(Ser(1)-e+e*e-e*e*e)
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
  ar=np.zeros((DIM,5*(self.a.shape[1]-1)+1),dtype=np.int64)
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

SIGGEN=cp(GENERATOR,5)
for _ in range(3):
 qq=sum((cp(SIGGEN,i)*Q[i] for i in range(DIM+1)),start=ca(0))%MOD
 dq=sum((cp(SIGGEN,i-1)*(i*Q[i]) for i in range(1,DIM+1)),start=ca(0))%MOD
 SIGGEN=(SIGGEN-cdiv(qq,dq))%MOD
SIGMAT=np.array([cp(SIGGEN,i) for i in range(DIM)]).T
T=ca(DATA['tau'])
TMIN=[3,4,1,4,1]
for _ in range(3):
 val=sum((cp(T,i)*c for i,c in enumerate(TMIN)),start=ca(0))%MOD
 der=sum((cp(T,i-1)*(i*TMIN[i]) for i in range(1,5)),start=ca(0))%MOD
 T=(T-cdiv(val,der))%MOD
assert not np.any(sum((cp(T,i)*c for i,c in enumerate(TMIN)),start=ca(0))%MOD)
SIGT=SIGMAT@T%MOD
def tpoly(cc):
 return sum((cp(T,i)*int(c) for i,c in enumerate(cc)),start=ca(0))%MOD
Z=Ser(1,1)

def linear_solve(A,b):
 # coefficients: A rows x cols x 4, b rows x 4
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
 x=np.zeros((nc,DIM),dtype=np.int64)
 for j,c in enumerate(pivs):x[c]=M[j,-1]
 return x,pivs
