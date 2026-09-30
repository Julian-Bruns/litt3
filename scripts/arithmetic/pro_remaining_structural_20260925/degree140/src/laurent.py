"""Sparse multivariate Laurent polynomials over the exact finite field ff.K.
Negative exponents are permitted; variable ordering is supplied by the caller.
All data are JSON-portable lists of [exponent_vector, coefficient_code].
"""
from ff import add,mul,neg,inv,powf,sumf
class LP:
 nv=4
 def __init__(self,data=0):
  if isinstance(data,LP):self.d=dict(data.d)
  elif isinstance(data,int):self.d={(0,)*self.nv:data} if data else {}
  else:self.d={tuple(k):int(v) for k,v in dict(data).items() if v}
 @classmethod
 def var(cls,i):
  e=[0]*cls.nv;e[i]=1;return cls({tuple(e):1})
 @classmethod
 def mon(cls,e,c=1):return cls({tuple(e):c})
 def __bool__(self):return bool(self.d)
 def __eq__(self,b):return self.d==LP(b).d
 def __add__(self,b):
  b=LP(b);d=self.d.copy()
  for m,c in b.d.items():
   u=add(d.get(m,0),c)
   if u:d[m]=u
   else:d.pop(m,None)
  return LP(d)
 __radd__=__add__
 def __neg__(self):return LP({e:neg(c) for e,c in self.d.items()})
 def __sub__(self,b):return self+-LP(b)
 def __rsub__(self,b):return LP(b)+-self
 def __mul__(self,b):
  b=LP(b)
  if not self or not b:return LP()
  d={}
  for m,c in self.d.items():
   for n,bv in b.d.items():
    e=tuple(x+y for x,y in zip(m,n));v=add(d.get(e,0),mul(c,bv))
    if v:d[e]=v
    else:d.pop(e,None)
  return LP(d)
 __rmul__=__mul__
 def __pow__(self,n):
  if n==0:return LP(1)
  if n<0:
   if len(self.d)!=1:raise ValueError('Laurent inversion requires a monomial')
   e,c=next(iter(self.d.items()));return LP.mon([v*n for v in e],powf(c,n))
  if n%5==0:return LP({tuple(5*x for x in e):powf(c,5) for e,c in (self**(n//5)).d.items()})
  z=LP(1);a=self
  while n:
   if n&1:z=z*a
   n>>=1
   if n:a=a*a
  return z
 def __truediv__(self,b):return self*(LP(b)**-1)
 def coeff(self,variable,power):return LP({tuple(0 if i==variable else v for i,v in enumerate(e)):c for e,c in self.d.items() if e[variable]==power})
 def without(self,ids):return LP({e:c for e,c in self.d.items() if all(e[i]==0 for i in ids)})
 def degree(self,i=None):
  if not self:return -10**9
  return max(sum(e) if i is None else e[i] for e in self.d)
 def valuation(self,i):return min(e[i] for e in self.d) if self else 10**9
 def eval(self,values):return sumf(mul(c,self._mon_eval(e,values)) for e,c in self.d.items())
 @staticmethod
 def _mon_eval(e,values):
  z=1
  for v,n in zip(values,e):z=mul(z,powf(v,n))
  return z
 def subs(self,repl):
  result=LP();cache={}
  for e,c in self.d.items():
   u=LP(c)
   for i,n in enumerate(e):
    if n:
     if (i,n) not in cache:cache[i,n]=repl.get(i,LP.var(i))**n
     u=u*cache[i,n]
   result=result+u
  return result
 def dump(self):return [[list(e),c] for e,c in sorted(self.d.items())]
 @classmethod
 def load(cls,rows):return cls({tuple(e):c for e,c in rows})
 def __repr__(self):return 'LP('+repr(self.dump())+')'
 def show(self,names=('h','w','s','u')):
  if not self:return '0'
  return ' + '.join(str(c)+''.join('*'+name+(f'^{n}' if n!=1 else '') for name,n in zip(names,e) if n) for e,c in sorted(self.d.items()))
