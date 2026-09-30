#!/usr/bin/env python3
"""Rebuild the exact minor and graded-module certificates; no field-point search."""
from __future__ import annotations
import argparse
import itertools
import json
from pathlib import Path
import sys
import time
import numpy as np
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
import graded_module as gm

def minor_data(M):
    rows,cols,det=gm.pivot_witness(M)
    return {'rank':len(rows),'row_indices':rows.tolist(),
            'column_indices':cols.tolist(),'determinant_code':det}

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--group',choices=('all','P4','large'),default='all')
    args=parser.parse_args()
    gm.field_self_test()
    T=np.load(ROOT/'data/hom_tensor.npz')['T']
    assert T.shape==(19,80,35)
    start=time.monotonic()
    if args.group in ('all','P4'):
        certificates=[]
        outside=[i for i in range(19) if i not in (0,6,7)]
        for k,pair in enumerate(itertools.combinations(outside,2),1):
            support=[0,6,7,*pair]
            M=gm.macaulay(T[support],4)
            evidence=minor_data(M)
            assert evidence['rank']==2450==M.shape[1],support
            certificate={'support':support,'degree':4,'matrix_shape':list(M.shape),
                         'minor':evidence}
            certificates.append(certificate)
            print('P4',k,support,'shape',M.shape,'rank',evidence['rank'],
                  'minor determinant',evidence['determinant_code'],flush=True)
        (ROOT/'certificates/P4.json').write_text(json.dumps(certificates,indent=1)+'\n')
        assert len(certificates)==120
    if args.group in ('all','large'):
        supports=[
          ('pure_u_P5',[0,1,2,3,4,5]),
          ('mixed_a_P5',[0,6,7,1,2,3]),
          ('mixed_b_P5',[0,6,7,8,9,10]),
          ('mixed_c_P5',[0,6,7,13,14,15]),
          ('mixed_d_P5',[0,6,7,1,8,13]),
          ('mixed_P6',[0,6,7,1,8,13,2]),
        ]
        certificates=[]
        for name,support in supports:
            M=gm.macaulay(T[support],4)
            evidence=minor_data(M)
            N,pivots,free=gm.normal_form(M)
            assert evidence['rank']==len(pivots)
            h=N.shape[1]
            record={'name':name,'support':support,'degree':4,
                    'matrix_shape':list(M.shape),'quotient_dimension':h,'minor':evidence}
            print(name,'degree 4',M.shape,'rank',len(pivots),'quotient',h,flush=True)
            if h:
                filename=f'certificates/{name}_normal_form.npz'
                np.savez_compressed(ROOT/filename,N=N,free=free)
                record['normal_form_file']=filename
                n=len(support)
                count=gm.relation_count(n,4,35)
                success=False
                for scale in (2,4,8,16):
                    size=min(count,max(1024,scale*n*h))
                    indices=np.random.default_rng(0).choice(count,size=size,replace=False)
                    A=gm.commutator_relations(N,n,4,35,indices)
                    rows,cols,det=gm.pivot_witness(A)
                    print(name,'relation sample',len(indices),'rank',len(rows),
                          'target',n*h,flush=True)
                    if len(rows)==n*h:
                        assert np.array_equal(cols,np.arange(n*h))
                        record['commutator']={
                          'full_relation_count':count,
                          'sample_size':len(indices),
                          'selection_seed':0,
                          'selected_relation_indices':indices[rows].tolist(),
                          'square_size':n*h,'determinant_code':det}
                        record['vanishing_degree']=5
                        success=True
                        break
                assert success, f'No certificate obtained for {name}'
            else:
                record['vanishing_degree']=4
            certificates.append(record)
        (ROOT/'certificates/large.json').write_text(json.dumps(certificates,indent=1)+'\n')
    print('PASS certificate generation; elapsed seconds',round(time.monotonic()-start,3),flush=True)

if __name__=='__main__':
    main()
