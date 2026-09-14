#!/usr/bin/env sage
"""Verify the three Cartier blocks of the fixed-X first-integral map."""
import json

k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'z')([2, 4, 1]))
a = k.gen()
R = PolynomialRing(k, 'x')
x = R.gen()
F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
     +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
assert F.gcd(F.derivative()) == 1


def fourth_power_coefficients(polynomial, size):
    # These are coefficients of -Cartier(polynomial*dx)^5/dx^5.
    return vector(k, [4*polynomial[5*i+4] for i in range(size)])


def fourth_derivative_numerator(numerator, character):
    for shift in range(4):
        numerator = (F*numerator.derivative()
                     +(2*character-2-shift)*F.derivative()*numerator)
    return numerator


def verify_block(power, source_size, target_size, character, denominator_power):
    columns = []
    for j in range(source_size):
        coefficients = fourth_power_coefficients(x**j*F**power, target_size)
        polynomial = sum(c*x**(5*i) for i, c in enumerate(coefficients))
        original = x**j if character == 2 else x**j*F
        assert fourth_derivative_numerator(original, character) == F**denominator_power*polynomial
        columns.append(coefficients)
    return matrix(k, columns).transpose()


# Input order is (B,C,A); output order is (G0,G1,G2).
MB = verify_block(4, 8, 9, 0, 1)
MA = verify_block(2, 11, 6, 2, 2)
MC = verify_block(1, 5, 3, 1, 4)
H0 = 2*x**8-F.derivative(2)
offset0 = fourth_power_coefficients(H0*F**4, 9)
offset_polynomial = sum(c*x**(5*i) for i, c in enumerate(offset0))
native_offset = 2*F.derivative(2)*F+2*F.derivative()**2+2*x**8*F
assert fourth_derivative_numerator(native_offset, 0) == F*offset_polynomial

# These two small minors are the only fixed-curve rank witnesses needed.
assert MC.matrix_from_columns([0, 1, 4]).determinant() == 2*a+2
assert MA.matrix_from_columns([0, 1, 2, 3, 4, 9]).determinant() == a+1
assert [MB.rank(), MA.rank(), MC.rank()] == [8, 6, 3]
assert MB.augment(matrix(k, 9, 1, list(offset0))).rank() == 9
print(json.dumps(dict(status='first_integral_cartier_blocks_PASS',
                      block_ranks=[8, 6, 3], rank=17, augmented_rank=18,
                      independent_derivative_columns=24,
                      minor_A=str(a+1), minor_C=str(2*a+2)), default=int))
