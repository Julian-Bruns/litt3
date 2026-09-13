#!/usr/bin/env python3
"""Exact local cyclic25 function-algebra filtration and integral colon checks.

This is regular-representation algebra; it does not certify higher inverse
Cartier. The regular functions are represented on the 25-point cyclic set.
"""
from math import comb

p = 5
size = 25
mahler = [[comb(x, j) % p if x >= j else 0 for x in range(size)]
          for j in range(size)]


def difference(values):
    return [(values[(i + 1) % size] - values[i]) % p
            for i in range(size)]


def coefficients(values):
    # B_j(x)=binomial(x,j), so evaluation is unit lower triangular.
    out = []
    for x in range(size):
        out.append((values[x] - sum(out[j] * mahler[j][x]
                                    for j in range(x))) % p)
    return out


for j in range(size):
    assert difference(mahler[j]) == (mahler[j - 1] if j else [0] * size)

tested = 0
for r in range(size):
    for s in range(size):
        product = [(a * b) % p for a, b in zip(mahler[r], mahler[s])]
        coeffs = coefficients(product)
        assert not any(coeffs[min(r + s + 1, size):])
        tested += 1

assert all(not x for x in coefficients(
    [(a*b) % p for a,b in zip(mahler[1],mahler[21])])[23:])

# For e=σ-1, e25/5 has augmentation order5 modulo5.
carry = [(-comb(size, j) // 5) % p for j in range(size)]
# Constant coefficient of (1+e)^25-1 is zero, not binomial(25,0).
carry[0] = 0
support = [j for j, x in enumerate(carry) if x]
assert support == [5, 10, 15, 20]
assert [carry[j] for j in support] == [4, 3, 3, 4]

print('PASS cyclic25 binomial-function difference basis')
print('PASS multiplication filtration:', tested, 'basis products')
print('PASS e23*A squared is in e22*A; e23*A times e3*A is in e2*A')
print('PASS e25/5 mod5 support:', support)
print('Scope: regular function algebra and integral carry, not Hodge geometry.')
