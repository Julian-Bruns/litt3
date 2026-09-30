"""Dependency-free finite field arithmetic for the user's specified tower.

The integers used by Field.__call__ are PRIME-FIELD integers, never F25 codes.
Use code(n), or embed(code(n), F), for the problem's [n] convention.
This deliberately slow reference implementation favors verifiability.
"""
from __future__ import annotations
from dataclasses import dataclass
from typing import Iterable

class PrimeField:
    p = 5
    order = 5
    degree = 1
    name = 'F5'
    def __call__(self, n): return int(n) % 5
    def add(self, a, b): return (a + b) % 5
    def neg(self, a): return (-a) % 5
    def mul(self, a, b): return (a * b) % 5
    def inv(self, a):
        if not a: raise ZeroDivisionError
        return pow(a, 3, 5)
    def pow(self, a, n):
        if n < 0: return self.pow(self.inv(a), -n)
        return pow(a, n, 5)
    zero = 0
    one = 1

F5 = PrimeField()

class Field:
    def __init__(self, base, modulus, name):
        self.base = base
        self.modulus = tuple(modulus)
        assert self.modulus[-1] == base.one
        self.n = len(modulus) - 1
        self.degree = base.degree * self.n
        self.order = 5 ** self.degree
        self.name = name
        self.zero = Elt(self, (base.zero,) * self.n)
        self.one = self(1)
        self.gen = Elt(self, (base.zero, base.one) + (base.zero,) * (self.n-2))
    def __call__(self, n):
        if isinstance(n, Elt):
            return embed(n, self)
        return self.from_base(self.base(n))
    def from_base(self, a): return Elt(self, (a,) + (self.base.zero,) * (self.n-1))
    def row(self, entries):
        entries = tuple(entries)
        assert len(entries) <= self.n
        return Elt(self, entries + (self.base.zero,) * (self.n-len(entries)))
    def add(self, a, b):
        return Elt(self, tuple(self.base.add(x, y) for x,y in zip(a.c, b.c)))
    def neg(self, a): return Elt(self, tuple(self.base.neg(x) for x in a.c))
    def mul(self, a, b):
        B = self.base; n = self.n
        out = [B.zero] * (2*n-1)
        for i,x in enumerate(a.c):
            if x == B.zero: continue
            for j,y in enumerate(b.c):
                if y != B.zero: out[i+j] = B.add(out[i+j], B.mul(x,y))
        for i in range(2*n-2, n-1, -1):
            t = out[i]
            if t != B.zero:
                for j,v in enumerate(self.modulus[:-1]):
                    if v != B.zero: out[i-n+j] = B.add(out[i-n+j], B.neg(B.mul(t,v)))
        return Elt(self, tuple(out[:n]))
    def pow(self, a, n):
        if n < 0: return self.pow(self.inv(a), -n)
        r = self.one
        while n:
            if n & 1: r = self.mul(r,a)
            n >>= 1
            if n: a = self.mul(a,a)
        return r
    def inv(self, a):
        if a == self.zero: raise ZeroDivisionError
        return self.pow(a, self.order-2)

@dataclass(frozen=True)
class Elt:
    field: Field
    c: tuple
    def coerce(self, b): return b if isinstance(b,Elt) and b.field is self.field else self.field(b)
    def __add__(self, b): return self.field.add(self, self.coerce(b))
    def __radd__(self, b): return self + b
    def __neg__(self): return self.field.neg(self)
    def __sub__(self, b): return self + (-self.coerce(b))
    def __rsub__(self, b): return self.coerce(b) - self
    def __mul__(self, b): return self.field.mul(self, self.coerce(b))
    def __rmul__(self, b): return self * b
    def __pow__(self, n): return self.field.pow(self,n)
    def __truediv__(self, b): return self * self.coerce(b).inverse()
    def __rtruediv__(self, b): return self.coerce(b) * self.inverse()
    def inverse(self): return self.field.inv(self)
    def frob(self, n=1): return self ** (5 ** (n % self.field.degree))
    def __bool__(self): return self != self.field.zero
    def __repr__(self): return f'{self.field.name}{self.c}'

def embed(a, target):
    if not isinstance(a, Elt): return target(a)
    if a.field is target: return a
    if isinstance(target, PrimeField): raise ValueError('Not an embedding')
    return target.from_base(embed(a, target.base))

F25 = Field(F5, [2,4,1], 'F25') # beta^2 - beta - 3
beta = F25.gen

def code(n: int):
    if not 0 <= n < 25: raise ValueError('F25 code must be in 0..24')
    return F25.row([n%5,n//5])

def to_code(a):
    assert a.field is F25
    return a.c[0] + 5*a.c[1]

A_CODES = [5,2,6,7,1]
F7_CODES = [4,22,7,20,21,7,24,1]
K = Field(F25, list(map(code,F7_CODES)), 'K')
zeta = K.gen
T = Field(F25, list(map(code,A_CODES)), 'T')
alpha_T = T.gen
F = Field(K, [embed(code(n),K) for n in A_CODES], 'F')
alpha = F.gen

def T_to_F(a):
    assert a.field is T
    return F.row([embed(x,K) for x in a.c])

def F_to_K(a):
    assert a.field is F
    if any(a.c[1:]): raise ValueError('Element is not in K')
    return a.c[0]

def encode(a):
    """JSON data: F25 code, K row of 7 codes, F row of 4 K rows."""
    if a.field is F25: return to_code(a)
    if a.field is T: return [to_code(v) for v in a.c]
    return [encode(v) for v in a.c]

def decode(field, data):
    if field is F25: return code(data)
    return field.row([decode(field.base,v) for v in data])

def evaluate(row, x):
    v = x.field.zero
    for n in reversed(row): v = v*x + embed(code(n), x.field)
    return v

def sigma(a):
    # Computing in alpha after fixing all K coefficients is quicker than 5^42.
    assert a.field is F or a.field is T
    im = a.field.gen ** 25
    s = a.field.zero
    for v in reversed(a.c): s = s*im + a.field.from_base(v)
    return s

def pi(a, lam):
    s = a.field.zero
    for j in range(4):
        s += pow(lam, (-j)%4, 5) * a
        a = sigma(a)
    return 4*s

CODES = {'c':[22,7,9,23], 'e':[1,3,8,15],
         'f':[20,12,13,8], 'g':[21,21,20,2]}
ETA = code(22)

if __name__ == '__main__':
    import json, sys
    assert beta**2 == beta+3
    assert evaluate(A_CODES, alpha_T) == T.zero
    assert evaluate(F7_CODES,zeta) == K.zero
    assert zeta**29 == 1*zeta.field.one and zeta != K.one
    assert alpha_T**(25**4) == alpha_T and alpha_T**(25**2) != alpha_T
    c = evaluate(CODES['c'],alpha_T)
    projections = {str(lam):encode(pi(c,lam)) for lam in [1,2,3,4]}
    assert projections['2'] == [5,17,12,5]
    assert projections['3'] == [23,8,17,20]
    assert projections['4'] == [4,12,5,23]
    print(json.dumps({'status':'PASS','field_degrees':[2,14,8,56],
                     'c_projections':projections},indent=2))
