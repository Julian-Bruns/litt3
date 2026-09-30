"""SymPy coefficient-domain adapter for the certified F_(5^8) kernel.
Only field arithmetic and polynomial/Groebner operations are used; factorization
routines that assume a prime field must not be used with this domain.
"""
from exact import add,sub,mul,neg,inv,power,ORDER,lib
from sympy.polys.domains import FiniteField,ZZ
from sympy import Integer,Symbol

class FE:
    __slots__=('v',)
    def __init__(self,v=0):self.v=v.v if isinstance(v,FE) else int(v)%5
    @classmethod
    def code(cls,v):
        o=object.__new__(cls);o.v=int(v);return o
    def __bool__(self):return bool(self.v)
    def __hash__(self):return hash(self.v)
    def __int__(self):return self.v
    def __repr__(self):return f'c{self.v}'
    def __eq__(self,b):
        if isinstance(b,FE):return self.v==b.v
        if isinstance(b,int):return self.v==b%5
        return NotImplemented
    def __lt__(self,b):return self.v<FE(b).v
    def __add__(self,b):
        if not isinstance(b,(int,FE)):return NotImplemented
        return FE.code(add(self.v,FE(b).v))
    __radd__=__add__
    def __neg__(self):return FE.code(neg(self.v))
    def __sub__(self,b):
        if not isinstance(b,(int,FE)):return NotImplemented
        return FE.code(sub(self.v,FE(b).v))
    def __rsub__(self,b):return FE(b)-self
    def __mul__(self,b):
        if not isinstance(b,(int,FE)):return NotImplemented
        return FE.code(mul(self.v,FE(b).v))
    __rmul__=__mul__
    def __truediv__(self,b):
        b=FE(b)
        if not b:raise ZeroDivisionError
        return FE.code(mul(self.v,inv(b.v)))
    def __rtruediv__(self,b):return FE(b)/self
    def __floordiv__(self,b):return self/b
    def __mod__(self,b):
        if not b:raise ZeroDivisionError
        return FE(0)
    def __divmod__(self,b):return self/b,FE(0)
    def __pow__(self,n):
        if not self and n<0:raise ZeroDivisionError
        return FE.code(power(self.v,int(n)))
    def inverse(self):return FE(1)/self

class ExtensionField(FiniteField):
    alias='F6254'
    def __init__(self):
        self.dtype=FE;self.zero=FE(0);self.one=FE(1);self.dom=ZZ;self.mod=5;self.sym=False;self._tp=FE;self._is_field=True;self._is_flint=False;self._poly_ctx=None
    def __str__(self):return 'F5^8_exact'
    def __eq__(self,other):return isinstance(other,ExtensionField)
    def __hash__(self):return hash('F5^8_exact')
    def to_sympy(self,a):
        # Explicit user-field representation in alpha and beta.
        v=a.v;aa=Symbol('alpha');bb=Symbol('beta');out=Integer(0)
        for i in range(4):
            c=v%25;v//=25;out+=(Integer(c%5)+Integer(c//5)*bb)*aa**i
        return out
    def from_F6254(self,a,K0=None):return a
    def is_square(self,a):return not a or power(a.v,(ORDER-1)//2)==1
    def exsqrt(self,a):
        if not a:return FE(0)
        e=lib.ff_log(a.v)
        return FE.code(lib.ff_exp(e//2)) if e%2==0 else None
    def from_FF(self,a,K0=None):
        if isinstance(K0,ExtensionField):return a
        return FE(int(a))

K=ExtensionField()

if __name__=='__main__':
    from sympy.polys.rings import ring
    from sympy.polys.groebnertools import groebner
    R,u,v=ring('u,v',K)
    a=FE.code(25);b=FE.code(5)
    print((u+a)*(u-a))
    G=groebner([u*v-a,u-v],R)
    print(G)
    assert all(not f.rem(G) for f in [u*v-a,u-v])
    print('adapter arithmetic and Groebner self-check PASS')
