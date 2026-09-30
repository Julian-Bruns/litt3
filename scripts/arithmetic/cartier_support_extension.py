#!/usr/bin/env python3
"""Exact continuation of the six-missed-point scalar Cartier test.

This only computes downstairs differential spaces. It does not construct
or exclude a finite etale cover without the separate trace argument.
"""
import argparse
from collections import Counter
import itertools
import json
from pathlib import Path
import sys
import time

ap = argparse.ArgumentParser()
ap.add_argument('--archive', type=Path, required=True)
ap.add_argument('--output', type=Path, required=True)
ap.add_argument('--sizes', type=int, nargs='+', default=[5, 4, 3, 2, 1])
args = ap.parse_args()
sys.path.insert(0, str(args.archive / 'src'))
import numpy as np
import cartier_test as ct
import field as f

start = time.monotonic()
M = ct.cartier_matrix()
jets = ct.all_jets(ct.geometric_points())
out = {'scope': 'downstairs scalar Cartier spaces only', 'sizes': {}}
for size in args.sizes:
    masks = [sum(1 << i for i in ii)
             for ii in itertools.combinations(range(13), size)]
    orbits = {mask: min(ct.rot(mask, j) for j in range(12))
              for mask in masks}
    records = {}
    for mask in sorted(set(orbits.values())):
        J = np.vstack([jets[i] for i in range(13) if mask >> i & 1])
        R, piv = f.row_reduce(J)
        R = R[:len(piv)]
        dims = [21 - len(piv)]
        stages = []
        for iteration in range(22):
            nxt = np.vstack((R, f.mpow_entries(f.matmul(R, M), 5)))
            red, piv = f.row_reduce(nxt)
            stages.append({'constraints': R.tolist(),
                           'pivot_columns': piv.tolist()})
            R = red[:len(piv)]
            dims.append(21 - len(piv))
            if dims[-1] == 0 or dims[-1] == dims[-2]:
                break
        else:
            raise AssertionError('descending sequence did not stabilize')
        K = f.kernel(R)
        assert K.shape[1] == dims[-1]
        assert not np.any(f.matmul(J, K))
        if K.shape[1]:
            # C preserves the claimed terminal kernel, checked directly.
            CK = f.matmul(M, f.mpow_entries(K, f.ORDER // 5))
            assert not np.any(f.matmul(R, CK))
        invertible = K
        image_dims = [K.shape[1]]
        for _ in range(22):
            CK = f.matmul(M, f.mpow_entries(invertible, f.ORDER // 5))
            rr, pp = f.row_reduce(CK.T)
            invertible = rr[:len(pp)].T.copy()
            image_dims.append(len(pp))
            if len(pp) == image_dims[-2]:
                break
        else:
            raise AssertionError('Cartier images did not stabilize')
        records[mask] = {'dimensions': dims, 'stages': stages,
                         'terminal_constraints': R.tolist(),
                         'terminal_kernel': K.tolist(),
                         'image_dimensions': image_dims,
                         'invertible_kernel': invertible.tolist()}
    counts = Counter(tuple(records[orbits[m]]['dimensions']) for m in masks)
    out['sizes'][size] = {'all_masks': orbits, 'records': records,
                         'dimension_counts': {str(k): v for k, v in sorted(counts.items())}}
    print('missed', size, 'subsets', len(masks), 'orbits', len(records),
          'dimension chains', dict(sorted(counts.items())), flush=True)
    fixed_counts = Counter(records[orbits[m]]['image_dimensions'][-1]
                           for m in masks)
    print('Cartier-bijective dimensions', dict(sorted(fixed_counts.items())),
          flush=True)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(out, indent=2) + '\n')
print('seconds', round(time.monotonic() - start, 3), flush=True)
