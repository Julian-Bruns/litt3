# Adapted locally21 September2026; original audited source preserved outside the repo.
from witt import *

# Coefficientwise unramified lift of H; s is horizontal, s^5=H*s.
H=ca(DATA["H"]); HS=Ser(H)
class AS:
 def __init__(self,x=0):
  if isinstance(x,AS): self.c=list(x.c)
  elif isinstance(x,(list,tuple)) and len(x)==5: self.c=[Ser(a) for a in x]
  else:self.c=[Ser(x)]+[Ser(0) for _ in range(4)]
 @property
 def prec(self): return min(x.prec for x in self.c)
 @property
 def valuation(self):return min(x.valuation for x in self.c)
 def __add__(self,b):
  b=AS(b);return AS([a+b for a,b in zip(self.c,b.c)])
 __radd__=__add__
 def __neg__(self):return AS([-a for a in self.c])
 def __sub__(self,b):return self+-AS(b)
 def __rsub__(self,b):return AS(b)+-self
 def __mul__(self,b):
  b=AS(b);r=[Ser(0) for _ in range(9)]
  precision=min(INF,self.prec+b.valuation,b.prec+self.valuation)
  for i,a in enumerate(self.c):
   if a.iszero():continue
   for j,c in enumerate(b.c):
    if not c.iszero():r[i+j]=r[i+j]+a*c
  for i in range(8,4,-1):r[i-4]=r[i-4]+HS*r[i]
  return AS([x.cut(precision) for x in r[:5]])
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  out=AS(1);a=self
  while n:
   if n&1:out=out*a
   n//=2
   if n:a=a*a
  return out
 def inv(self):
  # All inverse calls made here have a scalar invertible reduction mod5.
  b=self.mod(5)
  assert all(a.iszero() for a in b.c[1:]),'non-scalar mod5 inverse'
  iv=AS(b.c[0].inv());e=(self-b)*iv
  return iv*(1-e+e*e-e*e*e)
 def __truediv__(self,b):return self*AS(b).inv()
 def __rtruediv__(self,b):return AS(b)*self.inv()
 def cut(self,n):return AS([a.cut(n) for a in self.c])
 def mod(self,n):return AS([a.mod(n) for a in self.c])
 def divint(self,n):return AS([a.divint(n) for a in self.c])
 def deriv(self):return AS([a.deriv() for a in self.c])
 def frob(self):
  return sum((AS(c.frob())*SPHI_POW[i] for i,c in enumerate(self.c)),AS(0))
 def trace(self):return 5*self.c[0]+4*HS*self.c[4]
 def iszero(self):return all(a.iszero() for a in self.c)
 def __repr__(self):return '\n'.join(str(j)+': '+str(c)+' (prec '+str(c.prec)+')' for j,c in enumerate(self.c) if not c.iszero()) or '0'

S=AS([0,1,0,0,0])
SPHI=S**5
for _ in range(3):
 SPHI=SPHI-(SPHI**5-AS(HS.sigma())*SPHI)/(5*SPHI**4-AS(HS.sigma()))
assert (SPHI**5-AS(HS.sigma())*SPHI).iszero()
assert (SPHI-S**5).mod(5).iszero()
SPHI_POW=[SPHI**i for i in range(5)]
