#!/usr/bin/env python3
"""Small independent covariance/ODE audit; no profile rank sweep is replayed."""
import argparse
import itertools
import json
from math import comb
from pathlib import Path

import actual_norms_fifty_seven_20260929 as ff


def trim(a):
    a = list(a)
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a or [0]


def add(a, b):
    return trim([ff.add(x, y) for x, y in itertools.zip_longest(a, b, fillvalue=0)])


def scale(a, c):
    return trim([ff.mul(x, c) for x in a])


def mul(a, b):
    return trim(ff.polynomial_product(a, b, len(a) + len(b) - 1))


def power(a, n):
    result = [1]
    while n:
        if n & 1:
            result = mul(result, a)
        a = mul(a, a)
        n >>= 1
    return result


def derivative(a):
    return trim([ff.mul(i % 5, a[i]) for i in range(1, len(a))])


def evaluate(a, x):
    result = 0
    for c in reversed(a):
        result = ff.add(ff.mul(result, x), c)
    return result


def shifted(a, x, length):
    result = [0] * length
    for j in range(min(length, len(a))):
        for i in range(j, len(a)):
            result[j] = ff.add(result[j], ff.mul(a[i], ff.mul(comb(i, j) % 5, ff.power(x, i-j))))
    return result


def cartier(a):
    return trim([ff.power(a[j], 5**7) for j in range(4, len(a), 5)])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    root = Path("../litt3-computation-data/conceptual_continuation_20260929")
    con = json.loads((root / "marked_log_connection/connection_and_sections.json").read_text())
    field = con["field"]
    assert field["modulus"] == ff.MODULUS
    alpha, beta, p0, zeta = [field[k] for k in ("alpha", "beta", "p0", "zeta")]
    dec = lambda c: ff.add(c % 5, ff.mul(c // 5, beta))
    P = list(map(dec, [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]))
    Q = scale(P, ff.inverse(p0))
    A, B = con["A"], con["B"]
    d = [ff.neg(alpha), 1]
    assert evaluate(A, alpha) == evaluate(B, alpha) == 2
    assert scale(cartier(mul(mul(B, P), power(d, 4))), ff.power(ff.inverse(p0), 5**7)) == A
    assert scale(cartier(mul(mul(A, power(P, 3)), power(d, 4))), ff.power(ff.inverse(ff.power(p0, 3)), 5**7)) == B
    roots = [ff.power(alpha, 25**i) for i in range(4)]
    denominator = [1]
    for a in roots:
        denominator = mul(denominator, [ff.neg(a), 1])

    def form(i, s):
        factor = [1]
        for j, a in enumerate(roots):
            if i != j:
                factor = mul(factor, [ff.neg(a), 1])
        ratio = ff.mul(ff.power(p0, (25**i - 1)//3), ff.power(zeta, s))
        aa = [ff.power(c, 25**i) for c in A]
        bb = [ff.power(c, 25**i) for c in B]
        return [scale(factor, 2), scale(mul(factor, bb), ff.power(ratio, 2)), scale(mul(factor, aa), ratio)]

    target = form(3, 2)
    next_form = [[ff.power(c, 25) for c in h] for h in target]
    relative = ff.power(p0, 8)
    next_form[1] = scale(next_form[1], ff.power(relative, 2))
    next_form[2] = scale(next_form[2], relative)
    assert next_form == form(0, 0), "Frobenius wrap/cubic carry is incorrect"
    residues = []
    for i, a in enumerate(roots):
        q = evaluate(Q, a)
        for s in range(3):
            v = ff.mul(ff.power(p0, (25**i-1)//3), ff.power(zeta, s))
            assert ff.power(v, 3) == q
            numerator = evaluate(target[0], a)
            numerator = ff.add(numerator, ff.mul(evaluate(target[1], a), ff.mul(v, ff.inverse(q))))
            numerator = ff.add(numerator, ff.mul(evaluate(target[2], a), ff.mul(ff.power(v, 2), ff.inverse(q))))
            residues.append(ff.mul(numerator, ff.inverse(evaluate(derivative(denominator), a))))
    assert residues == [0] * 11 + [1]

    case = json.loads((root / "log_norm_100/case_0005.json").read_text())
    assert case["base"] == [0] * 11 + [14] and case["dimension"] == 2
    monomials, kernel = case["monomials"], case["kernel"]
    H = [scale(h, 4) for h in target]
    triple = [[0] for _ in range(3)]
    for row, (i, j) in enumerate(monomials):
        triple[j] = add(triple[j], [0]*i + [kernel[row][0]])
    # Multiply generically in E[x,v]/(v^3-Q), rather than copying the
    # three expanded equations from the producer.
    omega_numerator = [mul(Q, H[0]), H[1], H[2]]
    rhs = [[0] for _ in range(3)]
    for i in range(3):
        for j in range(3):
            term = mul(omega_numerator[i], triple[j])
            if i + j >= 3:
                term = mul(term, Q)
            rhs[(i+j) % 3] = add(rhs[(i+j) % 3], term)
    lhs = []
    for j, polynomial in enumerate(triple):
        differential = add(mul(Q, derivative(polynomial)), scale(mul(derivative(Q), polynomial), (2*j) % 5))
        lhs.append(mul(denominator, differential))
    assert lhs == rhs

    # One two-block support minor, checked with independently powered jets.
    length, a = 20, roots[3]
    local_q = shifted(Q, a, length)
    ratio = ff.mul(ff.power(p0, (25**3-1)//3), ff.power(zeta, 2))
    unit = [ff.mul(c, ff.inverse(local_q[0])) for c in local_q]
    local_v = [ff.mul(c, ratio) for c in ff.polynomial_power(unit, 42, length)]
    assert ff.polynomial_power(local_v, 3, length) == local_q
    local_characters = [[1]+[0]*(length-1), local_v, ff.polynomial_product(local_v, local_v, length)]
    jets = [[0]*length for _ in range(2)]
    for row, (i, j) in enumerate(monomials):
        xpower = shifted([0]*i+[1], a, length)
        column = ff.polynomial_product(xpower, local_characters[j], length)
        for k in range(2):
            for n in range(length):
                jets[k][n] = ff.add(jets[k][n], ff.mul(kernel[row][k], column[n]))
    assert all(all(c == 0 for c in jet[:14]) for jet in jets)
    minor = ff.add(ff.mul(jets[0][14], jets[1][19]), ff.neg(ff.mul(jets[1][14], jets[0][19])))
    record = next(r for r in case["minors"] if r["D"] == [0]*11+[2])
    assert minor == record["det"] != 0

    # This also detects accidental reuse of case files from other inputs.
    completed = {}
    for budget in (73, 100):
        profiles = json.loads((root / f"phase_cost_{budget}.json").read_text())["cases"]
        summary = json.loads((root / f"log_norm_{budget}/summary.json").read_text())
        assert len(summary) == len(profiles)
        for i, expected in enumerate(profiles):
            actual = json.loads((root / f"log_norm_{budget}/case_{i:04d}.json").read_text())
            assert actual["index"] == i
            assert all(actual[k] == expected[k] for k in ("base", "blocks", "pole_bound"))
            assert actual["status"] in ("excluded_zero_horizontal_space", "excluded_all_support_subdivisors")
        completed[str(budget)] = len(profiles)
    result = {"status": "PASS", "cartier_polynomials_checked": True,
              "frobenius_conjugation": "root3,sheet2 maps to root0,sheet0 with inverse-pullback covariance",
              "target_residues": residues, "ordinary_ode_case": "pole100 case0005, first kernel column",
              "independent_support_minor": minor, "matching_completed_profile_headers": completed,
              "profile_rank_sweeps_replayed": 0}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print("PASS: Cartier equations, Frobenius wrap, one ODE and support minor", minor,
          "; matching profile headers", completed)


if __name__ == "__main__":
    main()
