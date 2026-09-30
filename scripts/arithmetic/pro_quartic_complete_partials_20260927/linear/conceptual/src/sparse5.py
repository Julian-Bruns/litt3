"""Small exact sparse polynomial arithmetic over F5; no external dependencies."""
from __future__ import annotations

class Poly:
    def __init__(self, n: int, terms=None):
        self.n=n
        self.terms={tuple(e):int(c)%5 for e,c in (terms or {}).items() if int(c)%5}
        if any(len(e)!=n or min(e)<0 for e in self.terms):
            raise ValueError('Invalid exponent tuple')
    @classmethod
    def constant(cls,n,c): return cls(n,{(0,)*n:c})
    @classmethod
    def variable(cls,n,i):
        e=[0]*n;e[i]=1
        return cls(n,{tuple(e):1})
    def coerce(self,other):
        if isinstance(other,int):return Poly.constant(self.n,other)
        if not isinstance(other,Poly) or self.n!=other.n:raise TypeError('Ring mismatch')
        return other
    def __add__(self,other):
        other=self.coerce(other);t=dict(self.terms)
        for e,c in other.terms.items():t[e]=(t.get(e,0)+c)%5
        return Poly(self.n,t)
    __radd__=__add__
    def __neg__(self):return Poly(self.n,{e:-c for e,c in self.terms.items()})
    def __sub__(self,other):return self+-self.coerce(other)
    def __rsub__(self,other):return self.coerce(other)+-self
    def __mul__(self,other):
        other=self.coerce(other);t={}
        for e,c in self.terms.items():
            for f,d in other.terms.items():
                g=tuple(a+b for a,b in zip(e,f));t[g]=(t.get(g,0)+c*d)%5
        return Poly(self.n,t)
    __rmul__=__mul__
    def __pow__(self,p):
        if not isinstance(p,int) or p<0:raise ValueError('Nonnegative integer exponent required')
        a=self;r=Poly.constant(self.n,1)
        while p:
            if p&1:r=r*a
            a=a*a;p//=2
        return r
    def __eq__(self,other):
        other=self.coerce(other)
        return self.terms==other.terms
    def __bool__(self):return bool(self.terms)
    def data(self):return [[list(e),c] for e,c in sorted(self.terms.items())]

def variables(n):return tuple(Poly.variable(n,i) for i in range(n))
