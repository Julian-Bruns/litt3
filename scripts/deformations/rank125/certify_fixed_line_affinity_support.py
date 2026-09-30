#!/usr/bin/env python3
"""Finite filtration checks for the actual fixed-line affinity argument.

This checks the actual scalar primary data, not a fifth coefficient.
No code from the incoming geometric engine is imported. The supplied
primary pickle is trusted, preserved mathematical input; only f is used.
"""
import argparse
import hashlib
import itertools
import json
import pickle
from pathlib import Path

from audit_w4_existence_polynomial import add, inv, mul, neg


MONS = sorted(itertools.product(range(5), repeat=3), key=lambda e: (sum(e), e))
INDEX = {e: i for i, e in enumerate(MONS)}


def product(a, b):
    out = [0] * 125
    for e, x in zip(MONS, a):
        if not x:
            continue
        for v, y in zip(MONS, b):
            if not y:
                continue
            w = tuple(e[i] + v[i] for i in range(3))
            if max(w) < 5:
                j = INDEX[w]
                out[j] = add(out[j], mul(x, y))
    return out


def basis(e):
    out = [0] * 125
    out[INDEX[e]] = 1
    return out


def sparse(v):
    return [[list(e), x] for e, x in zip(MONS, v) if x]


def echelon_with_sources(f, source_degree):
    rows = []
    for e in MONS:
        if sum(e) >= source_degree:
            h = basis(e)
            rows.append(product(f, h) + h)
    pivot_rows = []
    r = 0
    for c in range(125):
        p = next((i for i in range(r, len(rows)) if rows[i][c]), None)
        if p is None:
            continue
        rows[r], rows[p] = rows[p], rows[r]
        z = inv(rows[r][c])
        rows[r] = [mul(x, z) for x in rows[r]]
        for i in range(len(rows)):
            if i != r and rows[i][c]:
                z = neg(rows[i][c])
                rows[i] = [add(x, mul(z, y)) for x, y in zip(rows[i], rows[r])]
        pivot_rows.append((c, rows[r]))
        r += 1
    return pivot_rows


def solve(rows, target):
    rem = target[:]
    source = [0] * 125
    for p, row in rows:
        z = rem[p]
        if z:
            rem = [add(x, neg(mul(z, y))) for x, y in zip(rem, row[:125])]
            source = [add(x, mul(z, y)) for x, y in zip(source, row[125:])]
    assert not any(rem), "Target lacks the claimed filtered primary preimage"
    return source


def homogeneous_rank(q, degree):
    rows = [product(q, basis(e)) for e in MONS if sum(e) == degree]
    n = len(rows)
    r = 0
    for c in range(125):
        p = next((i for i in range(r, n) if rows[i][c]), None)
        if p is None:
            continue
        rows[r], rows[p] = rows[p], rows[r]
        z = inv(rows[r][c])
        rows[r] = [mul(x, z) for x in rows[r]]
        for i in range(r + 1, n):
            if rows[i][c]:
                z = neg(rows[i][c])
                rows[i] = [add(x, mul(z, y)) for x, y in zip(rows[i], rows[r])]
        r += 1
    return {"degree": degree, "domain": n, "rank": r, "kernel": n - r}


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--primary", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    raw = args.primary.read_bytes()
    f = pickle.loads(raw)["f"]
    assert len(f) == 125
    q = [x if sum(e) == 2 else 0 for e, x in zip(MONS, f)]
    assert sparse(q) == [
        [[0, 0, 2], 25], [[0, 1, 1], 45],
        [[0, 2, 0], 114], [[2, 0, 0], 14],
    ]
    ranks = [homogeneous_rank(q, d) for d in range(5)]
    assert [r["rank"] for r in ranks] == [1, 3, 6, 10, 13]

    checks = []
    for target_degree, source_degree in [(9, 7), (11, 9)]:
        rows = echelon_with_sources(f, source_degree)
        preimages = []
        for e in MONS:
            if sum(e) < target_degree:
                continue
            target = basis(e)
            source = solve(rows, target)
            assert product(f, source) == target
            assert all(not x or sum(v) >= source_degree for v, x in zip(MONS, source))
            preimages.append({"target": list(e), "source": sparse(source)})
        checks.append({"target_J": target_degree, "source_J": source_degree,
                       "image_rank": len(rows), "preimages": preimages})

    # First whole product carry of f*nu39 in the original odd logarithms.
    # Terms with two overflowing variables are p^2-divisible and have no
    # first carry; keep the complete f, not merely q2.
    nu = (3, 4, 4)
    carry = [0] * 125
    for e, x in zip(MONS, f):
        if not x:
            continue
        w = [e[i] + nu[i] for i in range(3)]
        over = [i for i in range(3) if w[i] >= 5]
        assert over, "f*nu39 must vanish modulo5"
        if len(over) != 1:
            continue
        i = over[0]
        w[i] -= 4
        j = INDEX[tuple(w)]
        carry[j] = add(carry[j], mul(x, neg((3, 1, 2)[i])))
    assert all(not x or sum(e) >= 9 for e, x in zip(MONS, carry))
    carry_source = solve(echelon_with_sources(f, 7), carry)
    assert product(f, carry_source) == carry

    # The original residue AS trace, for the reduced basis degrees used
    # by the two-trace functional. T_5=0 modulo5 is essential here.
    def trace_monomial(e):
        z = 1
        for d, c in zip(e, (3, 1, 2)):
            z = mul(z, neg(inv(c)) if d == 4 else 0)
        return z

    checked = 0
    for e in MONS:
        if sum(e) <= 10:
            assert trace_monomial(e) == 0
            assert trace_monomial((e[0] + 1, e[1], e[2])) == 0
            checked += 1
    assert checked == 121

    result = {
        "status": "PASS: finite filtration support only; no actual fifth value",
        "primary_input": str(args.primary.resolve()),
        "primary_sha256": hashlib.sha256(raw).hexdigest(),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "field": "F5[t]/(t^3+t+1); field codes m0+5m1+25m2",
        "f": sparse(f),
        "q2_homogeneous_ranks": ranks,
        "filtered_primary_preimages": checks,
        "nu39_first_whole_product_carry": sparse(carry),
        "nu39_carry_source_in_J7": sparse(carry_source),
        "F10_two_trace_basis_checks": checked,
        "limits": [
            "Actual mixed-characteristic fifth slope is not computed.",
            "Whole regular primitive and fifth support arguments require the prose audit.",
            "The nodal q2 has kernel dimension2 in degree4: J5 mixed preimages are not asserted.",
        ],
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print("PASS: q2 ranks, filtered primary preimages, nu39 carry, F10 two-trace cutoff")


if __name__ == "__main__":
    main()
