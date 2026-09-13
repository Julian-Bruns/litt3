#!/usr/bin/env python3
"""Verify the complete degree-48 census and its geometric exclusion witnesses.

Usage: python3 scripts/orbifolds/triangle238_certificate/verify48.py [tables.jsonl]
Default verification is read-only. --export-witnesses FILE regenerates all witnesses.
No external Python packages, GAP, Sage, Magma or group databases are needed.
Assertions must be enabled (do not use python -O).
"""
import argparse
import collections
from fractions import Fraction
import hashlib
import json
from pathlib import Path
import sys
from time import perf_counter
from characters48 import (small_cross_checks, mass48, mn_character,
                          abacus_character)


def cycles(p):
    seen = set()
    result = []
    for x in range(len(p)):
        if x in seen:
            continue
        c = []
        y = x
        while y not in seen:
            seen.add(y)
            c.append(y)
            y = p[y]
        assert y == x
        result.append(c)
    return result


def labelled_generators(t):
    a = [row[0] for row in t]
    b = [row[1] for row in t]
    # Functional composition ba: x |-> b(a(x)).
    c = [b[a[x]] for x in range(len(t))]
    return a, b, c


def rooted_key(t, root):
    """BFS-normalized table, preserving the generator and branch labels."""
    relabel = {root: 0}
    queue = [root]
    result = []
    for x in queue:
        for g in range(3):
            y = t[x][g]
            if y not in relabel:
                relabel[y] = len(queue)
                queue.append(y)
            result.append(relabel[y])
    assert len(queue) == len(t), 'nontransitive table'
    return tuple(result)


def commuting_permutations(t):
    """All centralizer elements, each determined by the image of 0."""
    n = len(t)
    answer = []
    for image0 in range(n):
        p = [-1]*n
        p[0] = image0
        queue = [0]
        good = True
        for x in queue:
            for g in range(3):
                y = t[x][g]
                z = t[p[x]][g]
                if p[y] < 0:
                    p[y] = z
                    queue.append(y)
                elif p[y] != z:
                    good = False
                    break
            if not good:
                break
        if good:
            assert len(queue) == n and sorted(p) == list(range(n))
            assert all(p[t[x][g]] == t[p[x]][g]
                       for x in range(n) for g in range(3))
            answer.append(p)
    return answer


def join_pair(t, partition, j):
    """Smallest invariant equivalence coarsening partition and identifying 0,j."""
    parent = list(partition)

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    pending = [(0, j)]
    for x, y in pending:
        x, y = find(x), find(y)
        if x == y:
            continue
        if x > y:
            x, y = y, x
        parent[y] = x
        pending.extend((t[x][g], t[y][g]) for g in range(3))
    result = tuple(find(x) for x in range(len(t)))
    # Independently check invariance of the resulting equivalence relation.
    for x in range(len(t)):
        for g in range(3):
            assert result[t[x][g]] == result[t[result[x]][g]]
    return result


def invariant_partitions(t):
    discrete = tuple(range(len(t)))
    result = [discrete]
    seen = {discrete}
    for partition in result:
        for j in range(len(t)):
            if partition[j] != j or partition[j] == partition[0]:
                continue
            new = join_pair(t, partition, j)
            if new not in seen:
                seen.add(new)
                result.append(new)
    return result


def quotient_profile(t, partition):
    representatives = sorted(set(partition))
    labels = {b: i for i, b in enumerate(representatives)}
    sizes = collections.Counter(partition)
    assert len(set(sizes.values())) == 1
    qt = [[labels[partition[t[b][g]]] for g in range(3)]
          for b in representatives]
    cyc = [cycles(p) for p in labelled_generators(qt)]
    genus_numerator = 2+len(qt)-sum(map(len, cyc))
    assert genus_numerator >= 0 and genus_numerator % 2 == 0
    signature = []
    for e, branch_cycles in zip((2, 3, 8), cyc):
        for orbit in branch_cycles:
            ell = len(orbit)
            assert e % ell == 0
            if ell < e:
                signature.append(e//ell)
    return dict(genus=genus_numerator//2,
                signature=sorted(signature),
                source_degree=len(t)//len(qt),
                target_degree=len(qt),
                quotient_cycle_lengths=[sorted(map(len, cs)) for cs in cyc],
                partition=list(partition))


def main():
    if not __debug__:
        raise RuntimeError('Assertions must be enabled; do not use python -O.')
    start = perf_counter()
    here = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('tables', nargs='?', type=Path,
                        default=here.parent.parent/'Research/computations/triangle238_tables.jsonl')
    parser.add_argument('--export-witnesses', type=Path)
    args = parser.parse_args()
    filename = args.tables
    data = filename.read_bytes()
    tables = [json.loads(line) for line in data.decode().splitlines() if line]
    keys = set()
    records = []
    deck_orders = collections.Counter()
    census_mass = Fraction(0)
    exclusions = collections.Counter()
    remaining = []
    ordered_profiles = [((3, 3, 4), 24), ((2, 2, 2, 3), 12), ((2, 4, 8), 16)]
    for number, t in enumerate(tables, 1):
        assert len(t) == 48
        assert all(len(row) == 3 and all(type(v) is int and 0 <= v < 48
                                        for v in row) for row in t)
        for g in range(3):
            assert sorted(row[g] for row in t) == list(range(48))
        assert all(t[t[x][0]][0] == x and t[t[x][1]][2] == x
                   for x in range(48))
        generators = labelled_generators(t)
        cyc = [cycles(p) for p in generators]
        assert [sorted(map(len, cs)) for cs in cyc] == [[2]*24, [3]*16, [8]*6]
        key = min(rooted_key(t, root) for root in range(48))
        assert key not in keys, 'simultaneously conjugate duplicate'
        keys.add(key)
        centralizer = commuting_permutations(t)
        deck_order = len(centralizer)
        deck_orders[deck_order] += 1
        census_mass += Fraction(1, deck_order)
        record = dict(class_number=number, centralizer_order=deck_order)
        if deck_order > 2:
            category = 'deck_order_gt_2'
            # Three distinct deck transformations already certify this exclusion.
            record['commuting_witnesses'] = centralizer[:3]
        elif deck_order == 2:
            d = next(p for p in centralizer if p[0] != 0)
            assert all(d[d[x]] == x for x in range(48))
            fixed = sum(all(d[x] in orbit for x in orbit)
                        for branch_cycles in cyc for orbit in branch_cycles)
            assert fixed in (2, 6)
            record['deck_involution'] = d
            record['fixed_points'] = fixed
            category = 'nonhyperelliptic_deck_involution' if fixed == 2 else None
        else:
            category = None
        if category is None:
            partitions = invariant_partitions(t)
            proper = [p for p in partitions if 1 < len(set(p)) < 48]
            profiles = [quotient_profile(t, p) for p in proper]
            for signature, degree in ordered_profiles:
                witnesses = [q for q in profiles
                             if q['genus'] == 0 and tuple(q['signature']) == signature
                             and q['source_degree'] == degree]
                if witnesses:
                    category = 'intermediate_' + '_'.join(map(str, signature))
                    record['intermediate_witness'] = witnesses[0]
                    break
            if category is None:
                category = 'remaining'
                remaining.append(number)
                record['proper_invariant_partitions'] = len(proper)
                assert not proper  # The two remaining classes are primitive.
        record['category'] = category
        records.append(record)
        exclusions[category] += 1

    print('tables_sha256 =', hashlib.sha256(data).hexdigest(), flush=True)
    print('verified_distinct_transitive_classes =', len(keys), flush=True)
    print('centralizer_order_distribution =', dict(sorted(deck_orders.items())), flush=True)
    print('census_mass =', census_mass, flush=True)
    print('character_small_cross_checks =', small_cross_checks(), flush=True)
    direct_mass, npart, nonzero = mass48(mn_character)
    print('partitions_of_48 =', npart, flush=True)
    print('nonzero_character_products =', nonzero, flush=True)
    print('direct_Murnaghan_Nakayama_mass =', direct_mass, flush=True)
    abacus_mass, npart2, nonzero2 = mass48(abacus_character)
    print('independent_abacus_mass =', abacus_mass, flush=True)
    assert (npart, nonzero) == (npart2, nonzero2)
    assert census_mass == direct_mass == abacus_mass
    # Since each missing conjugacy class would have strictly positive mass,
    # this equality and inequivalence establish completeness of the census.
    print('EXHAUSTIVENESS_CERTIFICATE_PASSED', flush=True)
    for category, count in exclusions.items():
        print(category, '=', count, flush=True)
    print('remaining_class_numbers =', remaining, flush=True)
    print('remaining_classes_are_primitive =', True, flush=True)
    assert len(remaining) == 2
    report = dict(classes=records,
                  centralizer_order_distribution=dict(sorted(deck_orders.items())),
                  categories=dict(exclusions),
                  remaining_class_numbers=remaining,
                  census_mass=str(census_mass), character_mass=str(direct_mass),
                  abacus_mass=str(abacus_mass), tables_sha256=hashlib.sha256(data).hexdigest())
    if args.export_witnesses:
        args.export_witnesses.write_text(json.dumps(report, indent=2)+'\n')
    print('FINITE_GROUP_CERTIFICATE_COMPLETE', flush=True)
    print('verification_seconds =', round(perf_counter()-start, 3), flush=True)


if __name__ == '__main__':
    main()
