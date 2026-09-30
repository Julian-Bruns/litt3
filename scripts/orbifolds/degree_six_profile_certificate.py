#!/usr/bin/env python3
"""Exact branch-cycle checks for three uniform genus-two degree-six profiles.

Scope: (2,2,3,3), (2,2,2,6), (3,6,6), in characteristic zero.
This is NOT a membership certificate for the full arithmetic set S_2.

No third-party dependencies. Run with Python 3.10 or newer.
Permutations act on {0,...,5}; compose(p,q) means p after q.
One first branch cycle is fixed in each profile. Every possible first
branch cycle is conjugate to this choice, so enumeration is exhaustive
up to simultaneous conjugacy. The counts printed are tuple counts with
that first branch cycle fixed, not counts of isomorphism classes.
"""
from collections import Counter
from itertools import permutations

Perm = tuple[int, ...]
IDENTITY: Perm = tuple(range(6))


def compose(p: Perm, q: Perm) -> Perm:
    return tuple(p[q[i]] for i in range(6))


def inverse(p: Perm) -> Perm:
    q = [0] * 6
    for i, j in enumerate(p):
        q[j] = i
    return tuple(q)


def cycle_type(p: Perm) -> tuple[int, ...]:
    unseen = set(range(6))
    lengths = []
    while unseen:
        j = min(unseen)
        length = 0
        while j in unseen:
            unseen.remove(j)
            length += 1
            j = p[j]
        lengths.append(length)
    return tuple(sorted(lengths))


def group(generators: tuple[Perm, ...]) -> set[Perm]:
    found = {IDENTITY}
    queue = [IDENTITY]
    for h in queue:
        for g in generators:
            gh = compose(g, h)
            if gh not in found:
                found.add(gh)
                queue.append(gh)
    return found


def transitive(G: set[Perm]) -> bool:
    return len({h[0] for h in G}) == 6


def conjugate(p: Perm, by: Perm) -> Perm:
    return compose(compose(by, p), inverse(by))


def main() -> None:
    S6 = list(permutations(range(6)))
    twos = [p for p in S6 if cycle_type(p) == (2, 2, 2)]
    threes = [p for p in S6 if cycle_type(p) == (3, 3)]
    sixes = [p for p in S6 if cycle_type(p) == (6,)]
    assert (len(twos), len(threes), len(sixes)) == (15, 40, 120)

    a = twos[0]
    profile_2233: Counter[int] = Counter()
    for b in twos:
        for c in threes:
            d = inverse(compose(compose(a, b), c))
            if cycle_type(d) != (3, 3):
                continue
            G = group((a, b, c))
            if transitive(G):
                profile_2233[len(G)] += 1
    assert profile_2233 == Counter({6: 24, 24: 144})

    profile_2226: Counter[int] = Counter()
    for b in twos:
        for c in twos:
            d = inverse(compose(compose(a, b), c))
            if cycle_type(d) != (6,):
                continue
            G = group((a, b, c))
            assert transitive(G)
            profile_2226[len(G)] += 1
    assert profile_2226 == Counter({12: 72})

    a = threes[0]
    profile_366: Counter[int] = Counter()
    order_120_pairs: set[tuple[Perm, Perm]] = set()
    for b in sixes:
        c = inverse(compose(a, b))
        if cycle_type(c) != (6,):
            continue
        G = group((a, b))
        assert transitive(G)
        profile_366[len(G)] += 1
        if len(G) == 120:
            order_120_pairs.add((b, c))
    assert profile_366 == Counter({6: 3, 18: 6, 24: 9, 120: 18})

    # Simultaneous conjugacy with a fixed is the centralizer action.
    centralizer = [s for s in S6 if compose(s, a) == compose(a, s)]
    assert len(centralizer) == 18
    b0, c0 = min(order_120_pairs)
    orbit = {(conjugate(b0, s), conjugate(c0, s)) for s in centralizer}
    assert orbit == order_120_pairs
    assert len(orbit) == 18

    for label, counts in (("(2,2,3,3)", profile_2233),
                          ("(2,2,2,6)", profile_2226),
                          ("(3,6,6)", profile_366)):
        print(label, dict(sorted(counts.items())))
    print("(3,6,6), order 120: exactly one simultaneous-conjugacy class")
    print("All assertions passed. Scope is only these degree-six profiles.")


if __name__ == "__main__":
    main()
