#!/usr/bin/env python3
"""Exact certificate for H^0(X, Sym^2(K)(O)) = 0.

This verifies a restricted obstruction, NOT universal nonexistence of
higher-rank irreducible finite coefficients mapping to K.

Field encoding: [n0+5*n1] = n0+n1*a, a^2=a+3.
Only the Python standard library is used. No series truncations are used.
Laurent polynomials are dictionaries {exponent: encoded coefficient}.
"""
from typing import Dict, List

Poly = Dict[int, int]
Matrix = List[List[int]]


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) % 5 + 5 * ((-(a // 5)) % 5)


def mul(a: int, b: int) -> int:
    a0, a1, b0, b1 = a % 5, a // 5, b % 5, b // 5
    return (a0*b0 + 3*a1*b1) % 5 + 5*((a0*b1 + a1*b0 + a1*b1) % 5)


def inv(a: int) -> int:
    if a == 0:
        raise ZeroDivisionError("Cannot invert zero")
    return next(b for b in range(1, 25) if mul(a, b) == 1)


def padd(a: Poly, b: Poly) -> Poly:
    out = a.copy()
    for i, c in b.items():
        out[i] = add(out.get(i, 0), c)
    return {i: c for i, c in out.items() if c}


def pscale(a: Poly, c: int) -> Poly:
    return {i: mul(v, c) for i, v in a.items() if mul(v, c)}


def pmul(a: Poly, b: Poly) -> Poly:
    out: Poly = {}
    for i, c in a.items():
        for j, d in b.items():
            out[i+j] = add(out.get(i+j, 0), mul(c, d))
    return {i: c for i, c in out.items() if c}


def positive_part(a: Poly) -> Poly:
    """Polynomial part: includes the constant term."""
    return {i: c for i, c in a.items() if i >= 0}


def determinant(matrix: Matrix) -> int:
    n = len(matrix)
    if any(len(row) != n for row in matrix):
        raise ValueError("Expected a square matrix")
    a = [row[:] for row in matrix]
    result = 1
    for j in range(n):
        pivot = next((i for i in range(j, n) if a[i][j]), None)
        if pivot is None:
            return 0
        if pivot != j:
            a[j], a[pivot] = a[pivot], a[j]
            result = neg(result)
        result = mul(result, a[j][j])
        t = inv(a[j][j])
        a[j] = [mul(v, t) for v in a[j]]
        for i in range(j+1, n):
            t = a[i][j]
            a[i] = [add(v, neg(mul(t, w))) for v, w in zip(a[i], a[j])]
    return result


P = dict(enumerate([11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]))
E = {-m: v for m, v in enumerate([2, 16, 16, 7, 1, 2, 7, 1, 24, 11], 1)}
E2 = pmul(E, E)


def residual_A(p: Poly) -> Poly:
    # A = P * (2 E [E p]_+ - E^2 p)
    return pmul(P, padd(pscale(pmul(E, positive_part(pmul(E, p))), 2),
                        pscale(pmul(E2, p), 4)))


def residual_B(b: int, h: Poly) -> Poly:
    # B = b E + 2 E [P E h]_+ - P E^2 h
    peh = pmul(P, pmul(E, h))
    return padd(pscale(E, b),
                padd(pscale(pmul(E, positive_part(peh)), 2),
                     pscale(pmul(P, pmul(E2, h)), 4)))


def main() -> None:
    # Necessary coefficients of g0 = -y[A]_- - y^2[B]_-.
    acols = [residual_A({i: 1}) for i in range(5)]
    bcols = [residual_B(1, {}), residual_B(0, {0: 1}), residual_B(0, {1: 1})]
    ma = [[neg(col.get(-m, 0)) for col in acols] for m in range(1, 6)]
    mb = [[neg(col.get(-m, 0)) for col in bcols] for m in range(1, 4)]
    assert ma == [[6,16,21,3,5], [0,22,4,7,1], [15,1,9,0,9],
                  [16,10,6,16,14], [16,11,21,24,24]]
    assert mb == [[3,24,0], [14,14,8], [14,9,1]]
    assert determinant(ma) == 16
    assert determinant(mb) == 18
    print("M_A (columns p_0,...,p_4):")
    for row in ma:
        print(row)
    print("det(M_A) = [16] = 1 + 3a != 0")
    print("M_B (columns b,h_0,h_1):")
    for row in mb:
        print(row)
    print("det(M_B) = [18] = 3 + 3a != 0")
    print("Verified: H^0(X, Sym^2(K)(O)) = 0.")
    print("Consequence: no self-dual irreducible finite rank-three source maps to K.")
    print("No assertion is made about non-self-dual rank-three sources or all higher ranks.")


if __name__ == "__main__":
    main()
