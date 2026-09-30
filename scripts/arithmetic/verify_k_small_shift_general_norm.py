#!/usr/bin/env python3
"""Elementary reconstruction and identity replay for the two-character norm.

Do not invoke the preparation script or a CAS. Rebuild cubic-vector
products and all wedge products from the actual global sections, then
check the retained prime-field polynomial identity for one.
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
    ap.add_argument('prepared', type=Path)
    ap.add_argument('certificate', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    source = json.loads(args.source.read_text())['sections']
    net = json.loads(args.net.read_text())['sections']
    data = json.loads(args.prepared.read_text())
    cert = json.loads(args.certificate.read_text())
    assert data['input_hashes'] == [hashlib.sha256(p.read_bytes()).hexdigest() for p in (args.source, args.net)]
    assert cert['input_sha256'] == hashlib.sha256(args.prepared.read_bytes()).hexdigest()
    ps = [[read(s, i) for i in range(2)] for s in source if s['C3_character'] == 0]
    qs = [[read(s, i) for i in range(2)] for s in source if s['C3_character'] == 1]
    assert len(ps)+len(qs) == len(source)
    gs = [[read(s, i) for i in range(4)] for s in net if s['C3_character'] == 0]
    nb, nd, ng = len(ps), len(qs), len(gs)
    names = [f'b{i}' for i in range(nb)]+[f'd{i}' for i in range(nd)]+[f'g{i}' for i in range(ng)]
    columns, exponents = [], []
    for offset, basis in ((0, ps), (nb, qs)):
        for inds in combinations_with_replacement(range(len(basis)), 3):
            e = [0]*len(names)
            factor = factorial(3)
            for i in range(len(basis)):
                count = inds.count(i)
                e[offset+i] = count
                factor //= factorial(count)
            columns.append([q.add({}, f, factor % 5) for f in product([basis[i] for i in inds])])
            exponents.append(e)
    for i, p in enumerate(ps):
        for j, v in enumerate(qs):
            wedge = q.add(q.multiply(p[0], v[1]), q.multiply(p[1], v[0]), 4)
            assert all(r == 0 and 0 <= m <= 1+2*data['shift'] for r, m in wedge)
            for k, g in enumerate(gs):
                columns.append([q.add({}, q.multiply(wedge, f), 4) for f in g])
                e = [0]*len(names)
                e[i] = e[nb+j] = e[nb+nd+k] = 1
                exponents.append(e)
    assert exponents == data['coefficient_monomials']
    rows = sorted({(i, r, m) for col in columns for i, f in enumerate(col) for r, m in f})
    full = [[col[i].get((r, m), 0) for col in columns] for i, r, m in rows]
    rr, piv = q.rref(full)
    assert len(piv) == data['coefficient_rank']
    assert rr[:len(piv)] == data['reduced_coefficient_rows']
    assert cert['variables'] == data['variables']+['a']
    n = len(cert['variables'])
    chart = data['chart']
    equations = []
    for row in rr[:len(piv)]:
        f = {}
        for code, e in zip(row, exponents):
            if not code or any(e[i] for i in range(chart+1, nb)):
                continue
            powers = [e[names.index(name)] for name in data['variables']]
            add_term(f, tuple(powers)+(0,), code % 5)
            add_term(f, tuple(powers)+(1,), code//5)
        if f:
            equations.append(f)
    equations.append({(0,)*(n-1)+(2,): 1, (0,)*(n-1)+(1,): 4, (0,)*n: 2})
    assert equations == [{tuple(e): c for e, c in f} for f in cert['equations']]
    assert cert['empty'] is True and len(cert['multipliers']) == len(equations)
    total = {}
    for f, h in zip(equations, cert['multipliers']):
        for e, c in h:
            for ee, cc in f.items():
                add_term(total, tuple(a+b for a, b in zip(e, ee)), c*cc)
    assert total == {(0,)*n: 1}
    receipt = {'status': 'PASS', 'shift': data['shift'], 'chart': chart,
               'scope': 'Full coefficient matrix and chart equations reconstructed; literal identity for one verified without CAS.',
               'coefficient_matrix_shape': [len(full), len(columns)], 'coefficient_rank': len(piv),
               'witness_terms': sum(len(h) for h in cert['multipliers']),
               'input_hashes': {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                                for p in (args.source, args.net, args.prepared, args.certificate)}}
    args.output.write_text(json.dumps(receipt, indent=2)+'\n')
    print('PASS shift', data['shift'], 'chart', chart, 'terms', receipt['witness_terms'])


if __name__ == '__main__':
    main()
