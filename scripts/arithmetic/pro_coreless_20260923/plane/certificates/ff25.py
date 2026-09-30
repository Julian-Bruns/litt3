"""Exact F_25 and ascending-polynomial arithmetic, using the problem's codes.

A code c0+5*c1 denotes c0+c1*a, with a^2=a+3.  No dependencies.
This module deliberately uses elementary arithmetic so that certificates
can be checked without a computer algebra system.
"""
from typing import List, Sequence, Tuple

Poly = List[int]
P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
A0 = [1, 21, 14, 22, 13]
Q = [0, 11, 6, 21, 22, 0, 15, 21, 9, 4, 0, 1, 1, 24, 14, 0, 3, 9, 8, 24]
B_EXPECTED = [22, 16, 11, 3, 15, 11, 2, 6, 12, 14]


def add(x: int, y: int) -> int:
    return ((x % 5 + y % 5) % 5) + 5 * ((x // 5 + y // 5) % 5)


def neg(x: int) -> int:
    return (-x % 5) + 5 * (-(x // 5) % 5)


def sub(x: int, y: int) -> int:
    return add(x, neg(y))


def mul(x: int, y: int) -> int:
    a, b = x % 5, x // 5
    c, d = y % 5, y // 5
    return ((a * c + 3 * b * d) % 5) + 5 * ((a * d + b * c + b * d) % 5)


def power(x: int, n: int) -> int:
    if n < 0:
        return power(inv(x), -n)
    ans = 1
    while n:
        if n & 1:
            ans = mul(ans, x)
        x = mul(x, x)
        n //= 2
    return ans


def inv(x: int) -> int:
    if x == 0:
        raise ZeroDivisionError("zero in F_25")
    return power(x, 23)


def trim(a: Sequence[int]) -> Poly:
    a = list(a) or [0]
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def padd(a: Sequence[int], b: Sequence[int]) -> Poly:
    return trim([add(a[i] if i < len(a) else 0, b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def pneg(a: Sequence[int]) -> Poly:
    return trim([neg(x) for x in a])


def psub(a: Sequence[int], b: Sequence[int]) -> Poly:
    return padd(a, pneg(b))


def scale(a: Sequence[int], c: int) -> Poly:
    return trim([mul(x, c) for x in a])


def pmul(a: Sequence[int], b: Sequence[int]) -> Poly:
    ans = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            ans[i + j] = add(ans[i + j], mul(x, y))
    return trim(ans)


def ppow(a: Sequence[int], n: int) -> Poly:
    if n < 0:
        raise ValueError("negative polynomial exponent")
    ans, a = [1], list(a)
    while n:
        if n & 1:
            ans = pmul(ans, a)
        a = pmul(a, a)
        n //= 2
    return ans


def pdiv(a: Sequence[int], b: Sequence[int]) -> Tuple[Poly, Poly]:
    a, b = trim(a), trim(b)
    if b == [0]:
        raise ZeroDivisionError("zero polynomial")
    quotient = [0] * max(1, len(a) - len(b) + 1)
    ib = inv(b[-1])
    while a != [0] and len(a) >= len(b):
        j = len(a) - len(b)
        c = mul(a[-1], ib)
        quotient[j] = c
        a = psub(a, [0] * j + scale(b, c))
    return trim(quotient), a


def pmod(a: Sequence[int], b: Sequence[int]) -> Poly:
    return pdiv(a, b)[1]


def pgcd(a: Sequence[int], b: Sequence[int]) -> Poly:
    a, b = trim(a), trim(b)
    while b != [0]:
        a, b = b, pmod(a, b)
    return [0] if a == [0] else scale(a, inv(a[-1]))


def pxgcd(a: Sequence[int], b: Sequence[int]) -> Tuple[Poly, Poly, Poly]:
    """Return monic g,s,t with s*a+t*b=g."""
    r0, r1, s0, s1, t0, t1 = trim(a), trim(b), [1], [0], [0], [1]
    while r1 != [0]:
        q, r = pdiv(r0, r1)
        r0, r1 = r1, r
        s0, s1 = s1, psub(s0, pmul(q, s1))
        t0, t1 = t1, psub(t0, pmul(q, t1))
    if r0 == [0]:
        return r0, s0, t0
    c = inv(r0[-1])
    return scale(r0, c), scale(s0, c), scale(t0, c)


def derivative(a: Sequence[int]) -> Poly:
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def evaluate(a: Sequence[int], x: int) -> int:
    ans = 0
    for c in reversed(a):
        ans = add(mul(ans, x), c)
    return ans


def dot(a: Sequence[int], b: Sequence[int]) -> int:
    if len(a) != len(b):
        raise ValueError("incompatible vector lengths")
    ans = 0
    for x, y in zip(a, b):
        ans = add(ans, mul(x, y))
    return ans


def determinant(matrix: Sequence[Sequence[int]]) -> int:
    n = len(matrix)
    if any(len(row) != n for row in matrix):
        raise ValueError("matrix is not square")
    a = [list(row) for row in matrix]
    ans = 1
    for j in range(n):
        i = next((i for i in range(j, n) if a[i][j]), None)
        if i is None:
            return 0
        if i != j:
            a[i], a[j] = a[j], a[i]
            ans = neg(ans)
        pivot = a[j][j]
        ans = mul(ans, pivot)
        a[j] = [mul(x, inv(pivot)) for x in a[j]]
        for i in range(j + 1, n):
            c = a[i][j]
            a[i] = [sub(x, mul(c, y)) for x, y in zip(a[i], a[j])]
    return ans


def solve_unique(matrix: Sequence[Sequence[int]], rhs: Sequence[int]) -> List[int]:
    """Solve a square nonsingular system, raising on singular inputs."""
    n = len(matrix)
    if len(rhs) != n or any(len(row) != n for row in matrix):
        raise ValueError("expected a square system")
    a = [list(row) + [rhs[i]] for i, row in enumerate(matrix)]
    for j in range(n):
        i = next((i for i in range(j, n) if a[i][j]), None)
        if i is None:
            raise ValueError("singular system")
        a[i], a[j] = a[j], a[i]
        a[j] = [mul(x, inv(a[j][j])) for x in a[j]]
        for i in range(n):
            if i != j:
                c = a[i][j]
                a[i] = [sub(x, mul(c, y)) for x, y in zip(a[i], a[j])]
    return [a[i][-1] for i in range(n)]


def interpolate_B() -> Poly:
    columns = []
    for i in range(10):
        c = pmod([0] * (5 * i) + [1], P)
        columns.append(c + [0] * (10 - len(c)))
    matrix = [list(row) for row in zip(*columns)]
    rhs = pmod(pneg(Q), P)
    rhs += [0] * (10 - len(rhs))
    fifth_powers = solve_unique(matrix, rhs)
    return [power(c, 5) for c in fifth_powers]
