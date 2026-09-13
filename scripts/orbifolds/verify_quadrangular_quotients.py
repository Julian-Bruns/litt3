#!/usr/bin/env python3
"""Exact small-cover quotient and Hecke checks, Python standard library only.

This replays every row of the retained complete GAP censuses. Completeness
of those censuses is separately supported by their generator and the
published 9/39 counts; this script does not replace subgroup enumeration.
It checks permutation groups, deck groups, elliptic blocks, and INTEGER
adjacency identities. The geometric use is proved in Solutions, not here.
"""
import json
import time
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def compose(a, b):
    return tuple(a[i] for i in b)


def closure(gs):
    unit = tuple(range(len(gs[0])))
    group, known = [unit], {unit}
    for g in group:
        for a in gs:
            h = compose(a, g)
            if h not in known:
                known.add(h)
                group.append(h)
    return group


def cycles(p):
    seen, lengths = set(), []
    for i in range(len(p)):
        if i not in seen:
            j, length = i, 0
            while j not in seen:
                seen.add(j)
                length += 1
                j = p[j]
            lengths.append(length)
    return sorted(lengths)


def centralizer(group):
    n = len(group[0])
    result = []
    for j in range(n):
        p = [None] * n
        for g in group:
            i, value = g[0], g[j]
            if p[i] is not None and p[i] != value:
                break
            p[i] = value
        else:
            assert sorted(p) == list(range(n))
            p = tuple(p)
            assert all(compose(p, g) == compose(g, p) for g in group)
            result.append(p)
    return result


def pair_block_quotients(gs):
    n = len(gs[0])
    for j in range(1, n):
        blocks = [frozenset((0, j))]
        known, ok = set(blocks), True
        for B in blocks:
            for g in gs:
                image = frozenset(g[i] for i in B)
                if image not in known:
                    if any(image & other for other in blocks):
                        ok = False
                        break
                    blocks.append(image)
                    known.add(image)
            if not ok:
                break
        if not ok or len(blocks) * 2 != n:
            continue
        index = {B: i for i, B in enumerate(blocks)}
        types = [cycles([index[frozenset(g[i] for i in B)] for B in blocks])
                 for g in gs]
        yield blocks, types


def hecke_test(group, deck):
    n = 12
    H = [g for g in group if g[0] == 0]
    assert len(group) == 60 and len(H) == 5
    orbits = {frozenset(h[i] for h in H) for i in range(n)}
    assert sorted(map(len, orbits)) == [1, 1, 5, 5]
    unit = tuple(range(n))
    assert len(deck) == 2
    sigma = next(p for p in deck if p != unit)
    assert compose(sigma, sigma) == unit and all(sigma[i] != i for i in range(n))
    for orbit in sorted((x for x in orbits if len(x) == 5), key=lambda x: sorted(x)):
        neighbors = [None] * n
        for g in group:
            image = frozenset(g[i] for i in orbit)
            i = g[0]
            assert neighbors[i] is None or neighbors[i] == image
            neighbors[i] = image
        A = [[int(j in neighbors[i]) for j in range(n)] for i in range(n)]
        B = [[A[i][sigma[j]] for j in range(n)] for i in range(n)]
        assert all(A[i][j] == A[j][i] for i in range(n) for j in range(n))
        assert all(B[i][j] == B[j][i] for i in range(n) for j in range(n))
        assert all(sum(row) == 5 for row in A)
        assert all(A[i][j] + B[i][j] + int(i == j) + int(sigma[i] == j) == 1
                   for i in range(n) for j in range(n))
        assert all(sum(A[i][z] * A[z][j] for z in range(n))
                   == 5 * int(i == j) + 2 * A[i][j] + 2 * B[i][j]
                   for i in range(n) for j in range(n))
        # Point stabilizers at both ends intersect trivially: the
        # correspondence normalization is the Galois closure itself.
        assert all(sum(h[j] == j for h in H) == 1 for j in orbit)


def main():
    start = time.monotonic()
    for profile, total, expected in (
        ("2233", 9, {(6, 6): 3, (24, 2): 6}),
        ("2223", 39, {(12, 12): 3, (48, 4): 18, (60, 2): 9, (96, 4): 9}),
    ):
        data = json.loads((ROOT / "Research/computations" /
                          ("genus_two_quadrangular_" + profile + ".json")).read_text())
        assert len(data["rows"]) == total
        hist, elliptic, hecke = Counter(), 0, 0
        for row in data["rows"]:
            gs = [tuple(i - 1 for i in p) for p in row[3]]
            assert len(gs) == len(profile)
            unit = tuple(range(len(gs[0])))
            product = unit
            for g in gs:
                assert tuple(sorted(g)) == unit
                product = compose(g, product)  # GAP's right-action convention.
            assert product == unit
            assert all(cycles(g) == [int(e)] * (len(g) // int(e))
                       for g, e in zip(gs, profile))
            group = closure(gs)
            assert len({g[0] for g in group}) == len(gs[0])
            deck = centralizer(group)
            assert (len(group), len(deck)) == (row[0], row[2])
            hist[len(group), len(deck)] += 1
            if profile == "2233" and len(deck) == 2:
                quotients = list(pair_block_quotients(gs))
                assert any(types == [[1, 2], [1, 2], [3], [3]]
                           for _, types in quotients)
                elliptic += 1
            if profile == "2223" and len(deck) == 2:
                hecke_test(group, deck)
                hecke += 1
        assert hist == expected
        print(f"{profile}: {total} rows checked; elliptic double quotients={elliptic}; "
              f"icosahedral Hecke identities={hecke}")
    print("PASS exact integer A^2=5I+2A+2B for both five-valent relations in all nine A5 cases")
    print(f"seconds={time.monotonic()-start:.6f}")


if __name__ == "__main__":
    main()
