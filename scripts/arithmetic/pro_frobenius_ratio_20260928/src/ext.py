"""Exact arithmetic in finite K-algebras K[z]/m(z), retaining zero divisors."""
import ctypes as C
import numpy as np
from ff import lib,u32p,Poly,va,vm
lib.ex_context.argtypes=[u32p,C.c_int]
lib.ex_mul.argtypes=[u32p,u32p,u32p]
lib.ex_inv.argtypes=[u32p,u32p]
lib.ex_pow.argtypes=[u32p,C.c_uint64,u32p]
lib.ex_poly_mul.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,C.c_int]
lib.ex_poly_divrem.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,u32p]
D=1;MOD=Poly([0,1])
class NonUnit(ArithmeticError):
 def __init__(self,a):self.coefficient=a;self.factor=Poly(a.a).gcd(MOD);super().__init__('Nonunit: '+str(self.factor))
def context(mod):
 global D,MOD
 MOD=Poly(mod).monic();D=MOD.degree();assert D>=1
 assert lib.ex_context(MOD.a,D)==1
 return Element([0,1])
class Element:
 __slots__=('a',)
 def __init__(self,x=0):
  if isinstance(x,Element):self.a=x.a;return
  if isinstance(x,(int,np.integer)):
   self.a=np.zeros(D,dtype=np.uint32);self.a[0]=int(x);return
  p=Poly(x)%MOD;self.a=np.zeros(D,dtype=np.uint32);self.a[:len(p)]=p.a
 def __bool__(self):return bool(self.a.any())
 def __repr__(self):return repr(list(map(int,self.a)))
 def __eq__(self,b):return np.array_equal(self.a,Element(b).a)
 def __add__(self,b):return Element(va(self.a,Element(b).a))
 __radd__=__add__
 def __neg__(self):return Element(vm(self.a,np.uint32(4)))
 def __sub__(self,b):return self+-Element(b)
 def __rsub__(self,b):return Element(b)+-self
 def __mul__(self,b):
  b=Element(b);out=np.empty(D,dtype=np.uint32);lib.ex_mul(self.a,b.a,out);return Element(out)
 __rmul__=__mul__
 def inverse(self):
  out=np.empty(D,dtype=np.uint32)
  if not lib.ex_inv(self.a,out):raise NonUnit(self)
  return Element(out)
 def __truediv__(self,b):return self*Element(b).inverse()
 def __rtruediv__(self,b):return Element(b)*self.inverse()
 def __pow__(self,n):
  if n<0:return self.inverse()**(-n)
  out=np.empty(D,dtype=np.uint32);lib.ex_pow(self.a,n,out);return Element(out)
 def serialize(self):return list(map(int,self.a))
class EP:
 __slots__=('a',)
 def __init__(self,x=0):
  if isinstance(x,EP):self.a=x.a;return
  if isinstance(x,(int,Element,np.integer)):x=[x]
  if isinstance(x,Poly):x=x.tolist()
  if isinstance(x,np.ndarray) and x.ndim==2:
   assert x.shape[1]==D;a=x.copy()
  else:a=np.array([Element(i).a for i in x],dtype=np.uint32).reshape((-1,D))
  n=len(a)
  while n and not a[n-1].any():n-=1
  self.a=a[:n].copy()
 def __len__(self):return len(self.a)
 def degree(self):return len(self)-1
 def __bool__(self):return bool(len(self))
 def __getitem__(self,i):return Element(self.a[i]) if 0<=i<len(self) else Element()
 def __eq__(self,b):return np.array_equal(self.a,EP(b).a)
 def __neg__(self):return EP(vm(self.a,np.uint32(4)))
 def __add__(self,b):
  b=EP(b);n=max(len(self),len(b));aa=np.zeros((n,D),dtype=np.uint32);bb=aa.copy();aa[:len(self)]=self.a;bb[:len(b)]=b.a
  return EP(va(aa,bb))
 __radd__=__add__
 def __sub__(self,b):return self+-EP(b)
 def __rsub__(self,b):return EP(b)+-self
 def __mul__(self,b):return self.mullow(b,2**30)
 __rmul__=__mul__
 def mullow(self,b,n):
  b=EP(b)
  if not self or not b or n<=0:return EP()
  n=min(n,len(self)+len(b)-1);out=np.empty((n,D),dtype=np.uint32)
  lib.ex_poly_mul(self.a.ravel(),len(self),b.a.ravel(),len(b),out.ravel(),n)
  return EP(out)
 def __pow__(self,n):
  if n<0:
   assert len(self)==1;return EP(self[0]**n)
  if n==5:return self.frob(1)
  r=EP(1);a=self
  while n:
   if n&1:r=r*a
   n//=2
   if n:a=a*a
  return r
 def __divmod__(self,b):
  b=EP(b)
  if not b:raise ZeroDivisionError
  if len(self)<len(b):return EP(),self
  q=np.empty((max(1,len(self)-len(b)+1),D),dtype=np.uint32);r=np.empty_like(self.a)
  if not lib.ex_poly_divrem(self.a.ravel(),len(self),b.a.ravel(),len(b),q.ravel(),r.ravel()):raise NonUnit(b[b.degree()])
  return EP(q),EP(r[:len(b)-1])
 def __mod__(self,b):return divmod(self,b)[1]
 def __floordiv__(self,b):
  q,r=divmod(self,b)
  if r:raise ArithmeticError('non-exact EP division')
  return q
 def monic(self):return self*self[self.degree()].inverse() if self else self
 def gcd(self,b):
  a=self;b=EP(b)
  while b:a,b=b,a%b
  return a.monic()
 def xgcd(self,b):
  a,b=self,EP(b);s0,s1=EP(1),EP();t0,t1=EP(),EP(1)
  while b:
   q,r=divmod(a,b);a,b=b,r;s0,s1=s1,s0-q*s1;t0,t1=t1,t0-q*t1
  if not a:return a,s0,t0
  z=a[a.degree()].inverse();return a*z,s0*z,t0*z
 def frob(self,n=1):
  if not self:return EP()
  fac=5**n;out=np.zeros((fac*self.degree()+1,D),dtype=np.uint32)
  for i in range(len(self)):out[fac*i]=(self[i]**fac).a
  return EP(out)
 def eval(self,a):
  a=Element(a);out=Element()
  for i in range(len(self)-1,-1,-1):out=out*a+self[i]
  return out
 def serialize(self):return [list(map(int,a)) for a in self.a]
 def truncate(self,n):return EP(self.a[:n])
