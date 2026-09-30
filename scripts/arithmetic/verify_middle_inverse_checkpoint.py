#!/usr/bin/env python3
"""Verify the compact coefficient checkpoint as an exact polynomial inverse.

This avoids expanding or saving the derived reduced pencil. The identity
L(b)Q(b)=I is checked directly from the original tensor, using elementary
F25 tables; it already proves the global elimination of all corrections.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

import numpy as np
from verify_middle_correction_inverse import accumulate


def exponents(n, degree):
    out = []
    for d in range(degree+1):
        for indices in itertools.combinations_with_replacement(range(n), d):
            e = [0]*n
            for i in indices:
                e[i] += 1
            out.append(tuple(e))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("checkpoint", type=Path)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    z = np.load(args.checkpoint, allow_pickle=False)
    digest = hashlib.sha256(args.tensor.read_bytes()).hexdigest()
    assert str(z["input_sha256"]) == digest
    assert H.shape == (30,15,10)
    j, degree = int(z["source_stratum"]), int(z["degree_bound"])
    assert 0 <= j <= 2 and degree >= 0
    n = 9-j
    monomials = exponents(n,degree)
    selected = list(map(int,z["selected_rows"]))
    assert len(set(selected)) == len(selected) and all(0 <= r < 30 for r in selected)
    C = z["constant_combinations"]
    assert np.array_equal(C,np.eye(7,dtype=np.uint8))
    coefficients = z["coefficients"]
    assert coefficients.shape == (len(selected)*len(monomials),7)
    assert np.all(coefficients < 25)
    zero = (0,)*n
    affine = [(zero,j)]+[(tuple(int(k==t) for k in range(n)),j+1+t) for t in range(n)]
    L = [[{} for _ in range(30)] for _ in range(7)]
    for rr,r in enumerate(selected):
        for u,e in enumerate(monomials):
            for a in range(7):
                value = int(coefficients[rr*len(monomials)+u,a])
                if value:
                    L[a][r][e] = value
    for a in range(7):
        for col in range(7):
            out = {}
            for r in selected:
                for shift,b in affine:
                    accumulate(out,L[a][r],shift,int(H[r,8+col,b]))
            assert out == ({zero:1} if a==col else {}),(a,col)
    receipt = {
        "status":"PASS", "input_sha256":digest,
        "checkpoint_sha256":hashlib.sha256(args.checkpoint.read_bytes()).hexdigest(),
        "source_stratum":j,"inverse_degree_bound":degree,"eliminated_correction_rank":7,
        "polynomial_term_count":sum(len(f) for row in L for f in row),
        "seconds":time.time()-start,
        "scope":"Exact global polynomial left inverse of the seven correction columns on the normalized geometric source stratum.",
        "checks":{"coefficient_encoding":True,"LQ_equals_I7":True,"no_parameter_localization":True},
        "limitation":"This alone does not decide the reduced incidence or certify a Frobenius return.",
    }
    args.output.write_text(json.dumps(receipt,indent=2)+"\n")
    print("PASS compact inverse",j,receipt["seconds"],receipt["polynomial_term_count"],flush=True)


if __name__ == "__main__":
    main()
