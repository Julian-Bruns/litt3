#!/usr/bin/env python3
"""Exact F5[t] certificate for the maximal elementary two-cover.

Polynomial tuples are (u-degree,t-degree). No finite-field sampling,
external package, field-extension search, or large atlas data is used.
"""
from itertools import combinations
import json
import time


def mul(a, b):
    out = {}
    for (i, j), x in a.items():
        for (l, m), y in b.items():
            key = i+l, j+m
            out[key] = (out.get(key, 0)+x*y) % 5
    return {key: c for key, c in out.items() if c}


def add(a, b, scale=1):
    out = dict(a)
    for key, c in b.items():
        out[key] = (out.get(key, 0)+scale*c) % 5
    return {key: c for key, c in out.items() if c}


def polynomial(subset):
    out = {(0, 0): 1}
    for root in subset:
        factor = {(1, 0): 1, (0, 1): 4} if root == "t" else {
            (1, 0): 1, (0, 0): -root % 5}
        out = mul(out, factor)
    return out


def ucoeff(a, i):
    return {(0, j): c for (n, j), c in a.items() if n == i}


def verify():
    started = time.monotonic()
    roots = (0, 1, 2, 3, "t")
    expected = [
        (3, 0, 0), (2, 0, 0), (1, 4, 1), (2, 0, 0), (4, 3, 1),
        (4, 2, 1), (3, 0, 0), (3, 2, 1), (2, 1, 1), (2, 0, 1),
        (3, 0, 0), (4, 4, 3), (4, 3, 2), (1, 0, 2), (3, 3, 3)]
    triples = list(combinations(roots, 3))+list(combinations(roots, 4))
    product, monics = {(0, 0): 1}, set()
    for subset, row in zip(triples, expected):
        f = polynomial(subset)
        c = ucoeff(mul(f, f), 4)
        assert tuple(c.get((0, j), 0) for j in range(3)) == row
        if row[2]:
            inverse = pow(row[2], -1, 5)
            monic = tuple(inverse*x % 5 for x in row)
            assert (monic[1]**2-4*monic[0]) % 5 in (2, 3)
            monics.add(monic)
            product = mul(product, {(0, j): x for j, x in enumerate(monic) if x})
    assert len(monics) == 10
    assert product == {(0, i): 1 for i in range(0, 21, 4)}
    f2 = mul(polynomial(roots), polynomial(roots))
    c4, c3, c9, c8 = [ucoeff(f2, i) for i in (4, 3, 9, 8)]
    linear = {(0, 0): 1, (0, 1): 1}
    factors = [{(0, 0): 1, (0, 1): 3}, {(0, 1): 3},
               {(0, 0): 3}, {(0, 0): 3, (0, 1): 1}]
    assert [c4, c3, c9, c8] == [mul(linear, f) for f in factors]
    fourth = mul(mul(linear, linear), mul(linear, linear))
    assert add(mul(c4, c8), mul(c3, c9), -1) == {
        key: 3*c % 5 for key, c in fourth.items() if 3*c % 5}
    return {"elliptic_blocks": 15, "irreducible_quadratics": 10,
            "identity_checks": "PASS", "seconds": time.monotonic()-started}


if __name__ == "__main__":
    print(json.dumps(verify(), indent=2))
