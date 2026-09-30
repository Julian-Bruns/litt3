"""Complete Hom-space evaluation and map reconstruction at an F25 point.

This utility is a finite-field evaluator, not a geometric existence decision.
Input z consists of the sixteen source 25th-power coordinates. On F25 only,
xi=z is justified because Frobenius squared is the identity. No geometric
stability claim is made by this utility. The exclusion proofs do not restrict
coefficients to F25.
"""
import argparse,json
from pathlib import Path
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]
def serialize(p):return [[i,j,int(c)] for (i,j),c in sorted(p.items(),key=lambda t:(t[0][1],t[0][0]))]
def evaluate(z,all_maps=False):
    z=np.asarray(z,dtype=np.uint8)
    if z.shape!=(16,) or any(int(c)>24 for c in z):raise ValueError('Expected sixteen field codes 0..24')
    D=np.load(ROOT/'data/pencils.npz')
    T=contract_last(D['T'][:16].transpose(1,2,0),z)
    Q=contract_last(D['Q'][:16].transpose(1,2,0),z)
    K=nullspace(T);KL=nullspace(Q)
    raw=contract_last(D['raw'][:16].transpose(1,2,0),z)
    U={};V={}
    for c,(u,v) in zip(z,uv_powers(False)):
        U=add(U,scale(u,int(c)));V=add(V,scale(v,int(c)))
    out=dict(field='F25: beta^2=beta+3',z=z.tolist(),xi=z.tolist(),xi_equals_z_reason='All input coefficients belong to F25',T_rank=rank(T),Q_rank=rank(Q),Hom_to_K_dimension=K.shape[1],Hom_to_L_dimension=KL.shape[1],full_T_kernel=K.T.tolist(),full_Q_kernel=KL.T.tolist(),geometric_stability='not checked',maps=[])
    for k in range(K.shape[1] if all_maps else min(1,K.shape[1])):
        w=K[:,k]
        corrected=NEG[mm(D['H'][:235],mm(raw,w[:,None]))[:,0]]
        f=poly(w[:23],basis(31));alpha=poly(w[23:],basis(20))
        g0=poly(corrected[:123],basis(131));q0=poly(corrected[123:],basis(120))
        a,q,r,f,g,h,B,DD=raw_equations(U,V,f,alpha,g0,q0,True)
        assert not np.any(vec(B,obs_basis(-144))) and not np.any(vec(DD,obs_basis(-155)))
        assert all(i>=0 for p in [a,q,r,f,g,h] for i,j in p)
        minors=[sub(mul(a,g),mul(q,f)),sub(mul(a,h),mul(r,f)),sub(mul(q,h),mul(r,g))]
        generic_rank=2 if any(minors) else (1 if any([a,q,r,f,g,h]) else 0)
        out['maps'].append(dict(kernel_basis_index=k,generic_rank=generic_rank,alpha=serialize(alpha),g0=serialize(g0),q0=serialize(q0),matrix_rows=[[serialize(p) for p in [a,q,r]],[serialize(p) for p in [f,g,h]]],two_by_two_minors=[serialize(p) for p in minors],global_obstructions_zero=True))
    return out
if __name__=='__main__':
    pa=argparse.ArgumentParser();pa.add_argument('--z');pa.add_argument('--sample',action='store_true');pa.add_argument('--all-maps',action='store_true');pa.add_argument('--out',type=Path);args=pa.parse_args()
    if args.sample:z=[0]*10+[16,22,12,7,21,1]
    elif args.z:
        z=[int(x.strip()) for x in args.z.split(',')]
        if len(z)!=16 or any(x<0 or x>24 for x in z):pa.error('--z must contain sixteen field codes 0..24')
    else:pa.error('Supply --z or --sample')
    out=evaluate(z,args.all_maps)
    if args.out:args.out.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k not in ['maps','full_T_kernel','full_Q_kernel']},indent=2))
    print('Reconstructed map generic ranks:',[m['generic_rank'] for m in out['maps']])
    print('This output is not a quotient-window witness or a geometric stability certificate.')
