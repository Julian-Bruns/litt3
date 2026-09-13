#!/usr/bin/env sage
"""Exact structural diagnostics of the first atlas's linear-in-v pencil.

Ranks and invariant spaces are diagnostics, not exclusions. No sampling of
possible atlas points is treated as completeness evidence.
"""
import argparse,hashlib,json,time
from pathlib import Path

ap=argparse.ArgumentParser();ap.add_argument('--chart',type=int,default=23)
ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
start=time.monotonic(); source=Path('Research/computations/canonical_atlas_system.json')
d=json.loads(source.read_text()); k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
cache={}
def c(s):
    if s not in cache:cache[s]=k(sage_eval(s,locals={'a':a}))**5
    return cache[s]
N=[matrix(k,[[c(d['N_tensor'][i][r][h]) for i in range(32)] for r in range(64)]) for h in range(32)]
S=[matrix(k,[[c(d['R_tensor'][i][r][h]) for i in range(32)] for r in range(32)]) for h in range(32)]
j=args.chart
H=[M.stack(T[:j+1,:]) for M,T in zip(N,S)]
# Put the selected s_j=1 row first, so a constant full-rank row choice has
# a nonzero affine source. The omitted rows remain essential constraints.
order=[64+j]+list(range(64+j))
ordered=H[j].matrix_from_rows(order)
piv=list(ordered.transpose().pivots()); selected=[order[h] for h in piv]
out=dict(chart=int(j),source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
    N_single_coordinate_ranks=[int(M.rank()) for M in N],
    H_single_coordinate_ranks=[int(M.rank()) for M in H],
    constant_rank=int(H[j].rank()),selected_rows=selected,
    scope='Exact pencil structure diagnostic, not a solver or exclusion')
if len(selected)==32:
    C=H[j].matrix_from_rows(selected); Ci=C.inverse()
    rhs=vector(k,[int(r==64+j) for r in selected]); v0=Ci*rhs
    A=[-Ci*M.matrix_from_rows(selected) for M in H[j+1:]]
    reach=matrix(k,[v0]); dimensions=[reach.rank()]
    while True:
        new=matrix(k,reach.rows()+[row*M.transpose() for M in A for row in reach.rows()]).row_space().basis_matrix()
        dimensions.append(new.nrows())
        if new.nrows()==reach.nrows():break
        reach=new
    out.update(affine_source_nonzero=bool(v0),reachable_dimensions=[int(r) for r in dimensions],
        perturbation_ranks=[int(M.rank()) for M in A],
        pairwise_commutator_ranks=[[int((M*T-T*M).rank()) for T in A] for M in A],
        perturbation_characteristic_polynomials=[str(M.charpoly()) for M in A])
    # The pencil is NOT replaced by its formal germ; rank-loss branches of C(b)
    # must be retained by any subsequent rational elimination algorithm.
    out['rational_elimination_warning']='Chosen variable-dependent determinant can vanish; no branch discarded'
out['seconds']=time.monotonic()-start
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(out,indent=2,default=int)+'\n')
print(json.dumps(out,indent=2,default=int),flush=True)
