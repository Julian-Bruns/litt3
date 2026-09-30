#!/usr/bin/env python3
"""Independent Lagrange and F5 certificates for all degree14 markings."""
import argparse
import json
from pathlib import Path
import check_klein_four_constant_pencils as C
from check_klein_four_constant_markings import flat, separator

T, Z, O = C.T, C.Z, C.O


def weights_for(rows, target):
    n = len(rows)
    assert len(target) == n and all(len(row) == n for row in rows)
    a = [[rows[j][i] for j in range(n)]+[target[i]] for i in range(n)]
    for j in range(n):
        p = next(i for i in range(j, n) if a[i][j])
        a[j], a[p] = a[p], a[j]
        q = pow(a[j][j], -1, 5)
        a[j] = [q*v % 5 for v in a[j]]
        for i in range(n):
            if i != j:
                q = a[i][j]
                a[i] = [(v-q*w) % 5 for v, w in zip(a[i], a[j])]
    out = [row[-1] for row in a]
    assert all(sum(out[j]*rows[j][i] for j in range(n)) % 5 == target[i] for i in range(n))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    root = ap.parse_args().root
    data = json.loads((root/'degree14_markings.json').read_text())
    assert data['candidates'] == 8 and data['marked_matches'] == 0
    ts = json.loads((root/'linear_pencil_targets.json').read_text())['targets']
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    results = []
    for old in data['checks']:
        mask, first, second = old['complement_mask'], old['first_target'], old['second_target']
        nodes = [a for a in range(29) if not mask >> a & 1]
        d = [O]
        for a in nodes:
            d = C.pm(d, [T.neg(zs[a]), O])
        q, _ = C.divide([Z]*22+[O], d)
        p, alpha, gamma = T.inv(d[0]), T.mul(d[1], T.inv(d[0])), d[13]
        lam, nu, tr, cn = map(tuple, ts[first])
        k = T.mul(p, T.sub(lam, alpha))
        shift0 = T.sub(T.mul(p, nu), C.scale(q[1], 2))
        if second is None:
            assert k == Z
            wanted = (T.neg(shift0),)
        else:
            lam2, nu2, tr2, cn2 = map(tuple, ts[second])
            assert k != Z and T.mul(T.sub(lam2, gamma), T.sub(lam, alpha)) == O
            shift = C.scale(T.sub(tr2, T.mul(k, tr)), 3)
            assert cn2 == T.sub(T.sub(T.mul(T.mul(k, k), cn), T.mul(T.mul(k, tr), shift)), T.mul(shift, shift))
            wanted = (T.sub(shift, shift0), T.add(T.sub(nu2, T.mul(T.sub(gamma, lam2), shift)), C.scale(q[0], 2)))
        rows = []
        for a in nodes:
            poly, value = [O], O
            for b in nodes:
                if b != a:
                    poly = C.pm(poly, [T.neg(zs[b]), O])
                    value = T.mul(value, T.sub(zs[a], zs[b]))
            poly = [T.mul(v, T.mul(zs[22*a % 29], T.inv(value))) for v in poly]
            assert len(poly) == 14
            for b in nodes:
                value = Z
                for v in reversed(poly):
                    value = T.add(T.mul(value, zs[b]), v)
                assert value == (zs[22*a % 29] if a == b else Z)
            effect = (T.neg(T.mul(p, T.sub(poly[1], T.mul(alpha, poly[0])))), T.neg(T.mul(p, poly[0])))
            rows.append(flat(effect[:len(wanted)]))
        target = flat(wanted)
        item = {'complement_mask': mask, 'first_target': first, 'second_target': second,
                'nodes': nodes, 'ground_rows': rows, 'ground_target': target}
        if second is None:
            coeffs = weights_for(rows, target)
            assert any(c not in (0, 1) for c in coeffs)
            item['unique_F5_weights'] = coeffs
            print('ZERO_BOUNDARY', mask, first, coeffs)
        else:
            item['annihilating_functional'] = separator(rows, target)
            item['target_value'] = 1
        results.append(item)
    assert sum(r['second_target'] is None for r in results) == 2
    out = {'status': 'PASS', 'scope': 'All6 nonzero endpoint pairs have F5-linear separating certificates. Both zero-ratio boundaries have unique F5 weights, not binary. Lagrange rows reconstructed directly.', 'certificates': results}
    (root/'degree14_markings_independent.json').write_text(json.dumps(out, indent=2)+'\n')
    print('PASS: all8 mixed degree14 endpoint cases independently excluded.')


if __name__ == '__main__':
    main()
