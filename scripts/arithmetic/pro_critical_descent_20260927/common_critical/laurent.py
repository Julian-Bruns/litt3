"""Small sparse Laurent polynomial arithmetic, exact over K."""
from algebra import add,sub,mul,neg,inv,power
class LP:
    n=2
    def __init__(self,d=0):
        if isinstance(d,LP):self.d=d.d.copy()
        elif isinstance(d,int):self.d={(0,)*self.n:d} if d else {}
        else:self.d={tuple(m):int(c) for m,c in d.items() if c}
    @classmethod
    def mono(cls,m,c=1):return cls({tuple(m):c})
    def __add__(self,b):
        b=LP(b);d=self.d.copy()
        for m,c in b.d.items():
            z=add(d.get(m,0),c)
            if z:d[m]=z
            else:d.pop(m,None)
        return LP(d)
    __radd__=__add__
    def __neg__(self):return LP({m:neg(c) for m,c in self.d.items()})
    def __sub__(self,b):return self+-LP(b)
    def __rsub__(self,b):return LP(b)+-self
    def __mul__(self,b):
        b=LP(b);d={}
        for m,c in self.d.items():
            for mm,cc in b.d.items():
                a=tuple(x+y for x,y in zip(m,mm));z=add(d.get(a,0),mul(c,cc))
                if z:d[a]=z
                else:d.pop(a,None)
        return LP(d)
    __rmul__=__mul__
    def __pow__(self,n):
        if n<0:
            assert len(self.d)==1
            m,c=next(iter(self.d.items()));return LP.mono([v*n for v in m],power(c,n))
        a=self;b=LP(1)
        while n:
            if n&1:b=b*a
            n>>=1
            if n:a=a*a
        return b
    def __truediv__(self,b):return self*LP(b)**-1
    def __bool__(self):return bool(self.d)
    def __eq__(self,b):return self.d==LP(b).d
    def __repr__(self):return repr(self.d)
    def eval(self,vs):
        out=0
        for mm,c in self.d.items():
            for x,n in zip(vs,mm):c=mul(c,power(x,n))
            out=add(out,c)
        return out
    def data(self):return [[*mm,c] for mm,c in sorted(self.d.items())]
