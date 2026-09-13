"""Finite checks of the doubled-irrational-tangent late norm lemma.

This is an audit aid, not a universal proof or a geometric simulation.
Uses the existing exact F25 coefficient/mixed-additive routines.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import json
from pathlib import Path
import random
import numpy as np
from scripts.deformations.rank25 import check_nodal25_late_inputs as C


def run():
    rng=random.Random(2026091302)
    one=np.zeros((25,2),dtype=np.int64);one[0,0]=1
    def mul(a,b):return (C.cm(a)@b.reshape(50)).reshape(25,2)%125
    def scale(a,c):return a@C.coefficient_matrix(c).T%125
    powers=[]
    for g in [(1,0),(0,1)]:
        e=-one.copy();e[C.INDEX[g],0]=1
        pp=[one]
        for _ in range(4):pp.append(mul(pp[-1],e))
        powers.append(pp)
    norm=np.tile(np.eye(2,dtype=np.int64),(25,1))
    results=[]
    for trial in range(48):
        slope=np.array([trial%5,1+(trial//5)%4])
        u=(powers[0][1]+scale(powers[1][1],slope))%125
        f=mul(u,u)
        if trial>=4:
            for i,j in C.MONOMIALS:
                if i+j>=3:
                    f=(f+scale(mul(powers[0][i],powers[1][j]),
                              [rng.randrange(5),rng.randrange(5)]))%125
        corr=np.zeros((50,50),dtype=np.int64)
        blocks=[np.array([[rng.randrange(25) for _ in range(2)] for _ in range(2)],dtype=np.int64) for _ in C.GROUP]
        for i,(s,t) in enumerate(C.GROUP):
            for j,(v,w) in enumerate(C.GROUP):
                corr[2*i:2*i+2,2*j:2*j+2]=blocks[C.INDEX[((v-s)%5,(w-t)%5)]]
        L=(C.cm(f)+5*corr)%125
        ext=np.column_stack([L,-norm])%125
        M=ext%5;K=C.kernel(M);left=C.kernel(M.T)
        assert K.shape==(22,52),K.shape
        carry=(ext@K.T%25)//5;B=left@carry%5
        leading=K.T@C.kernel(B).T%5
        poly=np.column_stack([C.solve(C.V,v[:50]) for v in leading.T])
        assert not np.any(poly[C.DEGREES>2])
        homogeneous=poly@C.kernel(leading[50:,:]).T%5
        assert not np.any(homogeneous[C.DEGREES>1])
        low4=np.flatnonzero(C.DEGREES<=4)
        for j in np.flatnonzero(C.DEGREES<=2):
            C.solve(L@C.V[:,low4]%5,C.V[:,j]%5)
        second=[]
        for z0 in leading.T:
            z1=C.solve(M,-((ext@z0%25)//5))
            res=ext@(z0+5*z1)%125
            assert not np.any(res%25)
            second.append(left@(res//25)%5)
        second=np.column_stack(second)
        full=leading@C.kernel(C.kernel(B.T)@second%5).T%5
        assert full.shape==(52,2),full.shape
        assert not np.any(full[50:])
        full_poly=np.column_stack([C.solve(C.V,v[:50]) for v in full.T])
        assert not np.any(full_poly[C.DEGREES>0])
        # Integral trace holds for EVERY first repair, not only a filtered choice.
        for z0 in leading.T:
            z1=C.solve(M,-((ext@z0%25)//5))
            xx=z0[:50]+5*z1[:50]
            assert not np.any(xx.reshape(25,2).sum(axis=0)%25)
        assert not np.any(K[:,:50].reshape(len(K),25,2).sum(axis=1)%5)
        results.append({'trial':trial,'slope':slope.tolist(),
            'higher_augmentation':trial>=4,'arbitrary_mixed_additive_corrections':True,
            'first_norm_dimension_F5':int(leading.shape[1]),
            'first_norm_degree_bound':2,'homogeneous_degree_bound':1,
            'F2_in_image':True,'combined_integral_trace_mod25_zero':True,
            'full_norm_reduction_dimension_F5':2,'full_norm_only_invariant':True,
            'full_norm_eta_reduction_zero':True})
    return {'status':'PASS','coefficient_ring':'(Z/125)[a]/(a^2-2)',
            'cases':results,'scope':'48 exact finite tests; not the general proof.'}


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path);args=p.parse_args()
    result=run()
    if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS',len(result['cases']),'doubled irrational tangent models, with all repair digits.')
