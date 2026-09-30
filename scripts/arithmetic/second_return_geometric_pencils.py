#!/usr/bin/env sage-python
"""Exact all-geometric two-coordinate LOWER-MAP pencils, not full P34.

Each affine pencil w=e_i+s e_j gives an 80x19 matrix A(s).
The source kernel is in the pure-v P5 iff rank(A)-rank(A[:,13:])=13.
One maximal minor covers the generic open. Every root of that minor
is checked in its exact residue field. The common infinity endpoints
are checked separately. No finite-field sampling is used as coverage.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
import numpy as np
from sage.all import GF, PolynomialRing, matrix

p = argparse.ArgumentParser()
p.add_argument("archive", type=Path)
p.add_argument("output", type=Path)
p.add_argument("--limit", type=int, default=595)
args = p.parse_args()
t0 = time.monotonic()
R5 = PolynomialRing(GF(5), "z"); z = R5.gen()
F = GF(25, "b", modulus=z*z-z-3); b = F.gen()
R = PolynomialRing(F, "s"); s = R.gen(); K = R.fraction_field()
els = [F(a % 5) + F(a // 5)*b for a in range(25)]
T = np.load(args.archive / "data/tensors.npz")["T"]
def code(x):
    c = list(F(x).polynomial()); c += [0]*(2-len(c))
    return int(c[0]) + 5*int(c[1])
def coeffs(f):
    return [code(x) for x in R(f).list()]
def const_matrix(j):
    return matrix(F, 80, 19, lambda a,c: els[int(T[c,a,j])])
const = [const_matrix(j) for j in range(35)]
for A in const:
    assert A.rank()-A[:,13:].rank() == 13
records = []
for i,j in list(itertools.combinations(range(35),2))[:args.limit]:
    A = const[i].change_ring(R) + s*const[j].change_ring(R)
    AK = A.change_ring(K)
    rt = AK[:,13:].rank()
    cols = list(AK.pivots()); r = len(cols)
    if r-rt != 13:
        records.append({"pair":[i,j], "generic_outside":True,
                        "rank":r,"tail_rank":rt})
        print("GENERIC OUTSIDE",i,j,r,rt,flush=True)
        break
    rows = list(AK[:,cols].transpose().pivots())
    minor = R(A[rows,cols].determinant())
    assert minor
    roots = []
    for f,m in minor.factor():
        if f.degree()==1:
            E=F; q=-f[0]/f[1]
        else:
            E=F.extension(f, "q");q=E.gen()
        AE=const[i].change_ring(E)+q*const[j].change_ring(E)
        ar, tr = AE.rank(), AE[:,13:].rank()
        roots.append({"factor":coeffs(f.monic()),"multiplicity":int(m),
                      "rank":int(ar),"tail_rank":int(tr)})
        if ar-tr !=13:
            print("EXCEPTIONAL OUTSIDE",i,j,coeffs(f),ar,tr,flush=True)
    records.append({"pair":[i,j],"generic_rank":r,"generic_tail_rank":rt,
                    "rows":rows,"columns":cols,"minor":coeffs(minor),
                    "exceptional_factors":roots})
    if len(records)%25==0:
        print("pencils",len(records),"seconds",round(time.monotonic()-t0,2),flush=True)
    if any(x["rank"]-x["tail_rank"]!=13 for x in roots):break
result={"scope":"all geometric lower-map directions with support at most two only if all595 pencils pass",
        "pencils_checked":len(records),"constant_directions_checked":35,
        "records":records,"elapsed_seconds":time.monotonic()-t0}
args.output.write_text(json.dumps(result,indent=2)+'\n')
print("DONE",len(records),round(time.monotonic()-t0,2),flush=True)
