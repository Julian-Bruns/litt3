"""Complete small first-layer arithmetic; no bound on total wild order.

Proof of the finite ranges: CORED_FIXED_PAIR_HAS_BOUNDED_MINIMAL_DEGREE.md.
Standard-library Python. A row is (D,m,t0,b,r,E).
"""
from math import gcd

nonlarge = []
for D in (1, 2, 4, 8, 16):
    for m in range(1, 26 * D // 18 + 1):
        for t0 in range(m + 1, m + D + 1):
            if (m + D) % t0 or gcd(m, t0) != 1 or m * t0 % 5 == 0:
                continue
            bound_b = (125 * t0 + D + m) // (124 * m)
            for b in range(1, bound_b + 1):
                if b % 5 == 0:
                    continue
                E, valuation = D + (b + 1) * m, 0
                quotient = E
                while quotient % 5 == 0:
                    quotient //= 5
                    valuation += 1
                for r in range(1, 2 * valuation + 1):
                    if b * (5**r - 1) % t0 == 0:
                        nonlarge.append((D, m, t0, b, r, E))
assert nonlarge == [(2, 1, 3, 2, 2, 5), (8, 1, 3, 1, 2, 10),
                    (8, 1, 9, 6, 2, 15), (16, 2, 3, 1, 2, 20)]

large = []
for D in (1, 2, 4, 8, 16):
    for t0 in (1, 2, 3, 4, 6, 8, 12, 24):
        for m in range(1, t0):
            if ((m + D) % t0 or gcd(m, t0) != 1 or m % 5 == 0
                    or (D + 2 * m) % 5 or 5 * t0 >= 9 * m):
                continue
            large.append((D, m, t0))
assert large == [(1, 2, 3), (1, 7, 8), (16, 2, 3)]
print('Complete non-large rows:', nonlarge)
print('Complete large rows:', large)
print('PASS; the remaining congruences and torsion exclusion are proved in the note.')
