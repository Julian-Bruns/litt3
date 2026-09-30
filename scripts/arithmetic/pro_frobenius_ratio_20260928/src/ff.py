"""Exact arithmetic for the problem's K-codes, characteristic 5.

Build: g++ -O3 -std=c++17 -shared -fPIC src/field.cpp -o src/field.so
No finite-field point restriction is implicit in using this coefficient field.
"""
from pathlib import Path
import ctypes as C
import numpy as np
lib=C.CDLL(str(Path(__file__).with_name('field.so')))
u32p=np.ctypeslib.ndpointer(dtype=np.uint32,ndim=1,flags='C_CONTIGUOUS')
lib.ff_init.restype=C.c_int
GENERATOR=lib.ff_init()
assert GENERATOR>0
for name in ['ff_addtab','ff_exps','ff_logs']:
    getattr(lib,name).restype=C.POINTER(C.c_uint32)
ADD=np.ctypeslib.as_array(lib.ff_addtab(),shape=(625*625,))
EXP=np.ctypeslib.as_array(lib.ff_exps(),shape=(781249,))
LOG=np.ctypeslib.as_array(lib.ff_logs(),shape=(390625,))
lib.ff_pow.argtypes=[C.c_uint32,C.c_uint64];lib.ff_pow.restype=C.c_uint32
lib.ff_rawmul.argtypes=[C.c_uint32,C.c_uint32];lib.ff_rawmul.restype=C.c_uint32
lib.ff_poly_mul.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,C.c_int]
lib.ff_poly_divrem.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,u32p]
lib.ff_rref.argtypes=[u32p,C.c_int,C.c_int,np.ctypeslib.ndpointer(dtype=np.int32,ndim=1,flags='C_CONTIGUOUS')]
AL=list(map(int,ADD));EL=list(map(int,EXP));LL=list(map(int,LOG))
def add(a,b): return AL[(a%625)*625+b%625]+625*AL[(a//625)*625+b//625]
def mul(a,b): return EL[LL[a]+LL[b]] if a and b else 0
def neg(a): return mul(4,a)
def sub(a,b): return add(a,neg(b))
def inv(a):
    if not a: raise ZeroDivisionError
    return EL[390624-LL[a]]
def div(a,b):return mul(a,inv(b))
def power(a,n):
    if n<0:return power(inv(a),-n)
    return int(lib.ff_pow(a,n))
def sumf(xs):
    r=0
    for x in xs:r=add(r,x)
    return r

def va(a,b):return ADD[(a%625)*625+b%625]+625*ADD[(a//625)*625+b//625]
def vm(a,b):return np.where((a==0)|(b==0),0,EXP[LOG[a]+LOG[b]]).astype(np.uint32)
def rref(a):
    a=np.array(a,dtype=np.uint32,order='C',copy=True)
    piv=np.empty(min(a.shape),dtype=np.int32)
    rank=lib.ff_rref(a.ravel(),*a.shape,piv)
    return a,list(map(int,piv[:rank]))
class Poly:
    __slots__=('a',)
    def __init__(self,cs=()):
        if isinstance(cs,Poly):self.a=cs.a;return
        if isinstance(cs,(int,np.integer)):cs=[int(cs)]
        a=np.array(cs,dtype=np.uint32)
        n=len(a)
        while n and a[n-1]==0:n-=1
        self.a=a[:n].copy()
    def __len__(self):return len(self.a)
    def degree(self):return len(self)-1
    def __bool__(self):return bool(len(self))
    def __getitem__(self,n):return int(self.a[n]) if 0<=n<len(self) else 0
    def __repr__(self):return 'Poly('+repr(self.tolist())+')'
    def tolist(self):return list(map(int,self.a))
    def __eq__(self,o):
        o=Poly(o);return np.array_equal(self.a,o.a)
    def __add__(self,o):
        o=Poly(o);n=max(len(self),len(o));a=np.zeros(n,dtype=np.uint32);b=a.copy();a[:len(self)]=self.a;b[:len(o)]=o.a
        return Poly(va(a,b))
    __radd__=__add__
    def __neg__(self):return Poly(vm(self.a,np.uint32(4)))
    def __sub__(self,o):return self+-Poly(o)
    def __rsub__(self,o):return Poly(o)+-self
    def __mul__(self,o):
        if isinstance(o,(int,np.integer)):return Poly(vm(self.a,np.uint32(o)))
        o=Poly(o)
        if not self or not o:return Poly()
        out=np.empty(len(self)+len(o)-1,dtype=np.uint32)
        lib.ff_poly_mul(self.a,len(self),o.a,len(o),out,len(out))
        return Poly(out)
    __rmul__=__mul__
    def mullow(self,o,n):
        o=Poly(o)
        if not self or not o or n<=0:return Poly()
        n=min(n,len(self)+len(o)-1);out=np.empty(n,dtype=np.uint32)
        lib.ff_poly_mul(self.a,len(self),o.a,len(o),out,n);return Poly(out)
    def __pow__(self,n):
        assert n>=0;r=Poly(1);a=self
        while n:
            if n&1:r=r*a
            n//=2
            if n:a=a*a
        return r
    def pow_trunc(self,n,length):
        assert n>=0;r=Poly(1);a=self.truncate(length)
        while n:
            if n&1:r=r.mullow(a,length)
            n//=2
            if n:a=a.mullow(a,length)
        return r
    def __divmod__(self,o):
        o=Poly(o)
        if not o:raise ZeroDivisionError
        if len(self)<len(o):return Poly(),self
        q=np.empty(max(1,len(self)-len(o)+1),dtype=np.uint32);r=np.empty(len(self),dtype=np.uint32)
        lib.ff_poly_divrem(self.a,len(self),o.a,len(o),q,r)
        return Poly(q),Poly(r[:len(o)-1])
    def __mod__(self,o):return divmod(self,o)[1]
    def __floordiv__(self,o):
        q,r=divmod(self,o)
        if r:raise ArithmeticError('nonexact polynomial division')
        return q
    def monic(self):return self*inv(self[self.degree()]) if self else self
    def gcd(self,o):
        o=Poly(o);a=self
        while o:a,o=o,a%o
        return a.monic()
    def xgcd(self,o):
        a,b=self,Poly(o);s0,s1=Poly(1),Poly();t0,t1=Poly(),Poly(1)
        while b:
            q,r=divmod(a,b);a,b=b,r;s0,s1=s1,s0-q*s1;t0,t1=t1,t0-q*t1
        if not a:return a,s0,t0
        z=inv(a[a.degree()]);return a*z,s0*z,t0*z
    def eval(self,x):
        v=0
        for c in reversed(self.a):v=add(mul(v,x),int(c))
        return v
    def derivative(self):return Poly([mul(i%5,self[i]) for i in range(1,len(self))])
    def truncate(self,n):return Poly(self.a[:n])
    def shift(self,n):
        assert n>=0
        return Poly(np.concatenate((np.zeros(n,dtype=np.uint32),self.a))) if self else self
    def frob(self,power_=1):
        f=5**power_;a=np.zeros(f*self.degree()+1,dtype=np.uint32) if self else np.empty(0,dtype=np.uint32)
        if self:a[::f]=[power(int(c),f) for c in self.a]
        return Poly(a)
    def powmod(self,n,mod):
        r=Poly(1);a=self%mod
        while n:
            if n&1:r=(r*a)%mod
            n//=2
            if n:a=(a*a)%mod
        return r
X=Poly([0,1])
