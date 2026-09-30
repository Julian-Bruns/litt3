"""Exact polynomials over F_(5^8)[s]/g(s), including reducible squarefree g.
Inverses are taken only after a unit test. No zero divisor is silently divided by.
"""
from exact import *
lib.ext_init.argtypes=[IP,C.c_int];lib.ext_op.argtypes=[C.c_int,IP,IP,IP];lib.ext_pow.argtypes=[IP,C.c_int64,IP]
lib.ep_op.argtypes=[C.c_int,IP,C.c_int,IP,C.c_int,IP]
EM=0;MOD=None

def setup(mod):
    global EM,MOD
    MOD=FP(mod).monic();EM=lib.ext_init(arr(MOD.c),len(MOD))
    if EM<1:raise ValueError('invalid modulus')

class E:
    __slots__=('c',)
    def __init__(self,a=0):
        if isinstance(a,E):self.c=a.c;return
        if isinstance(a,int):a=[a]
        a=list(a)
        if len(a)>EM:a=list((FP(a)%MOD).c)
        self.c=tuple(a+[0]*(EM-len(a)))
    def __bool__(self):return any(self.c)
    def __eq__(self,b):return self.c==E(b).c
    def __repr__(self):return 'E('+repr(list(self.c))+')'
    def op(self,b,code):
        b=E(b);out=(C.c_int*EM)();status=lib.ext_op(code,arr(self.c),arr(b.c),out)
        if status<0:raise ZeroDivisionError('nonunit in finite coefficient algebra')
        return E(out[:])
    def __add__(self,b):
        if isinstance(b,EP):return NotImplemented
        return self.op(b,0)
    __radd__=__add__
    def __sub__(self,b):return self.op(b,1)
    def __neg__(self):return E([neg(c) for c in self.c])
    def __rsub__(self,b):return E(b)-self
    def __mul__(self,b):
        if isinstance(b,EP):return NotImplemented
        return self.op(b,2)
    __rmul__=__mul__
    def inverse(self):return self.op(0,3)
    def __truediv__(self,b):return self*E(b).inverse()
    def __rtruediv__(self,b):return E(b)*self.inverse()
    def __pow__(self,n):
        out=(C.c_int*EM)();status=lib.ext_pow(arr(self.c),n,out)
        if status<0:raise ZeroDivisionError('nonunit in finite coefficient algebra')
        return E(out[:])

class EP:
    __slots__=('c',)
    def __init__(self,a=0):
        if isinstance(a,EP):self.c=a.c;return
        if isinstance(a,FP):a=[E(c) for c in a.c]
        elif isinstance(a,(E,int)):a=[a]
        a=[E(c) for c in a]
        while a and not a[-1]:a.pop()
        self.c=tuple(a)
    def __bool__(self):return bool(self.c)
    def __len__(self):return len(self.c)
    def __getitem__(self,i):return self.c[i] if 0<=i<len(self.c) else E()
    def __eq__(self,b):return self.c==EP(b).c
    @property
    def deg(self):return len(self.c)-1
    def __repr__(self):return 'EP('+repr(self.data())+')'
    def data(self):return [list(c.c) for c in self.c]
    def _op(self,b,op):
        b=EP(b)
        if op in (3,4,5) and not b:
            if op==5:return self.monic()
            raise ZeroDivisionError
        aa=arr([x for c in self.c for x in c.c]);bb=arr([x for c in b.c for x in c.c])
        out=(C.c_int*(max(1,len(self)+len(b)+1)*EM))()
        n=lib.ep_op(op,aa,len(self),bb,len(b),out)
        if n<0:raise ZeroDivisionError('nonunit coefficient or invalid operation in EP')
        return EP([E(out[i*EM:(i+1)*EM]) for i in range(n)])
    def __add__(self,b):return self._op(b,0)
    __radd__=__add__
    def __sub__(self,b):return self._op(b,1)
    def __rsub__(self,b):return EP(b)-self
    def __neg__(self):return EP([-c for c in self.c])
    def __mul__(self,b):return self._op(b,2)
    __rmul__=__mul__
    def __mod__(self,b):return self._op(b,4)
    def __floordiv__(self,b):
        if self%b:raise ArithmeticError('inexact polynomial division')
        return self._op(b,3)
    def monic(self):return self*EP(self.c[-1].inverse()) if self else self
    def gcd(self,b):return self._op(b,5)
    def frob(self):
        out=[E()]*(5*self.deg+1)
        for i,c in enumerate(self.c):out[5*i]=c**5
        return EP(out)
    def __pow__(self,n):
        if n<0:raise ValueError
        if n==5:return self.frob()
        r=EP(1);a=self
        while n:
            if n&1:r=r*a
            n>>=1
            if n:a=a*a
        return r
    def xgcd(self,b):
        r0,r1=self,EP(b);s0,s1=EP(1),EP();t0,t1=EP(),EP(1)
        while r1:
            q=r0._op(r1,3);r0,r1=r1,r0-q*r1;s0,s1=s1,s0-q*s1;t0,t1=t1,t0-q*t1
        if r0:
            z=EP(r0.c[-1].inverse());return r0*z,s0*z,t0*z
        return r0,s0,t0

class ER:
    __slots__=('c',)
    curveP=None
    def __init__(self,a=0):
        if isinstance(a,ER):self.c=a.c;return
        if isinstance(a,(EP,E,FP,int)):a=[a,0,0]
        a=list(a);a+=[0]*(3-len(a));self.c=tuple(EP(c) for c in a)
    def __getitem__(self,i):return self.c[i]
    def __eq__(self,b):return self.c==ER(b).c
    def __bool__(self):return any(self.c)
    def __add__(self,b):return ER([a+c for a,c in zip(self.c,ER(b).c)])
    __radd__=__add__
    def __neg__(self):return ER([-a for a in self.c])
    def __sub__(self,b):return self+-ER(b)
    def __mul__(self,b):
        if not isinstance(b,ER):return ER([a*EP(b) for a in self.c])
        a0,a1,a2=self.c;b0,b1,b2=b.c;p=ER.curveP
        return ER([a0*b0+p*(a1*b2+a2*b1),a0*b1+a1*b0+p*a2*b2,a0*b2+a1*b1+a2*b0])
    __rmul__=__mul__
    def frob(self):
        a,b,c=self.c;p=ER.curveP
        return ER([a.frob(),c.frob()*p**3,b.frob()*p])
    def __pow__(self,n):
        if n==5:return self.frob()
        r=ER(1);a=self
        while n:
            if n&1:r=r*a
            n>>=1
            if n:a=a*a
        return r
    def data(self):return [a.data() for a in self.c]

if __name__=='__main__':
    import random,json
    setup([1,0,0,1])
    a=E([2,3,4]);b=E([4,1,2])
    assert a*b==E((FP(a.c)*FP(b.c)%MOD).c)
    for _ in range(20):
        a=E([random.randrange(ORDER) for _ in range(EM)])
        try:ai=a.inverse()
        except ZeroDivisionError:continue
        assert a*ai==1
    p=EP([E([2,1]),E([4,3]),E([1,2])]);q=EP([E([3,4]),E([2,1])])
    assert (p*q)//q==p and p.frob()==p*p*p*p*p
    print('finite algebra and polynomial arithmetic self-check PASS')
