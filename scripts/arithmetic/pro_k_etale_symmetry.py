#!/usr/bin/env python3
"""Exact arithmetic used in the symmetry reduction for the stated bundle K.

No dependencies. Python 3.10+.
GF(25) elements are encoded n0 + 5*n1 = n0 + n1*a, a*a = a + 3.
Polynomial coefficient lists are ascending.

This certifies ONLY the factorization and F25-rational branch locus.
It does not certify existence/nonexistence of an etale generating cover,
and it does not verify the six supplied nonperiodicity exclusions.
"""
from __future__ import annotations

Poly = tuple[int, ...]


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) + 5 * (-(a // 5) % 5)


def mul(a: int, b: int) -> int:
    a0, a1 = a % 5, a // 5
    b0, b1 = b % 5, b // 5
    return (a0 * b0 + 3 * a1 * b1) % 5 + 5 * (
        (a0 * b1 + a1 * b0 + a1 * b1) % 5
    )


def power(a: int, exponent: int) -> int:
    if exponent < 0:
        raise ValueError("Negative exponent")
    result = 1
    while exponent:
        if exponent & 1:
            result = mul(result, a)
        a = mul(a, a)
        exponent //= 2
    return result


def inverse(a: int) -> int:
    if a == 0:
        raise ZeroDivisionError("Zero has no inverse")
    return power(a, 23)


def trim(coefficients) -> Poly:
    result = list(coefficients)
    while result and result[-1] == 0:
        result.pop()
    return tuple(result)


def psub(a: Poly, b: Poly) -> Poly:
    return trim(add(a[i] if i < len(a) else 0,
                    neg(b[i]) if i < len(b) else 0)
                for i in range(max(len(a), len(b))))


def pmul(a: Poly, b: Poly) -> Poly:
    if not a or not b:
        return ()
    result = [0] * (len(a) + len(b) - 1)
    for i, ai in enumerate(a):
        for j, bj in enumerate(b):
            result[i + j] = add(result[i + j], mul(ai, bj))
    return trim(result)


def pdivmod(a: Poly, b: Poly) -> tuple[Poly, Poly]:
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError("Polynomial division by zero")
    quotient = [0] * max(0, len(a) - len(b) + 1)
    remainder = list(a)
    inverse_lead = inverse(b[-1])
    while remainder and len(remainder) >= len(b):
        shift = len(remainder) - len(b)
        coefficient = mul(remainder[-1], inverse_lead)
        quotient[shift] = coefficient
        for i, bi in enumerate(b):
            remainder[shift + i] = add(remainder[shift + i], neg(mul(coefficient, bi)))
        remainder = list(trim(remainder))
    return trim(quotient), trim(remainder)


def pgcd(a: Poly, b: Poly) -> Poly:
    while b:
        a, b = b, pdivmod(a, b)[1]
    if not a:
        return ()
    coefficient = inverse(a[-1])
    return tuple(mul(coefficient, ai) for ai in a)


def ppowmod(a: Poly, exponent: int, modulus: Poly) -> Poly:
    if exponent < 0:
        raise ValueError("Negative exponent")
    result = (1,)
    a = pdivmod(a, modulus)[1]
    while exponent:
        if exponent & 1:
            result = pdivmod(pmul(result, a), modulus)[1]
        a = pdivmod(pmul(a, a), modulus)[1]
        exponent //= 2
    return result


def evaluate(f: Poly, a: int) -> int:
    value = 0
    for coefficient in reversed(f):
        value = add(mul(value, a), coefficient)
    return value


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ArithmeticError(message)


def main() -> None:
    # Basic field checks, including the defining relation.
    require(mul(5, 5) == add(5, 3), "Wrong field relation")
    for a in range(1, 25):
        require(mul(a, inverse(a)) == 1, "Invalid field inverse")

    P: Poly = (11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1)
    x: Poly = (0, 1)
    linear_9: Poly = (neg(9), 1)
    linear_14: Poly = (neg(14), 1)
    R1: Poly = (18, 15, 10, 4, 1)
    R2: Poly = (8, 2, 21, 11, 1)
    factors = (linear_9, linear_14, R1, R2)
    product: Poly = (1,)
    for factor in factors:
        product = pmul(product, factor)
    require(product == P, "Factorization product failed")

    # Degree-four irreducibility criterion over F25.
    for R in (R1, R2):
        require(psub(ppowmod(x, 25**4, R), x) == (),
                "Quartic does not divide x^(25^4)-x")
        require(pgcd(R, psub(ppowmod(x, 25**2, R), x)) == (1,),
                "Quartic has a factor of degree one or two")

    remainder = ppowmod(x, 25, P)
    require(remainder == (11, 6, 19, 11, 17, 10, 0, 15, 12, 13),
            "Unexpected x^25 remainder")
    rational_factor = pgcd(P, psub(remainder, x))
    require(rational_factor == (22, 12, 1), "Unexpected rational-root factor")
    require(rational_factor == pmul(linear_9, linear_14), "Root factor mismatch")
    roots = tuple(a for a in range(25) if evaluate(P, a) == 0)
    require(roots == (9, 14), "Unexpected F25-rational roots")

    print("Verified field relation: a^2 = a + 3")
    print("Verified factorization (ascending coded coefficients):")
    for factor in factors:
        print(" ", factor)
    print("Verified both quartic factors are irreducible over F25.")
    print("x^25 mod P =", remainder)
    print("gcd(P, x^25-x) =", rational_factor)
    print("F25-rational roots of P =", roots)
    print("This certificate does NOT decide etale generation of K.")


if __name__ == "__main__":
    main()
