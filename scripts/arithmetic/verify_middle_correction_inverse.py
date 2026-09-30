#!/usr/bin/env python3
"""Replay a middle correction inverse by elementary coefficient arithmetic.

NumPy only reads the previously audited tensor. Polynomial and F25
arithmetic below do not call Sage, Singular, a matrix solver or a CAS.
This verifies LQ=C and the complete substitution, not a finite point test.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np


ADD = [[(a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)
        for b in range(25)] for a in range(25)]
NEG = [(-a % 5) % 5 + 5 * ((-(a // 5)) % 5) for a in range(25)]
MUL = [[((a % 5) * (b % 5) + 3 * (a // 5) * (b // 5)) % 5
        + 5 * (((a % 5) * (b // 5) + (a // 5) * (b % 5)
                + (a // 5) * (b // 5)) % 5)
        for b in range(25)] for a in range(25)]


def decode(poly, n):
    out = {}
    for e, c in poly:
        e = tuple(e)
        assert len(e) == n and all(isinstance(x, int) and x >= 0 for x in e)
        assert 1 <= c < 25 and e not in out
        out[e] = c
    return out


def accumulate(out, f, shift, scalar):
    if not scalar:
        return
    for e, c in f.items():
        m = tuple(x + y for x, y in zip(e, shift))
        value = ADD[out.get(m, 0)][MUL[c][scalar]]
        if value:
            out[m] = value
        else:
            out.pop(m, None)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("certificate", type=Path)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    cert = json.loads(args.certificate.read_text())
    assert cert["status"] == "COMPLETE"
    assert cert["input_sha256"] == hashlib.sha256(args.tensor.read_bytes()).hexdigest()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30, 15, 10)
    j = cert["source_stratum"]
    n = 9 - j
    zero = (0,) * n
    affine = [(zero, j)] + [
        (tuple(int(k == t) for k in range(n)), j + 1 + t) for t in range(n)
    ]
    L = [[decode(f, n) for f in row] for row in cert["inverse"]]
    C = cert["constant_combinations"]
    rank = cert["eliminated_correction_rank"]
    assert len(L) == len(C) == rank and all(len(row) == 30 for row in L)
    pivots = cert["eliminated_correction_indices"]
    free = cert["retained_correction_indices"]
    assert sorted(pivots + free) == list(range(7))
    assert len(pivots) == rank and all(len(row) == 7 for row in C)
    for r in range(rank):
        for s, p in enumerate(pivots):
            assert C[r][p] == int(r == s)
    LP = []
    for a in range(rank):
        row = []
        for col in range(15):
            out = {}
            for r in range(30):
                for shift, b in affine:
                    accumulate(out, L[a][r], shift, int(H[r, col, b]))
            if col >= 8:
                expected = {zero: C[a][col - 8]} if C[a][col - 8] else {}
                assert out == expected, ("LQ", a, col - 8)
            else:
                row.append(out)
        LP.append(row)
    replacement = [[decode(f, n) for f in row]
                   for row in cert["correction_replacement"]]
    assert len(replacement) == 7
    assert all(len(row) == 8 + len(free) for row in replacement)
    expected = [[{} for _ in range(8 + len(free))] for _ in range(7)]
    for a, pivot in enumerate(pivots):
        for b in range(8):
            expected[pivot][b] = {e: NEG[c] for e, c in LP[a][b].items()}
        for b, col in enumerate(free):
            if C[a][col]:
                expected[pivot][8 + b] = {zero: NEG[C[a][col]]}
    for b, col in enumerate(free):
        expected[col][8 + b] = {zero: 1}
    assert replacement == expected
    reduced = cert.get("reduced_pencil")
    if reduced is not None:
        assert len(reduced) == 30
        for r in range(30):
            assert len(reduced[r]) == 8 + len(free)
            for col in range(8 + len(free)):
                out = {}
                if col < 8:
                    for shift, b in affine:
                        value = int(H[r, col, b])
                        if value:
                            out[shift] = value
                for a in range(7):
                    for shift, b in affine:
                        accumulate(out, replacement[a][col], shift, int(H[r, 8 + a, b]))
                assert out == decode(reduced[r][col], n), ("reduced", r, col)
    receipt = {
        "status": "PASS",
        "scope": "Exact polynomial left inverse and scheme-equivalent correction substitution on the entire normalized source stratum.",
        "source_stratum": j, "eliminated_correction_rank": rank,
        "input_sha256": cert["input_sha256"],
        "certificate_sha256": hashlib.sha256(args.certificate.read_bytes()).hexdigest(),
        "seconds": time.time() - start,
        "checks": {"LQ_equals_constant_combination": True,
                   "constant_pivot_identity": True, "complete_substitution": True,
                   "reduced_pencil": reduced is not None},
        "limitation": "No assertion that the reduced incidence is empty or that any positive point is an actual return.",
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("PASS", "stratum", j, "rank", rank, "seconds", receipt["seconds"], flush=True)


if __name__ == "__main__":
    main()
