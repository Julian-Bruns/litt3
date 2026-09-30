#!/usr/bin/env python3
"""Direct Lagrange reconstruction of the two remaining marked pencils."""
import argparse
import json
from pathlib import Path
import check_klein_four_constant_pencils as C

T, Z, O = C.T, C.Z, C.O


def flat(row):
    return [b for a in row for c in a for b in (c % 5, c // 5)]


def separator(rows, target):
    # Solve lambda(row)=0 and lambda(target)=1 over F5, retaining the
    # actual42-coordinate linear functional as the exclusion certificate.
    a = [list(r)+[0] for r in rows]+[list(target)+[1]]
    pivots = []
    for j in range(len(target)):
        p = next((i for i in range(len(pivots), len(a)) if a[i][j]), None)
        if p is None:
            continue
        r = len(pivots)
        a[r], a[p] = a[p], a[r]
        a[r] = [v*pow(a[r][j], -1, 5) % 5 for v in a[r]]
        for i in range(len(a)):
            if i != r:
                c = a[i][j]
                a[i] = [(v-c*w) % 5 for v, w in zip(a[i], a[r])]
        pivots.append(j)
    assert len(pivots) == len(rows)+1
    v = [0]*len(target)
    for i, p in enumerate(pivots):
        v[p] = a[i][-1]
    assert all(sum(x*y for x, y in zip(v, r)) % 5 == 0 for r in rows)
    assert sum(x*y for x, y in zip(v, target)) % 5 == 1
    return v


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    root = ap.parse_args().root
    data = json.loads((root/'constant_marked_pencils.json').read_text())
    assert data['first_slope_sets'] == 45 and data['both_slope_pairs'] == 47
    assert data['minimal_polynomial_pairs'] == 2 and data['marked_matches'] == 0
    base = json.loads((root/'constant_pencil_targets.json').read_text())['nonrational_targets']
    all_targets = json.loads((root/'linear_pencil_targets.json').read_text())['targets']
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    results = []
    for old in data['checks']:
        if not old['minimal_polynomial_compatible']:
            continue
        first, second, mask = old['first_target'], old['second_target'], old['complement_mask']
        assert (first, second, mask) in [(0, 314, 261461378), (0, 314, 275409532)]
        lam, nu, trace, constant = [tuple(base[first][key]) for key in
                                   ('slope', 'intercept', 'minimal_trace', 'minimal_constant')]
        lam2, nu2, trace2, constant2 = map(tuple, all_targets[second])
        nodes = [i for i in range(29) if not mask >> i & 1]
        d = [O]
        for i in nodes:
            d = C.pm(d, [T.neg(zs[i]), O])
        q, _ = C.divide([Z]*22+[O], d)
        f = [C.scale(v, 2) for v in C.pm(d, q)]
        k = T.inv(d[0])
        shift = C.scale(T.sub(trace2, T.mul(k, trace)), 3)
        assert constant2 == T.sub(T.sub(T.mul(T.mul(k, k), constant),
                                         T.mul(T.mul(k, trace), shift)), T.mul(shift, shift))
        gamma = d[14]
        assert lam == T.mul(d[1], k) and lam2 == gamma
        wanted = (T.sub(nu, T.sub(f[1], T.mul(lam, f[0]))),
                  T.sub(shift, T.sub(f[15], T.mul(k, f[0]))),
                  T.sub(nu2, T.sub(f[14], T.mul(gamma, f[15]))))
        rows = []
        for a in nodes:
            p, value = [O], O
            for b in nodes:
                if b != a:
                    p = C.pm(p, [T.neg(zs[b]), O])
                    value = T.mul(value, T.sub(zs[a], zs[b]))
            p = [T.mul(v, T.mul(zs[22*a % 29], T.inv(value))) for v in p]
            assert len(p) == 15
            for b in nodes:
                got = Z
                for v in reversed(p):
                    got = T.add(T.mul(got, zs[b]), v)
                assert got == (zs[22*a % 29] if a == b else Z)
            rows.append(flat((T.sub(p[1], T.mul(lam, p[0])), T.neg(T.mul(k, p[0])), p[14])))
        target = flat(wanted)
        dual = separator(rows, target)
        results.append({'first_target': first, 'second_target': second, 'complement_mask': mask,
                        'nodes': nodes, 'ground_rows': rows, 'ground_target': target,
                        'annihilating_functional': dual, 'target_value': 1})
    assert len(results) == 2
    out = {'status': 'PASS', 'scope': 'Two final cases independently excluded by explicit F5-linear functionals; no assumption that marking coefficients are limited to0 or1 is needed.', 'certificates': results}
    (root/'constant_markings_independent.json').write_text(json.dumps(out, indent=2)+'\n')
    print('PASS: two direct Lagrange systems, both excluded even for arbitrary F5 marking weights.')


if __name__ == '__main__':
    main()
