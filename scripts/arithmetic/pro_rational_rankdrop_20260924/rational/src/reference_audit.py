"""Bounded, independently implemented cross-check of recorded algebraic witnesses.

The exhaustive proof is the full certificate verification. This audit checks all
65 degree-seven representatives and reproducibly selected records in other degrees.
"""
from __future__ import annotations
import argparse,json,time
from pathlib import Path
from reference_matrices import *

def selection(path: Path) -> list[int]:
    d,count=read_header(path)
    if d==4:return list(range(count))
    chosen={0,count//2,count-1}; found_open=False;found_later=False
    data=path.read_bytes()
    for i in range(count):
        _,w,_=RECORD.unpack_from(data,16+i*RECORD.size)
        if not found_open and any(32<=x<64 for x in w):chosen.add(i);found_open=True
        if not found_later and any(4<=x<24 for x in w):chosen.add(i);found_later=True
        if found_open and found_later:break
    return sorted(chosen)

def audit(ns: list[int]) -> dict:
    start=time.monotonic();selected={};counts={'power':0,'pole_zero':0,'degree_or_constant':0};total=0
    for n in ns:
        path=ROOT/'certificates'/f'n{n:02}.rrc';d,count=read_header(path)
        if d!=n-3:raise ValueError('degree mismatch')
        selected[str(n)]=selection(path)
        for index in selected[str(n)]:
            mask,w,_=read_record(path,index);I=pole_indices(mask)
            if len(I)!=d:raise ValueError('wrong pole count')
            E=evaluation_spaces(I)
            for phase,reason in enumerate(w):
                _,v=phase_kernel(I,E,phase)
                counts[check_reason(reason,I,E,v)]+=1
            total+=1
        print(f'reference n={n} records={len(selected[str(n)])} PASS',flush=True)
    return {'status':'PASS','scope':'bounded independent cross-check; not exhaustive coverage proof',
            'field':'F_5[q]/degree-14 polynomial','matrix_basis':'partial fractions',
            'degrees':ns,'record_selection':selected,'records':total,'phase_cases':64*total,
            'witness_counts':counts,'seconds':time.monotonic()-start}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--n',nargs='+',type=int,default=list(range(7,27)));p.add_argument('--output',type=Path)
    args=p.parse_args()
    if any(n<7 or n>26 for n in args.n):p.error('n must lie in 7..26')
    result=audit(sorted(set(args.n)));text=json.dumps(result,indent=2)+'\n'
    if args.output:args.output.write_text(text)
    print(text,end='')
