# Imported from the user-supplied Pro certificate, 23 September 2026.
# Original bytes and provenance are retained in litt3-computation-data.
#!/usr/bin/env python3
"""Exact coefficient certificate for the degree-seven plane on X.

Requires Python 3.10+ and no third-party packages. Run:
    python cartier_orbit_certificate.py

Field: F_5[a]/(a^2-a-3). Code n0+5*n1 represents n0+n1*a.
Polynomial coefficient lists are in ascending order.

Cartier calculations use the absolute convention: coefficient fifth roots
are fifth powers in F_25. The scalar transport must also be applied to all
other coefficients when interpreting these identities relatively.

This verifies coefficient identities and gcds, not the existence of an
etale correspondence or the exclusion of a rank-three orbit.
"""
from __future__ import annotations

import json

Poly = list[int]


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) + 5 * (-(a // 5) % 5)


def mul(a: int, b: int) -> int:
    x, y = a % 5, a // 5
    u, v = b % 5, b // 5
    return (x*u + 3*y*v) % 5 + 5 * ((x*v + y*u + y*v) % 5)


def power(a: int, n: int) -> int:
    if n < 0:
        raise ValueError("Exponent must be nonnegative.")
    result = 1
    while n:
        if n & 1:
            result = mul(result, a)
        a = mul(a, a)
        n //= 2
    return result


def inverse(a: int) -> int:
    if a == 0:
        raise ZeroDivisionError("Cannot invert zero in F_25.")
    return power(a, 23)


def trim(a: Poly) -> Poly:
    a = a[:] or [0]
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def padd(a: Poly, b: Poly) -> Poly:
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def pscale(a: Poly, c: int) -> Poly:
    return trim([mul(x, c) for x in a])


def psub(a: Poly, b: Poly) -> Poly:
    return padd(a, [neg(x) for x in b])


def pmul(a: Poly, b: Poly) -> Poly:
    result = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            result[i+j] = add(result[i+j], mul(x, y))
    return trim(result)


def derivative(a: Poly) -> Poly:
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def integral(a: Poly) -> Poly:
    result = [0] * (len(a) + 1)
    for i, x in enumerate(a):
        if (i+1) % 5 == 0:
            if x:
                raise ValueError("Polynomial has no polynomial primitive.")
        else:
            result[i+1] = mul(x, inverse((i+1) % 5))
    return trim(result)


def pdivmod(a: Poly, b: Poly) -> tuple[Poly, Poly]:
    a, b = trim(a), trim(b)
    if b == [0]:
        raise ZeroDivisionError("Polynomial division by zero.")
    quotient = [0] * max(1, len(a)-len(b)+1)
    while a != [0] and len(a) >= len(b):
        shift = len(a)-len(b)
        scalar = mul(a[-1], inverse(b[-1]))
        quotient[shift] = scalar
        a = psub(a, [0]*shift + pscale(b, scalar))
    return trim(quotient), a


def pgcd(a: Poly, b: Poly) -> Poly:
    a, b = trim(a), trim(b)
    while b != [0]:
        a, b = b, pdivmod(a, b)[1]
    return pscale(a, inverse(a[-1])) if a != [0] else [0]


def fifth_power(a: Poly) -> Poly:
    result = [0] * (5*(len(a)-1)+1)
    for j, x in enumerate(a):
        result[5*j] = power(x, 5)
    return trim(result)


def cartier_polynomial(a: Poly) -> Poly:
    """Coefficient polynomial of C(a(x) dx), using absolute Cartier."""
    return trim([power(a[j], 5) for j in range(4, len(a), 5)])


def nullspace(matrix: list[list[int]]) -> list[list[int]]:
    m = [row[:] for row in matrix]
    nr, nc = len(m), len(m[0])
    if any(len(row) != nc for row in m):
        raise ValueError("Ragged matrix.")
    pivots: list[int] = []
    row = 0
    for col in range(nc):
        pivot = next((i for i in range(row, nr) if m[i][col]), None)
        if pivot is None:
            continue
        m[row], m[pivot] = m[pivot], m[row]
        inv = inverse(m[row][col])
        m[row] = [mul(x, inv) for x in m[row]]
        for i in range(nr):
            if i != row and m[i][col]:
                scalar = m[i][col]
                m[i] = [add(x, neg(mul(scalar, y)))
                        for x, y in zip(m[i], m[row])]
        pivots.append(col)
        row += 1
        if row == nr:
            break
    basis = []
    for col in range(nc):
        if col in pivots:
            continue
        vector = [0] * nc
        vector[col] = 1
        for i, pivot in enumerate(pivots):
            vector[pivot] = neg(m[i][col])
        basis.append(vector)
    return basis


def certify() -> dict:
    P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    q = [[24, 2, 1], [5, 16, 0, 1], [5, 20, 0, 0, 8, 1]]
    W = [3, 1, 13, 11, 8, 17, 9, 3]
    S = [integral(pmul(P, qi)) for qi in q]
    assert all(derivative(si) == pmul(P, qi) for si, qi in zip(S, q))

    # Primitive r_i=S_i(x)/y^5 satisfies dr_i=q_i(x) dx/y^2.
    pairs = {(i, j): cartier_polynomial(pmul(S[i], pmul(q[j], P)))
             for i in range(3) for j in range(i+1, 3)}
    expected_pairs = {
        (0, 1): [4, 16, 3, 18, 21],
        (0, 2): [10, 13, 0, 10, 6],
        (1, 2): [15, 3, 3, 18, 18, 4],
    }
    assert pairs == expected_pairs

    radical = [pairs[1, 2], pscale(pairs[0, 2], 4), pairs[0, 1]]
    matrix = [[0]*9 for _ in range(8)]
    for i in range(3):
        for j in range(3):
            for k, coefficient in enumerate(radical[i]):
                matrix[k+j][3*i+j] = coefficient
    kernel = nullspace(matrix)
    assert len(kernel) == 1
    phi = [trim(kernel[0][3*i:3*i+3]) for i in range(3)]
    assert phi == [[5, 21], [8, 9], [3, 8, 1]]
    syzygy = [0]
    for fi, bi in zip(phi, radical):
        syzygy = padd(syzygy, pmul(fi, bi))
    assert syzygy == [0]

    phi5 = [fifth_power(fi) for fi in phi]
    cross = [psub(pmul(q[(i+1) % 3], phi5[(i+2) % 3]),
                  pmul(q[(i+2) % 3], phi5[(i+1) % 3])) for i in range(3)]
    assert pgcd(pgcd(cross[0], cross[1]), cross[2]) == [1]
    R = [0]
    for ci, qi in zip(cross, q):
        R = padd(R, pmul(ci, derivative(qi)))
    V, remainder = pdivmod(R, P)
    assert remainder == [0]
    assert V == [20, 3, 24, 23, 4]
    assert pgcd(V, derivative(V)) == [1]
    assert pgcd(V, P) == [1]
    assert pgcd(V, W) == [1]

    # In the local basis (s0/w^10, s1/w^5, s2), the coefficients
    # of n=(cross dot s)/y^5 have the following valuations at O.
    infinity_vals = [50 + shift - 3*(len(ci)-1)
                     for shift, ci in zip([10, 5, 0], cross)]
    assert infinity_vals == [21, 19, 26]
    return {
        "field": "F5[a]/(a^2-a-3)",
        "coefficient_order": "ascending",
        "primitive_numerators_S": S,
        "pairing_polynomials": {f"{i}{j}": b for (i, j), b in pairs.items()},
        "quadratic_syzygy_kernel_dimension": len(kernel),
        "quotient_phi": phi,
        "cross_product": cross,
        "cross_product_gcd": [1],
        "beta_numerator_R": R,
        "V_equals_R_divided_by_P": V,
        "gcd_V_Vprime": [1], "gcd_V_P": [1], "gcd_V_W": [1],
        "kernel_generator_infinity_valuations": infinity_vals,
        "all_checks_passed": True,
    }


if __name__ == "__main__":
    print(json.dumps(certify(), indent=2))
