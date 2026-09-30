#!/usr/bin/env python3
"""Correct the returned Serre sign and probe the complete F4 scalar slice.

The evidence argument must name the already read and replayed source directory.
Its pickle files are LOCAL replay products, not deserialized uploaded pickles.
The probe is finite coefficient arithmetic, not by itself a Witt comparison.
"""
import argparse
import hashlib
import json
import pickle
import sys
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("evidence", type=Path)
parser.add_argument("--output", type=Path)
args = parser.parse_args()
sys.path.insert(0, str(args.evidence.resolve()))
import quadratic as q

with (args.evidence / "quad_setup.pkl").open("rb") as handle:
    setup = pickle.load(handle)
with (args.evidence / "lambda2.pkl").open("rb") as handle:
    functional = pickle.load(handle)["weights"]

def dot(a, b):
    result = 0
    for x, y in zip(a, b):
        result = q.ADD[result][q.MUL[x][y]]
    return result

def rank(columns):
    if not columns:
        return 0
    return len(q.rref(list(map(list, zip(*columns))))[1])

def actual_quadratic(a, b):
    # Base Serre matrix +I and three-variable AS trace -U imply -Q_returned.
    return q.rneg(q.Qpair(a, b, setup["BR"]))

def project(a):
    return q.reduceq(a, setup["QR"])

positive_carry = dot(functional, setup["beta"])
actual_q = dot(functional, q.rneg(setup["Q0"]))
positive = q.SUB[actual_q][positive_carry]
negative = q.ADD[actual_q][positive_carry]
assert (positive_carry, actual_q, positive, negative) == (4, 50, 51, 54)
assert q.MUL[positive][99] == q.MUL[negative][121] == 1
assert (-2 - 2) % 5 == 1  # du/u on the two infinity points of C
assert (-1) ** 3 == -1    # AS Top trace; product(c_i)=1

ker = setup["ker"]
linear = [project(q.rneg(q.carry(q.f, v))) for v in ker]
quadratic = []
for i, a in enumerate(ker):
    assert not any(q.rmul(q.f, a))
    for j, b in enumerate(ker[:i + 1]):
        value = project(actual_quadratic(a, b))
        if i != j:
            value = q.rscale(value, 2)
        quadratic.append((i, j, value))
        assert dot(functional, value) == 0
    assert dot(functional, linear[i]) == 0
    assert dot(functional, actual_quadratic(setup["h0"], a)) == 0

linear_null = q.nullspace(list(map(list, zip(*linear))))
null_sources = []
for coordinates in linear_null:
    value = [0] * 125
    for a, v in zip(coordinates, ker):
        value = q.radd(value, q.rscale(v, a))
    null_sources.append(value)
null_quadratic = [project(actual_quadratic(a, b))
                  for i, a in enumerate(null_sources)
                  for b in null_sources[:i + 1]]

linear6 = [[a if d == 6 else 0 for d, a in zip(q.SD, v)] for v in linear]
null6 = q.nullspace(list(map(list, zip(*linear6))))
sources6 = []
for coordinates in null6:
    value = [0] * 125
    for a, v in zip(coordinates, ker):
        value = q.radd(value, q.rscale(v, a))
    sources6.append(value)
quadratic6 = [project(actual_quadratic(a, b))
              for i, a in enumerate(sources6)
              for b in sources6[:i + 1]]
assert not any(any(v) for v in quadratic6)
assert rank(linear6) == 6
assert rank(linear) == 10

report = {
    "incoming_certificate_sha256": hashlib.sha256(
        (args.evidence / "certificate.json").read_bytes()).hexdigest(),
    "base_serre_matrix_sign": 1,
    "returned_test_realizes": "minus Lambda",
    "actual_lambda_Q": actual_q,
    "positive_divided_carry": positive_carry,
    "actual_E4_positive_branch": positive,
    "actual_E4_negative_branch": negative,
    "inverse_constants": [99, 121],
    "completion_linear_coefficients_checked": 25,
    "completion_quadratic_coefficients_checked": 325,
    "F4_probe": {
        "dimension": len(ker),
        "additive_rank": rank(linear),
        "additive_nullity": len(linear_null),
        "quadratic_image_rank": rank([v for _, _, v in quadratic]),
        "linear_and_quadratic_image_rank": rank(linear + [v for _, _, v in quadratic]),
        "linear_target_degrees": sorted({d for v in linear for d, a in zip(q.SD, v) if a}),
        "quadratic_target_degrees": sorted({d for _, _, v in quadratic for d, a in zip(q.SD, v) if a}),
        "quadratic_rank_on_linear_kernel": rank(null_quadratic),
        "degree6_additive_rank": rank(linear6),
        "degree6_kernel_dimension": len(null6),
        "quadratic_rank_on_degree6_kernel": rank(quadratic6),
        "degree6_kernel_symmetric_checks": len(quadratic6),
        "linear_kernel_min_degrees": [min(d for d, a in zip(q.SD, v) if a) for v in null_sources],
        "interpretation": "With the independently audited whole F4 comparison, the exact geometric W4 locus in F4 is the 15-dimensional kernel of the additive carry. Degree6 equations kill Q before degree7 is imposed.",
    },
}
print(json.dumps(report, indent=2))
if args.output:
    args.output.write_text(json.dumps(report, indent=2) + "\n")
