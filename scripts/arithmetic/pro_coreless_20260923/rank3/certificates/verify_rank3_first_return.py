"""Exact certificate: H^0(X, F_abs^* K(O)) = 0 over F_25.

Run with Python 3.10 or later. No third-party packages are required.
Codes n0 + 5*n1 represent n0 + n1*a, where a*a = a + 3.
Polynomial exponents below are allowed to be negative.

For a section (a_U,b_U), b_U has pole weight at most 31, while
 a_V = a_U - e^5*b_U must have pole weight at most -24.
There are 23 possible monomials in b_U and no free monomials in a_U.
The forbidden negative-x coefficients of e^5*b_U give a 32 x 23
matrix. Its three character blocks have nonzero maximal minors.
This certifies only the stated section vanishing; it does not decide
all Frobenius periods in the rank-three existence question.
"""
from __future__ import annotations

from typing import TypeAlias

Polynomial: TypeAlias = dict[int, int]
Matrix: TypeAlias = list[list[int]]
P_COEFFICIENTS = (11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1)
C_COEFFICIENTS = (2, 16, 16, 7, 1, 2, 7, 1, 24, 11)


def add(u: int, v: int) -> int:
    return ((u % 5 + v % 5) % 5) + 5 * ((u // 5 + v // 5) % 5)


def negative(u: int) -> int:
    return (-(u % 5) % 5) + 5 * (-(u // 5) % 5)


def multiply(u: int, v: int) -> int:
    u0, u1 = u % 5, u // 5
    v0, v1 = v % 5, v // 5
    return ((u0 * v0 + 3 * u1 * v1) % 5
            + 5 * ((u0 * v1 + u1 * v0 + u1 * v1) % 5))


def power(u: int, exponent: int) -> int:
    if exponent < 0:
        raise ValueError("The exponent must be nonnegative.")
    result = 1
    while exponent:
        if exponent & 1:
            result = multiply(result, u)
        u = multiply(u, u)
        exponent >>= 1
    return result


def inverse(u: int) -> int:
    if u == 0:
        raise ZeroDivisionError("Zero has no inverse in F_25.")
    return power(u, 23)


def polynomial_product(left: Polynomial, right: Polynomial) -> Polynomial:
    result: Polynomial = {}
    for i, u in left.items():
        for j, v in right.items():
            exponent = i + j
            coefficient = add(result.get(exponent, 0), multiply(u, v))
            if coefficient:
                result[exponent] = coefficient
            else:
                result.pop(exponent, None)
    return result


def polynomial_power(poly: Polynomial, exponent: int) -> Polynomial:
    if exponent < 0:
        raise ValueError("The exponent must be nonnegative.")
    result = {0: 1}
    while exponent:
        if exponent & 1:
            result = polynomial_product(result, poly)
        poly = polynomial_product(poly, poly)
        exponent >>= 1
    return result


def determinant(matrix: Matrix) -> int:
    size = len(matrix)
    if any(len(row) != size for row in matrix):
        raise ValueError("The matrix must be square.")
    work = [row.copy() for row in matrix]
    result = 1
    for column in range(size):
        pivot = next((row for row in range(column, size)
                      if work[row][column] != 0), None)
        if pivot is None:
            return 0
        if pivot != column:
            work[column], work[pivot] = work[pivot], work[column]
            result = negative(result)
        value = work[column][column]
        result = multiply(result, value)
        reciprocal = inverse(value)
        for row in range(column + 1, size):
            factor = negative(multiply(work[row][column], reciprocal))
            for j in range(column, size):
                work[row][j] = add(work[row][j],
                                   multiply(factor, work[column][j]))
    return result


def coefficient_matrix(poly: Polynomial, rows: range, columns: range) -> Matrix:
    # Multiplication by x^j shifts the coefficient at exponent r to poly[r-j].
    return [[poly.get(r - j, 0) for j in columns] for r in rows]


def verify() -> None:
    assert multiply(5, 5) == add(5, 3)
    assert all(multiply(u, inverse(u)) == 1 for u in range(1, 25))
    polynomial = {i: u for i, u in enumerate(P_COEFFICIENTS) if u}
    c5 = {-5 * m: power(u, 5) for m, u in enumerate(C_COEFFICIENTS, 1)}
    a = polynomial_product(polynomial_power(polynomial, 3), c5)
    b = polynomial_product(polynomial, a)
    # e^5 = y*A(x), and e^5*y^2 = B(x), since y^3=P(x).
    blocks = [
        coefficient_matrix(a, range(-11, 0), range(11)),
        coefficient_matrix(a, range(-14, 0), range(8)),
        coefficient_matrix(b, range(-7, 0), range(4)),
    ]
    selected_rows = [range(-11, 0), range(-14, -6), range(-7, -3)]
    expected = [22, 5, 17]
    for index, (block, exponents, wanted) in enumerate(
            zip(blocks, selected_rows, expected)):
        size = len(block[0])
        minor = block[:size]
        actual = determinant(minor)
        assert actual == wanted, (index, actual, wanted)
        print(f"Input y^{index}: block {len(block)} x {size}; "
              f"selected x-exponents {list(exponents)}; "
              f"determinant code [{actual}]")
    total_rows = sum(len(block) for block in blocks)
    total_columns = sum(len(block[0]) for block in blocks)
    assert (total_rows, total_columns) == (32, 23)
    print("Full obstruction matrix: 32 x 23; rank 23.")
    print("Certified: h^0(X, F_abs^*K(O)) = 0.")


if __name__ == "__main__":
    verify()
