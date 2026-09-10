#!/usr/bin/env python3
"""Regression checks for the two distinct recent Witt-comparison corrections.

Pure finite algebra/combinatorics, not a verification of inverse Cartier.
The geometric sign convention is an explicit input rho(S+xi)=rho(S)-Psi(xi).
"""
from math import comb


def v5_factorial(n):
    value = 0
    while n:
        n //= 5
        value += n
    return value


# Positive divided Psi/norm residual versus negatively oriented obstruction.
# Compute in (Z/25)[e]/((1+e)^5-1), keeping both augmentation coordinates.
modulus = 25
relation = [0] + [comb(5, j) for j in range(1, 5)]
norm = [comb(5, j + 1) for j in range(5)]
triples = 0
for c in range(5):
    for d in range(5):
        for b in range(5):
            # e²*(c e²+d e³+b e4)-c*N; in F5 c^5=c, etc.
            raw = [-c * n for n in norm] + [d, b]
            raw[4] += c
            for i in (6, 5):
                a = raw[i]
                for j in range(5):
                    raw[i - 5 + j] -= a * relation[j]
                raw[i] = 0
            reduced = [a % modulus for a in raw[:5]]
            assert all(a % 5 == 0 for a in reduced)
            positive = [(a // 5) % 5 for a in reduced]
            assert positive[:2] == [(-c) % 5, (-2 * c - d) % 5]
            assert (-positive[0]) % 5 == c
            triples += 1

# Correct high-Taylor bounds, including factorials divisible by five.
minima = {'one_operator': 99, 'two_operators': 99,
          'two_displacements': 99, 'mixed': 99}
for n in range(1, 20001):
    one = 2 + max(0, (n - 2) // 2) - v5_factorial(n)
    mixed = 3 + max(0, (n - 2) // 2) - v5_factorial(n - 1)
    assert one >= 2 and mixed >= 3
    minima['one_operator'] = min(minima['one_operator'], one)
    minima['mixed'] = min(minima['mixed'], mixed)
    if n >= 2:
        two = 4 + max(0, (n - 4) // 2) - v5_factorial(n)
        displacement = 2 + n // 2 - v5_factorial(n - 2)
        assert two >= 3 and displacement >= 3
        minima['two_operators'] = min(minima['two_operators'], two)
        minima['two_displacements'] = min(minima['two_displacements'], displacement)

print('PASS signed divided norm comparison:', triples, 'leading triples')
print('PASS corrected Taylor bounds through degree20000:', minima)
print('Scope: regression only; geometric identification uses the cited functor.')
