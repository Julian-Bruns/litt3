"""Exact F_25 and polynomial arithmetic, with no external dependencies.

Encoding: a + 5*b denotes a + b*beta, beta^2 = beta + 3.
Polynomials are ascending lists; the zero polynomial is [].
This small implementation is intended for transparent verification, not speed.
"""
from __future__ import annotations


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) + 5 * ((-(a // 5)) % 5)


def sub(a: int, b: int) -> int:
    return add(a, neg(b))


def mul(a: int, b: int) -> int:
    a0, a1, b0, b1 = a % 5, a // 5, b % 5, b // 5
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
        raise ZeroDivisionError('Inverse of zero in F_25')
    return power(a, 23)


def div(a: int, b: int) -> int:
    return mul(a, inv(b))


def trim(p: list[int]) -> list[int]:
    p = p[:]
    while p and p[-1] == 0:
        p.pop()
    return p


def padd(p: list[int], q: list[int]) -> list[int]:
    return trim([add(p[i] if i < len(p) else 0,
                     q[i] if i < len(q) else 0)
                 for i in range(max(len(p), len(q)))])


def pneg(p: list[int]) -> list[int]:
    return [neg(a) for a in p]


def psub(p: list[int], q: list[int]) -> list[int]:
    return padd(p, pneg(q))


def pscale(p: list[int], a: int) -> list[int]:
    return trim([mul(x, a) for x in p])


def pmul(p: list[int], q: list[int]) -> list[int]:
    if not p or not q:
        return []
    r = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            r[i+j] = add(r[i+j], mul(a, b))
    return trim(r)


def pdiv(p: list[int], q: list[int]) -> tuple[list[int], list[int]]:
    p, q = trim(p), trim(q)
    if not q:
        raise ZeroDivisionError('Polynomial division by zero')
    out = [0] * max(0, len(p) - len(q) + 1)
    while p and len(p) >= len(q):
        i = len(p) - len(q)
        a = div(p[-1], q[-1])
        out[i] = a
        p = psub(p, [0]*i + pscale(q, a))
    return trim(out), p


def pmod(p: list[int], q: list[int]) -> list[int]:
    return pdiv(p, q)[1]


def pmon(p: list[int]) -> list[int]:
    return pscale(p, inv(p[-1])) if p else []


def pgcd(p: list[int], q: list[int]) -> list[int]:
    while q:
        p, q = q, pmod(p, q)
    return pmon(p)


def ppow(a: list[int], n: int, modulus: list[int]) -> list[int]:
    if n < 0:
        raise ValueError('Use field inversion before negative polynomial powers')
    r = [1]
    a = pmod(a, modulus)
    while n:
        if n & 1:
            r = pmod(pmul(r, a), modulus)
        a = pmod(pmul(a, a), modulus)
        n >>= 1
    return r


def pdiff(p: list[int]) -> list[int]:
    return trim([mul(i % 5, p[i]) for i in range(1, len(p))])


def peval(p: list[int], a: int) -> int:
    r = 0
    for x in reversed(p):
        r = add(mul(r, a), x)
    return r


def pad(p: list[int], n: int) -> list[int]:
    if len(trim(p)) > n:
        raise ValueError('Padding would truncate a nonzero coefficient')
    return p[:n] + [0] * max(0, n-len(p))


def rref(mat: list[list[int]]) -> tuple[int, list[list[int]]]:
    a = [r[:] for r in mat]
    if not a:
        return 0, a
    h = 0
    for c in range(len(a[0])):
        i = next((i for i in range(h, len(a)) if a[i][c]), None)
        if i is None:
            continue
        a[h], a[i] = a[i], a[h]
        z = a[h][c]
        a[h] = [div(x, z) for x in a[h]]
        for j in range(len(a)):
            if j != h:
                z = a[j][c]
                a[j] = [sub(x, mul(z, y)) for x, y in zip(a[j], a[h])]
        h += 1
        if h == len(a):
            break
    return h, a


def determinant(mat: list[list[int]]) -> int:
    a = [r[:] for r in mat]
    n = len(a)
    if any(len(r) != n for r in a):
        raise ValueError('Determinant requires a square matrix')
    d = 1
    for i in range(n):
        j = next((j for j in range(i, n) if a[j][i]), None)
        if j is None:
            return 0
        if i != j:
            a[i], a[j] = a[j], a[i]
            d = neg(d)
        z = a[i][i]
        d = mul(d, z)
        a[i] = [div(x, z) for x in a[i]]
        for j in range(i+1, n):
            z = a[j][i]
            a[j] = [sub(x, mul(z, y)) for x, y in zip(a[j], a[i])]
    return d
