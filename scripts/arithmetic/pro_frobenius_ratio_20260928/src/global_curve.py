"""Exact polynomial arithmetic on z^2+2c(q)z+3b(q)e(q)=0.
Only q-polynomial division is accelerated; all divisions are checked exact
when // is used. No geometric parameter is specialized in these operations.
"""
from pathlib import Path
import ctypes as C
import numpy as np
from ff import Poly, u32p
from residual import RATIO
ROOT=Path(__file__).resolve().parents[1]
_fast=C.CDLL(str(ROOT/'src/fast_poly.so'))
_fast.ff_fast_divrem.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,u32p]
_fast.ff_fast_divrem.restype=C.c_int
_orig_divmod=Poly.__divmod__
def fast_divmod(self,b):
    b=Poly(b)
    if len(b)<64 or len(self)-len(b)<64:return _orig_divmod(self,b)
    q=np.empty(len(self)-len(b)+1,dtype=np.uint32);r=np.empty(len(self),dtype=np.uint32)
    assert _fast.ff_fast_divrem(self.a,len(self),b.a,len(b),q,r)==1
    return Poly(q),Poly(r[:len(b)-1])
Poly.__divmod__=fast_divmod
b,c,e=[Poly(RATIO[k]) for k in ('b','c','e')]
Z0=2*b*e;Z1=3*c

class QC:
    __slots__=('a','b')
    def __init__(self,a=0,b=0):
        if isinstance(a,QC):self.a,self.b=a.a,a.b
        else:self.a,self.b=Poly(a),Poly(b)
    def __bool__(self):return bool(self.a) or bool(self.b)
    def __eq__(self,v):v=QC(v);return self.a==v.a and self.b==v.b
    def __add__(self,v):v=QC(v);return QC(self.a+v.a,self.b+v.b)
    __radd__=__add__
    def __neg__(self):return QC(-self.a,-self.b)
    def __sub__(self,v):return self+-QC(v)
    def __rsub__(self,v):return QC(v)+-self
    def __mul__(self,v):
        if isinstance(v,(Poly,int,np.integer)):return QC(self.a*v,self.b*v)
        v=QC(v);aa=self.a*v.a;bb=self.b*v.b
        return QC(aa+bb*Z0,(self.a+self.b)*(v.a+v.b)-aa-bb+bb*Z1)
    __rmul__=__mul__
    def __pow__(self,n):
        assert n>=0;r=QC(1);v=self
        while n:
            if n&1:r=r*v
            n//=2
            if n:v=v*v
        return r
    def frob(self,k=1):
        z=QC(0,1)**(5**k)
        return QC(self.a.frob(k))+z*self.b.frob(k)
    def norm(self):return self.a*self.a+self.a*self.b*Z1-self.b*self.b*Z0
    def conjugate(self):return QC(self.a+self.b*Z1,-self.b)
    def content(self):return self.a.gcd(self.b)
    def __floordiv__(self,p):return QC(self.a//p,self.b//p)
    def serialize(self):return [self.a.tolist(),self.b.tolist()]
    def degrees(self):return self.a.degree(),self.b.degree()

def smul(a,b,n):
    out=[QC() for _ in range(n)]
    for i,x in enumerate(a):
        for j,y in enumerate(b[:n-i]):out[i+j]=out[i+j]+x*y
    return out

def ssquare(a,n):
    out=[QC() for _ in range(n)]
    for i in range(min(len(a),n)):
        for j in range(i,min(len(a),n-i)):
            val=a[i]*a[j]
            out[i+j]=out[i+j]+(val if i==j else 2*val)
    return out
