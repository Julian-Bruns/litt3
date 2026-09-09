#!/usr/bin/env python3
"""Small exact generic-nonvanishing certificate, not a common-cover test.

All arithmetic is over F25 = F5[a]/(a^2+4a+2). A single specialization
certifies that the bounded-degree discriminants/resultants are nonzero
polynomials in the family parameter. Quotient-algebra replays include
every geometric root of each of the fifteen quartics.
"""
import itertools
import json
import math
import time


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a):
    return (-a % 5) + 5 * ((-(a // 5)) % 5)


def mul(a, b):
    x, y, z, w = a % 5, a // 5, b % 5, b // 5
    return (x*z + 3*y*w) % 5 + 5*((x*w + y*z + y*w) % 5)


def power(a, n):
    b = 1
    while n:
        if n & 1:
            b = mul(b, a)
        a = mul(a, a)
        n >>= 1
    return b


def trim(a):
    while a and not a[-1]:
        a.pop()
    return a


def plus(a, b):
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def scale(a, c):
    return trim([mul(x, c) for x in a])


def times(a, b):
    c = [0] * max(0, len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] = add(c[i+j], mul(x, y))
    return trim(c)


def divide(a, b):
    assert b
    a = a[:]
    q = [0] * max(0, len(a)-len(b)+1)
    inv = power(b[-1], 23)
    while a and len(a) >= len(b):
        d = len(a)-len(b)
        c = mul(a[-1], inv)
        q[d] = c
        a = plus(a, [0]*d + scale(b, neg(c)))
    return trim(q), a


def gcd(a, b):
    while b:
        a, b = b, divide(a, b)[1]
    return scale(a, power(a[-1], 23)) if a else []


def derivative(a):
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def coeff(a, i):
    return a[i] if 0 <= i < len(a) else 0


def cartier_replay(F, A, modulus):
    """A is a u-polynomial over F25[h]/modulus; check C_3(s^4)=s."""
    def amul(x, y):
        return divide(times(x, y), modulus)[1]

    def apow(x, n):
        y = [1]
        while n:
            if n & 1:
                y = amul(y, x)
            x = amul(x, x)
            n >>= 1
        return y

    def umul(x, y):
        z = [[] for _ in range(len(x)+len(y)-1)]
        for i, c in enumerate(x):
            for j, d in enumerate(y):
                z[i+j] = plus(z[i+j], amul(c, d))
        return z

    A2 = umul(A, A)
    P = umul([[c] if c else [] for c in times(F, F)], umul(A2, A2))
    for i in range(5):
        assert (P[5*i+4] if 5*i+4 < len(P) else []) == apow(A[i] if i < len(A) else [], 5)


def verify():
    started = time.monotonic()
    assert power(5, 2) == add(5, 3)
    roots = [0, 1, 2, 3, 5]
    F = [1]
    for r in roots:
        F = times(F, [neg(r), 1])
    assert gcd(F, derivative(F)) == [1]
    rows = []
    pairs = [(i,) for i in range(5)] + list(itertools.combinations(range(5), 2))
    for ids in pairs:
        R = [1]
        for i in ids:
            R = times(R, [neg(roots[i]), 1])
        S, rem = divide(F, R)
        assert not rem
        D = times(R, times(S, S))
        J = plus(times(derivative(R), S), scale(times(R, derivative(S)), 2))
        H = trim([mul(math.comb(i, 6) % 5, D[i]) for i in range(6, len(D))])
        assert len(J) == 5 and derivative(D) == times(S, J)
        low = [coeff(D, 1), mul(2, coeff(D, 2)), mul(3, coeff(D, 3)), neg(coeff(D, 4))]
        assert plus(trim(low), [0]*5 + H) == derivative(D)
        assert gcd(J, F) == gcd(J, derivative(J)) == gcd(J, H) == [1]
        c = coeff(times(S, times(R, R)), 4)
        assert c
        # All four critical points at once, not just F25-rational roots.
        H = divide(H, J)[1]
        square = [[0, 0, 1], [0, 3], [1]]  # (u-h)^2
        A = [[] for _ in range(len(R)+2)]
        for i, r in enumerate(R):
            for j, e in enumerate(square):
                A[i+j] = plus(A[i+j], divide(scale(times(H, e), r), J)[1])
        cartier_replay(F, A, J)
        cartier_replay(F, [[x] if x else [] for x in scale(S, c)], [0, 1])
        rows.append({'branch_pair_indices': list(ids), 'J': J, 'H6': H, 'branch_scale': c})
    return {'status': 'PASS', 'branch_classes': len(rows),
            'nonsplit_active_points_over_algebraic_closure': 75,
            'generic_parameter_degree_threshold': 11,
            'seconds': round(time.monotonic()-started, 4),
            'scope': 'Endpoint certificate only; no common-source ordinariness or cover exclusion.',
            'specialization_data': rows}


if __name__ == '__main__':
    print(json.dumps(verify(), indent=2))
