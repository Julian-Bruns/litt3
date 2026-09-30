#!/usr/bin/env python3
"""Bounded source-of-quotient probe; never an all-geometric exclusion.

Enumerate F25 directions supported on at most two of the 35 lower-map
coordinates. Solve for every source vector in the corresponding linear
incidence fiber. Record whether the fiber lies in the known pure-v P5.
The tensor path is explicit; no coefficients or tests are inferred.
"""
import argparse
import json
from pathlib import Path
import sys
import time

parser = argparse.ArgumentParser()
parser.add_argument("archive", type=Path)
parser.add_argument("output", type=Path)
args = parser.parse_args()
sys.path.insert(0, str(args.archive / "src"))
import numpy as np
from exact import ADD, MUL, NEG, INV, kernel, matmul

t0 = time.monotonic()
data = np.load(args.archive / "data/tensors.npz")
T = data["T"]
assert T.shape == (19, 80, 35)
records = []
counts = {"tested_directions": 0, "nonzero_fibers": 0,
          "pure_v_fibers": 0, "outside_pure_v_fibers": 0}
def check(w, label):
    A = np.zeros((80, 19), dtype=np.uint8)
    for i in np.flatnonzero(w):
        A = ADD[A, MUL[w[i], T[:, :, i].T]]
    K = kernel(A)
    counts["tested_directions"] += 1
    if K.shape[1] == 0:
        return
    assert not matmul(A, K).any()
    counts["nonzero_fibers"] += 1
    outside = bool(K[:13].any())
    counts["outside_pure_v_fibers" if outside else "pure_v_fibers"] += 1
    records.append({"direction": label, "source_kernel": K.tolist(),
                    "outside_pure_v": outside})
for i in range(35):
    w = np.zeros(35, dtype=np.uint8); w[i] = 1
    check(w, [[i, 1]])
    for j in range(i + 1, 35):
        for c in range(1, 25):
            w[j] = c
            check(w, [[i, 1], [j, c]])
        w[j] = 0
result = {"scope": "F25 lower-map directions with support at most two; source fibers computed exactly over the algebraic closure for these directions only",
          "counts": counts, "records": records,
          "elapsed_seconds": time.monotonic() - t0}
args.output.write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps({k:v for k,v in result.items() if k != "records"}, indent=2))
