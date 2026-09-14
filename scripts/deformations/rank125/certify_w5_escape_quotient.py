#!/usr/bin/env python3
"""Exact four-coordinate relative W5 quotient on the odd W4 escape.

Pure Python polynomial and finite-field arithmetic; no symbolic matrix
backend. The actual relative Witt identity is a separate audited input.
"""
import argparse
import importlib.util
import json
from functools import lru_cache
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("certificate", type=Path)
parser.add_argument("--output", type=Path)
args = parser.parse_args()
spec = importlib.util.spec_from_file_location("a", Path(__file__).with_name("audit_w4_existence_polynomial.py"))
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)
d = json.loads(args.certificate.read_text())
qe = [tuple(e) for e in d["quotient_exponents"]]
lead = d["kernel_leading_degrees"]
red = d["quotient_projection"]
project = lambda v: [a.dot(v, column) for column in zip(*red)]
qp = {tuple(ij): project(v) for ij, v in zip(d["quadratic_pairs"], d["quadratic_scalar_coefficients"])}
alpha, beta = {(1, 0): 1}, {(0, 1): 1}
lin = lambda c, x, y: a.pa(a.pa(a.pc(c), a.scale(alpha, x)), a.scale(beta, y))
b12 = lin(34, 64, 12)
seed = {1: a.pc(101), 2: a.pc(14),
        11: a.pa(a.pc(103), a.scale(b12, a.neg(34))),
        12: b12, 15: lin(6, 111, 93), 16: lin(15, 100, 42),
        27: {(2, 0): 55, (1, 1): 123, (0, 2): 59,
             (1, 0): 90, (0, 1): 81, (0, 0): 124}}

def rref(rows):
    rows = [list(r) for r in rows]
    if not rows:
        return rows, []
    pv, r = [], 0
    for col in range(len(rows[0])):
        p = next((i for i in range(r, len(rows)) if rows[i][col]), None)
        if p is None:
            continue
        rows[r], rows[p] = rows[p], rows[r]
        unit = a.inv(rows[r][col])
        rows[r] = [a.mul(v, unit) for v in rows[r]]
        for j in range(len(rows)):
            if j != r and rows[j][col]:
                c = rows[j][col]
                rows[j] = [a.add(x, a.neg(a.mul(c, y))) for x, y in zip(rows[j], rows[r])]
        pv.append(col)
        r += 1
        if r == len(rows):
            break
    return rows, pv

def nullspace(rows):
    rr, pivots = rref(rows)
    free = [j for j in range(len(rows[0])) if j not in pivots]
    out = []
    for j in free:
        v = [0] * len(rows[0]); v[j] = 1
        for i, p in enumerate(pivots):
            v[p] = a.neg(rr[i][j])
        out.append(v)
    return out

def poly_sum(terms):
    out = {}
    for term in terms:
        out = a.pa(out, term)
    return out

def determinant(entries):
    @lru_cache(None)
    def recur(cols):
        if not cols:
            return a.pc(1)
        row = len(entries) - len(cols)
        return poly_sum(a.scale(a.pm(entries[row][col], recur(cols[:j] + cols[j + 1:])), 4 if j % 2 else 1)
                        for j, col in enumerate(cols))
    return recur(tuple(range(len(entries))))

def constant_minor(matrix):
    m0 = [[p.get((0, 0), 0) for p in row] for row in matrix]
    rows = rref(list(zip(*m0)))[1]
    cols = rref([m0[i] for i in rows])[1]
    sub = [[matrix[i][j] for j in cols] for i in rows]
    det = determinant(sub)
    assert det.get((0, 0), 0)
    assert set(det) == {(0, 0)}, det
    print("PASS: constant minor", len(rows), rows, cols, det[(0, 0)], flush=True)
    return {"rows": rows, "columns": cols, "determinant": det[(0, 0)]}

odd = [j for j in range(43) if lead[j] % 2]
L = {}
for j in odd:
    row = [a.pc(a.neg(c)) for c in d["carry_images"][j]]
    for i, x in seed.items():
        for k, c in enumerate(qp.get(tuple(sorted((i, j))), [0] * 43)):
            row[k] = a.pa(row[k], a.scale(x, a.mul(2, c)))
    L[j] = row
low = [i for i, e in enumerate(qe) if sum(e) in (1, 3)]
lowmat = [[L[j][i] for i in low] for j in odd]
assert all(not p for row in lowmat for p in row[:3])
separator = [0, 0, 0, 45, 1, 0, 0, 0, 0, 0]
assert all(not poly_sum(a.scale(p, c) for p, c in zip(row, separator)) for row in lowmat)
lowminor = constant_minor(lowmat)
assert len(lowminor["rows"]) == 6

o7 = [j for j in odd if lead[j] >= 7]
out3 = [i for i, e in enumerate(qe) if sum(e) == 3]
m3p = [[L[j][i] for i in out3] for j in o7]
assert all(set(p) <= {(0, 0)} for row in m3p for p in row)
m3 = [[p.get((0, 0), 0) for p in row] for row in m3p]
n3 = nullspace(list(zip(*m3)))
assert len(n3) == 16
assert len(rref(n3)[1]) == 16
assert all(not a.dot(v, col) for v in n3 for col in zip(*m3))
out5 = [i for i, e in enumerate(qe) if sum(e) == 5]
m5 = [[L[j][i] for i in out5] for j in o7]
high5 = [[poly_sum(a.scale(m5[j][i], c) for j, c in enumerate(v)) for i in range(len(out5))] for v in n3]
highminor = constant_minor(high5)
assert len(highminor["rows"]) == 8

encode = lambda p: [[list(e), c] for e, c in sorted(p.items())]
report = {
    "result": "PASS", "parameter_ring": "F125[alpha,beta]",
    "odd_source_indices": odd, "odd_source_ge7": o7,
    "quotient_exponents": [list(e) for e in qe],
    "relative_low_matrix": [[encode(p) for p in row] for row in lowmat],
    "degree3_kernel_basis": n3,
    "degree5_on_low_kernel": [[encode(p) for p in row] for row in high5],
    "low_minor": lowminor, "high_minor": highminor,
    "odd_relative_image_dimension": 18,
    "odd_residual_dimension": 4,
    "separators": ["E001", "E010", "E100", "E030+[45]E021"],
    "scope": "Fixed actual odd relative image after the separately audited Witt comparison. No absolute fifth residual evaluated.",
}
print("PASS: universal four-coordinate odd fifth quotient; no reference coefficient specialized")
if args.output:
    args.output.write_text(json.dumps(report, indent=2) + "\n")
