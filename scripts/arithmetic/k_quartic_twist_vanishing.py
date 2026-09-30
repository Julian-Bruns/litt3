#!/usr/bin/env python3
"""Exact Sym^12 K vanishing; all generated evidence goes to --output.

Reuses the accepted full Cech reconstruction. Independently checks ranks
after restriction of scalars to F5. No finite-point search is involved.
"""
import argparse
import json
from pathlib import Path

import pro_quadratic_twist_vanishing as q


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    columns, rows, matrix = q.system(12)
    assert (len(rows), len(columns)) == (248, 222)
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
        rank5 = q.prime_field_rank(block)
        assert determinant and rank5 == 2*len(ci)
        assert all(matrix[i][j] == 0 for i in range(len(rows)) for j in ci
                   if (rows[i][1]-rows[i][0]) % 3 != weight)
        row = dict(weight=weight, columns=[columns[i] for i in ci],
                   selected_rows=[rows[i] for i in selected], minor=minor,
                   determinant_code=determinant, rank_F5=rank5,
                   block_dimensions=[len(ri), len(ci)])
        blocks.append(row)
        print({k: row[k] for k in ('weight', 'block_dimensions',
                                   'determinant_code', 'rank_F5')}, flush=True)
    rank25 = len(q.rref(matrix)[1])
    assert rank25 == 222
    data = dict(power=12, twist=0, P_codes=q.P, C_codes=q.C,
                columns=columns, rows=rows, matrix=matrix, blocks=blocks,
                rank_F25=rank25, rank_F5=sum(b['rank_F5'] for b in blocks),
                scope='Full geometric section space of the actual bundle; '
                      'no claim about fifth or higher all-twist powers.')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(data, separators=(',', ':'))+'\n')
    print('CERTIFIED H0(Sym^12 K)=0; ranks F25=222, F5=444.')


if __name__ == '__main__':
    main()
