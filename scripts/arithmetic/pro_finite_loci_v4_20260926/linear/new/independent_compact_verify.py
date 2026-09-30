#!/usr/bin/env python3
"""Independent tower-arithmetic checks of compact V and the leading mu term.

This is not a verification that any full residual is square. It uses the
standard-library field operations from the baseline independent verifier,
not the logarithm-table C++ implementation.
"""
import json
from pathlib import Path
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
from independent_verify import add, neg, mul, power, pmul  # noqa: E402


def polynomial_power(p, n):
    result = [1]
    while n:
        if n & 1:
            result = pmul(result, p)
        p = pmul(p, p)
        n //= 2
    return result


def read_rows(path, nr, nc):
    data = path.read_bytes()
    assert len(data) == 8 + 4 * nr * nc, (path, 'length')
    assert struct.unpack_from('<II', data) == (nr, nc), (path, 'shape')
    coeffs = struct.unpack_from('<' + str(nr * nc) + 'I', data, 8)
    assert all(c < 390625 for c in coeffs), (path, 'field code')
    return [coeffs[i * nc:(i + 1) * nc] for i in range(nr)]


def main():
    # Literal tower code of epsilon=[24]+[4]alpha+[23]alpha^3.
    epsilon = 24 + 25 * 4 + 15625 * 23
    scalar = power(neg(mul(mul(2, 24), power(epsilon, 5))), 3)
    assert scalar == 240386
    assert mul(scalar, scalar) == 242747
    print('PASS: independent leading scalar codes 240386 and its square 242747.')
    roots = [row['r'] for row in json.loads((ROOT / 'global/summary.json').read_text())['roots']]
    for r in roots:
        folder = ROOT / 'global' / f'r{r}'
        pivot = json.loads((folder / 'summary.json').read_text())['pivot']
        V = read_rows(folder / 'leading_scale_V.bin', 7, 1040)
        # [x^64]V=s*b^4*(b-pivot^5)^3.
        top = [0] * 4 + [mul(scalar, a) for a in polynomial_power([neg(power(pivot, 5)), 1], 3)]
        for u in range(7):
            for b in range(16):
                expected = top[b] if u == 0 and b < len(top) else 0
                assert V[u][65 * b + 64] == expected, (r, u, b, 'V top')
        assert sum(c != 0 for row in V for c in row) == 4475, (r, 'term count')
        record = json.loads((folder / 'leading_scale_verification.json').read_text())
        assert record['all_global_coefficients_verified'] is True
        print(f'r={r}: independent compact format, term count, and complete x^64 coefficient PASS.')
    # Independent coefficient-level check of the retained N_9 leading mu term.
    folder = ROOT / 'global/r9'
    pivot = json.loads((folder / 'summary.json').read_text())['pivot']
    expected = [0] * 50 + [mul(242747, a) for a in polynomial_power([neg(pivot), 1], 36)]
    for h in range(73):
        data = (folder / f'N_H_{h}.bin').read_bytes()
        assert len(data) == 8 + 4 * 181 * 987
        assert struct.unpack_from('<II', data) == (181, 987)
        for q in range(181):
            actual, = struct.unpack_from('<I', data, 8 + 4 * (987 * q + 6 * 141 + 132))
            want = expected[q] if h == 0 and q < len(expected) else 0
            assert actual == want, (h, q, 'N leading mu/x coefficient')
    print('r=9: all coefficients of [mu^6 x^132]N=242747*q^50*(q-pivot)^36 PASS.')
    print('No square point, global ideal certificate, or new ratio exclusion is asserted.')


if __name__ == '__main__':
    main()
