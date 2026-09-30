#!/usr/bin/env python3
"""Replay a common-eigenvector obstruction without a computer algebra solver."""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np
from verify_middle_correction_inverse import ADD, NEG, MUL, decode, accumulate
from verify_middle_inverse_checkpoint import exponents


def product(f, g):
    out = {}
    for shift, scalar in g.items():
        accumulate(out, f, shift, scalar)
    return out


def matmul(A, B, n):
    C = [[{} for _ in range(len(B[0]))] for _ in A]
    zero = (0,)*n
    for i, row in enumerate(A):
        for j in range(len(B[0])):
            for k, a in enumerate(row):
                if a and B[k][j]:
                    accumulate(C[i][j], product(a, B[k][j]), zero, 1)
    return C


def rank(A):
    A = [list(map(int, row)) for row in A]
    r = 0
    for c in range(len(A[0])):
        p = next((i for i in range(r, len(A)) if A[i][c]), None)
        if p is None:
            continue
        A[r], A[p] = A[p], A[r]
        inv = next(x for x in range(1,25) if MUL[x][A[r][c]] == 1)
        A[r] = [MUL[inv][x] for x in A[r]]
        for i in range(r+1, len(A)):
            if A[i][c]:
                sc = NEG[A[i][c]]
                A[i] = [ADD[x][MUL[sc][y]] for x,y in zip(A[i],A[r])]
        r += 1
        if r == len(A):
            break
    return r


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("certificate", type=Path)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    compact = args.certificate.suffix == ".npz"
    if compact:
        z = np.load(args.certificate, allow_pickle=False)
        c = {"status":"COMPLETE", "input_sha256":str(z["input_sha256"]),
             "source_stratum":int(z["source_stratum"])}
        if "normal_ordered_words" in z:
            c["normal_ordered_words"] = z["normal_ordered_words"].astype(int).tolist()
    else:
        c = json.loads(args.certificate.read_text())
    assert c["status"] == "COMPLETE"
    assert c["input_sha256"] == hashlib.sha256(args.tensor.read_bytes()).hexdigest()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30,15,10)
    assert np.array_equal(H[:15,:,0],np.eye(15,dtype=np.uint8))
    assert not np.count_nonzero(H[15:,:,0])
    assert not np.count_nonzero(H[:15,:,1])
    assert np.array_equal(H[15:,:,1],np.eye(15,dtype=np.uint8))
    j = c["source_stratum"]
    n = 9-j
    zero = (0,)*n
    affine = [(zero,j)] + [(tuple(int(a==b) for a in range(n)),j+1+b) for b in range(n)]
    blocks = []
    for offset in [0,15]:
        blocks.append([[{e:int(H[offset+r,s,b]) for e,b in affine if H[offset+r,s,b]}
                        for s in range(15)] for r in range(15)])
    U,V = blocks
    UV,VU = matmul(U,V,n),matmul(V,U,n)
    C = UV
    for r in range(15):
        for s in range(15):
            accumulate(C[r][s],VU[r][s],zero,4)
    words = c.get("normal_ordered_words", [[0,0],[1,0],[0,1]])
    assert words and all(isinstance(a,int) and isinstance(b,int) and a>=0 and b>=0 for a,b in words)
    S = []
    for a,b in words:
        W = C
        for _ in range(a):
            W = matmul(W,U,n)
        for _ in range(b):
            W = matmul(W,V,n)
        S.extend(W)
    rows = len(S)
    if compact:
        degrees = list(map(int,z["generator_degrees"]))
        assert len(degrees)==rows
        assert degrees==[max(sum(e) for f in row for e in f) for row in S]
        total = int(z["total_degree"])
        monos = [exponents(n,total-d) for d in degrees]
        coeff = z["coefficients"]
        assert coeff.shape==(sum(map(len,monos)),15) and np.all(coeff<25)
        L = [[{} for _ in range(rows)] for _ in range(15)]
        offset = 0
        for r,ms in enumerate(monos):
            for u,e in enumerate(ms):
                for a in range(15):
                    value = int(coeff[offset+u,a])
                    if value:
                        L[a][r][e] = value
            offset += len(ms)
    else:
        L = [[decode(f,n) for f in row] for row in c["left_inverse"]]
    assert len(L)==15 and all(len(row)==rows for row in L)
    LS = matmul(L,S,n)
    assert all(LS[r][s]==({zero:1} if r==s else {}) for r in range(15) for s in range(15))
    # The final projective stratum b9=1 has no variables. Check it once
    # by its constant commutator, in the same independent field arithmetic.
    U9,V9 = H[:15,:,9],H[15:,:,9]
    C9 = [[0]*15 for _ in range(15)]
    for r in range(15):
        for s in range(15):
            for a in range(15):
                C9[r][s]=ADD[C9[r][s]][MUL[int(U9[r,a])][int(V9[a,s])]]
                C9[r][s]=ADD[C9[r][s]][NEG[MUL[int(V9[r,a])][int(U9[a,s])]]]
    last_rank = rank(C9)
    assert last_rank == 15
    out = {"status":"PASS", "source_stratum":j, "seconds":time.time()-start,
           "input_sha256":c["input_sha256"],
           "certificate_sha256":hashlib.sha256(args.certificate.read_bytes()).hexdigest(),
           "checks":{"exact_block_form":True,"commutator_reconstruction":True,
                     "left_inverse_of_stacked_commutators":True,"b9_constant_commutator_rank":last_rank},
           "scope":"Excludes a common eigenvector for all b0,b1 on this normalized stratum of b2..b9; also checks the final b9-only stratum."}
    args.output.write_text(json.dumps(out,indent=2)+"\n")
    print("PASS",j,out["seconds"],flush=True)


if __name__ == "__main__":
    main()
