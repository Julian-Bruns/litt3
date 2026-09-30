#!/usr/bin/env python3
"""Reconstruct every exceptional mixed-node pair by direct polynomial kernels."""
import argparse
import itertools
import json
import math
import random
import re
from pathlib import Path
import check_klein_four_pencil_boundary as B
C, T, Z, O = B.C, B.T, B.Z, B.O


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    args = ap.parse_args()
    log0 = (args.root/'constant_mixed_rank.log').read_text()
    log = (args.root/'mixed_pencil_rank.log').read_text()
    expected = {}
    for mask, a, b in re.findall(r'^COLLISION J_mask=(\d+) nodes=(\d+),(\d+) value=', log0, re.M):
        expected.setdefault((0, int(mask)), set()).add((int(a), int(b)))
    for d, mask, a, b in re.findall(r'^COLLISION d=(\d+) J_mask=(\d+) nodes=(\d+),(\d+)$', log, re.M):
        expected.setdefault((int(d), int(mask)), set()).add((int(a), int(b)))
    assert sum(map(len, expected.values())) == 378
    rng = random.Random(260927)
    extra = {(d, sum(1<<i for i in rng.sample(range(29), 14-2*d)))
             for d in range(6) for _ in range(4)}
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]

    def evaluate(poly, a):
        ans = Z
        for c in reversed(poly):
            ans = T.add(T.mul(ans, a), c)
        return ans

    records = []
    for d, mask in sorted(set(expected) | extra):
        c = [O]
        for i in range(29):
            if not mask>>i&1:
                c = C.pm(c, [T.neg(zs[i]), O])
        if d == 0:
            q, rem = C.divide([Z]*22+[O], c)
            ts = [[Z], [O]]
            fs = [c, [C.scale(v, 2) for v in C.pm(c, q)]]
        else:
            qs, rs = [], []
            for i in range(d+1):
                q, rem = C.divide([Z]*(22+i)+[O], c)
                qs.append(q)
                rs.append(rem+[Z]*(len(c)-1-len(rem)))
            mat = [[rs[j][k] for j in range(d+1)] for k in range(16+d, len(c)-1)]
            mat.append([O]+[Z]*d)
            mat.append([C.scale(T.mul(c[0], q[0] if q else Z), 2) for q in qs])
            ts = [B.solve(mat, [Z]*(d-1)+[O, Z]), B.solve(mat, [Z]*(d-1)+[Z, O])]
            fs = []
            for row in ts:
                q = [Z]*max(map(len, qs))
                for scalar, part in zip(row, qs):
                    for i, v in enumerate(part):
                        q[i] = T.add(q[i], T.mul(scalar, v))
                fs.append([C.scale(v, 2) for v in C.pm(c, q)])
        for f, t in zip(fs, ts):
            assert all(v == Z for v in f[16+d:22])
            assert all((f[22+i] if 22+i < len(f) else Z) == C.scale(v, 2) for i, v in enumerate(t))
        rows = {}
        for i in range(29):
            if mask>>i&1:
                rows[i] = tuple(T.sub(evaluate(f, zs[i]), T.mul(zs[22*i % 29], evaluate(t, zs[i])))
                                for f, t in zip(fs, ts))
                assert rows[i] != (Z, Z)
        pairs = set()
        for a, b in itertools.combinations(rows, 2):
            if T.mul(rows[a][0], rows[b][1]) == T.mul(rows[a][1], rows[b][0]):
                pairs.add((a, b))
        if (d, mask) in expected:
            assert pairs == expected[(d, mask)], (d, mask, pairs, expected[(d, mask)])
        for a, b, c0 in itertools.combinations(rows, 3):
            assert not ({(a, b), (a, c0), (b, c0)} <= pairs)
        records.append({'d': d, 'complement_mask': mask, 'pairs': sorted(pairs)})

    totals = []
    for line in log.splitlines():
        if line.startswith('TOTAL '):
            row = {k: int(v) for k, v in re.findall(r'(\w+)=(\d+)', line)}
            assert row['covered'] == row['normalized_subsets'] == math.comb(28, 13-2*row['d'])
            assert row['triple_collisions'] == row['zero_rows'] == 0
            assert row['max_same_direction'] <= 2
            totals.append(row)
    assert [t['d'] for t in totals] == list(range(1, 6))
    assert 'collision_masks=240 collision_pairs=240' in log0
    result = {'status': 'PASS', 'scope': 'All378 exceptional pairs independently reconstructed, plus24 bounded additional kernels. Complete enumeration remains the separate C++ logs.',
              'polynomial_kernels': len(records), 'complete_totals': totals, 'checks': records}
    (args.root/'mixed_rank_independent.json').write_text(json.dumps(result, indent=2)+'\n')
    print('PASS:', len(records), 'direct kernels, including all378 mixed-node collision pairs; no triple direction.')


if __name__ == '__main__':
    main()
