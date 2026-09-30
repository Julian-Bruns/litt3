#!/usr/bin/env python3
"""Elementary replay of the actual shifted norm equations and identities.

No CAS is used. Reconstruct the 109 columns by symmetric multiplication
in F25[x,y]/(y^3-P), redo row reduction with coded field arithmetic,
then multiply each prime-field ideal-membership identity literally.
"""
import argparse
import hashlib
import json
from math import factorial
from pathlib import Path
import pro_quadratic_twist_vanishing as q


def add_term(p, e, c):
    c = (p.get(e, 0)+c) % 5
    if c:
        p[e] = c
    else:
        p.pop(e, None)


def read(s, i):
    return {(r, m): c for r, m, c in s['affine'][i]}


def product(vectors):
    coefficients = [q.ONE]
    for v in vectors:
        new = [{} for _ in range(len(coefficients)+1)]
        for i, f in enumerate(coefficients):
            for j, g in enumerate(v):
                new[i+j] = q.add(new[i+j], q.multiply(f, g))
        coefficients = new
    return coefficients


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('sections', type=Path)
    ap.add_argument('net_sections', type=Path)
    ap.add_argument('prepared', type=Path)
    ap.add_argument('certificate', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    source = json.loads(args.sections.read_text())['sections']
    net = json.loads(args.net_sections.read_text())['sections']
    data = json.loads(args.prepared.read_text())
    certificate = json.loads(args.certificate.read_text())
    assert data['input_hashes'] == [hashlib.sha256(p.read_bytes()).hexdigest()
                                   for p in (args.sections, args.net_sections)]
    ps = [[read(s, 0), read(s, 5)] for s in source[:5]]
    qs = [[read(s, 0), read(s, 5)] for s in source[5:]]
    gs = [[read(s, i) for i in (0,5,10,15)] for s in net]
    columns = []
    monomials = data['coefficient_monomials']
    assert len(monomials) == 109
    for e in monomials[:39]:
        exponents, basis = (e[:5], ps) if sum(e[:5]) else (e[5:7], qs)
        assert sum(exponents) == 3
        factor = factorial(3)
        factors = []
        for count, v in zip(exponents, basis):
            factor //= factorial(count)
            factors.extend([v]*count)
        columns.append([q.add({}, f, factor % 5) for f in product(factors)])
    for e in monomials[39:]:
        i = e[:5].index(1); j = e[5:7].index(1); r = e[7:].index(1)
        assert sum(e) == 3
        h = q.add(q.multiply(qs[j][0], ps[i][1]),
                  q.multiply(ps[i][0], qs[j][1]), 4)
        assert all(res == 0 and 0 <= m <= 7 for res, m in h)
        columns.append([q.add({}, q.multiply(h, f), 4) for f in gs[r]])
    rows = sorted({(i, r, m) for column in columns
                   for i, f in enumerate(column) for r, m in f})
    full = [[column[i].get((r, m), 0) for column in columns] for i, r, m in rows]
    rr, pivots = q.rref(full)
    assert len(pivots) == data['coefficient_rank'] == 35
    assert rr[:35] == data['reduced_coefficient_rows']
    chart = data['chart']
    names = certificate['variables']
    assert names == data['variables']+['a']
    n = len(names); zero = (0,)*n
    source_names = ['b'+str(i) for i in range(5)]+['d0','d1']+['g'+str(i) for i in range(7)]
    equations = []
    for row in rr[:35]:
        polynomial = {}
        for code, exponents in zip(row, monomials):
            if not code:
                continue
            if chart == 0 and exponents[6]:
                continue
            e = [0]*n
            for name, power in zip(source_names, exponents):
                if name in names:
                    e[names.index(name)] = power
            add_term(polynomial, tuple(e), code % 5)
            e[-1] += 1
            add_term(polynomial, tuple(e), code//5)
        if polynomial:
            equations.append(polynomial)
    field = {}
    for power, c in ((2,1),(1,4),(0,2)):
        e = [0]*n; e[-1] = power; add_term(field,tuple(e),c)
    equations.append(field)
    recorded = [{tuple(e): c for e, c in f} for f in certificate['equations']]
    assert equations == recorded
    assert certificate['empty'] is True
    assert len(certificate['multipliers']) == len(equations)
    total = {}
    for f, h in zip(equations, certificate['multipliers']):
        for e, c in h:
            for ee, cc in f.items():
                add_term(total, tuple(a+b for a,b in zip(e,ee)), c*cc)
    assert total == {zero: 1}
    receipt = {'status': 'PASS', 'chart': chart,
               'scope': 'Independently reconstructed the complete norm coefficient matrix and the prepared prime-field equations, then verified the exact identity1 by elementary multiplication.',
               'coefficient_rank': len(pivots),
               'witness_terms': sum(len(h) for h in certificate['multipliers']),
               'input_hashes': {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                                for p in (args.sections,args.net_sections,args.prepared,args.certificate)}}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS chart', chart, 'norm rank35, exact identity1, terms', receipt['witness_terms'])


if __name__ == '__main__':
    main()
