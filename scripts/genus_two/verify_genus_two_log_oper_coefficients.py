#!/usr/bin/env python3
"""Tiny symbolic coefficient identities for the new log-oper classification.

No endpoint arithmetic, Groebner basis, or historical certificate is replayed.
"""
class Polynomial:
    """Sparse polynomial in z,q,r,s,t,u,b over F5, without dependencies."""

    def __init__(self, terms=None):
        self.terms = {key: value % 5 for key, value in (terms or {}).items()
                      if value % 5}

    @staticmethod
    def coerce(value):
        if isinstance(value, Polynomial):
            return value
        return Polynomial({(0,)*7: value})

    def __add__(self, other):
        result = dict(self.terms)
        for key, value in self.coerce(other).terms.items():
            result[key] = result.get(key, 0) + value
        return Polynomial(result)

    __radd__ = __add__

    def __neg__(self):
        return Polynomial({key: -value for key, value in self.terms.items()})

    def __sub__(self, other):
        return self + -self.coerce(other)

    def __rsub__(self, other):
        return self.coerce(other) + -self

    def __mul__(self, other):
        result = {}
        for left, a in self.terms.items():
            for right, coefficient in self.coerce(other).terms.items():
                key = tuple(x+y for x, y in zip(left, right))
                result[key] = result.get(key, 0) + a*coefficient
        return Polynomial(result)

    __rmul__ = __mul__

    def __pow__(self, exponent):
        result = self.coerce(1)
        for _ in range(exponent):
            result = result*self
        return result

    def derivative(self, order=1):
        result = self
        for _ in range(order):
            terms = {}
            for key, coefficient in result.terms.items():
                if key[0]:
                    terms[(key[0]-1,)+key[1:]] = coefficient*key[0]
            result = Polynomial(terms)
        return result


def variable(index):
    key = [0]*7
    key[index] = 1
    return Polynomial({tuple(key): 1})


z, q, r, s, t, u, b = (variable(index) for index in range(7))


def zero_mod_five(expression):
    assert not expression.terms, expression.terms


phi = z**5 + q*z**4 + r*z**3 + s*z**2 + t*z + u
c_odd = q*z**2 + 3*r*z + s
h = 2*q*z**5 + 2*q*u + 2*r*t + s**2
# Restricted derivative (y*d/dz)^5 = H*(y*d/dz).
zero_mod_five(4*phi.derivative(2)**2
              + 2*phi.derivative()*phi.derivative(3)
              + 3*phi*phi.derivative(4) - h)
# For v^2=q the odd potential's remaining even equation is universal.
zero_mod_five(phi*c_odd.derivative(2)
              + 3*phi.derivative()*c_odd.derivative()
              - 3*c_odd**2 - 3*q*phi - 2*h)
# The third polynomial equation is redundant modulo the cubic.
c_numerator = b**2 + 2*r*b + 4*q*s
cubic = b**3 + 2*r*b**2 + 3*q*s*b - q**2*t
zero_mod_five(c_numerator**2 - q**2*(b*t + 2*r*t + s**2)
              - (b + 2*r)*cubic)
print("PASS: three symbolic log-oper identities over F5; no arithmetic replay.")
