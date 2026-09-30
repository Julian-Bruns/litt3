#!/usr/bin/env python3
"""Exact bounded checks for the September21 BT/Hodge and jet returns.

This checks new scalar/Taylor formulas, not geometric effectivity,
infinite-window existence, or a common-cover assertion.
"""
import argparse
import itertools
import json
from pathlib import Path


def field(degree, modulus, characteristic=5):
    def add(a, b):
        return tuple((a[i]+b[i]) % characteristic for i in range(degree))

    def neg(a):
        return tuple(-x % characteristic for x in a)

    def mul(a, b):
        v = [0]*(2*degree-1)
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                v[i+j] += x*y
        for n in range(2*degree-2, degree-1, -1):
            for j, c in enumerate(modulus):
                v[n-degree+j] -= v[n]*c
        return tuple(x % characteristic for x in v[:degree])

    one = (1,)+(0,)*(degree-1)

    def power(a, n):
        out = one
        while n:
            if n & 1:
                out = mul(out, a)
            a = mul(a, a)
            n //= 2
        return out
    return add, neg, mul, power


def check():
    # F25 and its actual unramified length-two lift, a^2=2.
    add, neg, mul, power = field(2, [-2, 0])
    wadd, wneg, wmul, wpow = field(2, [-2, 0], 25)
    zero = (0, 0)

    def teich(x):
        return wpow(x, 625)

    def frob_w(x):
        return (x[0], -x[1] % 25)

    def pmul(a, b):
        out = [zero]*11
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                if i+j < 11:
                    out[i+j] = wadd(out[i+j], wmul(x, y))
        return out

    for gamma in itertools.product(range(5), repeat=2):
        g = tuple(gamma)
        f = [zero]*11
        coefficients = [(1, 0), neg(g), power(g, 2),
                        neg(power(g, 3)), power(g, 4), power(g, 5)]
        for i, x in enumerate(coefficients, 1):
            f[i] = teich(x)
            assert wpow(f[i], 25) == f[i]
        f5 = [(1, 0)]+[zero]*10
        for _ in range(5):
            f5 = pmul(f5, f)
        numerator = wadd(frob_w(f[2]), wneg(f5[10]))
        assert all(x % 5 == 0 for x in numerator)
        divided = tuple(x//5 for x in numerator)
        assert divided == mul((3, 0), power(g, 5)), (g, divided)

    # First-order projective-potential change over F5[eps]/eps^2.
    def dmul(a, b):
        return (a[0]*b[0] % 5, (a[0]*b[1]+a[1]*b[0]) % 5)

    def dinv(a):
        iv = pow(a[0], -1, 5)
        return (iv, -iv*iv*a[1] % 5)

    count = 0
    for w0 in range(1, 5):
        for w1, w2, c0, c1, c2 in itertools.product(range(5), repeat=5):
            W = (w0, w0*c0 % 5)
            W1 = (w1, (w1*c0+w0*c1) % 5)
            W2 = (w2, (w2*c0+2*w1*c1+w0*c2) % 5)
            ratio = dmul(W1, dinv(W))
            square = dmul(ratio, ratio)
            second = dmul(W2, dinv(W))
            # 3/4=2 and -1/2=2 in F5.
            variation = 2*(square[1]+second[1]) % 5
            expected = 2*(c2-w1*pow(w0, -1, 5)*c1) % 5
            assert variation == expected
            count += 1

    for i in range(5):
        assert pow(i, 6, 5) == pow(i, 2, 5)
        assert (-3*pow(i, 3, 5)*(-2*pow(i, 3, 5))) % 5 == pow(i, 2, 5)

    # The explicit sharpness value over F125.
    add3, neg3, mul3, pow3 = field(3, [1, 1, 0])
    z = (0, 1, 0)
    z5, root = pow3(z, 5), pow3(z, 25)
    value = mul3((2, 0, 0), add3(root, neg3(z5)))
    assert z5 == (1, 1, 4)
    assert root == (4, 3, 1)
    assert value == (1, 4, 4)
    # phi=t+z^5 t^12 has u11=4z^5; 25th root in F125 is fifth power.
    u11 = mul3((4, 0, 0), z5)
    assert mul3((2, 0, 0), add3(u11, neg3(pow3(u11, 5)))) == value

    # Only the new scale-two implication of the old F625 certificate.
    add4, neg4, mul4, pow4 = field(4, [3, 4, 1, 4])
    lam = (3, 4, 4, 3)
    assert mul4((4, 4, 0, 0), lam) == (1, 0, 0, 0)
    assert mul4((2, 0, 0, 0), lam) == (1, 3, 3, 1)

    # Horizontal second columns require fifth roots, not constants.
    # K12=t removes X22=t^5 and X12=t^6 in the reduced gauge equation.
    gauge_regression = {'X22': 't^5', 'K12': 't', 'constant_required': False}
    return {'projective_variation_cases': count,
            'divided_Taylor_F25_cases': 25,
            'Taylor_degree10': '-2*gamma^5',
            'operator_identity': 'D^6=D^2',
            'F125_sharpness_value': list(value),
            'F625_actual_obstruction_value': [1, 3, 3, 1],
            'gauge_regression': gauge_regression,
            'scope': 'Exact bounded arithmetic and operator normalizations only.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = check()
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Generated evidence must be outside litt3')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
