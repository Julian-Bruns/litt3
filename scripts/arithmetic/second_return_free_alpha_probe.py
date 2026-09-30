#!/usr/bin/env python3
"""Exact low-degree membership probe with one f monomial and arbitrary alpha.

A failed test is inconclusive. A passed test is a geometric exclusion of
that specified map subspace, conditional on the accepted pure-v theorem.
This script does not test arbitrary polynomial f or the full return locus.
"""
import argparse
import json
from pathlib import Path
import sys
import time

p = argparse.ArgumentParser()
p.add_argument("archive", type=Path)
p.add_argument("output", type=Path)
p.add_argument("--degree", type=int, default=2)
p.add_argument("--f-indices", default=",".join(map(str, range(23))))
a = p.parse_args()
sys.path.insert(0, str(a.archive / "src"))
import numpy as np
from prolong import prolong_index, monomial_tuples
from pure_power_test import test_support

T = np.load(a.archive / "data/pencils.npz")["T"]
indices, nm = prolong_index(13, a.degree)
monomials = monomial_tuples(13, a.degree)
pure = np.array([monomials.index((i,) * a.degree) for i in range(13)], dtype=np.int64)
start = time.monotonic()
records = []
f_indices = [int(x) for x in a.f_indices.split(",")]
assert len(set(f_indices)) == len(f_indices) and all(0 <= x < 23 for x in f_indices)
for f_index in f_indices:
    support = np.array([f_index, *range(23, 35)], dtype=np.int64)
    flags, rank = test_support(T, support, indices, nm, pure)
    row = {"f_index": f_index, "direction_indices": support.tolist(),
           "degree": a.degree, "rank": int(rank),
           "geometric_exclusion_certified": bool(flags[0])}
    records.append(row)
    print(row, "elapsed", round(time.monotonic() - start, 2), flush=True)
    a.output.write_text(json.dumps({
        "scope": "one nonzero f monomial, all twelve alpha coordinates free",
        "completed": len(records) == len(f_indices),
        "requested_f_indices": f_indices,
        "records": records,
        "elapsed_seconds": time.monotonic() - start,
        "failure_meaning": "Failed membership is inconclusive, not a point."}, indent=2) + "\n")
