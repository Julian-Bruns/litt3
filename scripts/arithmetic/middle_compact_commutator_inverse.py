#!/usr/bin/env python3
"""Seek a bounded weighted-degree inverse of the common-eigenvector matrix.

Save exact linear coefficients, not large expanded polynomial matrices.
A bounded failure is not an assertion that the matrix drops rank.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix, identity_matrix


def monomials(n, d):
    out = []
    for a in range(d+1):
        for inds in itertools.combinations_with_replacement(range(n), a):
            e = [0]*n
            for i in inds:
                e[i] += 1
            out.append(tuple(e))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("--source-stratum", type=int, choices=range(2,8), required=True)
    ap.add_argument("--total-degree", type=int, required=True)
    ap.add_argument("--word-depth", type=int, choices=range(1,5), default=1)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30,15,10)
    k = GF(25,"a",modulus=PolynomialRing(GF(5),"v")([2,4,1]))
    dec = lambda c:k(int(c)%5)+k(int(c)//5)*k.gen()
    enc = lambda c:int(c.polynomial()[0])+5*int(c.polynomial()[1])
    j,n,D = args.source_stratum,9-args.source_stratum,args.total_degree
    R = PolynomialRing(k,[f"b{i}" for i in range(j+1,10)],order="degrevlex")
    vals = [R.zero() if i<j else R.one() if i==j else R(f"b{i}") for i in range(10)]
    U,V = [matrix(R,15,15,[sum(dec(H[o+r,c,b])*vals[b] for b in range(2,10))
                            for r in range(15) for c in range(15)]) for o in [0,15]]
    C = U*V-V*U
    words = [(d-b,b) for d in range(args.word_depth+1) for b in range(d+1)]
    blocks = [C*(U**a)*(V**b) for a,b in words]
    S = blocks[0]
    for block in blocks[1:]:
        S = S.stack(block)
    rows = S.nrows()
    degrees = [int(max(f.total_degree() for f in row if f)) for row in S.rows()]
    assert min(degrees)>0 and max(degrees)<=D
    small = [monomials(n,D-d) for d in degrees]
    offsets = [0]
    for v in small:
        offsets.append(offsets[-1]+len(v))
    large = monomials(n,D)
    pos = {e:i for i,e in enumerate(large)}
    M = matrix(k,15*len(large),offsets[-1])
    receipt = {"status":"BUILDING", "input_sha256":hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
               "source_stratum":j,"total_degree_bound":D,"matrix_shape":[M.nrows(),M.ncols()],
               "word_depth":args.word_depth,"normal_ordered_words":words,
               "generator_degrees":degrees,
               "scope":"Bounded exact polynomial inverse of stacked [U,V], [U,V]U, [U,V]V; no finite-field equations."}
    args.output.write_text(json.dumps(receipt,indent=2)+"\n")
    print("BUILD",j,D,M.nrows(),M.ncols(),flush=True)
    for r in range(rows):
        for c in range(15):
            for e,a in S[r,c].dict().items():
                for u,v in enumerate(small[r]):
                    w=tuple(x+y for x,y in zip(e,v))
                    M[c*len(large)+pos[w],offsets[r]+u]=a
    target=matrix(k,M.nrows(),15)
    for c in range(15):
        target[c*len(large),c]=1
    receipt["status"]="SOLVING"
    args.output.write_text(json.dumps(receipt,indent=2)+"\n")
    print("SOLVE",time.time()-start,flush=True)
    A=M.augment(-target).echelon_form()
    pivots=A.pivots(); r=sum(p<M.ncols() for p in pivots)
    obstruction=A[r:len(pivots),M.ncols():]
    combinations=obstruction.right_kernel().basis_matrix()
    if combinations.nrows()!=15:
        receipt.update(status="NO_FULL_INVERSE_AT_BOUND",recoverable_constant_rank=int(combinations.nrows()),seconds=time.time()-start)
        args.output.write_text(json.dumps(receipt,indent=2)+"\n")
        print(receipt["status"],receipt["recoverable_constant_rank"],flush=True)
        return
    assert combinations==identity_matrix(k,15)
    coeff=matrix(k,M.ncols(),15)
    for row,p in enumerate(pivots[:r]):
        coeff[p,:]=-A[row,M.ncols():]
    assert M*coeff==target
    checkpoint=args.output.with_suffix(".npz")
    np.savez_compressed(checkpoint,input_sha256=receipt["input_sha256"],source_stratum=j,total_degree=D,
                        normal_ordered_words=np.array(words,dtype=np.uint8),
                        generator_degrees=np.array(degrees,dtype=np.uint8),
                        coefficients=np.array([[enc(x) for x in row] for row in coeff.rows()],dtype=np.uint8))
    receipt.update(status="COMPLETE",seconds=time.time()-start,
                   checkpoint_sha256=hashlib.sha256(checkpoint.read_bytes()).hexdigest(),
                   checkpoint_bytes=checkpoint.stat().st_size,
                   checks={"linear_coefficient_identity":True},
                   limitation="Independent coefficient replay is required before promoting the exclusion.")
    args.output.write_text(json.dumps(receipt,indent=2)+"\n")
    print("COMPLETE",receipt["seconds"],receipt["checkpoint_bytes"],flush=True)


if __name__ == "__main__":
    main()
