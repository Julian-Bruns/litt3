"""Exact arithmetic scaffold for a biquadratic extension of F_25(t).

It is a field when d1,d2,d3 are squarefree, pairwise coprime and the three
products d2*d3, d1*d3, d1*d2 are nonsquares. These hypotheses are NOT
silently checked by the constructor. This module is not a geometric
candidate verifier; in particular it does not certify endpoint indices.

Basis: 1,z1,z2,z3; zi^2=dj*dk and zi*zj=dk*zk.
Involution i fixes zi and negates the two other nontrivial basis vectors.
"""
from __future__ import annotations
from dataclasses import dataclass
from finite25 import Rat


@dataclass(frozen=True)
class Algebra:
    d: tuple[Rat, Rat, Rat]

    def element(self, rows):
        if len(rows) != 4:
            raise ValueError('four components required')
        return Element(self, tuple(Rat.coerce(c) for c in rows))

    def scalar(self, x):
        return self.element((x, 0, 0, 0))

    def basis(self, i):
        return self.element(tuple(1 if j == i else 0 for j in range(4)))

    def table(self, i, j):
        if i == 0:
            return j, Rat.constant(1)
        if j == 0:
            return i, Rat.constant(1)
        if i == j:
            other = [k for k in range(1, 4) if k != i]
            return 0, self.d[other[0]-1] * self.d[other[1]-1]
        k = 6-i-j
        return k, self.d[k-1]


@dataclass(frozen=True)
class Element:
    algebra: Algebra
    c: tuple[Rat, Rat, Rat, Rat]

    def coerce(self, other):
        if isinstance(other, Element):
            if other.algebra != self.algebra:
                raise ValueError('different algebras')
            return other
        return self.algebra.scalar(other)

    def __bool__(self):
        return any(self.c)

    def __add__(self, other):
        o = self.coerce(other)
        return self.algebra.element(tuple(a+b for a,b in zip(self.c,o.c)))

    __radd__ = __add__

    def __neg__(self):
        return self.algebra.element(tuple(-a for a in self.c))

    def __sub__(self, other):
        return self + (-self.coerce(other))

    def __rsub__(self, other):
        return self.coerce(other) + (-self)

    def __mul__(self, other):
        o = self.coerce(other)
        c = [Rat()] * 4
        for i in range(4):
            for j in range(4):
                if not self.c[i] or not o.c[j]:
                    continue
                k, r = self.algebra.table(i,j)
                c[k] = c[k] + self.c[i]*o.c[j]*r
        return self.algebra.element(c)

    __rmul__ = __mul__

    def inverse(self):
        """Solve the four-dimensional multiplication matrix over F_25(t)."""
        if not self:
            raise ZeroDivisionError('zero element')
        columns = [(self*self.algebra.basis(j)).c for j in range(4)]
        rows = [[columns[j][i] for j in range(4)] +
                [Rat.constant(1 if i == 0 else 0)] for i in range(4)]
        for j in range(4):
            pivot = next((i for i in range(j,4) if rows[i][j]), None)
            if pivot is None:
                raise ArithmeticError('singular multiplication matrix')
            rows[j], rows[pivot] = rows[pivot], rows[j]
            q = rows[j][j].inverse()
            rows[j] = [a*q for a in rows[j]]
            for i in range(4):
                if i != j and rows[i][j]:
                    q = rows[i][j]
                    rows[i] = [a-q*b for a,b in zip(rows[i],rows[j])]
        return self.algebra.element(tuple(rows[i][4] for i in range(4)))

    def __truediv__(self, other):
        return self * self.coerce(other).inverse()

    def __pow__(self, n):
        if n < 0:
            return self.inverse()**(-n)
        r, a = self.algebra.scalar(1), self
        while n:
            if n & 1:
                r = r*a
            a = a*a
            n >>= 1
        return r

    def sigma(self, i):
        if i not in (0,1,2,3):
            raise ValueError('involution index 0..3')
        return self.algebra.element(tuple(
            a if i == 0 or j == 0 or i == j else -a
            for j,a in enumerate(self.c)))

    def diff(self):
        c = [a.diff() for a in self.c]
        for i in range(1,4):
            _, square = self.algebra.table(i,i)
            c[i] = c[i] + self.c[i]*square.diff()/(square*2)
        return self.algebra.element(c)

    def orbit_size(self):
        return len(set(self.sigma(i) for i in range(4)))

    def as_json(self):
        return [x.as_json() for x in self.c]
