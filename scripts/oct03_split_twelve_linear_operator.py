#!/usr/bin/env python3
"""Tiny exact F5 kernel check for the split-twelve necessary canonical equation.

Normalize d=-1 by u=aU,v=aV with a^2=-d.  Then V^2=U^2-1+t^6
and D=V d/dt+3t^5 d/dV.  Candidate sections have weighted degree <=10,
ordinary U,V fiber degree <=3.  Solve (D^2-3*j*t^2*D)Y=0 for j in F5.
This does not construct a curve, a cubic coordinate, or an etale map.
"""

import json
import sys
from pathlib import Path

MOD = 5


def add(*polys):
    out = {}
    for poly in polys:
        for mon, coeff in poly.items():
            out[mon] = (out.get(mon, 0) + coeff) % MOD
    return {m: c for m, c in out.items() if c}


def shift(poly, t=0, scalar=1):
    return {(k + t, i, v): scalar * c % MOD
            for (k, i, v), c in poly.items() if scalar * c % MOD}


def derivative(poly):
    out = {}
    for (k, i, v), c in poly.items():
        if not v:
            if k % MOD:
                out = add(out, {(k - 1, i, 1): c * k % MOD})
        else:
            # D(V U^i t^k)=k U^(i+2)t^(k-1)-k U^i t^(k-1)
            #                 +(k+3) U^i t^(k+5).
            if k % MOD:
                out = add(out, {(k - 1, i + 2, 0): c * k % MOD,
                                (k - 1, i, 0): -c * k % MOD})
            out = add(out, {(k + 5, i, 0): c * (k + 3) % MOD})
    return out


def nullspace(matrix, columns):
    a = [row[:] for row in matrix]
    pivots = []
    r = 0
    for c in range(columns):
        p = next((i for i in range(r, len(a)) if a[i][c]), None)
        if p is None:
            continue
        a[r], a[p] = a[p], a[r]
        inv = pow(a[r][c], -1, MOD)
        a[r] = [x * inv % MOD for x in a[r]]
        for i in range(len(a)):
            if i != r and a[i][c]:
                scale = a[i][c]
                a[i] = [(x - scale * y) % MOD for x, y in zip(a[i], a[r])]
        pivots.append(c)
        r += 1
        if r == len(a):
            break
    free = [c for c in range(columns) if c not in pivots]
    out = []
    for c in free:
        vector = [0] * columns
        vector[c] = 1
        for row, pivot in enumerate(pivots):
            vector[pivot] = -a[row][c] % MOD
        assert all(sum(x * y for x, y in zip(row, vector)) % MOD == 0
                   for row in matrix)
        out.append(vector)
    return out, pivots


def describe(poly):
    parts = []
    for (k, i, v), c in sorted(poly.items(), key=lambda z: (z[0][2], z[0][1], z[0][0])):
        factors = ([str(c)] if c != 1 else [])
        if k:
            factors.append('t' if k == 1 else f't^{k}')
        if i:
            factors.append('U' if i == 1 else f'U^{i}')
        if v:
            factors.append('V')
        parts.append('*'.join(factors) or '1')
    return ' + '.join(parts) or '0'


def main():
    domain = [(k, i, v) for v in range(2) for i in range(4 - v)
              for k in range(11 - 3 * (i + v))]
    assert len(domain) == 41
    records = []
    for j in range(5):
        images = []
        for mon in domain:
            dy = derivative({mon: 1})
            images.append(add(derivative(dy), shift(dy, t=2, scalar=-3 * j)))
        codomain = sorted(set().union(*(set(p) for p in images)))
        matrix = [[p.get(mon, 0) for p in images] for mon in codomain]
        basis, pivots = nullspace(matrix, len(domain))
        polys = [dict((mon, c) for mon, c in zip(domain, b) if c) for b in basis]
        for y in polys:
            dy = derivative(y)
            assert not add(derivative(dy), shift(dy, t=2, scalar=-3 * j))
        record = {'j': j, 'f': (-3 * j) % MOD, 'rows': len(codomain),
                  'columns': len(domain), 'rank': len(pivots),
                  'kernel_dimension': len(basis),
                  'basis': [{'Y': describe(p), 'DY': describe(derivative(p))}
                            for p in polys], 'checks': 'matrix and direct derivative verification passed'}
        records.append(record)
        print(f'j={j}: rank={len(pivots)}, kernel={len(basis)}')
        for b in record['basis']:
            print(f"  Y={b['Y']}; DY={b['DY']}")
    if len(sys.argv) > 1:
        target = Path(sys.argv[1])
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(json.dumps({'scope': __doc__, 'records': records}, indent=2) + '\n')


if __name__ == '__main__':
    main()
