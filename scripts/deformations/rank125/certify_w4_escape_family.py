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

# Explicit odd translation basis, independently using the previously
# reconstructed actual-AS coefficient table (not the new return's engine).
delta_image = [a.pa(a.scale(x, 117), y) for x, y in zip(L[32], L[33])]
assert not any(delta_image)
assert [p for p, e in zip(L[32], qe) if sum(e) == 7] == [{}, {}, {}, a.pc(107)]
assert [p for p, e in zip(L[33], qe) if sum(e) == 7] == [{}, {}, {}, a.pc(72)]
assert a.add(a.mul(117, 107), 72) == 0
kernel = d["kernel_basis"]
delta = [a.add(a.mul(117, x), y) for x, y in zip(kernel[32], kernel[33])]
translations = [delta, kernel[39], kernel[40], kernel[41]]
exps = [tuple(e) for e in d["exponents"]]
expected_translations = [
    {(4, 1, 4): 117, (4, 2, 3): 1, (4, 3, 2): 41, (4, 4, 1): 35},
    {(3, 4, 4): 1}, {(4, 3, 4): 1}, {(4, 4, 3): 1},
]
for v, expected in zip(translations, expected_translations):
    assert {e: c for e, c in zip(exps, v) if c} == expected
assert len(rref(translations)[1]) == 4
assert a.mul(a.mul(37, 65), 44) == 91

# This verifies only the scalar algebra of the second tame involution.
# Its actual marked geometric action is audited separately.
for j, v in enumerate(kernel):
    parity = tuple(d["kernel_pivots"][j])[0] % 2
    assert all(not c or e[0] % 2 == parity for e, c in zip(exps, v))
for j in (1, 2, 11, 12, 15, 16, 27, 30, 31, 39):
    assert all(not c or e[0] % 2 for e, c in zip(exps, kernel[j]))
for v, sign in zip(translations, (-1, 1, -1, -1)):
    assert all(not c or (-1 if e[0] % 2 == 0 else 1) == sign for e, c in zip(exps, v))
terminal_signs = [-1 if e[0] % 2 == 0 else 1 for e in qe if sum(e) == 7]
assert terminal_signs == [-1, 1, 1, -1]
fifth_projection_signs = [-1 if e[0] % 2 == 0 else 1
                          for e in ((0, 0, 1), (0, 1, 0), (1, 0, 0), (0, 3, 0))]
assert fifth_projection_signs == [-1, -1, 1, -1]

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
    "odd_translation_basis": [
        [{"exponents": list(e), "coefficient": c} for e, c in sorted(v.items())]
        for v in expected_translations
    ],
    "odd_translation_basis_dimension": 4,
    "constant_odd_rank_six_minor": 91,
    "second_involution_translation_signs": [-1, 1, -1, -1],
    "second_involution_terminal_signs": terminal_signs,
    "second_involution_fifth_projection_signs": fifth_projection_signs,
    "second_involution_geometric_interpretation": "Separate actual-marking/reference audit required; this script verifies scalar identities only.",
    "conclusion": "For the actual constructed H*, Z4 intersect (H*+K9) = H*+ker L_H*, an eight-dimensional affine scalar family. No fifth-lift assertion.",
}
print(json.dumps(report, indent=2))
if args.output:
    args.output.write_text(json.dumps(report, indent=2) + "\n")
