"""Exact F_25 and univariate arithmetic, with no third-party dependencies.

The code a+5*b denotes a+b*beta, beta^2=beta+3. Polynomial rows ascend.
All integer operands in field operations are encoded field elements, not Z.
Use c % 5 for the image of a rational integer c.
"""
from __future__ import annotations
from dataclasses import dataclass


def add(a: int, b: int) -> int:
    return ((a % 5 + b % 5) % 5) + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) + 5 * (-(a // 5) % 5)


def sub(a: int, b: int) -> int:
    return add(a, neg(b))


def mul(a: int, b: int) -> int:
    a0, a1 = a % 5, a // 5
    b0, b1 = b % 5, b // 5
    return (a0*b0 + 3*a1*b1) % 5 + 5*((a0*b1+a1*b0+a1*b1) % 5)


def power(a: int, n: int) -> int:
    if n < 0:
        return power(inv(a), -n)
    r = 1
    while n:
        if n & 1:
            r = mul(r, a)
        a = mul(a, a)
        n >>= 1
    return r


def inv(a: int) -> int:
    if a == 0:
        raise ZeroDivisionError('zero in F_25')
    return power(a, 23)


def div(a: int, b: int) -> int:
    return mul(a, inv(b))


def trim(a) -> tuple[int, ...]:
    a = list(a)
    if any(not isinstance(c, int) or not 0 <= c < 25 for c in a):
        raise ValueError('coefficients must be encoded integers 0..24')
    while a and a[-1] == 0:
        a.pop()
    return tuple(a)


def padd(a, b):
    return trim(add(a[i] if i < len(a) else 0, b[i] if i < len(b) else 0)
                for i in range(max(len(a), len(b))))


def pneg(a):
    return trim(neg(c) for c in a)


def psub(a, b):
    return padd(a, pneg(b))


def pscale(a, c):
    return trim(mul(x, c) for x in a)


def pmul(a, b):
    if not a or not b:
        return ()
    out = [0] * (len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i+j] = add(out[i+j], mul(x, y))
    return trim(out)


def ppow(a, n):
    if n < 0:
        raise ValueError('negative polynomial exponent')
    r = (1,)
    while n:
        if n & 1:
            r = pmul(r, a)
        a = pmul(a, a)
        n >>= 1
    return r


def pdivmod(a, b):
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError('zero polynomial')
    q = [0] * max(0, len(a)-len(b)+1)
    r = list(a)
    while len(r) >= len(b):
        j = len(r)-len(b)
        c = div(r[-1], b[-1])
        q[j] = c
        for i, x in enumerate(b):
            r[i+j] = sub(r[i+j], mul(c, x))
        while r and r[-1] == 0:
            r.pop()
    return trim(q), trim(r)


def pexact(a, b):
    q, r = pdivmod(a, b)
    if r:
        raise ArithmeticError('inexact polynomial division')
    return q


def pgcd(a, b):
    a, b = trim(a), trim(b)
    while b:
        a, b = b, pdivmod(a, b)[1]
    return pscale(a, inv(a[-1])) if a else ()


def derivative(a):
    return trim(mul(i % 5, a[i]) for i in range(1, len(a)))


def evaluate(a, x):
    r = 0
    for c in reversed(a):
        r = add(mul(r, x), c)
    return r


@dataclass(frozen=True)
class Rat:
    """A normalized element of F_25(t)."""
    num: tuple[int, ...] = ()
    den: tuple[int, ...] = (1,)

    def __post_init__(self):
        n, d = trim(self.num), trim(self.den)
        if not d:
            raise ZeroDivisionError('zero rational-function denominator')
        if not n:
            n, d = (), (1,)
        else:
            g = pgcd(n, d)
            n, d = pexact(n, g), pexact(d, g)
            c = inv(d[-1])
            n, d = pscale(n, c), pscale(d, c)
        object.__setattr__(self, 'num', n)
        object.__setattr__(self, 'den', d)

    @staticmethod
    def constant(a: int):
        return Rat((a,))

    @staticmethod
    def coerce(a):
        return a if isinstance(a, Rat) else Rat.constant(a)

    def __bool__(self):
        return bool(self.num)

    def __add__(self, other):
        o = Rat.coerce(other)
        return Rat(padd(pmul(self.num, o.den), pmul(o.num, self.den)),
                   pmul(self.den, o.den))

    __radd__ = __add__

    def __neg__(self):
        return Rat(pneg(self.num), self.den)

    def __sub__(self, other):
        return self + (-Rat.coerce(other))

    def __rsub__(self, other):
        return Rat.coerce(other) + (-self)

    def __mul__(self, other):
        o = Rat.coerce(other)
        return Rat(pmul(self.num, o.num), pmul(self.den, o.den))

    __rmul__ = __mul__

    def inverse(self):
        if not self:
            raise ZeroDivisionError('zero rational function')
        return Rat(self.den, self.num)

    def __truediv__(self, other):
        return self * Rat.coerce(other).inverse()

    def __rtruediv__(self, other):
        return Rat.coerce(other) * self.inverse()

    def __pow__(self, n: int):
        if n < 0:
            return self.inverse() ** (-n)
        return Rat(ppow(self.num, n), ppow(self.den, n))

    def diff(self):
        return Rat(psub(pmul(derivative(self.num), self.den),
                         pmul(self.num, derivative(self.den))),
                   ppow(self.den, 2))

    def as_json(self):
        return {'numerator': list(self.num), 'denominator': list(self.den)}
