#!/usr/bin/env python3
"""Exact two-endpoint test for a degree15 mixed interpolation divisor.

The first nonrational endpoint is normalized to the established142 targets.
The other endpoint uses their full3364-element symmetry closure. The old
complete slope subset scan supplies45 complementary root sets. Every
zero/mixed marking of the15 remaining nodes is tested by subset sums.
"""
import argparse
import json
import re
from pathlib import Path
import check_klein_four_constant_pencils as C

T, Z, O = C.T, C.Z, C.O


def evaluate(p, a):
    v = Z
    for b in reversed(p):
        v = T.add(T.mul(v, a), b)
    return v


def triplesums(values):
    out = [((Z, Z, Z), 0)]
    for j, row in enumerate(values):
        out += [(tuple(T.add(x, y) for x, y in zip(v, row)), m | 1 << j) for v, m in out[:]]
    return out


def ground_vector(row):
    return [b for a in row for c in a for b in (c % 5, c // 5)]


def ground_rank(rows):
    a = [list(r) for r in rows]
    rank = 0
    for j in range(len(a[0])):
        p = next((i for i in range(rank, len(a)) if a[i][j]), None)
        if p is None:
            continue
        a[rank], a[p] = a[p], a[rank]
        inv = pow(a[rank][j], -1, 5)
        a[rank] = [x*inv % 5 for x in a[rank]]
        for i in range(len(a)):
            if i != rank:
                c = a[i][j]
                a[i] = [(x-c*y) % 5 for x, y in zip(a[i], a[rank])]
        rank += 1
    return rank


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    root = ap.parse_args().root
    base = json.loads((root/'constant_pencil_targets.json').read_text())['nonrational_targets']
    targets = json.loads((root/'linear_pencil_targets.json').read_text())['targets']
    hits = re.findall(r'^SUM target=(\d+) complement_mask=(\d+)$',
                      (root/'constant_pencil_subsets.log').read_text(), re.M)
    assert len(hits) == 45
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    records = []
    for first, mask in hits:
        first, mask = int(first), int(mask)
        lam, nu, trace, constant = [tuple(base[first][k]) for k in
                                   ('slope', 'intercept', 'minimal_trace', 'minimal_constant')]
        nodes = [i for i in range(29) if not mask >> i & 1]
        d = [O]
        for i in nodes:
            d = C.pm(d, [T.neg(zs[i]), O])
        assert len(d) == 16 and lam == T.mul(d[1], T.inv(d[0]))
        gamma = d[14]
        q, _ = C.divide([Z]*22+[O], d)
        f = [C.scale(v, 2) for v in C.pm(d, q)]
        k = T.inv(d[0])
        nu0 = T.sub(f[1], T.mul(lam, f[0]))
        nu_inf0 = T.sub(f[14], T.mul(gamma, f[15]))
        shift0 = T.sub(f[15], T.mul(k, f[0]))
        der = [C.scale(v, i % 5) for i, v in enumerate(d)][1:]
        weights = []
        for i in nodes:
            inv = T.inv(evaluate(der, zs[i]))
            weights.append(tuple(T.mul(zs[(a*i) % 29], inv) for a in (20, 21, 22)))
        low = {}
        for v, m in triplesums(weights[:7]):
            low.setdefault(v, []).append(m)
        high = triplesums(weights[7:])
        for second, row in enumerate(targets):
            lam2, nu2, trace2, constant2 = map(tuple, row)
            if lam2 != gamma:
                continue
            shift = C.scale(T.sub(trace2, T.mul(k, trace)), 3)
            predicted = T.sub(T.sub(T.mul(T.mul(k, k), constant),
                                     T.mul(T.mul(k, trace), shift)), T.mul(shift, shift))
            record = {'first_target': first, 'second_target': second, 'complement_mask': mask,
                      'minimal_polynomial_compatible': predicted == constant2, 'mixed_masks': []}
            if predicted == constant2:
                wanted = (T.mul(k, T.sub(nu0, nu)), T.sub(shift, shift0), T.sub(nu2, nu_inf0))
                ground = list(map(ground_vector, weights))
                record['ground_span_rank'] = ground_rank(ground)
                record['ground_augmented_rank'] = ground_rank(ground+[ground_vector(wanted)])
                record['ground_rows'] = ground
                record['ground_target'] = ground_vector(wanted)
                for v, m in high:
                    need = tuple(T.sub(x, y) for x, y in zip(wanted, v))
                    for m0 in low.get(need, []):
                        selected = m0 | m << 7
                        record['mixed_masks'].append(sum(1 << nodes[j] for j in range(15) if selected >> j & 1))
            records.append(record)
        print('DONE', first, mask, 'cumulative matches', sum(len(r['mixed_masks']) for r in records), flush=True)
    out = {'status': 'exact_necessary_test', 'scope': __doc__, 'first_slope_sets': len(hits),
           'both_slope_pairs': len(records), 'minimal_polynomial_pairs': sum(r['minimal_polynomial_compatible'] for r in records),
           'marked_matches': sum(len(r['mixed_masks']) for r in records), 'checks': records}
    (root/'constant_marked_pencils.json').write_text(json.dumps(out, indent=2)+'\n')
    print({k: v for k, v in out.items() if k not in ('checks', 'scope')})


if __name__ == '__main__':
    main()
