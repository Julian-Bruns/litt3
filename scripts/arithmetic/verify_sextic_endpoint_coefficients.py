#!/usr/bin/env python3
"""Exact root-character projection used to restrict the sextic scalar."""
import argparse
import functools
import hashlib
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent / 'pro_mixed_quintic_20260927/src'))
from exact import F, Extension, evaluate, determinant


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    modulus = [5, 2, 6, 7, 1]
    field = Extension(modulus)
    alpha = field.element([0, 1])
    roots = [field.pow(alpha, 25**i) for i in range(4)]
    values = []
    for row in ([22, 7, 9, 23], [1, 3, 8, 15]):
        values.append([evaluate([field.embed(c) for c in row], a, field)
                       for a in roots])
    matrix = [[v[j] for v in values[0]] for j in range(1, 4)]
    det = determinant([row[:3] for row in matrix])
    assert det == 9
    assert all(functools.reduce(F.add, row, 0) == 0 for row in matrix)
    assert all(any(v[j] for j in range(1, 4)) for vs in values for v in vs)
    result = {
        'status': 'PASS', 'A_monic': modulus,
        'c_values': values[0], 'e_values': values[1],
        'nonconstant_c_matrix': matrix, 'first_three_column_determinant': det,
        'kernel': 'span of (1,1,1,1) over F25',
        'all_c_and_e_values_outside_F25': True,
        'source_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'arithmetic_source_sha256': hashlib.sha256(
            (Path(__file__).parent / 'pro_mixed_quintic_20260927/src/exact.py').read_bytes()
        ).hexdigest(),
    }
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
