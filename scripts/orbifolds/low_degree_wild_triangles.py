#!/usr/bin/env python3
"""Complete genus-two (5,5,5) and (2,5,10) classes over characteristic zero.

The word 'wild' refers only to the proposed residue characteristic five.
We enumerate every fixed-first triple and take its full centralizer orbits.
No reduction of the covering map is presumed.
"""
from collections import Counter
from itertools import permutations, combinations
import json
from degree_eight_uniform_profiles import (
    compose, inverse, cycle_type, generated_group, enumerate_profile,
)


def uniform_permutations(n, length):
    """Each permutation all of whose cycles have the given length, once."""
    def rec(remaining, mapping):
        if not remaining:
            yield tuple(mapping)
            return
        first = min(remaining)
        rest = remaining - {first}
        for support in combinations(sorted(rest), length - 1):
            for tail in permutations(support):
                cyc = (first,) + tail
                next_map = mapping.copy()
                for i, j in zip(cyc, cyc[1:] + cyc[:1]):
                    next_map[i] = j
                yield from rec(rest - set(support), next_map)
    yield from rec(set(range(n)), [-1] * n)


def degree_ten():
    a = tuple(list(range(1, 10)) + [0])
    centralizer = []
    p = tuple(range(10))
    for _ in range(10):
        centralizer.append((p, inverse(p)))
        p = compose(a, p)
    candidates = {b for b in uniform_permutations(10, 5)
                  if cycle_type(inverse(compose(a, b))) == (2,) * 5}
    total = len(candidates)
    records = []
    while candidates:
        b = min(candidates)
        orbit = {compose(compose(p, b), pi) for p, pi in centralizer}
        assert orbit <= candidates
        candidates -= orbit
        deck = [p for p, _ in centralizer if compose(p, b) == compose(b, p)]
        aut = len(deck)
        assert len(orbit) * aut == 10
        # The ten-cycle already proves transitivity.
        group = generated_group((a, b))
        c = inverse(compose(a, b))
        fixed_counts = []
        for p in deck:
            if p == tuple(range(10)):
                continue
            counts = []
            for generator in (a, b, c):
                remaining = set(range(10))
                count = 0
                while remaining:
                    first = min(remaining)
                    cyc, current = set(), first
                    while current not in cyc:
                        cyc.add(current)
                        current = generator[current]
                    remaining -= cyc
                    count += {p[i] for i in cyc} == cyc
                counts.append(count)
            fixed_counts.append({'permutation': p, 'branch_fixed_counts': counts,
                                 'total': sum(counts)})
        records.append({'a': a, 'b': b, 'c': c,
                        'monodromy_order': len(group),
                        'automorphism_order': aut,
                        'nonidentity_deck_fixed_points': fixed_counts,
                        'fixed_first_tuple_count': len(orbit)})
    assert sum(r['fixed_first_tuple_count'] for r in records) == total
    assert len(records) == 7
    return {'profile': [10, 5, 2], 'degree': 10, 'classes': records}


def main():
    five = enumerate_profile(list(permutations(range(5))), (5,), (5,), (5,))
    assert Counter((r['monodromy_order'], r['automorphism_order'])
                   for r in five['classes']) == {(5, 5): 3, (60, 1): 1}
    ten = degree_ten()
    assert Counter((r['monodromy_order'], r['automorphism_order'])
                   for r in ten['classes']) == {
                       (1920, 2): 3, (720, 1): 1, (120, 2): 1,
                       (50, 5): 1, (10, 10): 1}
    assert all(r['nonidentity_deck_fixed_points'][0]['total'] == 2
               for r in ten['classes'] if r['automorphism_order'] == 2)
    print(json.dumps([five, ten], indent=2))


if __name__ == '__main__':
    main()
