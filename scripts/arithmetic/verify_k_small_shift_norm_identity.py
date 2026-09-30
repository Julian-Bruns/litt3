#!/usr/bin/env python3
"""Replay the K(2O) norm certificate by elementary finite-field arithmetic.

Reconstruct all binary cubic coefficients, check the full linear matrix,
reconstruct each prime-field equation, and multiply the identity for one.
No computer-algebra package or Groebner-basis routine is used.
"""
import argparse
import hashlib
import json
from itertools import combinations_with_replacement
from math import factorial
from pathlib import Path

import pro_quadratic_twist_vanishing as q
from verify_k_shifted_norm_identities import add_term, product, read


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('source', type=Path)
    ap.add_argument('net', type=Path)
    ap.add_argument('matrix', type=Path)
    ap.add_argument('certificate', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    source = json.loads(args.source.read_text())['sections']
    net = json.loads(args.net.read_text())['sections']
    matrix = json.loads(args.matrix.read_text())
    cert = json.loads(args.certificate.read_text())
    assert [s['C3_character'] for s in source] == [0, 1, 1, 1]
    assert [s['C3_character'] for s in net] == [0, 0, 0]
    p = [read(source[0], i) for i in range(2)]
    qs = [[read(s, i) for i in range(2)] for s in source[1:]]
    gs = [[read(s, i) for i in range(4)] for s in net]
    cols = [product([p, p, p])]
    exponents = [(0,)*6]
    signs = [1]
    for inds in combinations_with_replacement(range(3), 3):
        counts = tuple(inds.count(i) for i in range(3))
        scale = factorial(3)
        for count in counts:
            scale //= factorial(count)
        cols.append([q.add({}, f, scale % 5) for f in product([qs[i] for i in inds])])
        exponents.append(counts+(0, 0, 0))
        signs.append(1)
    for i, v in enumerate(qs):
        wedge = q.add(q.multiply(p[0], v[1]), q.multiply(p[1], v[0]), 4)
        assert all(r == 0 and 0 <= m <= 5 for r, m in wedge)
        for j, g in enumerate(gs):
            cols.append([q.multiply(wedge, f) for f in g])
            e = [0]*6
            e[i] = e[3+j] = 1
            exponents.append(tuple(e))
            signs.append(4)
    rows = sorted({(i, r, m) for col in cols for i, f in enumerate(col) for r, m in f})
    full = [[col[i].get((r, m), 0) for col in cols] for i, r, m in rows]
    assert full == matrix['matrix']
    assert [list(row) for row in rows] == matrix['rows']
    rr, piv = q.rref(full)
    assert len(piv) == matrix['rank'] == 18
    assert cert['variables'] == ['d0', 'd1', 'd2', 'g0', 'g1', 'g2', 'a']
    equations = []
    for row in rr[:18]:
        f = {}
        for code, e, sign in zip(row, exponents, signs):
            add_term(f, e+(0,), sign*(code % 5))
            add_term(f, e+(1,), sign*(code//5))
        equations.append(f)
    field = {(0,)*6+(2,): 1, (0,)*6+(1,): 4, (0,)*7: 2}
    equations.append(field)
    recorded = [{tuple(e): c for e, c in f} for f in cert['equations']]
    assert equations == recorded
    assert cert['empty'] is True
    assert len(cert['multipliers']) == len(equations)
    total = {}
    for f, multiplier in zip(equations, cert['multipliers']):
        for e, c in multiplier:
            for ee, cc in f.items():
                add_term(total, tuple(a+b for a, b in zip(e, ee)), c*cc)
    assert total == {(0,)*7: 1}
    result = {'status': 'PASS',
              'scope': 'Full cubic norm reconstruction and literal exact identity for one; all geometric parameters retained.',
              'matrix_shape': [len(full), len(cols)], 'rank': len(piv),
              'witness_terms': sum(len(h) for h in cert['multipliers']),
              'input_hashes': {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                               for p in (args.source, args.net, args.matrix, args.certificate)}}
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('PASS full 80x20 norm matrix; exact identity1;', result['witness_terms'], 'terms')


if __name__ == '__main__':
    main()
