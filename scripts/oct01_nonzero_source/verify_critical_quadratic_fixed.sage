#!/usr/bin/env sage
"""Focused new coefficient-kernel checks; retain fixed-source scope."""
from sage.all import *
import argparse,json
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();data=args.work/'data';records=[]
for name in ('quadratic_torsion_d10_m3_seed1','quadratic_torsion_d0_m12_seed1'):
    saved=load(str(data/(name+'_critical_quadratic_coefficients.sobj')));K=saved['K'];A=saved['A'];U=saved['U'];pairs=saved['pairs'];M=saved['matrix'];ker=saved['kernel']
    assert ker.nrows()==1 and not M*ker.transpose()
    vector=ker.row(0);assert not any(vector[len(pairs):])
    raw=[A.zero() for _ in range(11)];zz=matrix(K,len(U))
    for scalar,(i,j) in zip(vector,pairs):
        zz[i,j]=scalar;zz[j,i]=scalar
        for aa in range(6):
            for bb in range(6):raw[aa+bb]+=(1 if i==j else 2)*scalar*U[i][aa]*U[j][bb]
    assert not any(raw) and zz.rank()==4
    rows=saved['pivot_rows'];minor=M.matrix_from_rows_and_columns(rows,list(M.pivots()))
    assert minor.nrows()==150 and minor.ncols()==150 and minor.det()
    records.append({'name':name,'fixed_source_scope':True,'matrix_rank':int(150),'kernel_auxiliary_zero':True,'raw_product_identity':True,'symmetric_relation_rank':int(4),'retained_pivot_minor_nonzero':True})
    print('PASS',name,flush=True)
(data/'critical_quadratic_fixed_verification.json').write_text(json.dumps({'records':records},separators=(',',':'))+'\n')
