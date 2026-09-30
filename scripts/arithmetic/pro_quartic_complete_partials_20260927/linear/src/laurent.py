"""Small sparse Laurent polynomials over K. Parameters (h,w,s,u)."""
import field as F
N=4;Z=(0,)*N
class LP:
    __slots__=('d',)
    def __init__(self,d=None):self.d={e:c for e,c in (d or {}).items() if c}
    def __add__(a,b):
        b=coerce(b);d=a.d.copy()
        for e,c in b.d.items():
            v=F.add(d.get(e,0),c)
            if v:d[e]=v
            else:d.pop(e,None)
        return LP(d)
    __radd__=__add__
    def __neg__(a):return LP({e:F.neg(c) for e,c in a.d.items()})
    def __sub__(a,b):return a+-coerce(b)
    def __rsub__(a,b):return coerce(b)+-a
    def __mul__(a,b):
        b=coerce(b);d={}
        for e,c in a.d.items():
            for f,v in b.d.items():
                ef=tuple(e[i]+f[i] for i in range(N))
                d[ef]=F.add(d.get(ef,0),F.mul(c,v))
        return LP(d)
    __rmul__=__mul__
    def __pow__(a,n):
        if n<0:
            assert len(a.d)==1
            e,c=next(iter(a.d.items()))
            return LP({tuple(n*x for x in e):F.powk(c,n)})
        if n==5:return LP({tuple(5*x for x in e):F.powk(c,5) for e,c in a.d.items()})
        out=k(1)
        while n:
            if n&1:out=out*a
            a=a*a;n//=2
        return out
    def __truediv__(a,b):return a*coerce(b)**-1
    def __bool__(a):return bool(a.d)
    def __eq__(a,b):return a.d==coerce(b).d
    def coeff_kernel(a,s,u):return LP({(e[0],e[1],0,0):c for e,c in a.d.items() if e[2:]==(s,u)})
    def specialize(a,h,w,s=0,u=0):
        out=0
        for e,c in a.d.items():
            for v,p in zip([h,w,s,u],e):c=F.mul(c,F.powk(v,p))
            out=F.add(out,c)
        return out
    def data(a):return [[list(e),c] for e,c in sorted(a.d.items())]
    @classmethod
    def load(cls,data):return cls({tuple(e):c for e,c in data})
    def shift(a,e):return LP({tuple(ee[i]+e[i] for i in range(N)):c for ee,c in a.d.items()})

def coerce(a):return a if isinstance(a,LP) else k(a%5)
def k(c):return LP({Z:c})
def var(i):return LP({tuple(int(i==j) for j in range(N)):1})
h,w,s,u=[var(i) for i in range(N)]
