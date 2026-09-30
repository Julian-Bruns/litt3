#!/usr/bin/env python3
"""Complete labeled degree-eight triangle classes, not an arithmetic census.

Profiles: (2,8,8) and (4,4,4). Exact permutations, centralizer orbits,
monodromy orders, and automorphism orders; no third-party dependencies.
"""
from collections import Counter
from itertools import permutations
import json


def compose(a, b):
    return tuple(a[b[i]] for i in range(len(a)))


def inverse(a):
    out = [0] * len(a)
    for i, j in enumerate(a):
        out[j] = i
    return tuple(out)


def cycle_type(a):
    seen = set()
    sizes = []
    for i in range(len(a)):
        if i in seen:
            continue
        j, size = i, 0
        while j not in seen:
            seen.add(j)
            size += 1
            j = a[j]
        sizes.append(size)
    return tuple(sorted(sizes))


def generated_group(gens):
    identity = tuple(range(len(gens[0])))
    found, queue = {identity}, [identity]
    for a in queue:
        for b in gens:
            c = compose(b, a)
            if c not in found:
                found.add(c)
                queue.append(c)
    return found


def enumerate_profile(all_perms, first_type, second_type, third_type):
    a = next(p for p in all_perms if cycle_type(p) == first_type)
    centralizer = [(p, inverse(p)) for p in all_perms
                   if compose(a, p) == compose(p, a)]
    candidates = {b for b in all_perms
                  if cycle_type(b) == second_type
                  and cycle_type(inverse(compose(a, b))) == third_type}
    total = len(candidates)
    records = []
    discarded = 0
    while candidates:
        b = min(candidates)
        orbit = {compose(compose(p, b), pi) for p, pi in centralizer}
        assert orbit <= candidates
        candidates -= orbit
        group = generated_group((a, b))
        if len({g[0] for g in group}) != len(a):
            discarded += len(orbit)
            continue
        aut = sum(compose(p, b) == compose(b, p) for p, _ in centralizer)
        assert len(orbit) * aut == len(centralizer)
        records.append({'a': a, 'b': b, 'c': inverse(compose(a, b)),
                        'monodromy_order': len(group),
                        'automorphism_order': aut,
                        'fixed_first_tuple_count': len(orbit)})
    assert sum(r['fixed_first_tuple_count'] for r in records) + discarded == total
    return {'profile': [first_type, second_type, third_type],
            'centralizer_order': len(centralizer),
            'accepted_tuple_count': total - discarded,
            'nontransitive_tuple_count': discarded,
            'classes': records}


def main():
    all_perms = list(permutations(range(8)))
    answers = []
    for profile in (((2, 2, 2, 2), (8,), (8,)),
                    ((4, 4), (4, 4), (4, 4))):
        answer = enumerate_profile(all_perms, *profile)
        answers.append(answer)
    assert [len(a['classes']) for a in answers] == [4, 6]
    print(json.dumps(answers, indent=2))


if __name__ == '__main__':
    main()
