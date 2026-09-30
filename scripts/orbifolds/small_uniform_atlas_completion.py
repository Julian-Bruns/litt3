#!/usr/bin/env python3
"""Complete degree-eight (2,2,2,4) and degree-nine (3,3,9) tuples.

Outputs exact permutation representatives and centralizer orbit sizes.
No arithmetic membership claim, no third-party dependencies.
"""
from itertools import permutations
import json
from degree_eight_uniform_profiles import (
    compose, inverse, cycle_type, generated_group, enumerate_profile,
)


def quadrangle():
    perms = list(permutations(range(8)))
    involutions = [a for a in perms if cycle_type(a) == (2, 2, 2, 2)]
    a = involutions[0]
    centralizer = [(p, inverse(p)) for p in perms
                   if compose(p, a) == compose(a, p)]
    candidates = {(b, c) for b in involutions for c in involutions
                  if cycle_type(inverse(compose(compose(a, b), c))) == (4, 4)}
    total = len(candidates)
    records = []
    discarded = 0
    while candidates:
        b, c = min(candidates)
        orbit = {(compose(compose(p, b), pi), compose(compose(p, c), pi))
                 for p, pi in centralizer}
        assert orbit <= candidates
        candidates -= orbit
        group = generated_group((a, b, c))
        if len({g[0] for g in group}) != 8:
            discarded += len(orbit)
            continue
        aut = sum(compose(p, b) == compose(b, p)
                  and compose(p, c) == compose(c, p) for p, _ in centralizer)
        assert len(orbit) * aut == len(centralizer)
        records.append({'a': a, 'b': b, 'c': c,
                        'd': inverse(compose(compose(a, b), c)),
                        'monodromy_order': len(group),
                        'automorphism_order': aut,
                        'fixed_first_tuple_count': len(orbit)})
    assert sum(r['fixed_first_tuple_count'] for r in records) + discarded == total
    return {'profile': [2, 2, 2, 4], 'degree': 8,
            'centralizer_order': len(centralizer),
            'nontransitive_tuple_count': discarded, 'classes': records}


def main():
    quad = quadrangle()
    assert len(quad['classes']) == 19
    tri = enumerate_profile(list(permutations(range(9))), (3, 3, 3),
                            (3, 3, 3), (9,))
    assert len(tri['classes']) == 4
    print(json.dumps([quad, tri], indent=2))


if __name__ == '__main__':
    main()
