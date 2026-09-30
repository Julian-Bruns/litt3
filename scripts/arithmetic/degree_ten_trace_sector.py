#!/usr/bin/env python3
"""Exact linear restrictions of the already verified degree-ten family."""
import argparse
import json
import sys
from pathlib import Path

p=argparse.ArgumentParser()
p.add_argument('archive',type=Path)
p.add_argument('output',type=Path)
a=p.parse_args()
sys.path.insert(0,str(a.archive/'source'))
from reconstruction import np,DIG,VARS,nullE,matmulE,rrefE,enc

d=json.loads((a.archive/'certificates/linear_system.json').read_text())
K=DIG[:,np.array(d['full_kernel_columns'],dtype=np.int64).T]
out={}
for name,extra in [('trace_zero',[]),('trace_zero_polynomial_v',[VARS.index((0,1,0))]),('linear_derivative',[j for j,v in enumerate(VARS) if v[0]==2])]:
    rows=[j for j,v in enumerate(VARS) if v[0]==1]+extra
    kernel,piv=nullE(K[:,rows,:]);restricted=matmulE(K,kernel)
    assert not restricted[:,rows,:].any()
    kr=len(rrefE(restricted[:,195:196,:])[1])
    vrows=[j for j,v in enumerate(VARS) if v[0]==0]
    vrank=len(rrefE(restricted[:,vrows,:])[1])
    record=dict(homogeneous_dimension=restricted.shape[2],kappa_rank=kr,
                normalized_affine_dimension=restricted.shape[2]-1 if kr else None,
                v_projection_rank=vrank,
                full_kernel_columns=[[enc(restricted[:,i,j]) for i in range(196)] for j in range(restricted.shape[2])])
    out[name]=record
    print(name, {k:v for k,v in record.items() if k!='full_kernel_columns'},flush=True)
a.output.parent.mkdir(parents=True,exist_ok=True)
a.output.write_text(json.dumps(out,indent=2)+'\n')
