#!/usr/bin/env python3
"""Exact formal graph/weight bookkeeping, NOT a higher-IC certificate."""

NAMES = "A B D K11 K12 K21 K22 r qi qj eps".split()
ZERO = (0,) * len(NAMES)


def var(name):
    powers = list(ZERO)
    powers[NAMES.index(name)] = 1
    return {tuple(powers): 1}


def add(*terms):
    result = {}
    for term in terms:
        for powers, coefficient in term.items():
            result[powers] = result.get(powers, 0) + coefficient
    return {p: c for p, c in result.items() if c}


def scale(c, term):
    return {p: c * v for p, v in term.items() if c * v}


def mul(*terms):
    result = {ZERO: 1}
    for term in terms:
        following = {}
        for p, c in result.items():
            for q, d in term.items():
                powers = tuple(a + b for a, b in zip(p, q))
                following[powers] = following.get(powers, 0) + c * d
        result = {p: c for p, c in following.items() if c}
    return result


def main():
    A, B, D, K11, K12, K21, K22, r, qi, qj, eps = map(var, NAMES)
    # G = [[A+eps*K11, B+eps*K12],
    #      [eps*(r+K21), D+eps*K22]], v_i=(1,eps*qi).
    upper = add(A, mul(eps, K11), mul(add(B, mul(eps, K12)), eps, qi))
    lower = add(mul(eps, add(r, K21)), mul(add(D, mul(eps, K22)), eps, qi))
    normal = add(lower, scale(-1, mul(eps, qj, upper)))
    linear = add(r, K21, mul(D, qi), scale(-1, mul(A, qj)))
    quadratic = add(mul(K22, qi), scale(-1, mul(K11, qj)),
                    scale(-1, mul(B, qi, qj)))
    cubic = scale(-1, mul(K12, qi, qj))
    expected = add(mul(eps, linear), mul(eps, eps, quadratic),
                   mul(eps, eps, eps, cubic))
    assert normal == expected
    print("EXACT_GRAPH_IDENTITY_PASS")
    # The lower-left transition rescaling sends eps^j to 5^(m*j-1).
    for n in (3, 4, 5):
        m = n - 1
        modulus = 5 ** (m + 2)
        coefficients = tuple(pow(5, m * j - 1, modulus) for j in (1, 2, 3))
        if n == 3:
            assert coefficients == (5, 125, 0)
        else:
            assert coefficients[1:] == (0, 0)
        print(f"n={n}; modulus={modulus}; rescaled_L_Q_cubic={coefficients}")
    print("SCOPE: formal overlap bookkeeping only; geometric cancellation unproved.")


if __name__ == "__main__":
    main()
