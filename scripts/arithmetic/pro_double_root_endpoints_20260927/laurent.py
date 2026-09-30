"""Small exact Laurent polynomials over K; exponents may be negative."""
from exact import add as ka, mul as km, neg as kn, inv as ki, power as kp
class LP:
 n=4
 def __init__(self,obj=0):
  if isinstance(obj,LP):self.d=obj.d.copy()
  elif isinstance(obj,dict):self.d={tuple(m):v for m,v in obj.items() if v}
  elif isinstance(obj,int):self.d={(0,)*self.n:obj} if obj else {}
  else:raise TypeError(type(obj))
 @classmethod
 def var(cls,i):
  e=[0]*cls.n;e[i]=1;return cls({tuple(e):1})
 def __bool__(self):return bool(self.d)
 def __add__(a,b):
  b=LP(b);c=a.d.copy()
  for m,v in b.d.items():
   w=ka(c.get(m,0),v)
   if w:c[m]=w
   else:c.pop(m,None)
  return LP(c)
 __radd__=__add__
 def __neg__(a):return LP({m:kn(v) for m,v in a.d.items()})
 def __sub__(a,b):return a+-LP(b)
 def __rsub__(a,b):return LP(b)+-a
 def __mul__(a,b):
  b=LP(b);c={}
  for m,v in a.d.items():
   for n,w in b.d.items():
    e=tuple(x+y for x,y in zip(m,n));z=ka(c.get(e,0),km(v,w))
    if z:c[e]=z
    else:c.pop(e,None)
  return LP(c)
 __rmul__=__mul__
 def __truediv__(a,b):
  b=LP(b)
  if len(b.d)!=1:raise ValueError('LP only divides by a nonzero monomial')
  m,v=next(iter(b.d.items()));return LP({tuple(x-y for x,y in zip(n,m)):km(w,ki(v)) for n,w in a.d.items()})
 def __pow__(a,n):
  if n<0:
   if len(a.d)!=1:raise ValueError('negative power of nonmonomial')
   m,v=next(iter(a.d.items()));return LP({tuple(x*n for x in m):kp(v,n)})
  r=LP(1)
  while n:
   if n&1:r=r*a
   a=a*a;n//=2
  return r
 def __eq__(a,b):return a.d==LP(b).d
 def __repr__(a):return repr(a.d)
 def coeff(a,indices,exps):
  c={}
  for m,v in a.d.items():
   if all(m[i]==j for i,j in zip(indices,exps)):
    mm=list(m)
    for i in indices:mm[i]=0
    c[tuple(mm)]=v
  return LP(c)
 def eval(a,values):
  z=0
  for m,v in a.d.items():
   for x,n in zip(values,m):v=km(v,kp(x,n))
   z=ka(z,v)
  return z
 def records(a):return [list(m)+[v] for m,v in sorted(a.d.items())]
 @classmethod
 def fromrecords(cls,r):return cls({tuple(a[:-1]):a[-1] for a in r})

def sa(a,b,N):return [(a[i] if i<len(a) else LP())+(b[i] if i<len(b) else LP()) for i in range(N)]
def sm(a,b,N):
 c=[LP() for _ in range(N)]
 for i,v in enumerate(a[:N]):
  if v:
   for j,w in enumerate(b[:N-i]):
    if w:c[i+j]=c[i+j]+v*w
 return c

def sp(a,n,N):
 c=[LP(1)]+[LP() for _ in range(N-1)]
 while n:
  if n&1:c=sm(c,a,N)
  a=sm(a,a,N);n//=2
 return c

def ss(a,n,N):return ([LP()]*n+a)[:N]
def sc(a,c):return [v*c for v in a]
