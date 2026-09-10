#!/usr/bin/env python3
"""Integral deck carry; NOT an inverse-Cartier geometric certificate."""
from math import comb


def remainder(coefficients, order=5):
    """Reduce over Z by (1+e)^order-1, retaining mixed-characteristic carry."""
    a = list(coefficients)
    a += [0] * max(0, order - len(a))
    for j in range(len(a) - 1, order - 1, -1):
        c = a[j]
        for i in range(1, order):
            a[j - order + i] -= c * comb(order, i)
        a[j] = 0
    return a[:order]


def monomial(n, coefficient=1):
    return [0] * n + [coefficient]


def divided_carry(coefficients, order=5, quotient_power=2):
    a = remainder(coefficients, order)
    assert all(c % 5 == 0 for c in a), a
    return [(c // 5) % 5 for c in a[:quotient_power]]


norm = [comb(5, i + 1) for i in range(5)]
assert norm == [5, 10, 10, 5, 1]
norm_error = [-c for c in norm]
norm_error[4] += 1
eta_column = divided_carry(norm_error)
new_kernel_column = divided_carry(monomial(5))
old_kernel_column = divided_carry(monomial(6))
assert eta_column == [4, 3]
assert new_kernel_column == [0, 4]
assert old_kernel_column == [0, 0]
assert (eta_column[0] * new_kernel_column[1]
        - eta_column[1] * new_kernel_column[0]) % 5 == 1

# Every change of the scalar lift by 5*b(e) gives zero in R/(e^2)
# on the relevant inputs e^2,e^3,e^4. Linearity handles every b(e).
for input_power in (2, 3, 4):
    for j in range(5):
        assert divided_carry(monomial(input_power + j, 5)) == [0, 0]

# The rank-one Bockstein in the defect-four case has rank THREE,
# but the direct inclusion ker(e^4)->coker(e^4) is also nonzero.
# It cannot be substituted for the two-defect prediction.
for j in (1, 2, 3):
    col = divided_carry(monomial(4 + j), quotient_power=4)
    assert col[:j] == [0] * j and col[j] == 4
assert divided_carry(monomial(8), quotient_power=4) == [0, 0, 0, 0]

# One carry is insufficient already in the analogous order-25 ring.
assert divided_carry(monomial(25), order=25) == [0, 0]
assert divided_carry(monomial(26), order=25) == [0, 0]

print('PASS: norm carry = -eta*(1+2e), new direction carry = -a^5*e.')
print('PASS: rank 2 on (eta,a^5); kernel is the old e^4 direction.')
print('PASS: unchanged by every 5*b(e) scalar lift correction.')
print('PASS: defect-four and order-25 boundaries retained.')
print('Geometric identification with the corrected Hodge obstruction remains OPEN.')
