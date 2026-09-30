"""Two small endpoint determinants for the unrestricted admissible norm.

Only the standard library and the adjacent independent finite-field
implementation are used. No cover, degree, support pattern or geometric
parameter is enumerated. Run with python3 -B; optional argument writes
the exact certificate outside the research workspace.
"""
import json
import sys
from pathlib import Path
import verify_pole_ten_norm_support as field

add, mul, neg = field.a25, field.m25, field.n25


def power(a, n):
    result = 1
    while n:
        if n & 1:
            result = mul(result, a)
        a = mul(a, a)
        n //= 2
    return result


def total(values):
    result = 0
    for a in values:
        result = add(result, a)
    return result


def product(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i + j] = add(c[i + j], mul(x, y))
    return c


def polynomial_power(a, n):
    result = [1]
    for _ in range(n):
        result = product(result, a)
    return result


def determinant(matrix):
    matrix = [row[:] for row in matrix]
    result = 1
    for i in range(len(matrix)):
        pivot = next((j for j in range(i, len(matrix)) if matrix[j][i]), None)
        if pivot is None:
            return 0
        if pivot != i:
            matrix[i], matrix[pivot] = matrix[pivot], matrix[i]
            result = neg(result)
        value = matrix[i][i]
        result = mul(result, value)
        for j in range(i + 1, len(matrix)):
            c = mul(matrix[j][i], power(value, 23))
            matrix[j] = [add(x, neg(mul(c, y)))
                         for x, y in zip(matrix[j], matrix[i])]
    return result


P = field.P
A = field.A
Q = [0, 11, 6, 21, 22, 0, 15, 21, 9, 4, 0, 1, 1, 24, 14, 0, 3, 9, 8, 24]
derivative_Q = [mul(i % 5, Q[i]) for i in range(1, len(Q))]
assert derivative_Q == product(P, product(A, A))

# Cartier interchanges the two noninvariant cubic-character spaces.
# U_i=x^i theta/A, i=0,...,9; V_i=x^i y theta/A, i=0,...,6.
A4 = polynomial_power(A, 4)
P3 = polynomial_power(P, 3)
C_UV = [[0] * 10 for _ in range(7)]
C_VU = [[0] * 7 for _ in range(10)]
for j in range(10):
    h = [0] * j + product(A4, P)
    for degree in range(4, len(h), 5):
        i = (degree - 4) // 5
        if h[degree]:
            assert i < 7
            C_UV[i][j] = power(h[degree], 5)
for j in range(7):
    h = [0] * j + product(A4, P3)
    for degree in range(4, len(h), 5):
        i = (degree - 4) // 5
        if h[degree]:
            assert i < 10
            C_VU[i][j] = power(h[degree], 5)
B = [[total(mul(C_UV[i][k], power(C_VU[k][j], 5))
            for k in range(10)) for j in range(7)] for i in range(7)]
rows = []
row = [0] * 6 + [1]
for _ in range(7):
    rows.append(row)
    row = [total(mul(row[k], B[k][j]) for k in range(7))
           for j in range(7)]
cartier_det = determinant(rows)
assert cartier_det == 18

# At alpha, the first regular coefficient of the logarithmic differential
# is determined by its residue. Expand the four residue coefficients in
# the eight-dimensional F5 basis of F25[alpha]/M.
def derivative(p):
    return [field.mul(i % 5, a) for i, a in enumerate(p)][1:]


alpha = field.roots[0]
P_ratio = field.mul(field.peval(derivative(P), alpha),
                    field.inv(field.peval(P, alpha)))
A_ratio = field.mul(field.peval(derivative(derivative(A)), alpha),
                    field.inv(field.peval(derivative(A), alpha)))
columns = [field.neg(field.add(P_ratio, A_ratio))]
columns += [field.mul(4, field.inv(field.sub(alpha, r)))
            for r in field.roots[1:]]
expanded = [[v for c in field.digits(a) for v in (c % 5, c // 5)]
            for a in columns]
residue_matrix = list(map(list, zip(*expanded)))
residue_minor = residue_matrix[:4]
residue_det = determinant(residue_minor)
assert residue_det == 1

def polynomial_derivative(p):
    return [mul(i % 5, a) for i, a in enumerate(p)][1:]


def polynomial_subtract(a, b):
    c = [add(a[i] if i < len(a) else 0,
             neg(b[i] if i < len(b) else 0))
         for i in range(max(len(a), len(b)))]
    while c and not c[-1]:
        c.pop()
    return c


def polynomial_remainder(a, b):
    a = a[:]
    while a and not a[-1]:
        a.pop()
    while len(a) >= len(b):
        shift = len(a) - len(b)
        c = mul(a[-1], power(b[-1], 23))
        a = polynomial_subtract(a, [0] * shift + [mul(c, x) for x in b])
    return a


# A simpler geometric check uses all four root conditions together:
# L(U)=4PA'U'-3PA''U-P'A'U modulo A, for deg U<=3.
operator_columns = []
for i in range(4):
    u = [0] * i + [1]
    first = [mul(4, x) for x in
             product(product(P, polynomial_derivative(A)), polynomial_derivative(u))]
    second = [mul(3, x) for x in
              product(product(P, polynomial_derivative(polynomial_derivative(A))), u)]
    third = product(product(polynomial_derivative(P), polynomial_derivative(A)), u)
    remainder = polynomial_remainder(polynomial_subtract(
        polynomial_subtract(first, second), third), A)
    operator_columns.append(remainder + [0] * (4 - len(remainder)))
operator_matrix = list(map(list, zip(*operator_columns)))
operator_det = determinant(operator_matrix)
assert operator_det == 21

certificate = {
    "scope": "endpoint Cartier and local-residue identities; independent of cover degree",
    "F25_modulus": "beta^2-beta-3",
    "root_modulus_codes": list(field.MOD),
    "cartier_square_matrix": B,
    "cyclic_rows": rows,
    "cyclic_determinant_code": cartier_det,
    "residue_columns_base25": list(map(field.digits, columns)),
    "residue_matrix_F5": residue_matrix,
    "residue_minor_rows": [0, 1, 2, 3],
    "residue_determinant": residue_det,
    "polynomial_jet_operator": operator_matrix,
    "polynomial_jet_determinant_code": operator_det,
}
if len(sys.argv) > 1:
    Path(sys.argv[1]).write_text(json.dumps(certificate, indent=2) + "\n")
print("PASS: Q'=P A^2; Cartier cyclic determinant [18]; polynomial-jet determinant [21].")
print("Independent first-root residue check: determinant 1 over F5.")
print("No covering degree, support divisor or coefficient parameter was enumerated.")
