#!/usr/bin/env sage
"""Choose a numerator pivot over eta only and benchmark exact lambda minors."""
from sage.all import *
import argparse,time
from pathlib import Path
from itertools import combinations_with_replacement
import numpy as np
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);ap.add_argument('--global-basis',action='store_true');args=ap.parse_args();data=args.work/'data';start=time.time()
s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));compact=data/f'twisted_d10m6_incidence_compact_{args.root}.npz';m=load(str(data/f'twisted_d10m6_incidence_compact_metadata_{args.root}.sobj')) if compact.exists() else load(str(data/f'twisted_d10m6_incidence_matrix_{args.root}.sobj'));K=s['K'];RR=s['RR'];eta,lam=RR.gens();J=s['top_compatibility'];pivots=(0,1);g=J.matrix_from_columns(pivots).det();assert not g.degree(lam)
print('LOADED','SECONDS',time.time()-start,flush=True)
if not compact.exists():
    degree=max(f.degree(eta) for f in m['matrix'].list());encoded=np.zeros((m['matrix'].nrows(),m['matrix'].ncols(),3*(int(degree)+1)),dtype=np.uint32)
    for row in range(m['matrix'].nrows()):
        for col in range(m['matrix'].ncols()):
            for (ep,lp),cc in m['matrix'][row,col].dict().items():encoded[row,col,3*int(ep)+int(lp)]=int(cc.to_integer())
    np.savez_compressed(str(compact),coefficients=encoded)
    save({k:v for k,v in m.items() if k!='matrix'},str(data/f'twisted_d10m6_incidence_compact_metadata_{args.root}.sobj'))
    print('COMPACT_EXPORTED','SECONDS',time.time()-start,flush=True)
free=[j for j in range(8) if j not in pivots];B=matrix(RR,8,6)
for column,j in enumerate(free):
    B[j,column]=g;B[pivots[0],column]=-J[1,pivots[1]]*J[0,j]+J[0,pivots[1]]*J[1,j];B[pivots[1],column]=J[1,pivots[0]]*J[0,j]-J[0,pivots[0]]*J[1,j]
assert (J*B).is_zero()
if args.global_basis:B=load(str(data/f'twisted_d10m6_global_top_kernel_{args.root}.sobj'))['global_kernel'];g=RR.one()
L=PolynomialRing(K,'ll',implementation='NTL');ll=L.gen();point=K.one()
def evaluate_eta(f):return sum((cc*point**ee*ll**lp for (ee,lp),cc in RR(f).dict().items()),L.zero())
BB=B.apply_map(evaluate_eta);smallpairs=list(combinations_with_replacement(range(6),2));T=matrix(L,36,21)
for row,(i,j) in enumerate(m['pairs']):
    for col,(f,h) in enumerate(smallpairs):
        if i==j:T[row,col]=BB[i,f]*BB[i,h]*(1 if f==h else 2)
        elif f==h:T[row,col]=BB[i,f]*BB[j,f]
        else:T[row,col]=BB[i,f]*BB[j,h]+BB[i,h]*BB[j,f]
encoded=np.load(str(compact))['coefficients'];digits=encoded.reshape(encoded.shape[0],encoded.shape[1],-1,3);values=np.zeros((encoded.shape[0],encoded.shape[1],3),dtype=np.uint64);prime=int(5)
for exponent in range(8):values+=(((digits//np.uint32(prime**exponent))%np.uint32(prime)).sum(axis=int(2),dtype=np.uint64)%np.uint64(prime))*np.uint64(prime**exponent)
raw=matrix(L,encoded.shape[0],encoded.shape[1],[L([K.from_integer(int(cc)) for cc in coefficients]) for row in values for coefficients in row]);rawcoeff=matrix(K,raw.nrows(),108,[[f[k] for f in row for k in range(3)] for row in raw.rows()]);print('RAW_COEFFICIENT_RANK',rawcoeff.rank(),'OF',108,flush=True)
print('EVALUATED','SECONDS',time.time()-start,flush=True)
M=raw*T;assert not any(M[-16:].list());M=M[:-16];ev=M.apply_map(lambda f:f(K.one()));assert ev.rank()==21
coefficient=matrix(K,M.nrows(),105,[[f[k] for f in row for k in range(5)] for row in M.rows()]);target=matrix(K,21,105)
for j in range(21):target[j,5*j]=1
print('REDUCED_COEFFICIENT_RANK',coefficient.rank(),'OF',105,'TARGET_AUGMENTED',coefficient.stack(target).rank(),flush=True)
for degree in (1,2):
    shift=matrix(K,(degree+1)*M.nrows(),(5+degree)*21)
    for offset in range(degree+1):
        for row,entries in enumerate(M.rows()):
            for col,f in enumerate(entries):
                for k in range(5):shift[offset*M.nrows()+row,(5+degree)*col+k+offset]=f[k]
    rank=shift.rank();target=matrix(K,21,shift.ncols())
    for j in range(21):target[j,(5+degree)*j]=1
    augmented=shift.stack(target).rank();print('LEFT_INVERSE_SHIFT_RANK',degree,rank,'OF',shift.ncols(),'TARGET_AUGMENTED',augmented,flush=True)
    if rank==augmented:break
rows=list(ev.transpose().pivots());Q=M.matrix_from_rows(rows)
print('MINOR_READY','ROWS',len(rows),'DEG',max(f.degree() for f in Q.list()),'PIVOT_ETADEG',g.degree(eta),'SECONDS',time.time()-start,flush=True)
t=time.time();det=Q.det();assert det;print('SAGE_MINOR','LAMBDADEG',det.degree(),'SECONDS',time.time()-t,flush=True)
suffix='_global' if args.global_basis else '';save({'K':K,'RR':RR,'top_kernel':B,'top_pivot':g,'pivot_indices':pivots,'fixed_row_indices':rows,'lambda_minor':det,'lambda_matrix':Q,'setup_path':str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'),'matrix_path':str(data/f'twisted_d10m6_incidence_matrix_{args.root}.sobj')},str(data/f'twisted_d10m6_minor_benchmark_{args.root}{suffix}.sobj'))
try:
    t=time.time();pd=Q._pari_().matdet();print('PARI_MINOR','SECONDS',time.time()-t,flush=True)
except Exception as exc:print('PARI_UNAVAILABLE',type(exc).__name__,str(exc),flush=True)
