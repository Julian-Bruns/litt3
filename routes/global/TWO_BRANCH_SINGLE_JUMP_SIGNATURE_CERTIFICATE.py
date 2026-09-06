"""Complete necessary-signature sieve, using the proved finite bounds.

Run with Python 3; no packages or setup. Entries need not be realizable.
"""
from fractions import Fraction
from math import gcd, isqrt


def divisors(n):
    small = [d for d in range(1, isqrt(n) + 1) if n % d == 0]
    return sorted(set(small + [n // d for d in small]))


def signatures(h, p):
    rows = []
    q = p
    while q <= (h + 2) ** 2:
        for D in divisors(h):
            if q > (D + 2) ** 2:
                continue
            max_m = q + (q + D) // (q - 2)
            max_j = (max_m + D) * (q + 1) // (q - 1)
            for j in range(1, max_j + 1):
                c = j * (q - 1) - 1
                for t0 in divisors(c + 1):
                    if t0 % p == 0 or (q * t0 + D) % c:
                        continue
                    m0 = (q * t0 + D) // c
                    if m0 % p == 0 or gcd(t0, m0) != 1:
                        continue
                    assert m0 <= max_m
                    for g0 in divisors((c + 1) // t0):
                        e, m = q * g0 * t0, g0 * m0
                        if g0 % p == 0 or c >= e or m < 2:
                            continue
                        n = (h // D) * q * g0 * t0 * m0
                        assert n % e == n % m == 0
                        assert n * (Fraction(c, e) - Fraction(1, m)) == h
                        assert (c + 1) % (g0 * t0) == 0
                        rows.append((q, j, t0, m0, D, g0, n))
        q *= p
    return rows


if __name__ == "__main__":
    rows = signatures(16, 5)
    reduced = {}
    for q, j, t0, m0, D, g0, n in rows:
        key = q, j, t0, m0, D
        reduced[key] = max(reduced.get(key, 0), n)
    expected = {
        (5, 1, 4, 7, 1): 2240, (5, 2, 4, 3, 1): 1920,
        (5, 3, 2, 1, 1): 960, (5, 1, 1, 2, 1): 640,
        (5, 2, 1, 1, 2): 320, (5, 1, 1, 3, 4): 240,
        (5, 6, 3, 1, 8): 240, (5, 1, 1, 7, 16): 140,
        (5, 2, 1, 3, 16): 120,
    }
    assert reduced == expected
    assert max(row[-1] for row in rows) == 2240
    for key, degree in sorted(reduced.items(), key=lambda item: -item[1]):
        print(key, "maximum atlas degree", degree)
    print("PASS: complete proved ranges; maximum degree 2240")
