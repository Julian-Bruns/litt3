#!/usr/bin/env python3
"""Exact Sym^9 K certificate extending the supplied Sym^6 reconstruction.

Run with an explicit external --output path. The rank over F5 is checked
after restriction of scalars, independently of F25 elimination.
"""
import argparse
import json
from pathlib import Path

import pro_quadratic_twist_vanishing as q


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    columns, rows, matrix = q.system(9)
    assert (len(rows), len(columns)) == (158, 123)
    blocks = []
    for weight in range(3):
        ci = [j for j, (i, r, m) in enumerate(columns) if (r-i) % 3 == weight]
        ri = [j for j, (i, r, m) in enumerate(rows) if (r-i) % 3 == weight]
        block = [[matrix[i][j] for j in ci] for i in ri]
        _, pivots = q.rref([list(t) for t in zip(*block)])
        assert len(pivots) == len(ci)
        selected = [ri[i] for i in pivots]
        minor = [[matrix[i][j] for j in ci] for i in selected]
        determinant = q.determinant(minor)
        assert determinant != 0
        assert all(matrix[i][j] == 0 for i in range(len(rows))
                   for j in ci if (rows[i][1]-rows[i][0]) % 3 != weight)
        blocks.append({'weight': weight, 'columns': [columns[i] for i in ci],
                       'selected_rows': [rows[i] for i in selected],
                       'minor': minor, 'determinant_code': determinant,
                       'block_dimensions': [len(ri), len(ci)]})
        print('Weight', weight, 'block', len(ri), 'x', len(ci),
              'minor determinant code', determinant)
    rank25 = len(q.rref(matrix)[1])
    rank5 = q.prime_field_rank(matrix)
    assert (rank25, rank5) == (123, 246)
    data = {'power': 9, 'twist': 0, 'P_codes': q.P, 'C_codes': q.C,
            'columns': columns, 'rows': rows, 'matrix': matrix,
            'blocks': blocks, 'rank_F25': rank25, 'rank_F5': rank5}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(data, indent=2)+'\n')
    print('CERTIFIED: H^0(Sym^9 K)=0; ranks F25=123, F5=246.')


if __name__ == '__main__':
    main()
