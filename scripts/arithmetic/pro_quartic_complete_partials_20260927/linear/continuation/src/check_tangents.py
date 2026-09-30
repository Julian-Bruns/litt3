"""Exact normal-space checks for the scheme-theoretic rank theorem.

These are universal polynomial diagnostics, NOT points asserted to belong
in the r=[9] parameter family. The proof is in REPORT.md.
"""
from __future__ import annotations
import sys,json,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
import field as F,poly as U,evaluate as E
from frobenius_rank import matrices,differential_matrix,matmul,kernel,twist,ident
from check_frobenius import root_product


def check(J,name,expected):
    n=len(J)-1;R=U.mul(J,J);C=differential_matrix(R);_,M,_=matrices(R)
    # Direction W of the residual, with root variation set to zero.
    # After subtracting the square tangent 2*J*dJ, every normal direction
    # is of this form. No coefficient parameter is localized.
    T0=[[F.scale(U.coeff(J,i-k+1),i+k+1) for k in range(2*n)] for i in range(3*n)]
    V,p=kernel(T0)
    dims=[len(V[0])]
    J3=U.mul(R,J)
    K=[[F.scale(U.coeff(J3,5*a-k),2) for k in range(2*n)] for a in range(n+1)]
    W=matmul(K,V)
    for e in range(1,4):
        test=matmul(twist(C,5**e),W)
        change,p=kernel(test)
        V=matmul(V,change);W=matmul(W,change)
        dims.append(len(V[0]))
        W=matmul(twist(M,5**e),W)
    assert dims==expected,(name,dims,expected)
    assert dims[-1]==0
    print(name,'normal tangent dimensions',dims,'PASS',flush=True)
    return {'name':name,'monic_root_coefficients':J,'residual_is_root_squared':True,
            'normal_dimensions_after_stages':dims,'normal_dimension_after_fourth':0,
            'scope':'universal theorem diagnostic; NOT a parameter point in the r=[9] family'}


def run():
    start=time.time();rows=[]
    rows.append(check(U.powp([0,1],70),'one_root_multiplicity_70',[28,5,1,0]))
    rows.append(check(U.powp([4,1],70),'translated_root_multiplicity_70',[28,5,1,0]))
    rows.append(check(root_product(range(70)),'seventy_distinct_roots',[0,0,0,0]))
    rows.append(check(U.mul(U.powp([0,1],65),U.powp([4,1],5)),
                      'two_roots_multiplicities_65_and_5',[28,5,1,0]))
    out={'status':'exact implementation checks of universal scheme theorem; moving-ratio problem UNRESOLVED',
         'normal_space_tests':rows,'proof_not_inferred_from_tests':'REPORT.md Section 4',
         'seconds':round(time.time()-start,3)}
    (ROOT/'continuation/evidence/tangent_checks.json').write_text(json.dumps(out,indent=2)+'\n')
    print('All universal normal-space checks PASS',flush=True)

if __name__=='__main__':run()
