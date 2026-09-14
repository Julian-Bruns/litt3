#!/usr/bin/env python3
"""Verify degree-84 tables, completeness mass, and finite geometric witnesses.

Python standard library only. Run with assertions enabled. This verifies a
PERMUTATION CENSUS, not nonexistence of a map on the specified curve.
"""
import argparse
import collections
from fractions import Fraction
import hashlib
import json
from pathlib import Path
import re
from time import perf_counter
from permutation_tools import (cycles, labelled_generators, rooted_key,
                               commuting_permutations, invariant_partitions,
                               quotient_profile)


def main():
    if not __debug__:
        raise RuntimeError('Assertions must be enabled; do not use python -O.')
    start = perf_counter()
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('tables', type=Path)
    parser.add_argument('mass', type=Path)
    parser.add_argument('--export-witnesses', type=Path)
    args = parser.parse_args()
    filename, massfile = args.tables, args.mass
    text = massfile.read_text()
    match = re.search(r'^character_mass = (\d+)/(\d+)$', text, re.M)
    assert match, 'Run characters84 first to obtain the independent mass.'
    character_mass = Fraction(int(match[1]), int(match[2]))
    data = filename.read_bytes()
    tables = [json.loads(line) for line in data.decode().splitlines() if line]
    keys = set()
    records = []
    deck_orders = collections.Counter()
    categories = collections.Counter()
    census_mass = Fraction(0)
    primitive = []
    hyperelliptic = []
    outer_witnesses = []
    for number, t in enumerate(tables, 1):
        assert len(t) == 84
        assert all(len(row) == 3 and all(type(v) is int and 0 <= v < 84
                                        for v in row) for row in t)
        for g in range(3):
            assert sorted(row[g] for row in t) == list(range(84))
        assert all(t[t[x][0]][0] == x and t[t[x][1]][2] == x
                   for x in range(84))
        cyc = [cycles(p) for p in labelled_generators(t)]
        assert [sorted(map(len, cs)) for cs in cyc] == [[2]*42, [3]*28, [7]*12]
        key = min(rooted_key(t, root) for root in range(84))
        assert key not in keys, 'Simultaneously conjugate duplicate.'
        keys.add(key)
        centralizer = commuting_permutations(t)
        d = len(centralizer)
        deck_orders[d] += 1
        census_mass += Fraction(1, d)
        record = dict(class_number=number, centralizer_order=d)
        category = None
        if d > 2:
            category = 'deck_order_gt_2'
            record['commuting_witnesses'] = centralizer[:3]
        elif d == 2:
            involution = next(p for p in centralizer if p[0] != 0)
            assert all(involution[involution[x]] == x for x in range(84))
            fixed = sum(all(involution[x] in orbit for x in orbit)
                        for cs in cyc for orbit in cs)
            assert fixed in (2, 6)
            record['deck_involution'] = involution
            record['fixed_points'] = fixed
            if fixed == 2:
                category = 'elliptic_deck_quotient'
        if category is None:
            parts = invariant_partitions(t)
            profiles = [quotient_profile(t, part) for part in parts
                        if 1 < len(set(part)) < 84]
            record['proper_profiles'] = profiles
            bad = [p for p in profiles
                   if p['genus'] != 0 or p['source_degree'] != 2]
            if bad:
                witness = bad[0]
                if witness['genus'] == 1:
                    category = 'elliptic_intermediate'
                else:
                    assert witness['genus'] == 0
                    assert witness['source_degree'] == 12
                    assert witness['signature'] == [2, 2, 2, 3]
                    category = 'forbidden_degree_12_intermediate'
                record['intermediate_witness'] = witness
            elif profiles:
                category = 'hyperelliptic_survivor'
                assert d == 2 and record['fixed_points'] == 6
                assert len(profiles) == 1
                p = profiles[0]
                assert p['signature'] == [2]*6
                assert p['quotient_cycle_lengths'] == [[1]*6+[2]*18, [3]*14, [7]*6]
                part = p['partition']
                representatives = sorted(set(part))
                labels = {x: i for i, x in enumerate(representatives)}
                qt = [[labels[part[t[x][g]]] for g in range(3)]
                      for x in representatives]
                outer_witnesses.append(dict(class_number=number, outer_table=qt,
                                            partition=part))
                hyperelliptic.append(number)
            else:
                category = 'primitive_survivor'
                assert d == 1
                primitive.append(number)
        record['category'] = category
        categories[category] += 1
        records.append(record)
    assert len(keys) == 155
    assert census_mass == character_mass == 64
    assert dict(deck_orders) == {2:90, 4:44, 1:6, 6:9, 12:6}
    assert dict(categories) == {
        'deck_order_gt_2':59,
        'elliptic_deck_quotient':30,
        'elliptic_intermediate':3,
        'forbidden_degree_12_intermediate':18,
        'hyperelliptic_survivor':42,
        'primitive_survivor':3,
    }
    assert primitive == [46, 55, 90]
    print('verified_inequivalent_classes =', len(keys))
    print('centralizer_distribution =', dict(sorted(deck_orders.items())))
    print('verified_census_mass =', census_mass)
    print('independent_character_mass =', character_mass)
    print('categories =', dict(sorted(categories.items())))
    print('primitive_classes =', primitive)
    print('hyperelliptic_classes =', hyperelliptic)
    if args.export_witnesses:
        args.export_witnesses.write_text(json.dumps(dict(
            classification=records, outer=outer_witnesses,
            primitive=primitive, hyperelliptic=hyperelliptic), indent=2)+'\n')
    print('tables_sha256 =', hashlib.sha256(data).hexdigest())
    print('verification_seconds =', round(perf_counter()-start, 6))


if __name__ == '__main__':
    main()
