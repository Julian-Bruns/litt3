#!/usr/bin/env python3
"""Focused independent checks for the actual-norm pole57 reduction.

Reconstructs one 29-by-26 base matrix by truncated powering, not by the
producer's cubic-jet recurrence.  Other residual systems are inspected
for combinatorial coverage only; their rank calculations are not replayed.
"""
import argparse
from functools import lru_cache
import itertools
import json
from math import comb
from pathlib import Path


P5 = [5**i for i in range(8)]
Q = 5**8
MODULUS = [2, 4, 3, 0, 1, 0, 0, 0, 1]


@lru_cache(maxsize=None)
def digits(x):
    return tuple(x // p % 5 for p in P5)


def encode(v):
    return sum((c % 5) * p for c, p in zip(v, P5))


def add(x, y):
    return encode([a + b for a, b in zip(digits(x), digits(y))])


def neg(x):
    return encode([-a for a in digits(x)])


def mul(x, y):
    v = [0] * 15
    for i, a in enumerate(digits(x)):
        for j, b in enumerate(digits(y)):
            v[i + j] += a * b
    for j in range(14, 7, -1):
        c = v[j] % 5
        for i in range(8):
            v[j - 8 + i] -= c * MODULUS[i]
    return encode(v[:8])


def power(x, n):
    r = 1
    while n:
        if n & 1:
            r = mul(r, x)
        x = mul(x, x)
        n >>= 1
    return r


def inverse(x):
    assert x
    result = power(x, Q - 2)
    assert mul(x, result) == 1
    return result


def polynomial_product(a, b, length):
    r = [0] * length
    for i, x in enumerate(a):
        for j, y in enumerate(b[:length - i]):
            r[i + j] = add(r[i + j], mul(x, y))
    return r


def polynomial_power(a, n, length):
    r = [1] + [0] * (length - 1)
    while n:
        if n & 1:
            r = polynomial_product(r, a, length)
        a = polynomial_product(a, a, length)
        n >>= 1
    return r


def determinant(rows):
    m = [list(row) for row in rows]
    n, result = len(m), 1
    assert all(len(row) == n for row in m)
    for i in range(n):
        pivot = next((j for j in range(i, n) if m[j][i]), None)
        if pivot is None:
            return 0
        if pivot != i:
            m[i], m[pivot] = m[pivot], m[i]
            result = neg(result)
        diagonal = m[i][i]
        result = mul(result, diagonal)
        recip = inverse(diagonal)
        for j in range(i + 1, n):
            factor = mul(m[j][i], recip)
            if factor:
                for k in range(i + 1, n):
                    m[j][k] = add(m[j][k], neg(mul(factor, m[i][k])))
            m[j][i] = 0
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    directory = Path("../litt3-computation-data/conceptual_continuation_20260929")
    source = directory / "phase_saturated_norms"
    base = json.loads((source / "a29_b1.json").read_text())
    field = base["field"]
    assert field["modulus"] == MODULUS
    beta, alpha = field["beta"], field["alpha"]
    assert power(beta, 2) == add(beta, 3)
    dec = lambda c: add(c % 5, mul(c // 5, beta))
    coeffs = list(map(dec, [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]))
    length = 29
    shifted = []
    for n in range(length):
        total = 0
        for i in range(n, len(coeffs)):
            total = add(total, mul(coeffs[i], mul(comb(i, n) % 5, power(alpha, i - n))))
        shifted.append(total)
    assert shifted[0] == field["p0"]
    phase = power(shifted[0], (Q - 1) // 3)
    assert phase == field["zeta"] == dec(11)
    unit = [mul(c, inverse(shifted[0])) for c in shifted]
    # 3*42=1 mod125; principal units have 125th power one modulo t^29.
    root = polynomial_power(unit, 42, length)
    assert polynomial_power(root, 3, length) == unit
    characters = [[1] + [0] * (length - 1), root, polynomial_product(root, root, length)]
    columns = base["columns"]
    assert columns == [[i, j] for j in range(3) for i in range((34 - 10*j)//3 + 1)]
    matrix_columns = []
    for i, j in columns:
        xpower = [mul(comb(i, n) % 5, power(alpha, i - n)) for n in range(i + 1)]
        matrix_columns.append(polynomial_product(xpower, characters[j], length))
    rows = [list(row) for row in zip(*matrix_columns)]
    det = determinant([rows[i] for i in base["base_rows"]])
    assert det == base["base_det"] == 352090

    classes = {}
    for triple in itertools.product(range(5), repeat=3):
        key = ((triple[1] - triple[0]) % 5, (triple[2] - triple[0]) % 5)
        classes.setdefault(key, []).append(triple)
    small_bad = []
    for key, triples in classes.items():
        least = min(map(sum, triples))
        if key != (0, 0) and 29*least <= 57:
            minima = [t for t in triples if sum(t) == least]
            assert least == 1 and len(minima) == 1
            small_bad.append(minima[0])
    assert set(small_bad) == {(1, 0, 0), (0, 1, 0), (0, 0, 1)}
    residuals = [(29 - 5*l, b) for l in range(5) for b in range(6)
                 if 29 + 7*l + 5*b <= 57 and 29 - 5*l + 5*b > 28]
    expected = [(29, b) for b in range(6)] + [(24, b) for b in range(1, 5)] + [(19, 2)]
    assert residuals == expected
    explicit_systems, base_excluded_divisors = 0, 0
    coverage = []
    for a, b in expected[1:]:
        data = json.loads((source / f"a{a}_b{b}.json").read_text())
        assert data["all_excluded"] and data["a"] == a and data["b"] == b
        assert data["pole"] == a + 5*b
        count = comb(b + 11, 11)
        if data["base_kernel_dimension"] == 0:
            assert data["base_det"] and data["systems"] == 0
            base_excluded_divisors += count
        else:
            records = data["records"]
            divisors = {tuple(r["D"]) for r in records}
            assert len(divisors) == len(records) == data["systems"] == count
            assert all(len(d) == 12 and min(d) >= 0 and sum(d) == b for d in divisors)
            assert not data["survivors"] and all(r["det"] for r in records)
            explicit_systems += count
        coverage.append([a, b, count])
    frobenius = json.loads((directory / "marked_support_frobenius_module.json").read_text())
    pi, q = frobenius["weil_polynomial"], frobenius["annihilator"]
    u, v = [frobenius["bezout_mod_5"][name] for name in ("U", "V")]
    bezout = [0] * max(len(pi) + len(u) - 1, len(q) + len(v) - 1)
    for a, b in ((pi, u), (q, v)):
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                bezout[i + j] = (bezout[i + j] + x*y) % 5
    assert bezout == [1] + [0] * (len(bezout) - 1)
    assert int(frobenius["resultant"]) % 5 == 2
    result = {"status": "PASS", "base_matrix_shape": [29, 26], "base_minor": det,
              "jet_method": "unit series to power42, checked by cubing modulo t^29",
              "small_bad_classes": small_bad, "residual_cases": expected,
              "coverage": coverage, "explicit_residual_records": explicit_systems,
              "divisors_excluded_by_zero_base_kernel": base_excluded_divisors,
              "marked_cubic_phase": phase, "mod5_bezout": True,
              "residual_rank_systems_replayed": 0}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print("PASS: base minor352090; packet cases and", explicit_systems + base_excluded_divisors,
          "divisor coverage; marked phase and mod5 Bezout")


if __name__ == "__main__":
    main()
