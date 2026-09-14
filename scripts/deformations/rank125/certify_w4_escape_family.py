#!/usr/bin/env python3
"""Certify the exact eight-dimensional K9 fibre around the W4 escape.

Uses geometric coefficient arrays already reconstructed independently by
replay_w4_existence_geometry.py. All parameter identities are polynomial
identities; alpha and beta are not specialized to a finite field.
"""
import argparse
import importlib.util
import json
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("certificate", type=Path)
parser.add_argument("--output", type=Path)
args = parser.parse_args()
spec = importlib.util.spec_from_file_location("audit", Path(__file__).with_name("audit_w4_existence_polynomial.py"))
a = importlib.util.module_from_spec(spec)
spec.loader.exec_module(a)
d = json.loads(args.certificate.read_text())
qe = d["quotient_exponents"]
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
    rows = [r.copy() for r in rows]
    if not rows:
        return rows, []
    pv, r = [], 0
    for col in range(len(rows[0])):
        p = next((i for i in range(r, len(rows)) if rows[i][col]), None)
        if p is None:
            continue
        rows[r], rows[p] = rows[p], rows[r]
        rows[r] = [a.mul(v, a.inv(rows[r][col])) for v in rows[r]]
        for j in range(len(rows)):
            if j != r and rows[j][col]:
                c = rows[j][col]
                rows[j] = [a.add(x, a.neg(a.mul(c, y))) for x, y in zip(rows[j], rows[r])]
        pv.append(col)
        r += 1
        if r == len(rows):
            break
    return rows, pv

L = {}
for j in range(43):
    if lead[j] < 9:
        continue
    row = [a.pc(a.neg(c)) for c in d["carry_images"][j]]
    for i, x in seed.items():
        for k, c in enumerate(qp.get(tuple(sorted((i, j))), [0] * 43)):
            row[k] = a.pa(row[k], a.scale(x, a.mul(2, c)))
    L[j] = row

odd = [j for j in L if lead[j] % 2]
even = [j for j in L if not lead[j] % 2]
low = []
for j in odd:
    assert all(not p or sum(e) in (5, 7) for p, e in zip(L[j], qe))
    row = [p for p, e in zip(L[j], qe) if sum(e) == 5]
    assert all(set(p) <= {(0, 0)} for p in row)
    low.append([p.get((0, 0), 0) for p in row])
assert len(odd) == 10
assert len(rref(low)[1]) == 2

even_values = []
for j in even:
    assert all(not p or sum(e) == 6 for p, e in zip(L[j], qe))
    assert all(set(p) <= {(0, 0)} for p in L[j])
    even_values.append([p.get((0, 0), 0) for p in L[j]])
assert len(even) == 6
assert len(rref(even_values)[1]) == 2

gammas = [{28: 29, 29: 1}, {27: 11, 30: 1}, {27: 87, 31: 1}, {32: 1}]
rows = []
for gamma in gammas:
    row = [{} for _ in qe]
    for j, c in gamma.items():
        row = [a.pa(x, a.scale(y, c)) for x, y in zip(row, L[j])]
    assert all(not p for p, e in zip(row, qe) if sum(e) < 7)
    rows.append([p for p, e in zip(row, qe) if sum(e) == 7])
A, B, C, D, G = lin(64, 67, 33), lin(81, 68, 50), lin(2, 38, 70), lin(8, 67, 33), lin(42, 14, 66)
assert rows == [[a.pc(57), {}, {}, G], [{}, A, B, {}], [{}, C, D, {}], [{}, {}, {}, a.pc(107)]]
assert a.pa(a.pm(A, D), a.scale(a.pm(B, C), 4)) == a.pc(58)
assert a.mul(a.mul(57, 58), 107) == 44
assert all(not p for j in (39, 40, 41, 42) for p in L[j])

report = {
    "result": "PASS",
    "parameter_ring": "F125[alpha,beta], with both variables unrestricted",
    "K9_dimension": 16,
    "odd_source_dimension": 10,
    "odd_degree5_rank": 2,
    "odd_terminal_degree7_rank": 4,
    "odd_total_rank": 6,
    "even_source_dimension": 6,
    "even_degree6_rank": 2,
    "total_rank_for_every_alpha_beta": 8,
    "exact_affine_W4_fibre_dimension": 8,
    "all_K11_relative_images_zero": True,
    "odd_low_rows": low,
    "even_rows": even_values,
    "conclusion": "For the actual constructed H*, Z4 intersect (H*+K9) = H*+ker L_H*, an eight-dimensional affine scalar family. No fifth-lift assertion.",
}
print(json.dumps(report, indent=2))
if args.output:
    args.output.write_text(json.dumps(report, indent=2) + "\n")
