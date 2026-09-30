"""ctypes interface to exact extension-field polynomials.
The process has one current extension context; do not mix contexts.
"""
from exact import lib,ct,ROOT,DATA
import random
V=ct.c_void_p;IP=ct.POINTER(ct.c_int)
lib.ef_init.argtypes=[IP,ct.c_int]
for name in ['ef_add','ef_sub','ef_mul']:getattr(lib,name).argtypes=[IP,IP,IP]
lib.ef_inv.argtypes=[IP,IP]
lib.ef_pow.argtypes=[IP,ct.c_uint64,IP]
lib.ep_new.argtypes=[IP,ct.c_int];lib.ep_new.restype=V
lib.ep_free.argtypes=[V];lib.ep_len.argtypes=[V];lib.ep_get.argtypes=[V,IP];lib.ep_coeff.argtypes=[V,ct.c_int,IP]
for name in ['ep_add','ep_sub','ep_mul','ep_gcd']:
 getattr(lib,name).argtypes=[V,V];getattr(lib,name).restype=V
lib.ep_scale.argtypes=[V,IP];lib.ep_scale.restype=V
lib.ep_pow.argtypes=[V,ct.c_int];lib.ep_pow.restype=V
lib.ep_divrem.argtypes=[V,V,ct.POINTER(V),ct.POINTER(V)]
lib.ep_xgcd.argtypes=[V,V,ct.POINTER(V),ct.POINTER(V),ct.POINTER(V)]
lib.ep_eval.argtypes=[V,IP,IP]
lib.ep_truncate.argtypes=[V,ct.c_int];lib.ep_truncate.restype=V
lib.ep_frobenius.argtypes=[V,ct.c_int,ct.c_int];lib.ep_frobenius.restype=V
D=1
MODULUS=[0,1]
def init(mod):
 global D,MODULUS
 D=len(mod)-1;MODULUS=mod
 assert lib.ef_init((ct.c_int*len(mod))(*mod),len(mod))==D

class E:
 __slots__=('a',)
 def __init__(self,obj=0):
  if isinstance(obj,E):self.a=obj.a
  elif isinstance(obj,int):
   assert 0<=obj<390625, 'integer must be a valid K code'
   self.a=(obj,)+(0,)*(D-1)
  else:self.a=tuple(obj)+(0,)*(D-len(obj))
  assert len(self.a)==D
 def buf(self):return (ct.c_int*D)(*self.a)
 def __bool__(self):return any(self.a)
 def _bin(self,other,fn):
  other=E(other);z=(ct.c_int*D)();fn(self.buf(),other.buf(),z);return E(tuple(z))
 def __add__(self,other):return self._bin(other,lib.ef_add)
 __radd__=__add__
 def __sub__(self,other):return self._bin(other,lib.ef_sub)
 def __rsub__(self,other):return E(other)-self
 def __mul__(self,other):return self._bin(other,lib.ef_mul)
 __rmul__=__mul__
 def __neg__(self):return E(0)-self
 def inv(self):
  z=(ct.c_int*D)();assert lib.ef_inv(self.buf(),z)==0,'extension nonunit';return E(tuple(z))
 def __truediv__(self,other):return self*E(other).inv()
 def __rtruediv__(self,other):return E(other)*self.inv()
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  z=(ct.c_int*D)();lib.ef_pow(self.buf(),n,z);return E(tuple(z))
 def __eq__(self,other):return self.a==E(other).a
 def __repr__(self):return repr(self.a)

class Poly:
 __slots__=('p',)
 def __init__(self,obj=0,ptr=None):
  if ptr is not None:self.p=ptr;return
  if isinstance(obj,Poly):obj=obj.coeffs()
  elif isinstance(obj,(int,E)):obj=[obj]
  a=[E(v).a for v in obj];flat=[v for row in a for v in row]
  self.p=lib.ep_new((ct.c_int*len(flat))(*flat),len(a))
 def __del__(self):
  try:lib.ep_free(self.p)
  except Exception:pass
 def __len__(self):return lib.ep_len(self.p)
 def __bool__(self):return bool(len(self))
 def degree(self):return len(self)-1
 def coeffs(self):
  n=len(self);z=(ct.c_int*(n*D))();lib.ep_get(self.p,z);return [E(tuple(z[i*D:(i+1)*D])) for i in range(n)]
 def records(self):return [list(v.a) for v in self.coeffs()]
 def __getitem__(self,i):
  z=(ct.c_int*D)();lib.ep_coeff(self.p,i,z);return E(tuple(z))
 def __add__(self,other):
  other=other if isinstance(other,Poly) else Poly(other)
  return Poly(ptr=lib.ep_add(self.p,other.p))
 __radd__=__add__
 def __sub__(self,other):
  other=other if isinstance(other,Poly) else Poly(other)
  return Poly(ptr=lib.ep_sub(self.p,other.p))
 def __rsub__(self,other):return Poly(other)-self
 def __neg__(self):return self.scale(E(4))
 def __mul__(self,other):
  if not isinstance(other,Poly):return self.scale(E(other))
  return Poly(ptr=lib.ep_mul(self.p,other.p))
 __rmul__=__mul__
 def scale(self,z):return Poly(ptr=lib.ep_scale(self.p,E(z).buf()))
 def __pow__(self,n):
  assert n>=0;return Poly(ptr=lib.ep_pow(self.p,n))
 def __truediv__(self,other):
  if not isinstance(other,Poly):return self.scale(E(other).inv())
  q,r=self.divrem(other);assert not r,'inexact extension polynomial division';return q
 def divrem(self,other):
  other=other if isinstance(other,Poly) else Poly(other);q=V();r=V()
  assert lib.ep_divrem(self.p,other.p,ct.byref(q),ct.byref(r))==0
  return Poly(ptr=q.value),Poly(ptr=r.value)
 def __mod__(self,other):return self.divrem(other)[1]
 def gcd(self,other):return Poly(ptr=lib.ep_gcd(self.p,other.p))
 def xgcd(self,other):
  g=V();s=V();t=V();assert lib.ep_xgcd(self.p,other.p,ct.byref(g),ct.byref(s),ct.byref(t))==0
  return tuple(Poly(ptr=z.value) for z in [g,s,t])
 def eval(self,x):
  z=(ct.c_int*D)();lib.ep_eval(self.p,E(x).buf(),z);return E(tuple(z))
 def truncate(self,n):return Poly(ptr=lib.ep_truncate(self.p,n))
 def frob(self,j=1,stride=None):
  return Poly(ptr=lib.ep_frobenius(self.p,j,5**j if stride is None else stride))
 def __eq__(self,other):return not (self-other)
 def __repr__(self):return 'Poly'+repr(self.records())

if __name__=='__main__':
 import json
 from factor import irreducible
 fs=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())['leading_boundary']['factors']
 mod=next(f for f,m in fs if len(f)==11);assert irreducible(mod);init(mod)
 rng=random.Random(20260927)
 for i in range(100):
  a,b,c=[E([rng.randrange(390625) for _ in range(D)]) for _ in range(3)]
  assert a*(b+c)==a*b+a*c
  if a:assert a/a==E(1)
 for i in range(5):
  a,b=[Poly([E([rng.randrange(390625) for _ in range(D)]) for _ in range(n)]) for n in [60,55]]
  assert (a*b)/b==a
  g,s,t=a.xgcd(b);assert s*a+t*b==g
  assert a.frob()==a**5
 print('extension degree 10: field identities, polynomial products/division/xgcd and Frobenius verified')
