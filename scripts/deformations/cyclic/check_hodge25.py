#!/usr/bin/env python3
"""Exact finite-ring checks for the cyclic-25 Hodge comparison.

These are algebraic checks only. Geometric identification of the comparison
with this algebra requires the jet-frame and repair argument in the text.
No external packages are needed.
"""
from math import comb
from random import Random

QORDER = 25


def shift_difference(a, modulus):
    return [(a[(i + 1) % QORDER] - a[i]) % modulus for i in range(QORDER)]


def e_power(a, n, modulus):
    for _ in range(n):
        a = shift_difference(a, modulus)
    return a


def binomial_function(j, modulus):
    return [comb(i, j) % modulus if i >= j else 0 for i in range(QORDER)]


def newton_coefficients(a, modulus):
    work = [x % modulus for x in a]
    ans = []
    while work:
        ans.append(work[0])
        work = [(work[i + 1] - work[i]) % modulus
                for i in range(len(work) - 1)]
    return ans


def check_integral_products():
    # First verify the stronger binomial-degree estimates modulo 25.
    for r, low, high in [(23, 1, 21), (22, 2, 22)]:
        for j in range(QORDER):
            coeff = newton_coefficients(e_power(binomial_function(j, 25), r, 25), 25)
            assert all(c % 5 == 0 for c in coeff[low + 1:])
            assert all(c == 0 for c in coeff[high + 1:])
    images = []
    for j in range(QORDER):
        basis = [int(i == j) for i in range(QORDER)]
        images.append(e_power(basis, 23, 25))
    low_lifts = [e_power(binomial_function(j, 25), 22, 25)
                 for j in [22, 23, 24]]
    tested = 0
    for a in images:
        for b in images:
            product = [x * y % 25 for x, y in zip(a, b)]
            c = newton_coefficients(product, 5)
            assert all(x == 0 for x in c[3:])
            lift = [sum(c[j] * low_lifts[j][i] for j in range(3)) % 25
                    for i in range(QORDER)]
            difference = [(x - y) % 25 for x, y in zip(product, lift)]
            assert all(x % 5 == 0 for x in difference)
            divided = [x // 5 for x in difference]
            divided_coeff = newton_coefficients(divided, 5)
            assert divided_coeff[23:] == [0, 0]
            tested += 1
    return tested


# R = (Z/125)[e]/((1+e)^25 - 1).
REL = [comb(25, j) for j in range(25)]
REL[0] = 0


def reduce_poly(a, modulus=125):
    a = [v % modulus for v in a]
    for n in range(len(a) - 1, 24, -1):
        c = a[n]
        if c:
            for j in range(25):
                a[n - 25 + j] = (a[n - 25 + j] - c * REL[j]) % modulus
    return (a[:25] + [0] * 25)[:25]


def add(a, b, modulus=125):
    return [(x + y) % modulus for x, y in zip(a, b)]


def scale(a, c, modulus=125):
    return [x * c % modulus for x in a]


def epow(a, n, modulus=125):
    return reduce_poly([0] * n + a, modulus)


def mono(n, c=1):
    return reduce_poly([0] * n + [c])


Q = [0] * 25
P = [0] * 25
for j in range(1, 25):
    if j % 5 == 0:
        assert comb(25, j) % 5 == 0
        Q[j] = comb(25, j) // 5
    else:
        assert comb(25, j) % 25 == 0
        P[j] = comb(25, j) // 25
QOVER2 = Q[2:] + [0, 0]


def check_pure_bockstein():
    tested = 0
    for d in range(5):
        for b in range(5):
            y0 = add(mono(23, d), mono(24, b))
            y1 = add(scale(QOVER2, d), scale(epow(QOVER2, 1), b))
            y = add(y0, scale(y1, 5))
            out = epow(y, 2)
            assert all(v % 25 == 0 for v in out)
            residue = [v // 25 % 5 for v in out]
            assert residue[:2] == [0, -d % 5]
            # A free compatible fourth digit changes no final quotient class.
            for a in range(5):
                for c in range(5):
                    free = add(mono(23, a), mono(24, c))
                    varied = epow(add(y, scale(free, 5)), 2)
                    assert all(v % 25 == 0 for v in varied)
                    assert [v // 25 % 5 for v in varied[:2]] == residue[:2]
            tested += 1
    return tested


# Coefficients in O = (Z/125)[a]/(a^2-2) = W_3(F_25).
# Phi(x + y*a) = x - y*a. Arbitrary 2x2 Z/125 matrices on coefficients
# permit mixed, noncommuting coefficient-linear/Frobenius corrections.

def zero2():
    return ([0] * 25, [0] * 25)


def add2(x, y):
    return add(x[0], y[0]), add(x[1], y[1])


def scale2(x, c):
    return scale(x[0], c), scale(x[1], c)


def epow2(x, n):
    return epow(x[0], n), epow(x[1], n)


def phi2(x):
    return x[0][:], scale(x[1], -1)


def constant2(x, y):
    return mono(0, x), mono(0, y)


def poly_coefficient_product(poly, coeff):
    return scale(poly, coeff[0]), scale(poly, coeff[1])


def make_correction(seed):
    rng = Random(seed)
    terms = [(j, tuple(rng.randrange(125) for _ in range(4)))
             for j in [0, 1, 2, 5, 13, 24]]
    def C(x):
        out = zero2()
        for j, (aa, ab, ba, bb) in terms:
            coeff_op = (add(scale(x[0], aa), scale(x[1], ab)),
                        add(scale(x[0], ba), scale(x[1], bb)))
            out = add2(out, epow2(coeff_op, j))
        return out
    return C


def check_mixed_bockstein():
    tested = 0
    for seed in [17, 20260910]:
        C = make_correction(seed)
        def A(x):
            return add2(epow2(x, 2), scale2(C(x), 5))
        rng = Random(seed + 1)
        # All 25 residue coefficients d, with several b and higher lifts.
        for d0 in range(5):
            for d1 in range(5):
                for _ in range(4):
                    d = (d0 + 5*rng.randrange(25), d1 + 5*rng.randrange(25))
                    b = (rng.randrange(125), rng.randrange(125))
                    x0 = add2(epow2(constant2(*d), 23),
                              epow2(constant2(*b), 24))
                    y0 = phi2(x0)  # L=A*Phi, so d is transported once.
                    D, B = (d[0], -d[1] % 125), (b[0], -b[1] % 125)
                    y1 = add2(poly_coefficient_product(QOVER2, D),
                              epow2(poly_coefficient_product(QOVER2, B), 1))
                    y1 = add2(y1, scale2(epow2(C(constant2(*D)), 21), -1))
                    y1 = add2(y1, scale2(epow2(C(constant2(*B)), 22), -1))
                    y = add2(y0, scale2(y1, 5))
                    out = A(y)
                    assert all(v % 25 == 0 for row in out for v in row)
                    low = tuple(tuple(row[j] // 25 % 5 for j in [0, 1]) for row in out)
                    assert low == ((0, -D[0] % 5), (0, -D[1] % 5))
                    # Verify the full exact identity, not only its two coordinates.
                    expected = add2(scale2(poly_coefficient_product(P, D), -1),
                                    scale2(epow2(poly_coefficient_product(P, B), 1), -1))
                    expected = scale2(add2(expected, C(y1)), 25)
                    assert out == expected
                    tested += 1
    return tested


def main():
    assert [(j, Q[j] % 5) for j in range(25) if Q[j] % 5] == [
        (5, 1), (10, 2), (15, 2), (20, 1)]
    assert P[0] == 0 and P[1] % 5 == 1
    print('Integral quadratic products:', check_integral_products(), 'basis pairs passed')
    print('Pure second Bockstein:', check_pure_bockstein(), 'leading digits passed; all free fourth digits checked')
    print('Mixed additive/Frobenius second Bockstein:', check_mixed_bockstein(), 'W_3(F_25) cases passed')
    print('Linear divided residue = -d^5 e; obstruction sign gives +d^5 e.')


if __name__ == '__main__':
    main()
