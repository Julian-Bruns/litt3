"""Sparse multivariate Laurent polynomials over the explicitly constructed finite field."""
import exact as E
class Poly:
 n=4
 def __init__(self,data=None):
  self.d={} if data is None else ({(0,)*self.n:int(data)} if isinstance(data,(int,)) and data else ({} if isinstance(data,int) else {tuple(k):int(v) for k,v in data.items() if v}))
 @classmethod
 def var(cls,i):
  z=[0]*cls.n;z[i]=1;return cls({tuple(z):1})
 def __bool__(self):return bool(self.d)
 def __add__(self,b):
  if not isinstance(b,Poly):b=Poly(int(b))
  r=dict(self.d)
  for k,v in b.d.items():
   v=E.F.A(r.get(k,0),v)
   if v:r[k]=v
   elif k in r:del r[k]
  return Poly(r)
 __radd__=__add__
 def __neg__(self):return Poly({k:E.F.N(v) for k,v in self.d.items()})
 def __sub__(self,b):return self+-coerce(b)
 def __rsub__(self,b):return coerce(b)+-self
 def __mul__(self,b):
  if not isinstance(b,Poly):
   b=int(b);return Poly({k:E.F.M(v,b) for k,v in self.d.items()}) if b else Poly()
  if not self or not b:return Poly()
  r={};A=E.F.A;M=E.F.M
  for k,v in self.d.items():
   for l,w in b.d.items():
    e=tuple(a+b for a,b in zip(k,l));c=A(r.get(e,0),M(v,w))
    if c:r[e]=c
    elif e in r:del r[e]
  return Poly(r)
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:
   if len(self.d)!=1:raise ValueError('inverse only for monomials')
   k,v=next(iter(self.d.items()));return Poly({tuple(x*n for x in k):E.F.P(v,n)})
  r=Poly(1);a=self
  while n:
   if n&1:r=r*a
   n>>=1
   if n:a=a*a
  return r
 def frobenius(self):return Poly({tuple(5*i for i in k):E.F.P(v,5) for k,v in self.d.items()})
 def coeffvar(self,i,j):
  r={}
  for k,v in self.d.items():
   if k[i]==j:
    e=list(k);e[i]=0;r[tuple(e)]=v
  return Poly(r)
 def evaluate(self,values):
  ans=0
  for k,v in self.d.items():
   for i,e in enumerate(k):
    if e:v=E.F.M(v,E.F.P(int(values[i]),e))
   ans=E.F.A(ans,v)
  return ans
 def serial(self):return [[list(k),v] for k,v in sorted(self.d.items())]
 @classmethod
 def read(cls,data):return cls({tuple(k):v for k,v in data})
 def __eq__(self,b):return self.d==coerce(b).d
 def __repr__(self):return 'Poly('+str(self.serial())+')'

def coerce(a):return a if isinstance(a,Poly) else Poly(int(a))

def sadd(a,b,n):return [(a[i] if i<len(a) else Poly())+(b[i] if i<len(b) else Poly()) for i in range(n)]
def smul(a,b,n):
 out=[Poly() for _ in range(n)]
 for i,x in enumerate(a[:n]):
  if x:
   for j,y in enumerate(b[:n-i]):
    if y:out[i+j]=out[i+j]+x*y
 return out
def spow(a,m,n):
 out=[Poly(1)]+[Poly() for _ in range(n-1)]
 while m:
  if m&1:out=smul(out,a,n)
  m>>=1
  if m:a=smul(a,a,n)
 return out
def shift(a,d,n):return [Poly()]*d+a[:n-d]
