#!/usr/bin/env python3
"""Complete reciprocal-balanced moment classification for epsilon in F25*.

Necessary moment data only. All possible integer lifts are characterized;
this script constructs no curve and assumes no descent for general epsilon.
Standalone, with direct arithmetic in an independently specified F5^14.
"""
import argparse
import json
from pathlib import Path

MOD = (1, 2, 4, 0, 4, 4, 3, 1, 3, 4, 4, 0, 4, 2, 1)
ZERO = (0,) * 14
ONE = (1,) + (0,) * 13
BETA = (1, 1, 0, 0, 4, 3, 3, 1, 1, 3, 1, 2, 1, 1)
ZETA = (0, 1) + (0,) * 12


def add(a, b):
    return tuple((x + y) % 5 for x, y in zip(a, b))


def scale(a, c):
    return tuple(c * x % 5 for x in a)


def mul(a, b):
    v = [0] * 27
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            v[i + j] += x * y
    for i in range(26, 13, -1):
        c = v[i] % 5
        for j in range(14):
            v[i - 14 + j] -= c * MOD[j]
    return tuple(x % 5 for x in v[:14])


def power(a, n):
    b = ONE
    while n:
        if n & 1:
            b = mul(b, a)
        a = mul(a, a)
        n //= 2
    return b


def a25(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def s25(a, b):
    return (a % 5 - b % 5) % 5 + 5 * ((a // 5 - b // 5) % 5)


def m25(a, b):
    x, y, u, v = a % 5, a // 5, b % 5, b // 5
    return (x * u + 3 * y * v) % 5 + 5 * ((x * v + y * u + y * v) % 5)


def bar25(a):
    return (a % 5 + a // 5) % 5 + 5 * ((-(a // 5)) % 5)


def inverse25(a):
    assert a
    return next(b for b in range(1, 25) if m25(a, b) == 1)


def generate():
    assert mul(BETA, BETA) == add(BETA, scale(ONE, 3))
    assert power(BETA, 25) == BETA and power(BETA, 5) != BETA
    assert power(ZETA, 29) == ONE and ZETA != ONE
    emb = [add(scale(ONE, a % 5), scale(BETA, a // 5)) for a in range(25)]
    assert len(set(emb)) == 25
    for a in range(25):
        assert emb[bar25(a)] == power(emb[a], 5)
        for b in range(25):
            assert emb[m25(a, b)] == mul(emb[a], emb[b])
    zp = [power(ZETA, i) for i in range(29)]
    orbits = []
    seen = {0}
    for i in range(1, 29):
        if i not in seen:
            orbit = sorted({i * pow(25, j, 29) % 29 for j in range(7)})
            orbits.append(orbit)
            seen.update(orbit)
    assert len(orbits) == 4 and len(seen) == 29
    rows = []
    for epsilon in range(1, 25):
        norm = m25(epsilon, bar25(epsilon))
        assert norm in range(1, 5)
        if norm == 1:
            continue
        # epsilon(1-bar(x))=kappa-bar(y), epsilon(kappa-y)=1-x.
        ybar = m25(s25(17, m25(norm, bar25(17))), inverse25(s25(1, norm)))
        y = bar25(ybar)
        x = a25(s25(1, m25(epsilon, 17)), m25(epsilon, y))
        assert m25(epsilon, s25(1, bar25(x))) == s25(17, bar25(y))
        assert m25(epsilon, s25(17, y)) == s25(1, x)
        for mass_residue in range(5):
            moments = [None] * 29
            moments[0] = scale(ONE, mass_residue)
            for j0, z0 in [(2, emb[x]), (6, emb[y])]:
                j, z = j0, z0
                for _ in range(14):
                    assert moments[j] is None
                    moments[j] = z
                    j = 5 * j % 29
                    z = power(z, 5)
                assert j == j0 and z == z0
            weights = []
            for i in range(29):
                w = ZERO
                for j, z in enumerate(moments):
                    w = add(w, mul(z, zp[-i * j % 29]))
                w = scale(w, 4)
                assert w[1:] == (0,) * 13
                weights.append(w[0])
            for orbit in orbits:
                assert len({weights[i] for i in orbit}) == 1
            # Independently sum all four moments back from the integer residues.
            for j, expected in [(2, x), (6, y), (-2, bar25(x)), (-6, bar25(y))]:
                total = ZERO
                for i, w in enumerate(weights):
                    total = add(total, scale(zp[i * j % 29], w))
                assert total == emb[expected]
            r, o = sum(weights), weights.count(1)
            assert r % 5 == mass_residue
            rows.append({'epsilon': epsilon, 'norm_epsilon': norm, 'M2': x, 'M6': y,
                         'mass_mod5': mass_residue, 'weights_at_zero_and_four_orbits':
                         [weights[0]] + [weights[a[0]] for a in orbits],
                         'residue_mass': r, 'residue_one_nodes': o,
                         'possible_degrees_14_to_87': [12+r+5*j for j in range(o+1)
                                                     if 14 <= 12+r+5*j <= 87]})
    assert len(rows) == 90 and len({r['epsilon'] for r in rows}) == 18
    return {'scope': 'Reciprocal balanced endpoints with normalized epsilon in F25*; moments only',
            'zeta_modulus_F5': MOD, 'beta_embedding': BETA, 'node_orbits_under_25': orbits,
            'rows': rows, 'minimum_residue_mass': min(r['residue_mass'] for r in rows),
            'attaining_rows': [r for r in rows if r['residue_mass'] == min(s['residue_mass'] for s in rows)],
            'actual_curves_constructed': 0,
            'lift_rule': 'Choose any subset of the residue-one nodes to upgrade weight1 to6; each adds5 to the pole mass.'}


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    result = generate()
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('18 scalars,90 exact residue vectors; minimum mass', result['minimum_residue_mass'])
    print('attaining rows:', len(result['attaining_rows']))
