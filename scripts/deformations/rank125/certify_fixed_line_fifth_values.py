#!/usr/bin/env python3
"""Check the executed whole fifth receipts and their affine consequence.

This audits receipt consistency and independent elementary field arithmetic;
the whole-tuple computation and its mathematical audit remain inputs.
"""
import argparse
import hashlib
import json
from pathlib import Path


def add(x, y):
    return sum(((x // 5**i + y // 5**i) % 5) * 5**i for i in range(3))


def neg(x):
    return sum((-(x // 5**i) % 5) * 5**i for i in range(3))


def mul(x, y):
    c = [0] * 5
    for i in range(3):
        for j in range(3):
            c[i+j] += (x // 5**i % 5) * (y // 5**j % 5)
    for i in (4, 3):
        c[i-2] -= c[i]
        c[i-3] -= c[i]
    return sum((c[i] % 5) * 5**i for i in range(3))


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--data-dir', type=Path, required=True)
    ap.add_argument('--engine-dir', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    root = Path(__file__).resolve().parents[3]
    assert not args.output.resolve().is_relative_to(root)
    names = ['lambda0_N3200_v0_b1.json', 'lambda1_N3200_v0_b1.json',
             'lambda0_N3600_v1_b1.json']
    cases = [json.loads((args.data_dir / n).read_text()) for n in names]
    summaries = []
    for name, d in zip(names, cases):
        assert d['source_modulus'] == 3125 and d['flat_modulus'] == 625
        assert d['source4_response_checked'] and d['normal4_zero']
        assert d['independent_two_trace_equal']
        assert d['rho5_precision'] >= 150 and d['second_primitive_precision'] >= 60
        assert d['projection5']['minimum_normal_precision'] >= 2
        assert d['normal4_projection_minimum_precision'] >= 2
        assert d['fifth_scalar'] == d['E5'][3]
        checks = {(r['label'], r['modulus']) for r in d['checks']}
        for ij in ('00', '01', '10', '11'):
            for label, m in [('complete corrected first jet ', 25),
                             ('complete corrected second jet ', 125),
                             ('complete inverse-Cartier horizontality ', 625)]:
                assert (label + ij, m) in checks
        assert all(r['precision'] >= 30 for r in d['checks'])
        for file, digest in d['source_sha256'].items():
            path = (Path(__file__).with_name(file) if file == 'compare_fifth_fixed_line.py'
                    else args.engine_dir / file)
            assert hashlib.sha256(path.read_bytes()).hexdigest() == digest, file
        summaries.append({
            'receipt': name, 'sha256': hashlib.sha256((args.data_dir/name).read_bytes()).hexdigest(),
            'lambda': d['lambda_code'], 'scalar': d['fifth_scalar'],
            'rho5_precision': d['rho5_precision'],
            'second_formal_precision': d['second_primitive_precision'],
            'second_affine_terms': sum(len(x['terms']) for x in d['second_affine']),
            'checks': len(d['checks']), 'E5': d['projection5']['scalar_nonzero']})
    assert cases[0]['E5'] == cases[2]['E5']
    assert all(d['source_sha256'] == cases[0]['source_sha256'] for d in cases)
    b = cases[0]['fifth_scalar']
    a = add(cases[1]['fifth_scalar'], neg(b))
    assert (a, b) == (25, 56)
    inverse = next(c for c in range(1, 125) if mul(a, c) == 1)
    zero = mul(neg(b), inverse)
    assert zero == 8 and add(b, mul(a, zero)) == 0
    report = {'status': 'PASS', 'scope': 'Receipt consistency and affine consequence; whole comparison and affinity are separately audited inputs',
              'a': a, 'b': b, 'unique_lambda': zero, 'cases': summaries,
              'changed_frobenius_complete_vector_equal': True,
              'source_sha256': cases[0]['source_sha256']}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('PASS: a=[25], b=[56], unique zero=[8]; all three whole comparison receipts agree with their sources')


if __name__ == '__main__':
    main()
