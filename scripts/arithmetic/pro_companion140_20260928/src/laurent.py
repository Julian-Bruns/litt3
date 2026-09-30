"""Small exact bivariate Laurent polynomial ring K[h,w]."""
from field import *
class LP:
    __slots__=('t',)
    def __init__(self,a=0):
        if isinstance(a,LP):self.t=a.t
        elif isinstance(a,F):self.t={(0,0):a.v} if a else {}
        else:self.t={(0,0):a%5} if a%5 else {}
    @staticmethod
    def terms(t):
        a=LP.__new__(LP);a.t={tuple(k):v for k,v in t.items() if v};return a
    @staticmethod
    def code(c):return LP(F.code(c))
    def __add__(a,b):
        b=LP(b);r=dict(a.t)
        for k,c in b.t.items():
            v=add(r.get(k,0),c)
            if v:r[k]=v
            elif k in r:del r[k]
        return LP.terms(r)
    __radd__=__add__
    def __neg__(a):return LP.terms({k:neg(c) for k,c in a.t.items()})
    def __sub__(a,b):return a+-LP(b)
    def __rsub__(a,b):return LP(b)+-a
    def __mul__(a,b):
        b=LP(b);r={}
        for i,c in a.t.items():
            for j,d in b.t.items():
                k=(i[0]+j[0],i[1]+j[1]);r[k]=add(r.get(k,0),mul(c,d))
        return LP.terms(r)
    __rmul__=__mul__
    def __truediv__(a,b):
        b=LP(b)
        if len(b.t)!=1:raise ValueError('only division by a monomial')
        (i,j),c=next(iter(b.t.items()))
        return LP.terms({(k-i,l-j):div(v,c) for (k,l),v in a.t.items()})
    def __rtruediv__(a,b):return LP(b)/a
    def __pow__(a,n):
        if n<0:return (1/a)**(-n)
        r=LP(1)
        while n:
            if n&1:r=r*a
            a=a*a;n>>=1
        return r
    def __bool__(a):return bool(a.t)
    def __eq__(a,b):return a.t==LP(b).t
    def __repr__(a):return repr(a.t)
    def eval(a,h,w):return sum((F.code(c)*h**i*w**j for (i,j),c in a.t.items()),F(0))
    def to_json(a):return [[i,j,c] for (i,j),c in sorted(a.t.items())]
    @staticmethod
    def from_json(row):return LP.terms({(i,j):c for i,j,c in row})
H=LP.terms({(1,0):1});W=LP.terms({(0,1):1})

# Generic series on any coefficient algebra supporting Python arithmetic.
def sadd(a,b,n):return [(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(n)]
def sscale(a,c,n):return [a[i]*c if i<len(a) else 0 for i in range(n)]
def smul(a,b,n):
    r=[0]*n
    for i in range(min(n,len(a))):
        if a[i]:
            for j in range(min(n-i,len(b))):
                if b[j]:r[i+j]=r[i+j]+a[i]*b[j]
    return r

def spow(a,e,n):
    r=[1]+[0]*(n-1)
    while e:
        if e&1:r=smul(r,a,n)
        e//=2
        if e:a=smul(a,a,n)
    return r

def shift(a,e,n):return [a[i-e] if 0<=i-e<len(a) else 0 for i in range(n)]

def sinv(a,n):
    assert a[0]
    r=[1/a[0]]
    for i in range(1,n):r.append(-sum((a[j]*r[i-j] for j in range(1,min(len(a),i+1))),0)/a[0])
    return r
