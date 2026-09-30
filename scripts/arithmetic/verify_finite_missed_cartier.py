#!/usr/bin/env python3
"""Portable independent certificate: a Cartier-fixed form in Omega(R)
cannot vanish to order two at any finite point of R.

Rebuilds the scalar field, jets and Cartier matrix using the independent
portable arithmetic supplied with seven_point_support. No NumPy or Numba.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import sys

ap = argparse.ArgumentParser()
ap.add_argument('--portable-source', type=Path, required=True)
ap.add_argument('--output', type=Path, required=True)
args = ap.parse_args()
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('portable_cartier', args.portable_source)
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)

def echelon(rows):
    a = [r[:] for r in rows]
    labels = list(range(len(a)))
    piv = []
    selected = []
    for col in range(21):
        row = len(piv)
        found = next((i for i in range(row, len(a)) if a[i][col]), None)
        if found is None:
            continue
        a[row], a[found] = a[found], a[row]
        labels[row], labels[found] = labels[found], labels[row]
        selected.append(labels[row])
        inv = p.inverse(a[row][col])
        a[row] = [p.mul(inv, x) for x in a[row]]
        for i in range(len(a)):
            if i != row and a[i][col]:
                q = a[i][col]
                a[i] = [p.sub(x, p.mul(q, y)) for x, y in zip(a[i], a[row])]
        piv.append(col)
    return a[:len(piv)], piv, selected

M = p.cartier_matrix()
point = (25, p.q0)
points = []
for _ in range(12):
    points.append(point)
    assert p.peval(p.A, point[0]) == 0
    assert p.power(point[1], 3) == p.peval(p.P, point[0])
    point = tuple(p.power(x, 25) for x in point)
assert point == points[0] and len(set(points)) == 12

# If v represents a Cartier-fixed form with Jv=0, it satisfies every
# block J_0=J, J_(i+1)=(J_i M)^[5]. This keeps coefficient Frobenius.
block = p.finite_jets(*points[0])
rows = []
counts = []
for stage in range(10):
    rows.extend(block)
    red, piv, selected = echelon(rows)
    counts.append(21-len(piv))
    block = [[p.power(x, 5) for x in r] for r in p.multiply(block, M)]
assert counts == [18,16,14,12,10,8,6,4,2,1]
assert len(piv) == 20
free = next(i for i in range(21) if i not in piv)
k = [0] * 21
k[free] = 1
for i, j in enumerate(piv):
    k[j] = p.neg(red[i][free])
assert not any(x[0] for x in p.multiply(rows, [[x] for x in k]))
ck = p.multiply(M, [[p.power(x, p.q//5)] for x in k])
assert not any(x[0] for x in ck)
minor = [[rows[i][j] for j in piv] for i in selected]
det = p.determinant(minor)
assert det
result = {
    'claim': 'For every finite P in R_X, a Cartier-fixed differential in '
             'H0(Omega_X(R_X)) vanishing to order at least two at P is zero.',
    'scope': 'scalar downstairs theorem; no etale cover is asserted',
    'basis': p.BASIS,
    'point': points[0], 'arithmetic_orbit': points,
    'constraint_nullities': counts,
    'rows': selected, 'columns': piv, 'minor_determinant': det,
    'one_dimensional_kernel': k,
    'Cartier_on_kernel': 'zero',
    'field_order': p.q,
}
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(result, indent=2) + '\n')
print('PASS: twelve finite points form one verified arithmetic orbit.')
print('PASS: independent constraint nullities:', counts)
print('PASS: selected 20x20 minor is nonzero:', det)
print('PASS: remaining one-dimensional kernel is Cartier-killed.')
print('THEOREM: no nonzero Cartier-fixed form in Omega(R) has a double '
      'zero at a finite R-point.')
