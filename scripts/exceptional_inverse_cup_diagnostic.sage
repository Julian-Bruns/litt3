#!/usr/bin/env sage
"""One-core polynomial-only q/cup diagnostic; never starts an atlas solver.

All kernels and fifth-power reconstructions are replayed against original
polynomial equations. Samples describe structure, not geometric exclusions.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import *

ap=argparse.ArgumentParser()
ap.add_argument('--rep',default='invariant_0')
ap.add_argument('--output',type=Path)
args=ap.parse_args()
start=time.monotonic()
exec(compile(Path('scripts/oper_representatives.sage').read_text(),
             'oper_representatives.sage','exec'))
data=load_oper(args.rep)
k,R,x,F=data['k'],data['R'],data['x'],data['F']
P=tuple(data['P']); Fp=F.derivative(); zero=(R.zero(),)*3
def basis(n):
    return sorted([(i,j) for j in range(3) for i in range(n//3+1)
                   if 3*i+10*j<=n],key=lambda ij:3*ij[0]+10*ij[1])
def poly(v,mons):
    ans=[R.zero() for _ in range(3)]
    for c,(i,j) in zip(v,mons): ans[j]+=c*x**i
    return tuple(ans)
def coeff(v,mons): return vector(k,[v[j][i] for i,j in mons])
def mon(m):
    ans=[R.zero() for _ in range(3)]; ans[m[1]]=x**m[0]
    return tuple(ans)
def sub(v,w): return tuple(f-g for f,g in zip(v,w))
def add(v,w): return tuple(f+g for f,g in zip(v,w))
def scale(c,v): return tuple(c*f for f in v)
def mul(v,w):
    ans=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        for h,g in enumerate(w): ans[(j+h)%3]+=f*g*F**((j+h)//3)
    return tuple(ans)
def delta(v):
    ans=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        ans[(j+2)%3]+=f.derivative()*F**((j+2)//3)
        if j: ans[j-1]+=2*j*f*Fp
    return tuple(ans)
def op(v): return sub(delta(delta(v)),mul(P,v))
dP=delta(P)
def third(v):
    return add(add(delta(delta(delta(v))),mul(P,delta(v))),scale(3,mul(dP,v)))
def kernel(mons):
    ims=[op(mon(m)) for m in mons]
    deg=max(f.degree() for v in ims for f in v)
    A=matrix(k,[[v[j][i] for v in ims] for j in range(3) for i in range(deg+1)])
    K=A.right_kernel().basis_matrix()
    assert A*K.transpose()==0 and K.nrows()+A.rank()==A.ncols()
    return K
M32,M64,M112,M160=map(basis,(32,64,112,160))
KU,KH=kernel(M112),kernel(M32)
assert KU.nrows()==32 and KH.nrows()==3
us=[poly(v,M112) for v in KU]; hs=[poly(v,M32) for v in KH]
QM=matrix(k,[coeff(third(mon(m)),M112) for m in M64]).transpose()
Qc=KU.transpose().solve_right(QM)
assert KU.transpose()*Qc==QM and Qc.rank()==32
assert all(poly(QM.column(i),M112)==third(mon(m)) for i,m in enumerate(M64))

def fifth(v):
    ans=[R.zero() for _ in range(3)]
    for j,f in enumerate(v): ans[(5*j)%3]+=f**5*F**((5*j)//3)
    return tuple(ans)
PM=matrix(k,[coeff(fifth(mon(m)),M160) for m in M32]).transpose()
rows=list(PM.transpose().pivots()); inverse=PM.matrix_from_rows(rows).inverse()
def wronskian5(v,w):
    W=sub(mul(v,delta(w)),mul(w,delta(v)))
    assert delta(W)==zero
    raw=coeff(W,M160)
    assert poly(raw,M160)==W
    out=inverse*vector(k,[raw[i] for i in rows])
    assert PM*out==raw
    return out
qs=[matrix(k,[wronskian5(u,h) for h in hs]).transpose() for u in us]
products=matrix(k,[coeff(mul(mon(i),mon(j)),M64) for i in M32 for j in M32])
cups_flat=products*Qc.transpose()
cups=[matrix(k,24,24,[c**5 for c in cups_flat.column(j)]) for j in range(32)]
assert all(C==C.transpose() for C in cups)
def sector(v,mons): return sorted(set(j for c,(i,j) in zip(v,mons) if c))
cup_ranks=[int(C.rank()) for C in cups]
tests=[]
for sector_id in range(3):
    indices=[i for i,row in enumerate(Qc) if sector(row,M64)==[sector_id]]
    C=sum(((k(1)+data['a']*(i+1))*cups[i] for i in indices),zero_matrix(k,24))
    mu=matrix(k,[vector(k,(C*q).list()) for q in qs]).transpose()
    KM=mu.right_kernel().basis_matrix()
    assert mu*KM.transpose()==0 and KM.nrows()+mu.rank()==32
    qkernels=[sum((c*q for c,q in zip(row,qs)),zero_matrix(k,24,3)) for row in KM]
    tests.append(dict(sector=sector_id,dimension=len(indices),cup_rank=int(C.rank()),
                      q_constraint_rank=int(mu.rank()),kernel_dimension=int(KM.nrows()),
                      q_kernel_basis_ranks=[int(Q.rank()) for Q in qkernels],
                      pure_x_kernel_gcds=[str(poly(row*KU,M112)[0].gcd(poly(row*KU,M112)[0].derivative()))
                          if sector(row*KU,M112)==[0] else None for row in KM],
                      branch_kernel_gcds=[str(poly(row*KU,M112)[0].gcd(F))
                          if sector(row*KU,M112)==[0] else None for row in KM],
                      U_kernel_polynomials=[list(map(str,poly(row*KU,M112))) for row in KM],
                      cup_coefficients=[str(k(1)+data['a']*(i+1)) if i in indices else '0' for i in range(32)],
                      kernel_coefficients=[list(map(str,row)) for row in KM]))
small_wedges=[wronskian5(hs[i],hs[j]) for i in range(3) for j in range(i+1,3)]
out=dict(rep=args.rep,scope='Polynomial structure diagnostic only; no atlas exclusion',
         h0V_basis=[list(map(str,h)) for h in hs],
         h0V_sectors=[sector(v,M32) for v in KH],
         U_sector_counts=[sum(sector(v,M112)==[j] for v in KU) for j in range(3)],
         J_sector_counts=[sum(sector(v,M64)==[j] for v in Qc) for j in range(3)],
         cup_coordinate_ranks=cup_ranks,sector_tests=tests,
         wedge_H0V_rank=int(matrix(k,small_wedges).rank()),
         all_original_kernel_and_fifthpower_checks=True,
         seconds=float(round(time.monotonic()-start,3)))
print(json.dumps(out,indent=2),flush=True)
if args.output:
    args.output.write_text(json.dumps(out,indent=2)+'\n')
