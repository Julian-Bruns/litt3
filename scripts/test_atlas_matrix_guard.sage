#!/usr/bin/env sage
"""Deterministic fresh-process Sage dense/scalar matrix arithmetic guard.

Run this file in a fresh Sage process; no random seed or pre-existing objects.
It records an upstream optimized-matrix mismatch, not a failed atlas identity.
"""
import json
from pathlib import Path
Z=PolynomialRing(GF(5),'z')
results=[]
for modulus in ([2,4,1],[4,2,1]):
    k=GF(25,'a',modulus=Z(modulus),check_irreducible=False);a=k.gen()
    M=matrix(k,[[1,a],[a,1]]);M.set_immutable();before=tuple(M.list())
    N=matrix(k,2,2,M.list(),implementation='generic');N.set_immutable()
    scalar=matrix(k,[[sum((M[i,h]*M[h,j] for h in range(2)),k.zero())
                     for j in range(2)] for i in range(2)],implementation='generic')
    fast=M*M;generic=N*N
    assert tuple(M.list())==before and M.base_ring() is N.base_ring()
    assert generic==scalar and scalar[0,0]==1+a*a
    results.append(dict(sage_version=version(),field_type=str(type(k)),matrix_type=str(type(M)),
        modulus=list(map(int,modulus)),seed='none; deterministic matrix [[1,a],[a,1]]',immutable=True,
        parent_identity_verified=True,inputs_unchanged=True,
        optimized_product=list(map(str,fast.list())),scalar_product=list(map(str,scalar.list())),
        optimized_matches_scalar=bool(fast==scalar),generic_matches_scalar=True))
assert results[0]['optimized_matches_scalar']
print(json.dumps(results,indent=2),flush=True)
out=Path(__file__).resolve().parents[2]/'litt3-computation-data/orbit11-structure/sage_dense_matrix_guard.json'
out.write_text(json.dumps(dict(scope='Fresh-process scalar arithmetic audit; no production certificate invalidity inferred',results=results),indent=2)+'\n')
