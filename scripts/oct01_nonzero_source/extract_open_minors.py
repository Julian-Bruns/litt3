#!/usr/bin/env python3
"""Extract exact maximal minor witnesses from retained necessary-test matrices."""
import argparse
import json
import sys
from pathlib import Path
import numpy as np

ARCHIVE = Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0, str(ARCHIVE/'src'))
from exact import Field


def determinant(k, matrix):
    a = np.array(matrix, dtype=np.uint32, copy=True)
    assert a.shape[0] == a.shape[1]
    value = 1
    for j in range(a.shape[0]):
        rows = np.flatnonzero(a[j:, j])
        if not len(rows):
            return 0
        row = j + int(rows[0])
        if row != j:
            a[[j, row]] = a[[row, j]]
            value = k.neg(value)
        pivot = int(a[j, j])
        value = k.mul(value, pivot)
        a[j] = k.mulv(a[j], k.inv(pivot))
        rows = np.flatnonzero(a[j+1:, j]) + j + 1
        if len(rows):
            factors = k.mulv(a[rows, j], 4)
            a[rows] = k.addv(a[rows], k.mulv(factors[:, None], a[j][None, :]))
    return value


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--work', type=Path, required=True)
    args = ap.parse_args()
    k = Field(args.work/'cache')
    results = []
    for name in ('quadratic_torsion_d10_m3_seed1.json',
                 'quadratic_torsion_d10_m3_seed2.json',
                 'quadratic_torsion_d0_m12_seed1.json'):
        data = json.loads((args.work/'data'/name).read_text())
        matrix = np.array(data['matrix'], dtype=np.uint32)
        _, columns = k.rref(matrix)
        _, rows = k.rref(matrix[:, columns].T)
        assert len(columns) == len(rows) == 207
        minor = matrix[np.ix_(rows, columns)]
        det = determinant(k, minor)
        assert det
        results.append({
            'input': name, 'd': data['d'], 'm': data['m'],
            'seed': data['seed'], 'size': 207,
            'row_indices': rows, 'column_indices': columns,
            'determinant_K_code': det,
            'quadratic_columns': data['quadratic_coordinates'],
            'trace_auxiliary_columns': data['eta_coordinates'],
            'scope': 'Nonvanishing minor at the recorded coefficient specialization; rational matrix continuation gives a nonempty coefficient-open exclusion, not the closed rank-drop locus.',
        })
    output = args.work/'data'/'quadratic_trace_open_minors.json'
    output.write_text(json.dumps(results, separators=(',', ':'))+'\n')
    print(json.dumps([{key: item[key] for key in ('input', 'size', 'determinant_K_code')} for item in results]))


if __name__ == '__main__':
    main()
