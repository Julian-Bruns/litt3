#!/usr/bin/env python3
"""Test the whole necessary H-row module on one geometric source stratum.

No map coefficient or parameter is inverted except the chosen source
normalization. A full module is followed by an exported polynomial left
inverse, so the conclusion can be replayed without a Groebner algorithm.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix, singular, identity_matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("--source-stratum", type=int, choices=range(9), required=True)
    ap.add_argument("--basis-only", action="store_true",
                    help="Retain the exact module decision without computing a membership inverse.")
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    j = args.source_stratum
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30, 15, 10)
    k = GF(25, "a", modulus=PolynomialRing(GF(5), "v")([2, 4, 1]))
    dec = lambda c: k(int(c) % 5) + k(int(c) // 5) * k.gen()
    enc = lambda c: int(c.polynomial()[0]) + 5 * int(c.polynomial()[1])
    names = [f"b{i}" for i in range(j + 1, 10)]
    assert names, "Use elementary constant matrices for the final stratum."
    R = PolynomialRing(k, names, order="degrevlex")
    bvals = [R.zero() if i < j else R.one() if i == j else R(f"b{i}") for i in range(10)]
    HP = matrix(R, 30, 15, [sum(dec(H[r, c, b]) * bvals[b] for b in range(10))
                           for r in range(30) for c in range(15)])
    receipt = {
        "status": "RUNNING", "input_sha256": hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
        "source_stratum": j, "variables": names,
        "scope": "Entire normalized geometric source stratum for the necessary H incidence; no finite-field equations.",
        "algorithm": "Singular module std, followed by an explicit polynomial lift of the free module",
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    M = singular(HP.transpose())
    print("MODULE", j, len(names), "variables", flush=True)
    singular.eval(f"module researchH={M.name()};module researchG=std(researchH);")
    G = singular("matrix(researchG)").sage().change_ring(R)
    receipt.update(status="BASIS_COMPLETE", basis_columns=int(G.ncols()), seconds=time.time() - start)
    full = int(singular.eval("size(reduce(freemodule(15),researchG))")) == 0
    receipt["full_row_module"] = full
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("BASIS", "full", full, "columns", G.ncols(), flush=True)
    if not full:
        receipt["status"] = "NOT_FULL"
        receipt["limitation"] = "No exclusion. A necessary H-kernel does not decide the full return window."
        args.output.write_text(json.dumps(receipt, indent=2) + "\n")
        return
    if args.basis_only:
        receipt["limitation"] = "Exact Singular module decision; an independent polynomial membership replay has not been supplied by this run."
        args.output.write_text(json.dumps(receipt, indent=2) + "\n")
        return
    singular.eval("matrix researchLift=lift(researchH,freemodule(15));")
    L = singular("researchLift").sage().change_ring(R).transpose()
    assert L * HP == identity_matrix(R, 15)
    def encode_poly(f):
        out = []
        for e, c in sorted(f.dict().items()):
            try:
                powers = list(e)
            except TypeError:
                powers = [int(e)]
            out.append([powers, enc(c)])
        return out
    receipt.update(status="COMPLETE", seconds=time.time()-start,
                   left_inverse=[[encode_poly(f) for f in row] for row in L.rows()],
                   maximum_degree=int(max(f.degree() if len(names)==1 else f.total_degree()
                                          for f in L.list() if f)),
                   term_count=sum(len(f.dict()) for f in L.list()))
    args.output.write_text(json.dumps(receipt, separators=(",", ":")) + "\n")
    print("COMPLETE", j, receipt["seconds"], receipt["maximum_degree"], receipt["term_count"], flush=True)


if __name__ == "__main__":
    main()
