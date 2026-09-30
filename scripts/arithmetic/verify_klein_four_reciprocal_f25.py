#!/usr/bin/env python3
"""Independent F25[zeta]/f7 replay of the complete90-row moment table.

Enumerate x,y,epsilon directly in F25; do not use the parametrizing formula.
The other implementation uses F5[zeta] of degree14 and a beta embedding.
"""
import argparse
import importlib.util
import json
from pathlib import Path

SOURCE = Path(__file__).parent / 'pro_finite_loci_v4_20260926/v4/src/ff25.py'
spec = importlib.util.spec_from_file_location('replay_ff25', SOURCE)
F = importlib.util.module_from_spec(spec)
spec.loader.exec_module(F)
MOD = [4, 22, 7, 20, 21, 7, 24, 1]


def product(a, b):
    return F.pdivmod(F.pmul(a, b), MOD)[1]


def power(a, n):
    r = [1]
    while n:
        if n & 1:
            r = product(r, a)
        a = product(a, a)
        n //= 2
    return r


def main(path):
    data = json.loads(path.read_text())
    z = [0, 1]
    assert power(z, 29) == [1]
    zp = [power(z, j) for j in range(29)]
    actual = set()
    # No division, norm condition or parametrization is assumed in this test.
    for e in range(1, 25):
        for x in range(25):
            for y in range(25):
                if (F.mul(e, F.sub(1, F.power(x, 5))) == F.sub(17, F.power(y, 5))
                        and F.mul(e, F.sub(17, y)) == F.sub(1, x)):
                    actual.add((e, x, y))
    assert len(actual) == 18
    assert actual == {(r['epsilon'], r['M2'], r['M6']) for r in data['rows']}
    seen = set()
    for row in data['rows']:
        e, x, y, mr = (row[k] for k in ['epsilon', 'M2', 'M6', 'mass_mod5'])
        assert (e, mr) not in seen
        seen.add((e, mr))
        weights = [None] * 29
        weights[0] = row['weights_at_zero_and_four_orbits'][0]
        for orbit, w in zip(data['node_orbits_under_25'], row['weights_at_zero_and_four_orbits'][1:]):
            for j in orbit:
                assert weights[j] is None
                weights[j] = w
        assert all(type(w) is int and 0 <= w <= 4 for w in weights)
        for j0, val in [(2, x), (6, y)]:
            j, expected = j0, val
            for _ in range(14):
                total = []
                for i, w in enumerate(weights):
                    total = F.padd(total, F.scale(zp[i * j % 29], w))
                assert total == ([] if expected == 0 else [expected])
                j = j * 5 % 29
                expected = F.power(expected, 5)
        assert sum(weights) % 5 == mr
        assert sum(weights) == row['residue_mass']
        assert weights.count(1) == row['residue_one_nodes']
        assert row['possible_degrees_14_to_87'] == [12+sum(weights)+5*j for j in range(weights.count(1)+1)
                                                   if 14 <= 12+sum(weights)+5*j <= 87]
    assert len(seen) == 90
    assert data['minimum_residue_mass'] == min(r['residue_mass'] for r in data['rows']) == 29
    assert len(data['attaining_rows']) == 2
    print('PASS: complete18 scalar/moment triples,90 unique residue vectors, all28 Fourier coordinates per row.')
    print('PASS: minimum residue mass29, exactly two minimizers, and every allowed integer lift.')
    print('No actual curve or unrestricted epsilon classification is asserted.')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('certificate', type=Path)
    main(p.parse_args().certificate)
