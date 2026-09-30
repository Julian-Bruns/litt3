#!/usr/bin/env python3
"""Independent, small plain-Python check of the four trace determinants.

No Sage arithmetic or phase-multiset enumeration is used.  Field elements
are tuples of four F25 codes in the displayed quartic power basis.
"""
import argparse
import itertools
import json
from pathlib import Path


def badd(x, y):
    return (x % 5 + y % 5) % 5 + 5 * ((x // 5 + y // 5) % 5)


def bneg(x):
    return (-x % 5) % 5 + 5 * ((-(x // 5)) % 5)


def bmul(x, y):
    a, b, c, d = x % 5, x // 5, y % 5, y // 5
    return (a * c + 3 * b * d) % 5 + 5 * ((a * d + b * c + b * d) % 5)


ZERO = (0, 0, 0, 0)
ONE = (1, 0, 0, 0)
ALPHA = (0, 1, 0, 0)
MODULUS = (5, 2, 6, 7)
ORDER = 5**8


def const(code):
    return (code, 0, 0, 0)


def add(x, y):
    return tuple(badd(a, b) for a, b in zip(x, y))


def neg(x):
    return tuple(map(bneg, x))


def sub(x, y):
    return add(x, neg(y))


def mul(x, y):
    v = [0] * 7
    for i, a in enumerate(x):
        for j, b in enumerate(y):
            v[i + j] = badd(v[i + j], bmul(a, b))
    for j in range(6, 3, -1):
        for i, coefficient in enumerate(MODULUS):
            v[j - 4 + i] = badd(v[j - 4 + i], bneg(bmul(v[j], coefficient)))
    return tuple(v[:4])


def power(x, n):
    assert n >= 0
    r = ONE
    while n:
        if n & 1:
            r = mul(r, x)
        x = mul(x, x)
        n >>= 1
    return r


def inverse(x):
    assert x != ZERO
    y = power(x, ORDER - 2)
    assert mul(x, y) == ONE
    return y


def divide(x, y):
    return mul(x, inverse(y))


def evaluate(coefficients, x):
    r = ZERO
    for coefficient in reversed(coefficients):
        r = add(mul(r, x), const(coefficient))
    return r


def derivative(coefficients):
    return [bmul(i % 5, c) for i, c in enumerate(coefficients)][1:]


def determinant(columns):
    answer = 0
    for p in itertools.permutations(range(4)):
        term = 1
        for row, column in enumerate(p):
            term = bmul(term, columns[column][row])
        inversions = sum(p[i] > p[j] for i in range(4) for j in range(i + 1, 4))
        answer = badd(answer, bneg(term) if inversions % 2 else term)
    return answer


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    A = [1, 21, 14, 22, 13]
    c = [22, 7, 9, 23]
    roots = [power(ALPHA, 25**i) for i in range(4)]
    assert len(set(roots)) == 4 and power(ALPHA, 25**4) == ALPHA
    assert all(evaluate(A, root) == ZERO for root in roots)
    # The quartic has four Frobenius conjugates and alpha has orbit four;
    # this independently establishes its irreducibility over F25.
    assert power(const(11), 3) == ONE and const(11) != ONE
    P0 = evaluate(P, ALPHA)
    u = {1: [], 2: []}
    v = {1: [], 2: []}
    w = []
    for i, alpha in enumerate(roots):
        av, ap, app = evaluate(P, alpha), evaluate(derivative(A), alpha), evaluate(derivative(derivative(A)), alpha)
        pp = evaluate(derivative(P), alpha)
        rhs = divide(mul(const(3), mul(power(ap, 3), power(av, 2))), power(const(13), 3))
        leading = power(rhs, pow(29, -1, ORDER - 1))
        assert power(leading, 29) == rhs
        a1 = divide(mul(const(13), power(leading, 4)), ap)
        a2 = divide(sub(mul(mul(const(bmul(4, 13)), power(leading, 3)), evaluate(c, alpha)), divide(mul(app, power(a1, 2)), const(2))), ap)
        relative_rho = power(P0, (25**i - 1) // 3)
        assert mul(power(relative_rho, 3), P0) == av
        for k in (1, 2):
            rk = power(relative_rho, k)
            u[k].append(divide(a1, rk))
            # Literal coefficient: (2*a2 - k*a1^2*P'/3P) / rho^k.
            v[k].append(divide(sub(mul(const(2), a2), divide(mul(mul(const(k), power(a1, 2)), pp), mul(const(3), av))), rk))
        w.append(mul(mul(divide(mul(const(2), ap), const(13)), power(inverse(leading), 10)), power(relative_rho, 2)))
    expected = {"U1": 23, "V1": 15, "U2": 16, "V2": 4, "W": 12}
    collections = {"U1": u[1], "V1": v[1], "U2": u[2], "V2": v[2], "W": w}
    computed = {name: determinant(cols) for name, cols in collections.items()}
    assert computed == expected, computed
    reference = json.loads(Path("../litt3-computation-data/conceptual_continuation_20260929/rootwise_trace_field_separation_v2.json").read_text())
    for k in (1, 2):
        for label, columns in (("constant", u[k]), ("linear", v[k])):
            rows = [list(row) for row in zip(*columns)]
            assert rows == reference["characters"][str(k)][label]["matrix_over_B"][:4]
    orbit4 = {4 * pow(5, i, 29) % 29 for i in range(14)}
    orbit8 = {8 * pow(5, i, 29) % 29 for i in range(14)}
    assert len(orbit4) == len(orbit8) == 14 and not orbit4 & orbit8
    assert orbit4 | orbit8 == set(range(1, 29))
    result = {"status": "PASS", "arithmetic": "independent plain Python", "determinants": computed,
              "matrices": {name: [list(row) for row in zip(*cols)] for name, cols in collections.items()},
              "checks": ["quartic Frobenius orbit and A roots", "cubic character", "canonical leading constants",
                         "relative cubic-root identities", "four coefficient matrices agree with producer",
                         "residue matrix", "complementary phase orbits"],
              "phase_multisets_enumerated": 0}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print("PASS:", computed, "; no phase multiset search")


if __name__ == "__main__":
    main()
