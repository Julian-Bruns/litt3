"""Small exact sparse Laurent polynomials over the problem coefficient field."""
from ff import add,mul,neg,inv,power
class Sparse:
    N=4
    __slots__=('d',)
    def __init__(self,data=0):
        if isinstance(data,Sparse):self.d=data.d;return
        if isinstance(data,int):
            if not 0<=data<390625:raise ValueError('Use a K-code in 0..390624, not an integer residue convention.')
            self.d={(0,)*self.N:data} if data else {};return
        self.d={tuple(k):v for k,v in data.items() if v}
    @classmethod
    def var(cls,i):
        m=[0]*cls.N;m[i]=1;return cls({tuple(m):1})
    def __bool__(self):return bool(self.d)
    def __repr__(self):return repr(self.d)
    def __eq__(self,o):return self.d==Sparse(o).d
    def __add__(self,o):
        o=Sparse(o);d=self.d.copy()
        for m,c in o.d.items():
            s=add(d.get(m,0),c)
            if s:d[m]=s
            elif m in d:del d[m]
        return Sparse(d)
    __radd__=__add__
    def __neg__(self):return Sparse({m:neg(c) for m,c in self.d.items()})
    def __sub__(self,o):return self+-Sparse(o)
    def __rsub__(self,o):return Sparse(o)+-self
    def __mul__(self,o):
        o=Sparse(o);d={}
        for m,a in self.d.items():
            for n,b in o.d.items():
                p=tuple(x+y for x,y in zip(m,n));s=add(d.get(p,0),mul(a,b))
                if s:d[p]=s
                elif p in d:del d[p]
        return Sparse(d)
    __rmul__=__mul__
    def shift(self,exps):return Sparse({tuple(x+y for x,y in zip(m,exps)):a for m,a in self.d.items()})
    def __pow__(self,n):
        if n<0:
            assert len(self.d)==1
            m,a=next(iter(self.d.items()));return Sparse({tuple(n*x for x in m):power(a,n)})
        if n==5:return Sparse({tuple(5*x for x in m):power(a,5) for m,a in self.d.items()})
        r=Sparse(1);a=self
        while n:
            if n&1:r=r*a
            n//=2
            if n:a=a*a
        return r
    def coefficient(self,i,j):return Sparse({m[:i]+(0,)+m[i+1:]:a for m,a in self.d.items() if m[i]==j})
    def maxdegree(self,i):return max((m[i] for m in self.d),default=-1)
    def evaluate(self,vs):
        r=0
        for m,a in self.d.items():
            z=a
            for v,e in zip(vs,m):z=mul(z,power(v,e))
            r=add(r,z)
        return r
    def serialize(self):return [[list(m),int(a)] for m,a in sorted(self.d.items())]

def series_add(a,b,n):return [a[i]+b[i] for i in range(n)]
def series_mul(a,b,n):
    out=[Sparse() for _ in range(n)]
    for i in range(min(n,len(a))):
        for j in range(min(n-i,len(b))):out[i+j]=out[i+j]+a[i]*b[j]
    return out

def series_pow(a,e,n):
    out=[Sparse(1)]+[Sparse() for _ in range(n-1)]
    while e:
        if e&1:out=series_mul(out,a,n)
        e//=2
        if e:a=series_mul(a,a,n)
    return out
