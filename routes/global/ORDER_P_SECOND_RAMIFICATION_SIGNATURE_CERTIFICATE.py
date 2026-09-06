"""Complete h16,p5 necessary sieve with second lower group of order5.

No external packages. Bounds proved in the accompanying theorem.
The output is numerical necessary data, not a realizability assertion.
"""
from fractions import Fraction
from math import gcd, isqrt


def divisors(n):
    small = [d for d in range(1, isqrt(n) + 1) if n % d == 0]
    return sorted(set(small + [n // d for d in small]))


def full_rows(h, p, D, q, b, t0, m0, T):
    c = q + (p - 1) * b - 2
    assert c * m0 - q * t0 == D
    for g0 in divisors(T // t0):
        e, m = q * g0 * t0, g0 * m0
        if c >= e or m < 2 or g0 % p == 0:
            continue
        n = (h // D) * q * g0 * t0 * m0
        assert n % e == n % m == 0
        assert n * (Fraction(c, e) - Fraction(1, m)) == h
        assert (c + 1) % (g0 * t0) == 0
        yield (D, q, b + 1, t0, m0, g0, n)


def genus_nine_rows():
    h, p, rows = 16, 5, []
    for D in divisors(h):
        # Non-large actions: b>=p^r. m0>=t0 is excluded by q<=22.5.
        max_m = D * (p * p + 1) // (p * (p - 1) - 2)
        r = 1
        while p ** ((r + 1) // 2) <= D + 2 * max_m:
            Q0, q = p ** r, p ** (r + 1)
            for m0 in range(1, max_m + 1):
                for t0 in divisors(m0 + D):
                    if t0 <= m0 or gcd(t0, m0) != 1 or (t0 * m0) % p == 0:
                        continue
                    numerator = q * (t0 - m0) + D + 2 * m0
                    denominator = (p - 1) * m0
                    if numerator % denominator:
                        continue
                    b = numerator // denominator
                    if b < Q0 or b % (p ** ((r + 1) // 2)):
                        continue
                    T = gcd(Q0 - 1, (p - 1) * (b + 1))
                    if T % t0 == 0:
                        rows.extend(full_rows(h, p, D, q, b, t0, m0, T))
            r += 1
        # Large actions: b=Q, q=pQR and p<=R<=Q.
        max_K = (D + 2 * (p * p - 1)) // p
        max_R = (p - 1) * D + 2 * max_K
        R = p
        while R <= max_R:
            Q = R
            while Q <= D + 2 * (p - 1) * (R + 1):
                q, b = p * Q * R, Q
                c = q + (p - 1) * b - 2
                T = gcd(Q * R - 1, (p - 1) * (Q + 1))
                for t0 in divisors(T):
                    if (q * t0 + D) % c:
                        continue
                    m0 = (q * t0 + D) // c
                    if m0 >= t0 or gcd(m0, t0) != 1 or (m0 * t0) % p == 0:
                        continue
                    rows.extend(full_rows(h, p, D, q, b, t0, m0, T))
                Q *= p
            R *= p
    return sorted(rows)


if __name__ == "__main__":
    rows = genus_nine_rows()
    assert rows == [(1, 125, 6, 8, 7, 1, 112000),
                    (1, 125, 6, 8, 7, 3, 336000),
                    (8, 125, 66, 3, 1, 2, 1500),
                    (8, 125, 66, 3, 1, 4, 3000),
                    (8, 125, 66, 3, 1, 8, 6000)]
    for row in rows:
        print(row)
    print("PASS: complete necessary sieve; maximum atlas degree", max(r[-1] for r in rows))
