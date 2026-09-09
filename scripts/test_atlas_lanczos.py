#!/usr/bin/env python3
"""Small exact regression tests for the F25 Lanczos candidate finder.

No solver output is trusted: replay certificates with independent field
arithmetic. Generated matrices and logs go outside the research library.
"""
import argparse
import json
import os
import random
import struct
import subprocess
from pathlib import Path


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def mul(a, b):
    a0, a1, b0, b1 = a % 5, a // 5, b % 5, b // 5
    return (a0*b0 + 3*a1*b1) % 5 + 5*((a0*b1 + a1*b0 + a1*b1) % 5)


def dot(a, b):
    result = 0
    for x, y in zip(a, b):
        result = add(result, mul(x, y))
    return result


def write_matrix(path, matrix):
    with path.open("wb") as stream:
        stream.write(struct.pack("<II", len(matrix), len(matrix[0])))
        for row in matrix:
            entries = [(i, c) for i, c in enumerate(row) if c]
            stream.write(struct.pack("<I", len(entries)))
            stream.write(struct.pack("<" + "I"*len(entries), *(i for i, _ in entries)))
            stream.write(bytes(c for _, c in entries))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("binary", type=Path)
    parser.add_argument("out", type=Path)
    parser.add_argument("--cases", type=int, default=100)
    args = parser.parse_args()
    args.out.mkdir(exist_ok=False)
    rng = random.Random(125)
    environment = dict(os.environ, ATLAS_GRAM_TEAM="1",
                       VECLIB_MAXIMUM_THREADS="1", OMP_WAIT_POLICY="PASSIVE")
    records = []
    for case in range(args.cases):
        n = rng.randrange(2, 13)
        # Low-rank factorizations deliberately stress singular Gram operators.
        rows, rank = rng.randrange(1, n+4), rng.randrange(1, n+1)
        left = [[rng.randrange(25) for _ in range(rank)] for _ in range(rows)]
        right = [[rng.randrange(25) for _ in range(n)] for _ in range(rank)]
        matrix = [[dot(row, col) for col in zip(*right)] for row in left]
        matrix_path = args.out / f"matrix-{case:03d}.bin"
        write_matrix(matrix_path, matrix)
        record = dict(case=case, rows=rows, columns=n)
        for mode in (0, 1):
            folder = args.out / f"solve-{case:03d}-{mode}"
            result = subprocess.run([str(args.binary), str(matrix_path), str(folder),
                                     "10", str(rows), "20260908", "8", "1", "0", str(mode)],
                                    env=environment, capture_output=True, text=True, timeout=20)
            (args.out / f"log-{case:03d}-{mode}.txt").write_text(result.stdout+result.stderr)
            assert result.returncode in (0, 2), (case, mode, result.stderr)
            data = json.loads((folder/"result.json").read_text())
            primal, dual = folder/"solution.bin", folder/"dual.bin"
            assert data["primal_verified"] == primal.exists()
            assert data["dual_verified"] == dual.exists()
            if primal.exists():
                coefficients = primal.read_bytes()
                assert len(coefficients) == rows and all(c < 25 for c in coefficients)
                assert [dot(coefficients, col) for col in zip(*matrix)] == [0]*(n-1)+[1]
            if dual.exists():
                coefficients = dual.read_bytes()
                assert len(coefficients) == n and all(c < 25 for c in coefficients)
                assert coefficients[-1] and all(dot(row, coefficients) == 0 for row in matrix)
            assert not (primal.exists() and dual.exists())
            record[str(mode)] = data["status"]
        records.append(record)
    summary = dict(cases=len(records), certified={str(mode):sum(
        r[str(mode)] in {"linear_certificate_verified", "bounded_ansatz_dual_verified"}
        for r in records) for mode in (0, 1)},
        repaired=[r["case"] for r in records if r["0"].endswith("inconclusive")
                  and not r["1"].endswith("inconclusive")],
        all_reported_certificates_independently_replayed=True, records=records)
    (args.out/"summary.json").write_text(json.dumps(summary, indent=2)+"\n")
    print(json.dumps({k: v for k, v in summary.items() if k != "records"}, indent=2))


if __name__ == "__main__":
    main()
