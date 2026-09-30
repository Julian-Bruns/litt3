"""Small exact finite fields; integer codes are base-p polynomial rows.
No third-party software is required. The modulus is supplied explicitly.
"""
from __future__ import annotations
from dataclasses import dataclass

@dataclass(frozen=True)
class FiniteField:
    p: int
    modulus: tuple[int, ...]  # ascending, monic

    @property
    def degree(self):
        return len(self.modulus)-1

    @property
    def order(self):
        return self.p**self.degree

    def digits(self, a: int) -> tuple[int, ...]:
        out=[]
        for _ in range(self.degree):
            out.append(a % self.p); a //= self.p
        if a:
            raise ValueError('Field code out of range')
        return tuple(out)

    def encode(self, coeffs) -> int:
        a=0
        for c in reversed(tuple(coeffs)):
            a=a*self.p+(c%self.p)
        return a

    def add(self, a: int, b: int) -> int:
        return self.encode((x+y)%self.p for x,y in zip(self.digits(a),self.digits(b)))

    def neg(self, a: int) -> int:
        return self.encode((-x)%self.p for x in self.digits(a))

    def sub(self, a: int, b: int) -> int:
        return self.add(a,self.neg(b))

    def mul(self, a: int, b: int) -> int:
        d=self.degree; p=self.p
        aa=self.digits(a); bb=self.digits(b)
        out=[0]*(2*d-1)
        for i,ai in enumerate(aa):
            if ai:
                for j,bj in enumerate(bb):
                    out[i+j]+=ai*bj
        out=[v%p for v in out]
        for i in range(2*d-2,d-1,-1):
            if out[i]:
                c=out[i]
                for j in range(d):
                    out[i-d+j]=(out[i-d+j]-c*self.modulus[j])%p
        return self.encode(out[:d])

    def pow(self, a: int, n: int) -> int:
        if n < 0:
            return self.pow(self.inv(a),-n)
        r=1
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a); n//=2
        return r

    def inv(self, a: int) -> int:
        if not a:raise ZeroDivisionError
        return self.pow(a,self.order-2)

    def div(self,a:int,b:int)->int:
        return self.mul(a,self.inv(b))

# beta^2=beta+3
F25=FiniteField(5,(2,4,1))
# One irreducible factor of Phi_29 over F5. Irreducibility is verified separately.
MU29_MODULUS=(1,2,4,0,4,4,3,1,3,4,4,0,4,2,1)
F5_14=FiniteField(5,MU29_MODULUS)


def trim(a):
    a=list(a)
    while len(a)>1 and a[-1]==0:a.pop()
    return a

def padd(F,a,b):
    return trim([F.add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])

def pneg(F,a):return [F.neg(x) for x in a]
def psub(F,a,b):return padd(F,a,pneg(F,b))

def pmul(F,a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=F.add(c[i+j],F.mul(x,y))
    return trim(c)

def pdivmod(F,a,b):
    a=trim(a);b=trim(b)
    if b==[0]:raise ZeroDivisionError
    q=[0]*max(1,len(a)-len(b)+1)
    inv=F.inv(b[-1])
    while a!=[0] and len(a)>=len(b):
        j=len(a)-len(b);c=F.mul(a[-1],inv);q[j]=c
        for i,x in enumerate(b):a[i+j]=F.sub(a[i+j],F.mul(c,x))
        a=trim(a)
    return trim(q),a

def pgcd(F,a,b):
    while b!=[0]:a,b=b,pdivmod(F,a,b)[1]
    inv=F.inv(a[-1]);return [F.mul(x,inv) for x in a]

def ppowmod(F,a,n,m):
    r=[1]
    while n:
        if n&1:r=pdivmod(F,pmul(F,r,a),m)[1]
        a=pdivmod(F,pmul(F,a,a),m)[1];n//=2
    return r

def peval(F,a,x):
    r=0
    for c in reversed(a):r=F.add(F.mul(r,x),c)
    return r

def pderiv(F,a):
    return trim([F.mul(i%F.p,a[i]) for i in range(1,len(a))] or [0])

@dataclass(frozen=True)
class ExtensionField:
    base: FiniteField
    modulus: tuple[int,...]

    @property
    def p(self):return self.base.p
    @property
    def degree(self):return len(self.modulus)-1
    @property
    def order(self):return self.base.order**self.degree
    def digits(self,a):
        v=[]
        for _ in range(self.degree):v.append(a%self.base.order);a//=self.base.order
        if a:raise ValueError('Field code out of range')
        return tuple(v)
    def encode(self,cs):
        a=0
        for c in reversed(tuple(cs)):a=a*self.base.order+c
        return a
    def add(self,a,b):return self.encode(self.base.add(x,y) for x,y in zip(self.digits(a),self.digits(b)))
    def neg(self,a):return self.encode(self.base.neg(x) for x in self.digits(a))
    def sub(self,a,b):return self.add(a,self.neg(b))
    def mul(self,a,b):
        F=self.base;d=self.degree;out=[0]*(2*d-1)
        for i,x in enumerate(self.digits(a)):
            for j,y in enumerate(self.digits(b)):
                if x and y:out[i+j]=F.add(out[i+j],F.mul(x,y))
        for i in range(2*d-2,d-1,-1):
            if out[i]:
                for j in range(d):out[i-d+j]=F.sub(out[i-d+j],F.mul(out[i],self.modulus[j]))
        return self.encode(out[:d])
    def pow(self,a,n):
        if n<0:return self.pow(self.inv(a),-n)
        r=1
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a);n//=2
        return r
    def inv(self,a):
        if not a:raise ZeroDivisionError
        return self.pow(a,self.order-2)
    def div(self,a,b):return self.mul(a,self.inv(b))
