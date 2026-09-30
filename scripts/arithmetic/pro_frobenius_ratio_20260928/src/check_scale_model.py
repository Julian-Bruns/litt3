"""Exact evaluation checks for the 54-row global scale model and minor circuits.
Nonzero minors at the recorded point establish only that the circuits are
nonzero rational functions; their common zero locus is NOT decided here.
"""
import argparse,json,time
from pathlib import Path
import numpy as np
import ext
from ext import Element as E,EP
from ff import mul,neg,inv,va,vm,rref
from residual import check_open
from residual_jet import residual_jet
from scale_model import monic_model,MINOR_INDICES,ideal_columns,nonzero_scale_target
ROOT=Path(__file__).resolve().parents[1]


def columns_matrix(polys,d):
    assert ext.D==1
    a=np.zeros((d,len(polys)),dtype=np.uint32)
    for j,p in enumerate(polys):a[:len(p),j]=p.a[:,0]
    return a


def determinant(a):
    a=a.copy();n=a.shape[0];assert a.shape==(n,n)
    det=1
    for j in range(n):
        p=next((i for i in range(j,n) if a[i,j]),None)
        if p is None:return 0
        if p!=j:a[[j,p]]=a[[p,j]];det=neg(det)
        v=int(a[j,j]);det=mul(det,v)
        row=vm(a[j,j:],np.uint32(inv(v)))
        for i in range(j+1,n):
            if a[i,j]:a[i,j:]=va(a[i,j:],vm(row,np.uint32(neg(int(a[i,j])))))
    return det


def run_checks(save_model=False):
    t=time.time();ext.context([0,1]);q,u=E(1),E(283421);check_open(q,u)
    _,A=residual_jet(q,u,140)
    P,res=monic_model(A,q,u)
    vals=[]
    for idx in MINOR_INDICES:
        mat=columns_matrix([res[n] for n in idx],54)
        det=determinant(mat)
        assert det and len(rref(mat)[1])==54
        vals.append({'tail_indices':idx,'determinant_at_check_point':det})
    data={'status':'three nonzero global determinant circuits in the square ideal; common zero locus undecided',
          'matrix_order':54,'coefficient_ring':'original ratio ring localized only at proved units',
          'scale_polynomial':'C72 / (2*A_top^6*B_top^5*(A_top^2+B_top))',
          'column_definition':'coefficients mu^0,...,mu^53 of corrected_tail_n modulo the monic scale polynomial',
          'check_point':{'q':1,'u':283421},'circuits':vals}
    if save_model:(ROOT/'data/scale_minor_circuits.json').write_text(json.dumps(data,indent=2)+'\n')
    else:assert data==json.loads((ROOT/'data/scale_minor_circuits.json').read_text())
    small=[([0,0,1],[[0,1]],True),([0,4,1],[],False),([1,3,1],[],False),
           ([1,3,1],[[4,1]],False),([1,3,1],[[1]],True),([0,0,0,0,1],[[0,0,0,1]],True)]
    regress=[]
    for pp,gg,expected in small:
        p=EP(pp);rr=[EP(g) for g in gg];cols=list(ideal_columns(rr,p));v=nonzero_scale_target(p)
        m=columns_matrix(cols,p.degree());rank=len(rref(m)[1]) if cols else 0
        aug=columns_matrix(cols+[v],p.degree());rank_aug=len(rref(aug)[1])
        assert (rank==rank_aug)==expected
        gcd=p
        for g in rr:gcd=gcd.gcd(g)
        # This includes nonreduced scale fibres, e.g. (mu-1)^2 and mu^4.
        while len(gcd)>1 and not gcd[0]:gcd=EP([gcd[j] for j in range(1,len(gcd))])
        assert (gcd.degree()==0)==expected
        regress.append({'P':pp,'generators':gg,'no_nonzero_scale':expected,'rank':rank,'augmented_rank':rank_aug})
    out={'status':'passed; global rank condition still not evaluated',
         'minor_determinants':[a['determinant_at_check_point'] for a in vals],
         'nonzero_scale_membership_regressions':regress,'elapsed_seconds':round(time.time()-t,3)}
    print('SCALE_MODEL_VERIFICATION_SUMMARY_JSON='+json.dumps(out,sort_keys=True),flush=True)
    return out

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--generate',action='store_true');ap.add_argument('--save-summary',action='store_true');args=ap.parse_args()
    out=run_checks(args.generate)
    if args.save_summary:(ROOT/'checks/scale_model_verification.json').write_text(json.dumps(out,indent=2)+'\n')
