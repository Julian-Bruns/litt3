"""Exact F_25 and univariate polynomial arithmetic; Python standard library only.

Code a+5*b denotes a+b*beta with beta^2=beta+3. Coefficients ascend.
These routines verify the supplied input, not the unknown geometric locus.
"""
from __future__ import annotations


def add(x: int, y: int) -> int:
    return (x % 5 + y % 5) % 5 + 5 * ((x // 5 + y // 5) % 5)


def neg(x: int) -> int:
    return (-x % 5) % 5 + 5 * ((-(x // 5)) % 5)


def sub(x: int, y: int) -> int:
    return add(x, neg(y))


def mul(x: int, y: int) -> int:
    a, b, c, d = x % 5, x // 5, y % 5, y // 5
    return (a*c + 3*b*d) % 5 + 5*((a*d + b*c + b*d) % 5)


def power(x: int, n: int) -> int:
    if n < 0:
        return power(inv(x), -n)
    result = 1
    while n:
        if n & 1:
            result = mul(result, x)
        x = mul(x, x)
        n >>= 1
    return result


def inv(x: int) -> int:
    if not x:
        raise ZeroDivisionError("zero in F_25")
    return power(x, 23)


def trim(p: list[int]) -> list[int]:
    q = list(p)
    while q and q[-1] == 0:
        q.pop()
    return q


def padd(a: list[int], b: list[int]) -> list[int]:
    out = [0] * max(len(a), len(b))
    for i, c in enumerate(a):
        out[i] = add(out[i], c)
    for i, c in enumerate(b):
        out[i] = add(out[i], c)
    return trim(out)


def pneg(a: list[int]) -> list[int]:
    return trim([neg(c) for c in a])


def psub(a: list[int], b: list[int]) -> list[int]:
    return padd(a, pneg(b))


def scale(a: list[int], c: int) -> list[int]:
    return trim([mul(x, c) for x in a])


def pmul(a: list[int], b: list[int]) -> list[int]:
    if not a or not b:
        return []
    out = [0] * (len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i+j] = add(out[i+j], mul(x, y))
    return trim(out)


def pdivmod(a: list[int], b: list[int]) -> tuple[list[int], list[int]]:
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError("zero polynomial")
    q = [0] * max(0, len(a)-len(b)+1)
    il = inv(b[-1])
    while a and len(a) >= len(b):
        k = len(a)-len(b)
        c = mul(a[-1], il)
        q[k] = add(q[k], c)
        a = psub(a, [0]*k + scale(b, c))
    return trim(q), a


def derivative(p: list[int]) -> list[int]:
    return trim([mul(i % 5, p[i]) for i in range(1, len(p))])


def xgcd(a: list[int], b: list[int]) -> tuple[list[int], list[int], list[int]]:
    a, b = trim(a), trim(b)
    s0, s1, t0, t1 = [1], [], [], [1]
    while b:
        q, r = pdivmod(a, b)
        a, b = b, r
        s0, s1 = s1, psub(s0, pmul(q, s1))
        t0, t1 = t1, psub(t0, pmul(q, t1))
    if not a:
        return [], [], []
    c = inv(a[-1])
    return scale(a, c), scale(s0, c), scale(t0, c)


def det_poly(matrix: list[list[list[int]]]) -> list[int]:
    """Small exact determinant over F_25[z], using the permutation formula."""
    from itertools import permutations
    n = len(matrix)
    if any(len(row) != n for row in matrix):
        raise ValueError("matrix must be square")
    result: list[int] = []
    for p in permutations(range(n)):
        inversions = sum(p[i] > p[j] for i in range(n) for j in range(i+1, n))
        term = [1]
        for i in range(n):
            term = pmul(term, matrix[i][p[i]])
        result = padd(result, pneg(term) if inversions % 2 else term)
    return result


def critical_value_polynomial(a: list[int]) -> list[int]:
    """det(zI-m_A) in F_25[x]/(A'), a monic critical-value polynomial."""
    ap = derivative(a)
    degree = len(ap)-1
    if degree <= 0:
        raise ValueError("positive-degree derivative required")
    columns = []
    for i in range(degree):
        r = pdivmod([0]*i + a, ap)[1]
        columns.append(r + [0]*(degree-len(r)))
    matrix = []
    for row in range(degree):
        matrix.append([
            padd([neg(columns[col][row])], [0,1] if row == col else [])
            for col in range(degree)
        ])
    return det_poly(matrix)
