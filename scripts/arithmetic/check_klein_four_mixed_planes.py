#!/usr/bin/env python3
"""Direct polynomial checks for the four-unused-location rank theorem.

The complete enumeration is separate C++ code. This checker reconstructs
every retained exceptional line and sample by division, and proves the
unique four-node exception has an inadmissible endpoint ratio.
"""
import argparse
import itertools
import json
import math
import random
import re
from pathlib import Path
import check_klein_four_constant_pencils as C

T, Z, O = C.T, C.Z, C.O


def nullspace(a, cols):
    a = [list(row) for row in a]
    pivots = []
    for j in range(cols):
        p = next((i for i in range(len(pivots), len(a)) if a[i][j] != Z), None)
        if p is None:
            continue
        r = len(pivots)
        a[r], a[p] = a[p], a[r]
        q = T.inv(a[r][j])
        a[r] = [T.mul(v, q) for v in a[r]]
        for i in range(len(a)):
            if i != r:
                q = a[i][j]
                a[i] = [T.sub(v, T.mul(q, w)) for v, w in zip(a[i], a[r])]
        pivots.append(j)
    out = []
    for j in range(cols):
        if j not in pivots:
            v = [Z]*cols
            v[j] = O
            for i, p in enumerate(pivots):
                v[p] = T.neg(a[i][j])
            out.append(v)
    return out, len(pivots)


def combination(rows, coeffs):
    v = [Z]*max(map(len, rows))
    for row, a in zip(rows, coeffs):
        for i, b in enumerate(row):
            v[i] = T.add(v[i], T.mul(a, b))
    return v


def evaluate(p, a):
    v = Z
    for b in reversed(p):
        v = T.add(T.mul(v, a), b)
    return v


def words(d, c):
    """Build W_d(C) by dividing monomials and imposing the actual gap."""
    qs, rs = [], []
    for i in range(d+1):
        q, r = C.divide([Z]*(22+i)+[O], c)
        qs.append(q)
        rs.append(r+[Z]*(len(c)-1-len(r)))
    mat = [[rs[j][i] for j in range(d+1)] for i in range(16+d, len(c)-1)]
    ts, _ = nullspace(mat, d+1)
    fs = [[C.scale(v, 2) for v in C.pm(c, combination(qs, t))] for t in ts]
    for i in range(16+d-(len(c)-1)):
        fs.append([Z]*i+c)
        ts.append([Z]*(d+1))
    for f, t in zip(fs, ts):
        assert all(v == Z for v in f[16+d:22])
        assert all((f[22+i] if 22+i < len(f) else Z) == C.scale(v, 2)
                   for i, v in enumerate(t))
        assert all(v == Z for v in C.divide(f, c)[1])
    return fs, ts


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    root = ap.parse_args().root
    log = (root/'mixed_plane_rank.log').read_text()
    samples = [(int(d), int(j), int(n)) for d, j, n in
               re.findall(r'^TRIPLE_SAMPLE d=(\d+) J_mask=(\d+) nodes_mask=(\d+)$', log, re.M)]
    high = [(int(d), int(j), int(n), int(k)) for d, j, n, k in
            re.findall(r'^HIGH_LINE d=(\d+) J_mask=(\d+) nodes_mask=(\d+) count=(\d+)$', log, re.M)]
    assert high == [(2, 81273, 6192, 4)]
    rng = random.Random(26092631)
    extra = [(d, sum(1 << i for i in rng.sample(range(29), 15-2*d)), None)
             for d in range(6) for _ in range(3)]
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    records = []
    for d, mask, node_mask in samples+[(2, 81273, 6192)]+extra:
        c = [O]
        for i in range(29):
            if not mask >> i & 1:
                c = C.pm(c, [T.neg(zs[i]), O])
        fs, ts = words(d, c)
        assert len(fs) == 3
        rows = {i: [T.sub(evaluate(f, zs[i]), T.mul(zs[22*i % 29], evaluate(t, zs[i])))
                    for f, t in zip(fs, ts)] for i in range(29) if mask >> i & 1}
        for a, b in itertools.combinations(rows, 2):
            assert nullspace([rows[a], rows[b]], 3)[1] == 2
        if node_mask is not None:
            ns = [i for i in rows if node_mask >> i & 1]
            ker, rank = nullspace([rows[i] for i in ns], 3)
            assert rank == 2 and len(ker) == 1
            all_nodes = sum(1 << i for i, row in rows.items()
                            if sum_field(T.mul(a, b) for a, b in zip(row, ker[0])) == Z)
            assert all_nodes == node_mask
        record = {'d': d, 'complement_mask': mask, 'node_mask': node_mask}
        if (d, mask, node_mask) == (2, 81273, 6192):
            low_f, low_t = combination(fs, ker[0]), combination(ts, ker[0])
            scale = T.inv(low_t[-1])
            low_f = [T.mul(v, scale) for v in low_f]
            low_t = [T.mul(v, scale) for v in low_t]
            assert low_t[0] != Z
            r = T.mul(low_f[0], T.inv(low_t[0]))
            s = T.mul(T.sub(T.mul(low_f[1], low_t[0]), T.mul(low_f[0], low_t[1])),
                      T.inv(T.mul(low_t[0], low_t[0])))
            norm = C.power(r, 29)
            assert any(norm[1:])
            upper_f, upper_t = words(3, c)
            assert len(upper_f) == 5
            upper_rows = [[T.sub(evaluate(f, zs[i]), T.mul(zs[22*i % 29], evaluate(t, zs[i])))
                           for f, t in zip(upper_f, upper_t)] for i in ns]
            upper_ker, upper_rank = nullspace(upper_rows, 5)
            assert upper_rank == 3 and len(upper_ker) == 2
            for coeffs in upper_ker:
                f, t = combination(upper_f, coeffs), combination(upper_t, coeffs)
                q, rem = C.divide(t, low_t)
                assert all(v == Z for v in rem) and len(q) <= 2
                product = C.pm(low_f, q)
                n = max(len(product), len(f))
                assert product+[Z]*(n-len(product)) == f+[Z]*(n-len(f))
            record.update({'lower_T': low_t, 'lower_F': low_f, 'r': r, 's': s,
                           'r_to_29': norm, 'upper_rank': upper_rank,
                           'upper_kernel_common_linear_factor': True})
        records.append(record)
    totals = []
    for line in log.splitlines():
        if line.startswith('TOTAL '):
            row = {k: int(v) for k, v in re.findall(r'(\w+)=(\d+)', line)}
            assert row['covered'] == row['normalized_subsets'] == math.comb(28, 14-2*row['d'])
            totals.append(row)
    assert [r['d'] for r in totals] == list(range(6))
    assert sum(r['high_lines'] for r in totals) == 1
    result = {'status': 'PASS', 'scope': 'Direct polynomial reconstruction of every retained line sample, the unique four-node exception and18 additional kernels. Complete coverage is the separate C++ enumeration.',
              'complete_totals': totals, 'checks': records}
    (root/'mixed_planes_independent.json').write_text(json.dumps(result, indent=2)+'\n')
    print('PASS:', len(records), 'direct word spaces; exceptional upper kernel has fixed inadmissible endpoint ratio.')


def sum_field(values):
    v = Z
    for a in values:
        v = T.add(v, a)
    return v


if __name__ == '__main__':
    main()
