# Experimental sixth-precision extension; original batch source is preserved.
"""Exact Laurent arithmetic on the 35 factors of the constant etale algebra.

Coefficient order is zeta^j T^i, j=0..3, i=0..2. A component axis of
length one denotes a scalar broadcast to all factors. Multiplication uses
GMP Kronecker substitution, not floating point convolution.
"""
import ctypes,itertools,math,time
from pathlib import Path
import numpy as np
import witt_cubic as w
MOD,MAX,INF=w.MOD,w.MAX,w.INF
TEICH2=pow(2,5**(round(math.log(MOD,5))-1),MOD)
TEICHS=[pow(r,5**(round(math.log(MOD,5))-1),MOD) for r in range(5)]
GRID=list(itertools.product(range(5),repeat=3));GIDX={r:i for i,r in enumerate(GRID)}
REPS=[];ORBITS=[];seen=set()
for r in GRID:
 if r in seen:continue
 orbit=[];a=r
 while a not in orbit:
  orbit.append(a);seen.add(a);a=(3*a[0]%5,a[1],2*a[2]%5)
 REPS.append(r);ORBITS.append(orbit)
assert len(REPS)==35 and sorted(map(len,ORBITS))==[1]*5+[4]*30
NC=35
_lib=ctypes.CDLL(str(Path(__file__).with_name('exact_batch_conv.so')))
_arr=np.ctypeslib.ndpointer(dtype=np.int64,flags='C_CONTIGUOUS')
_lib.batch_conv.argtypes=[_arr,_arr,_arr]+[ctypes.c_int]*8
STATS={'calls':0,'seconds':0.0}
def multiply(a,b,no=None):
 na,nb=a.shape[-1],b.shape[-1];nc=max(a.shape[0],b.shape[0])
 assert a.shape[0] in (1,nc) and b.shape[0] in (1,nc)
 if no is None:no=na+nb-1
 no=min(no,na+nb-1)
 assert 12*min(na,nb)*(MOD-1)**2<2**63
 out=np.zeros((nc,12,no),dtype=np.int64)
 a=np.ascontiguousarray(a);b=np.ascontiguousarray(b)
 start=time.monotonic()
 _lib.batch_conv(a,b,out,nc,na,nb,no,MOD,TEICH2,int(a.shape[0]==1),int(b.shape[0]==1))
 STATS['calls']+=1;STATS['seconds']+=time.monotonic()-start
 return out

def coeff_mul(a,b):return multiply(a[:,:,None],b[:,:,None])[:,:,0]
def coeff_pow(a,n):
 o=np.zeros((1,12),dtype=np.int64);o[:,0]=1
 while n:
  if n&1:o=coeff_mul(o,a)
  n//=2
  if n:a=coeff_mul(a,a)
 return o

def coeff_inv(a):
 assert np.all(np.any(a%5,axis=1))
 x=coeff_pow(a%5,5**12-2)%5
 two=np.zeros((1,12),dtype=np.int64);two[0,0]=2
 for _ in range(3):x=coeff_mul(x,(two-coeff_mul(a,x))%MOD)
 chk=coeff_mul(a,x);chk[:,0]-=1
 assert not np.any(chk%MOD)
 return x

SIG=np.zeros((12,12),dtype=np.int64)
for j in range(4):SIG[j*3:(j+1)*3,j*3:(j+1)*3]=pow(TEICH2,j,MOD)*w.SIGMAT%MOD

class Ser:
 def __init__(self,a=0,l=0,prec=INF):
  if isinstance(a,Ser):
   self.a=a.a;self.l=a.l;self.prec=min(a.prec,prec);return
  if isinstance(a,w.Ser):
   ar=np.zeros((1,12,a.a.shape[-1]),dtype=np.int64);ar[0,:3]=a.a
   l=a.l;prec=min(prec,a.prec)
  else:
   ar=np.asarray(a,dtype=np.int64)
   if ar.ndim==0:
    ar0=np.zeros((1,12,1),dtype=np.int64);ar0[0,0,0]=ar;ar=ar0
   elif ar.ndim==1:
    ar0=np.zeros((1,12,1),dtype=np.int64);ar0[0,:len(ar),0]=ar;ar=ar0
   elif ar.ndim==2:ar=ar[:,:,None]
  assert ar.ndim==3 and ar.shape[1]==12 and ar.shape[0] in (1,35),ar.shape
  ar=ar%MOD;self.prec=int(prec)
  ix=np.flatnonzero(np.any(ar,axis=(0,1)))
  if not len(ix):self.a=np.zeros((1,12,1),dtype=np.int64);self.l=0;return
  if ix[-1]+l>=MAX:self.prec=min(self.prec,MAX)
  first=int(ix[0]);last=min(int(ix[-1])+1,MAX-l,self.prec-l)
  if last<=first:self.a=np.zeros((1,12,1),dtype=np.int64);self.l=0;return
  self.a=np.ascontiguousarray(ar[:,:,first:last]);self.l=int(l+first)
 @property
 def valuation(self):return self.l if np.any(self.a) else self.prec
 @property
 def end(self):return self.l+self.a.shape[-1]
 def iszero(self):return not np.any(self.a)
 def __add__(self,b):
  b=Ser(b);lo=min(self.l,b.l);hi=max(self.end,b.end)
  ar=np.zeros((max(self.a.shape[0],b.a.shape[0]),12,hi-lo),dtype=np.int64)
  for x in (self,b):ar[:,:,x.l-lo:x.end-lo]+=x.a
  return Ser(ar,lo,min(self.prec,b.prec))
 __radd__=__add__
 def __neg__(self):return Ser(-self.a,self.l,self.prec)
 def __sub__(self,b):return self+-Ser(b)
 def __rsub__(self,b):return Ser(b)+-self
 def __mul__(self,b):
  b=Ser(b)
  precision=min(self.prec+b.valuation,b.prec+self.valuation,INF)
  if self.iszero() or b.iszero():return Ser(0,prec=precision)
  l=self.l+b.l;no=min(MAX-l,precision-l,self.a.shape[-1]+b.a.shape[-1]-1)
  if no<=0:return Ser(0,prec=precision)
  if no<self.a.shape[-1]+b.a.shape[-1]-1:precision=min(precision,l+no)
  return Ser(multiply(self.a,b.a,no),l,precision)
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  a=self;o=Ser(1)
  while n:
   if n&1:o=o*a
   n//=2
   if n:a=a*a
  return o
 def as_poly(self):return Ser(self.a,self.l)
 def inv(self):
  if self.iszero():raise ZeroDivisionError('zero Laurent series')
  if not np.all(np.any(self.a[:,:,0]%5,axis=1)):
   base=self.mod(5);iv=base.inv();e=(self-base)*iv
   level=0;power=1
   while power<MOD:level+=1;power*=5
   series=Ser(1);term=Ser(1)
   for _ in range(1,level):term=-term*e;series=series+term
   return iv*series
  a=Ser(self.a,0,self.prec-self.l);work=min(MAX,self.prec-self.l)
  if work<=0:raise ArithmeticError('Insufficient Laurent precision')
  out=Ser(coeff_inv(self.a[:,:,0]));n=1
  while n<work:
   n=min(2*n,work);out=(out*(2-a*out)).cut(n).as_poly()
  precision=min(self.prec-2*self.l,work-self.l)
  return Ser(out.a,-self.l,precision)
 def __truediv__(self,b):return self*Ser(b).inv()
 def __rtruediv__(self,b):return Ser(b)*self.inv()
 def shift(self,n):return Ser(self.a,self.l+n,min(INF,self.prec+n))
 def cut(self,n):return Ser(self.a,self.l,min(self.prec,n))
 def coef(self,n):
  if n>=self.prec:raise ArithmeticError(f'Coefficient {n} outside precision {self.prec}')
  return self.a[:,:,n-self.l].copy() if self.l<=n<self.end else np.zeros((self.a.shape[0],12),dtype=np.int64)
 def deriv(self):return Ser(self.a*np.arange(self.l,self.end),self.l-1,self.prec-1)
 def mod(self,m):return Ser(self.a%m,self.l,self.prec)
 def divint(self,n):
  if np.any(self.a%n):
   idx=np.argwhere(self.a%n)[0]
   raise ArithmeticError(f'Nonintegral division by {n}, index {idx}, value {self.a[tuple(idx)]}, z={self.l+idx[-1]}')
  return Ser(self.a//n,self.l,self.prec)
 def sigma(self):return Ser(np.einsum('ij,cjn->cin',SIG,self.a,optimize=True)%MOD,self.l,self.prec)
 def frob(self):
  ar=np.zeros((self.a.shape[0],12,5*(self.a.shape[-1]-1)+1),dtype=np.int64)
  ar[:,:,::5]=np.einsum('ij,cjn->cin',SIG,self.a,optimize=True)%MOD
  return Ser(ar,5*self.l,min(INF,5*self.prec))
 def __repr__(self):return f'BatchSer({self.a.shape[0]} components, val={self.valuation}, end={self.end}, prec={self.prec})'
Z=Ser(1,1)

def constants():
 result=[]
 for i,ji in enumerate((3,0,1)):
  ar=np.zeros((NC,12),dtype=np.int64)
  for c,r in enumerate(REPS):
   if ji==0:ar[c,0]=TEICHS[r[i]]
   else:ar[c,3*(4-ji)]=TEICHS[r[i]]*pow(TEICH2,-1,MOD)%MOD
  result.append(Ser(ar))
 return result
