#!/usr/bin/env python3
"""Exact coefficient certificate for the two-form reconstruction argument.

Python 3, standard library only.

The field is F_25 = F_5[a]/(a^2 + 4*a + 2).  Code n=n0+5*n1
means n0+n1*a, NOT reduction of the integer n modulo 5.
Polynomials are coefficient lists in ascending powers of x.

For X: y^3=P(x), the script verifies:
  * P is squarefree;
  * the displayed three h_i dx/y^2 are Cartier-exact;
  * rational primitives Q_i/y^5, with Q_i'=h_i P;
  * beta(omega_i,omega_j)=C((Q_i/y^5)*omega_j);
  * tau=C beta has coefficient determinant [13] != 0;
  * V+span(beta(V,V)) is the full six-dimensional dx/y^2 sector.

C is ABSOLUTE Cartier.  Its coefficient operation on F_25 is c -> c^5.
Thus tau is F_25-linear on wedge^2(V), and is 25^(-1)-semilinear
on extension of scalars to the algebraic closure.  The script verifies
coefficient identities, not existence or nonexistence of a clump.
"""
from typing import List, Tuple

Poly = List[int]
Matrix = List[List[int]]


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a) % 5 + 5 * ((-(a // 5)) % 5)


def sub(a: int, b: int) -> int:
    return add(a, neg(b))


def mul(a: int, b: int) -> int:
    # a^2 = a+3 for the field generator.
    x, y = a % 5, a // 5
    z, w = b % 5, b // 5
    return (x*z + 3*y*w) % 5 + 5 * ((x*w + y*z + y*w) % 5)


def power(a: int, n: int) -> int:
    if n < 0:
        raise ValueError("Exponent must be nonnegative")
    out = 1
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n //= 2
    return out


def inverse(a: int) -> int:
    if not a:
        raise ZeroDivisionError("Zero has no inverse")
    return power(a, 23)


def trim(a: Poly) -> Poly:
    a = list(a)
    while a and not a[-1]:
        a.pop()
    return a


def p_add(a: Poly, b: Poly) -> Poly:
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def p_sub(a: Poly, b: Poly) -> Poly:
    return p_add(a, [neg(x) for x in b])


def p_scale(a: Poly, c: int) -> Poly:
    return trim([mul(x, c) for x in a])


def p_mul(a: Poly, b: Poly) -> Poly:
    if not a or not b:
        return []
    out = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i+j] = add(out[i+j], mul(x, y))
    return trim(out)


def derivative(a: Poly) -> Poly:
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def p_divmod(a: Poly, b: Poly) -> Tuple[Poly, Poly]:
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError("Zero polynomial divisor")
    q = [0] * max(0, len(a) - len(b) + 1)
    while a and len(a) >= len(b):
        n = len(a) - len(b)
        c = mul(a[-1], inverse(b[-1]))
        q[n] = c
        a = p_sub(a, [0]*n + p_scale(b, c))
    return trim(q), a


def p_gcd(a: Poly, b: Poly) -> Poly:
    while b:
        a, b = b, p_divmod(a, b)[1]
    return p_scale(a, inverse(a[-1])) if a else []


def rref(matrix: Matrix) -> Tuple[Matrix, List[int]]:
    a = [row[:] for row in matrix]
    pivots = []
    row = 0
    for col in range(len(a[0])):
        pivot = next((i for i in range(row, len(a)) if a[i][col]), None)
        if pivot is None:
            continue
        a[row], a[pivot] = a[pivot], a[row]
        c = inverse(a[row][col])
        a[row] = [mul(x, c) for x in a[row]]
        for i in range(len(a)):
            if i != row and a[i][col]:
                c = a[i][col]
                a[i] = [sub(x, mul(c, y)) for x, y in zip(a[i], a[row])]
        pivots.append(col)
        row += 1
        if row == len(a):
            break
    return a, pivots


def determinant(matrix: Matrix) -> int:
    a = [row[:] for row in matrix]
    out = 1
    for col in range(len(a)):
        pivot = next((i for i in range(col, len(a)) if a[i][col]), None)
        if pivot is None:
            return 0
        if pivot != col:
            a[col], a[pivot] = a[pivot], a[col]
            out = neg(out)
        c = a[col][col]
        out = mul(out, c)
        for i in range(col+1, len(a)):
            factor = mul(a[i][col], inverse(c))
            for j in range(col, len(a)):
                a[i][j] = sub(a[i][j], mul(factor, a[col][j]))
    return out


def cartier_polynomial(a: Poly) -> Poly:
    """C(a(x) dx) = cartier_polynomial(a)(x) dx."""
    return trim([power(a[i], 5) for i in range(4, len(a), 5)])


def primitive(a: Poly) -> Poly:
    """Polynomial primitive with all coefficients of x^(5m) set to zero."""
    q = [0] * (len(a) + 1)
    for i, c in enumerate(a):
        if (i+1) % 5 == 0:
            if c:
                raise ValueError("Polynomial differential is not exact")
        else:
            q[i+1] = mul(c, inverse((i+1) % 5))
    q = trim(q)
    assert derivative(q) == trim(a)
    return q


def main() -> None:
    assert all(power(c, 25) == c for c in range(25))
    assert all(mul(c, inverse(c)) == 1 for c in range(1, 25))
    P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    H = [[24, 2, 1, 0, 0, 0],
         [5, 16, 0, 1, 0, 0],
         [5, 20, 0, 0, 8, 1]]
    expected_beta = [[4, 16, 3, 18, 21, 0],
                     [10, 13, 0, 10, 6, 0],
                     [15, 3, 3, 18, 18, 4]]
    expected_tau = [[5, 8, 5], [21, 6, 22], [12, 9, 5]]

    assert p_gcd(P, derivative(P)) == [1]
    assert p_gcd(trim(H[0]), trim(H[1])) == [1]
    assert p_gcd(trim(H[0]), trim(H[2])) == [1]
    assert len(trim(H[1])) - 1 == 3
    assert len(trim(H[2])) - 1 == 5
    A = [[P[j-i] if 0 <= j-i < len(P) else 0 for i in range(6)]
         for j in (4, 9, 14)]
    assert len(rref(A)[1]) == 3
    assert len(rref(H)[1]) == 3
    for h in H:
        assert cartier_polynomial(p_mul(h, P)) == []
        # This relation also rules out a nonconstant fifth-power ratio
        # between two independent h's of degree at most five.
        assert h[4] == mul(8, h[5])

    Q = [primitive(p_mul(h, P)) for h in H]
    pairs = [(0, 1), (0, 2), (1, 2)]
    beta = []
    for i, j in pairs:
        b = cartier_polynomial(p_mul(p_mul(Q[i], H[j]), P))
        reverse = cartier_polynomial(p_mul(p_mul(Q[j], H[i]), P))
        assert p_add(b, reverse) == []
        beta.append(b + [0] * (6-len(b)))
    for i in range(3):
        assert cartier_polynomial(p_mul(p_mul(Q[i], H[i]), P)) == []
    tau = [cartier_polynomial(p_mul(b, P)) for b in beta]

    assert beta == expected_beta
    assert tau == expected_tau
    assert determinant(tau) == 13  # 3+2*a != 0
    assert determinant(H+beta) == 7  # 2+a != 0

    print("Coefficient code: [n0+5*n1] = n0+n1*a, a^2=a+3")
    print("P:", P)
    print("Exact basis H:", H)
    print("gcd(h0,h1)=gcd(h0,h2)=1; ratio map degrees are 3 and 5")
    print("Primitive polynomials Q:", Q)
    print("beta rows (01,02,12):", beta)
    print("tau=C(beta) rows (01,02,12):", tau)
    print("det(tau) = [13] = 3+2*a")
    print("det(H stacked with beta) = [7] = 2+a")
    print("All exact coefficient checks passed.")


if __name__ == '__main__':
    main()
