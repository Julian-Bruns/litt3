#!/usr/bin/env sage
"""Exact eta-only top-moment module, with every slope retained."""
from sage.all import *
import argparse,time
from pathlib import Path
from itertools import combinations
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));K=s['K'];RR=s['RR'];eta,lam=RR.gens();N=PolynomialRing(K,'ee',implementation='NTL');ee=N.gen();J=s['top_compatibility']
def ep(f):
    assert not f.degree(lam)
    return N({int(e):c for (e,l),c in f.dict().items()})
C=matrix(N,[[ep(J[i,j]) for j in range(3)] for i in range(2)]);minors=[C.matrix_from_columns(p).det() for p in combinations(range(3),2)];g=N.zero()
for f in minors:g=g.gcd(f)
H,U=C.transpose().hermite_form(include_zero_rows=True,transformation=True);assert U*C.transpose()==H;assert U.det().degree()==0
print('MINOR_DEGREES',[f.degree() for f in minors],'MINOR_GCD_DEGREE',g.degree(),'HERMITE',H,flush=True)
B=None
if H[:2]==identity_matrix(N,2) and not any(H[2].list()):
    split=U.transpose();right=split[:,:2];kernel=split.column(2);assert C*right==identity_matrix(N,2) and not any(C*kernel)
    def rr(f):return sum((c*eta**e for e,c in enumerate(f.list())),RR.zero())
    B=matrix(RR,8,6)
    for j in range(3):B[j,0]=rr(kernel[j])
    for col in range(5):
        B[3+col,1+col]=1
        for j in range(3):B[j,1+col]=-sum((rr(right[j,i])*J[i,3+col] for i in range(2)),RR.zero())
    lead=max(range(3),key=lambda j:kernel[j].degree())
    for col in range(1,6):
        quotient=RR.zero()
        for lp in range(2):
            component=N({int(e):c for (e,l),c in B[lead,col].dict().items() if l==lp})
            q,_=component.quo_rem(kernel[lead]);quotient+=rr(q)*lam**lp
        for j in range(8):B[j,col]-=quotient*B[j,0]
    assert (J*B).is_zero()
    print('GLOBAL_KERNEL','ETADEG',max(f.degree(eta) for f in B.list()),'LAMDEG',max(f.degree(lam) for f in B.list()),flush=True)
save({'K':K,'RR':RR,'N':N,'C':C,'minor_polynomials':minors,'minor_gcd':g,'hermite':H,'transformation':U,'global_kernel':B},str(data/f'twisted_d10m6_global_top_kernel_{args.root}.sobj'))
