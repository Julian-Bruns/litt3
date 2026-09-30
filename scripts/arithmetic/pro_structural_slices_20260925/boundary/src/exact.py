"""Exact finite-field, polynomial, and cubic coordinate-ring arithmetic.
No external Python dependencies. The C++ kernel is compiled on demand.
"""
from __future__ import annotations
import ctypes as C
import subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent
LIB=HERE/'libffcore.so'
if not LIB.exists() or LIB.stat().st_mtime<(HERE/'ffcore.cpp').stat().st_mtime:
    subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(HERE/'ffcore.cpp'),'-o',str(LIB)],check=True)
lib=C.CDLL(str(LIB)); IP=C.POINTER(C.c_int)
lib.ff_init.restype=C.c_int
lib.ff_pow.argtypes=[C.c_int,C.c_int64]
lib.poly_op.argtypes=[C.c_int,IP,C.c_int,IP,C.c_int,IP]
lib.poly_powmod.argtypes=[IP,C.c_int,C.c_int64,IP,C.c_int,IP]
lib.poly_eval.argtypes=[IP,C.c_int,C.c_int]
lib.matrix_rref.argtypes=[IP,C.c_int,C.c_int,IP]
GENERATOR=lib.ff_init()
if GENERATOR<0:raise RuntimeError('Field initialization failed: '+str(GENERATOR))
add=lib.ff_add; sub=lib.ff_sub; neg=lib.ff_neg; mul=lib.ff_mul; inv=lib.ff_inv; power=lib.ff_pow
ORDER=390625

def arr(a):return (C.c_int*len(a))(*a)
def fdiv(a,b):
    if not b:raise ZeroDivisionError
    return mul(a,inv(b))

def rref(rows):
    if not rows:return [],[]
    nr=len(rows);nc=len(rows[0]);a=arr([v for row in rows for v in row]);piv=(C.c_int*min(nr,nc))()
    rank=lib.matrix_rref(a,nr,nc,piv)
    return [list(a[i*nc:(i+1)*nc]) for i in range(rank)],list(piv[:rank])

class FP:
    """A polynomial with FIELD-ENCODED integer coefficients, not ordinary integers."""
    __slots__=('c',)
    def __init__(self,c=()):
        if isinstance(c,FP):self.c=c.c;return
        if isinstance(c,int):c=[c]
        c=list(c)
        while c and c[-1]==0:c.pop()
        self.c=tuple(c)
    def __repr__(self):return 'FP('+repr(list(self.c))+')'
    def __len__(self):return len(self.c)
    def __bool__(self):return bool(self.c)
    def __eq__(self,b):return self.c==FP(b).c
    def __getitem__(self,i):return self.c[i] if 0<=i<len(self.c) else 0
    @property
    def deg(self):return len(self.c)-1
    def _op(self,b,op):
        b=FP(b)
        if op in (3,4,5) and not b:
            if op==5:return self.monic()
            raise ZeroDivisionError
        out=(C.c_int*max(1,len(self)+len(b)+1))()
        n=lib.poly_op(op,arr(self.c),len(self),arr(b.c),len(b),out)
        if n<0:raise RuntimeError('bad poly op')
        return FP(out[:n])
    def __add__(self,b):return self._op(b,0)
    __radd__=__add__
    def __sub__(self,b):return self._op(b,1)
    def __rsub__(self,b):return FP(b)-self
    def __neg__(self):return FP([neg(v) for v in self.c])
    def __mul__(self,b):return self._op(b,2)
    __rmul__=__mul__
    def __floordiv__(self,b):
        b=FP(b)
        if self%b:raise ArithmeticError('inexact polynomial division')
        return self._op(b,3)
    def __mod__(self,b):return self._op(b,4)
    def gcd(self,b):return self._op(b,5)
    def __pow__(self,n):
        if n<0:raise ValueError('negative polynomial power')
        r=FP(1);a=self
        while n:
            if n&1:r=r*a
            n>>=1
            if n:a=a*a
        return r
    def scale(self,s):return FP([mul(s,v) for v in self.c])
    def monic(self):return self.scale(inv(self.c[-1])) if self else self
    def derivative(self):return FP([mul(i%5,v) for i,v in enumerate(self.c)][1:])
    def eval(self,x):return lib.poly_eval(arr(self.c),len(self),x)
    def powmod(self,e,m):
        m=FP(m)
        if not m:raise ZeroDivisionError
        out=(C.c_int*max(1,len(m)))()
        n=lib.poly_powmod(arr(self.c),len(self),e,arr(m.c),len(m),out)
        return FP(out[:n])
    def xgcd(self,b):
        r0,r1=self,FP(b);s0,s1=FP(1),FP();t0,t1=FP(),FP(1)
        while r1:
            q=r0._op(r1,3);r0,r1=r1,r0-q*r1;s0,s1=s1,s0-q*s1;t0,t1=t1,t0-q*t1
        if r0:
            z=inv(r0.c[-1]);return r0.scale(z),s0.scale(z),t0.scale(z)
        return r0,s0,t0
    def inverse_mod(self,m):
        g,s,_=self.xgcd(m)
        if g!=1:raise ZeroDivisionError('polynomial not invertible')
        return s%m
    def geometric_square_root(self):
        """Return (leading scalar, monic root) or None; permits a scalar square root in k."""
        if not self:return 0,FP()
        if self.deg%2:return None
        f=self.monic();n=f.deg//2;j=[0]*(n+1);j[n]=1
        for k in range(1,n+1):
            target=2*n-k;s=0
            for i in range(n-k+1,n+1):
                ii=target-i
                if 0<=ii<=n:s=add(s,mul(j[i],j[ii]))
            j[n-k]=mul(3,sub(f[target],s))
        J=FP(j)
        return (self.c[-1],J) if J*J==f else None

x=FP([0,1]);P=FP([11,22,18,5,19,20,15,16,9,22,1]);A=FP([1,21,14,22,13])
Q=FP([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])
B=FP([8,14,19,2,10,19,3,24,18,16]);L=FP([18,20,20,15])
alpha=25;t=A//((x-alpha).scale(13))

class CR:
    """Cubic coordinate ring; components in basis 1,y,y^2."""
    __slots__=('c',)
    def __init__(self,c=0):
        if isinstance(c,CR):self.c=c.c
        elif isinstance(c,(FP,int)):self.c=(FP(c),FP(),FP())
        else:
            c=list(c);c += [0]*(3-len(c))
            if len(c)!=3:raise ValueError
            self.c=tuple(map(FP,c))
    def __repr__(self):return 'CR('+repr(self.c)+')'
    def __getitem__(self,i):return self.c[i]
    def __bool__(self):return any(self.c)
    def __eq__(self,b):return self.c==CR(b).c
    def __add__(self,b):return CR([a+d for a,d in zip(self.c,CR(b).c)])
    __radd__=__add__
    def __neg__(self):return CR([-a for a in self.c])
    def __sub__(self,b):return self+-CR(b)
    def __rsub__(self,b):return CR(b)-self
    def __mul__(self,b):
        if isinstance(b,(FP,int)):return CR([a*b for a in self.c])
        a0,a1,a2=self.c;b0,b1,b2=CR(b).c
        return CR([a0*b0+P*(a1*b2+a2*b1),a0*b1+a1*b0+P*a2*b2,a0*b2+a1*b1+a2*b0])
    __rmul__=__mul__
    def __pow__(self,n):
        if n<0:raise ValueError
        r=CR(1);a=self
        while n:
            if n&1:r=r*a
            n>>=1
            if n:a=a*a
        return r
    def scale(self,s):return CR([p.scale(s) for p in self.c])
    def norm(self):
        a,b,c=self.c
        return a**3+(b**3)*P+(c**3)*(P**2)-(a*b*c*P).scale(3)
    def adj(self):
        a,b,c=self.c
        return CR([a*a-b*c*P,c*c*P-a*b,b*b-a*c])
    def exact_div(self,b):
        if isinstance(b,(int,FP)):return CR([p//FP(b) for p in self.c])
        b=CR(b);n=b.norm();s=self*b.adj()
        return CR([p//n for p in s.c])
    def pole(self):return max([-10**9]+[3*p.deg+10*b for b,p in enumerate(self.c) if p])
    def mod(self,p):return CR([c%p for c in self.c])
    def mod_y(self,j):return CR([p%(P**max(0,(j-b+2)//3)) for b,p in enumerate(self.c)])
    def terms(self):return {(a,b):v for b,p in enumerate(self.c) for a,v in enumerate(p.c) if v}
    def data(self):return [list(p.c) for p in self.c]

y=CR([0,1,0])
epsilon=add(add(24,mul(4,alpha)),mul(23,power(alpha,3)))
eta=add(add(11,mul(18,power(alpha,2))),mul(20,power(alpha,3)))

if __name__=='__main__':
    import json, random
    assert Q.derivative()==P*A**2
    assert not (Q-B**5)%(P**2)
    assert not (Q-L**5)%(A**3)
    assert A.eval(alpha)==0
    assert power(alpha,ORDER)==alpha
    for _ in range(100):
        a=random.randrange(1,ORDER);b=random.randrange(1,ORDER)
        assert mul(a,inv(a))==1 and add(a,neg(a))==0
        assert power(add(a,b),5)==add(power(a,5),power(b,5))
    print(json.dumps({'field_order':ORDER,'primitive_element_code':GENERATOR,'alpha_code':alpha,'t':list(t.c),'epsilon':epsilon,'eta':eta,'basic_identities':'PASS'}))
