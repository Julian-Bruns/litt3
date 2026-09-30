#!/usr/bin/env python3
"""Test common eigenvectors independently of the two scalar source entries.

H=(b0 I+U,b1 I+V)^t. Every H-kernel lies in the kernel of
C=[U,V], C U and C V. A polynomial left inverse for their stacked
matrix excludes all b0,b1 on the chosen projective stratum of b2..b9.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix, identity_matrix, singular


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("--source-stratum", type=int, choices=range(2, 9), required=True)
    ap.add_argument("--word-depth", type=int, choices=range(1,5), default=1)
    ap.add_argument("--basis-only", action="store_true")
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30, 15, 10)
    assert np.array_equal(H[:15, :, 0], np.eye(15, dtype=np.uint8))
    assert not np.count_nonzero(H[15:, :, 0])
    assert not np.count_nonzero(H[:15, :, 1])
    assert np.array_equal(H[15:, :, 1], np.eye(15, dtype=np.uint8))
    k = GF(25, "a", modulus=PolynomialRing(GF(5), "v")([2, 4, 1]))
    dec = lambda c: k(int(c) % 5) + k(int(c) // 5) * k.gen()
    enc = lambda c: int(c.polynomial()[0]) + 5 * int(c.polynomial()[1])
    j = args.source_stratum
    names = [f"b{i}" for i in range(j+1, 10)]
    R = PolynomialRing(k, names, order="degrevlex")
    vals = [R.zero() if i < j else R.one() if i == j else R(f"b{i}") for i in range(10)]
    blocks = [matrix(R, 15, 15, [sum(dec(H[offset+r, c, b])*vals[b] for b in range(2, 10))
                               for r in range(15) for c in range(15)]) for offset in [0, 15]]
    U, V = blocks
    C = U*V - V*U
    words = [(d-b,b) for d in range(args.word_depth+1) for b in range(d+1)]
    blocks = [C*(U**a)*(V**b) for a,b in words]
    S = blocks[0]
    for block in blocks[1:]:
        S = S.stack(block)
    receipt = {
        "status": "RUNNING", "input_sha256": hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
        "source_stratum": j, "variables": names, "matrix_shape": [S.nrows(), 15],
        "word_depth": args.word_depth, "normal_ordered_words": words,
        "scope": "Necessary common-eigenvector obstruction, uniform in both b0 and b1; only bj is normalized.",
        "matrix_definition": "Stack [U,V] U^a V^b for the recorded normal-ordered words",
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    M = singular(S.transpose())
    print("COMMON EIGEN", j, len(names), "variables", flush=True)
    singular.eval(f"module eigenM={M.name()};module eigenG=std(eigenM);")
    full = int(singular.eval("size(reduce(freemodule(15),eigenG))")) == 0
    receipt.update(status="BASIS_COMPLETE", full_row_module=full,
                   basis_columns=int(singular.eval("size(eigenG)")), seconds=time.time()-start)
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("BASIS", full, "seconds", receipt["seconds"], flush=True)
    if not full or args.basis_only:
        return
    singular.eval("matrix eigenLift=lift(eigenM,freemodule(15));")
    L = singular("eigenLift").sage().change_ring(R).transpose()
    assert L*S == identity_matrix(R, 15)
    def poly(f):
        out = []
        for e, c in sorted(f.dict().items()):
            try:
                powers = list(e)
            except TypeError:
                powers = [int(e)]
            out.append([powers, enc(c)])
        return out
    receipt.update(status="COMPLETE", seconds=time.time()-start,
                   left_inverse=[[poly(f) for f in row] for row in L.rows()],
                   maximum_degree=int(max(f.degree() if len(names)==1 else f.total_degree()
                                          for f in L.list() if f)),
                   term_count=sum(len(f.dict()) for f in L.list()))
    args.output.write_text(json.dumps(receipt, separators=(",", ":")) + "\n")
    print("COMPLETE", j, receipt["seconds"], receipt["term_count"], flush=True)


if __name__ == "__main__":
    main()
