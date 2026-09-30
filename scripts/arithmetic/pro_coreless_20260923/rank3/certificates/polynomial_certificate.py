"""Small exact F_25 polynomial routines for independently checkable identities.

Ascending coefficient lists; [] is the zero polynomial. Field arithmetic is
imported from the dependency-free first-return verifier.
"""
from __future__ import annotations
import verify_rank3_first_return as ff

Polynomial = list[int]

def trim(a: Polynomial) -> Polynomial:
    a = list(a)
    while a and a[-1] == 0:
        a.pop()
    return a

def add(a: Polynomial, b: Polynomial) -> Polynomial:
    return trim([ff.add(a[i] if i < len(a) else 0,
                        b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])

def negative(a: Polynomial) -> Polynomial:
    return [ff.negative(x) for x in a]

def multiply(a: Polynomial, b: Polynomial) -> Polynomial:
    if not a or not b:
        return []
    result = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            result[i + j] = ff.add(result[i + j], ff.multiply(x, y))
    return trim(result)

def divide(a: Polynomial, b: Polynomial) -> tuple[Polynomial, Polynomial]:
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError('Polynomial divisor is zero.')
    quotient = [0] * max(0, len(a) - len(b) + 1)
    while a and len(a) >= len(b):
        shift = len(a) - len(b)
        value = ff.multiply(a[-1], ff.inverse(b[-1]))
        quotient[shift] = value
        for i, x in enumerate(b):
            a[i + shift] = ff.add(a[i + shift],
                                  ff.negative(ff.multiply(value, x)))
        a = trim(a)
    return trim(quotient), a

def xgcd(a: Polynomial, b: Polynomial) -> tuple[Polynomial, Polynomial, Polynomial]:
    """Return monic g, s, t such that s*a + t*b = g."""
    r0, r1 = trim(a), trim(b)
    s0, s1, t0, t1 = [1], [], [], [1]
    if not r0 and not r1:
        return [], [], []
    while r1:
        q, r = divide(r0, r1)
        r0, r1 = r1, r
        s0, s1 = s1, add(s0, negative(multiply(q, s1)))
        t0, t1 = t1, add(t0, negative(multiply(q, t1)))
    c = ff.inverse(r0[-1])
    scaled = lambda x: [ff.multiply(c, y) for y in x]
    result = scaled(r0), scaled(s0), scaled(t0)
    assert add(multiply(result[1], a), multiply(result[2], b)) == result[0]
    return result

def evaluate(a: Polynomial, x: int) -> int:
    value = 0
    for c in reversed(a):
        value = ff.add(ff.multiply(value, x), c)
    return value

def determinant_pencil(a, b) -> Polynomial:
    """det(a+t*b) by exterior-product dynamic programming, no interpolation."""
    n = len(a)
    if len(b) != n or any(len(r) != n for r in a) or any(len(r) != n for r in b):
        raise ValueError('Two equally sized square matrices are required.')
    state = {0: [1]}
    for i in range(n):
        new = {}
        for mask, polynomial in state.items():
            for j in range(n):
                if mask & (1 << j):
                    continue
                term = multiply(polynomial, [int(a[i][j]), int(b[i][j])])
                if (mask >> (j + 1)).bit_count() % 2:
                    term = negative(term)
                target = mask | (1 << j)
                new[target] = add(new.get(target, []), term)
        state = new
    return state[(1 << n) - 1]
