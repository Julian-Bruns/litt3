#!/usr/bin/env python3
"""Independently replay L*H=I by explicit F25 coefficient arithmetic."""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np

from verify_middle_correction_inverse import decode, accumulate


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
    L = [[decode(f, n) for f in row] for row in cert["left_inverse"]]
    assert len(L) == 15 and all(len(row) == 30 for row in L)
    for r in range(15):
        for c in range(15):
            out = {}
            for s in range(30):
                for shift, b in affine:
                    accumulate(out, L[r][s], shift, int(H[s, c, b]))
            assert out == ({zero: 1} if r == c else {}), (r, c)
    receipt = {
        "status": "PASS", "input_sha256": cert["input_sha256"],
        "certificate_sha256": hashlib.sha256(args.certificate.read_bytes()).hexdigest(),
        "source_stratum": j, "seconds": time.time()-start,
        "scope": "Exact polynomial left inverse of H on the entire normalized geometric source stratum.",
        "checks": {"L_times_H_equals_I15": True, "no_parameter_localization": True},
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("PASS", "stratum", j, "seconds", receipt["seconds"], flush=True)


if __name__ == "__main__":
    main()
