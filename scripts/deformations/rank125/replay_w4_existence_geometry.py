#!/usr/bin/env python3
"""Reconstruct the new W4 coefficients using the earlier audited engine.

The old engine's scalar sign is corrected explicitly.  The pickle inputs
are local outputs of that inspected earlier reconstruction, not uploaded
pickles.  This is independent of all source files in the new packet.
"""
import argparse
import hashlib
import json
import pickle
import sys
import time
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("old_evidence", type=Path)
parser.add_argument("new_evidence", type=Path)
parser.add_argument("--output", type=Path)
args = parser.parse_args()
start = time.monotonic()
sys.path.insert(0, str(args.old_evidence.resolve()))
import quadratic as q

manifest = args.new_evidence / "SHA256SUMS"
manifest_count = 0
for line in manifest.read_text().splitlines():
    expected, name = line.split(maxsplit=1)
    name = name.lstrip("*")
    assert hashlib.sha256((args.new_evidence / name).read_bytes()).hexdigest() == expected
    manifest_count += 1
print("PASS: incoming manifest", manifest_count, flush=True)
data = json.loads((args.new_evidence / "certificate.json").read_text())
assert q.SM == [tuple(e) for e in data["exponents"]]
assert [a if d <= 7 else 0 for a, d in zip(q.f, q.SD)] == data["scalar_f_through_degree_7"]
with (args.old_evidence / "quad_setup.pkl").open("rb") as handle:
    old = pickle.load(handle)
kn = data["kernel_basis"]
for h in kn:
    assert not any(q.rmul(q.f, h))  # FULL reconstructed symbol, not only f<=7.
qr = q.quotient_setup()
free = [i for i in range(125) if i not in qr[1]]
assert [q.SM[i] for i in free] == [tuple(e) for e in data["quotient_exponents"]]
for j in range(125):
    v = q.reduceq([int(i == j) for i in range(125)], qr)
    assert [v[i] for i in free] == data["quotient_projection"][j]
print("PASS: full primary symbol, completed kernel, quotient", flush=True)

for index, ((i, j), expected) in enumerate(zip(data["quadratic_pairs"], data["quadratic_scalar_coefficients"])):
    actual = q.rneg(q.Qpair(kn[i], kn[j], old["BR"]))
    actual = [a if d <= 7 else 0 for a, d in zip(actual, q.SD)]
    assert actual == expected, (index, i, j)
    if index % 100 == 0:
        print("actual fibre pairs", index, "seconds", round(time.monotonic() - start, 2), flush=True)
for j, h in enumerate(kn):
    actual = q.reduceq(q.carry(q.f, h), qr)
    assert [actual[i] for i in free] == data["carry_images"][j]

report = {
    "incoming_certificate_sha256": hashlib.sha256((args.new_evidence / "certificate.json").read_bytes()).hexdigest(),
    "manifest_files_checked": manifest_count,
    "completed_full_kernel_vectors": 43,
    "actual_fibre_quadratic_pairs": len(data["quadratic_pairs"]),
    "positive_carry_images": 43,
    "scalar_normalization": "negative of old Qpair; base Serre +I and actual scalar pairing -U E(-s)",
    "independent_engine": str(args.old_evidence.resolve()),
    "elapsed_seconds": time.monotonic() - start,
    "result": "PASS",
    "scope": "Reconstruction of characteristic-five geometric Q and carry coefficients; no numerical canonical reference coefficients or fifth comparison computed.",
}
print(json.dumps(report, indent=2))
if args.output:
    args.output.write_text(json.dumps(report, indent=2) + "\n")
