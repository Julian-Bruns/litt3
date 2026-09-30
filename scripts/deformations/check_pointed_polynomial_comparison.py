#!/usr/bin/env sage -python
"""Compare polynomial matrices with the certified Laurent construction.

Checks the actual parameter and target Cech basis changes, entry by
entry in the original scalar field, for all16 torsion labels. Raw
receipts must be outside litt3. This is a construction check, not
another projective-resultant computation.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import time
from sage.all import *
from sage.repl.preparse import preparse
from pointed_frobenius_polynomial import build_polynomial_blocks

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--height',type=int,default=3)
parser.add_argument('--output',type=Path,required=True)
args=parser.parse_args()
assert args.height>=2, 'The comparison includes all32 nonempty h>=2 blocks.'
workspace=Path(__file__).resolve().parents[2]
assert not args.output.resolve().is_relative_to(workspace)
args.output.parent.mkdir(parents=True,exist_ok=True)
source=workspace/'scripts/deformations/verify_pointed_extensions.sage'
text=source.read_text()
prefix=text.split('\ndef verify_block(block):',1)[0]
assert prefix.count('P = 25')==1
prefix=prefix.replace('P = 25','P = '+str(5**args.height))
oldargv=sys.argv
sys.argv=[str(source)]
env=dict(globals())
try:
    exec(preparse(prefix),env)
finally:
    sys.argv=oldargv
k=env['k']; P=5**args.height
x=env['x']; y=env['y']; t=env['t']
parameter=matrix(k,3,3,[(y/x**j)[e] for e in [-3,-1,1] for j in [1,2,3]],
                 implementation='generic')
assert all(parameter[i,i]==1 for i in range(3))
assert all(parameter[i,j]==0 for i in range(3) for j in range(i+1,3))
parameter_frob=parameter.apply_map(lambda c:c**P)
started=time.monotonic()
receipt=dict(kind='polynomial_laurent_full_matrix_comparison',height=args.height,
             P=P,precision=int(env['precision']),
             builder_sha256=hashlib.sha256((workspace/'scripts/deformations/pointed_frobenius_polynomial.py').read_bytes()).hexdigest(),
             laurent_sha256=hashlib.sha256(text.encode()).hexdigest(),
             parameter_matrix=[[str(c) for c in row] for row in parameter.rows()],
             blocks=[])
for torsion,R in enumerate(env['twists']):
    old=env['build_blocks'](torsion)
    new=build_polynomial_blocks(env['F'],R,P)
    d=int(R.degree())
    unit=t**(2*d)*env['eval_poly'](R.list(),x)
    kapunit=env['S'](1)+O(t**env['precision'])
    for _ in range(12):
        if (kapunit**2-unit).valuation()>=env['precision']-8:
            break
        kapunit=(kapunit+unit/kapunit)/2
    kap=kapunit/t**d
    for index,(previous,current) in enumerate(zip(old,new)):
        assert previous['weights']==current['weights']
        assert previous['exponents']==current['exponents']
        beta=y/kap if current['source_component']=='kappa' else kap
        series=[beta/x**j for j in current['cech_indices']]
        target=matrix(k,len(series),len(series),
                      [s[e] for e in previous['exponents'] for s in series],
                      implementation='generic')
        assert all(target[i,i]==1 for i in range(len(series)))
        assert all(target[i,j]==0 for i in range(len(series)) for j in range(i+1,len(series)))
        # Explicit generic multiplication stays in original scalar arithmetic.
        oldm=[matrix(k,A.nrows(),A.ncols(),A.list(),implementation='generic')
              for A in previous['matrices']]
        for j in range(3):
            lhs=target*current['matrices'][j]
            rhs=sum((parameter_frob[h,j]*oldm[h] for h in range(3)),
                    matrix(k,lhs.nrows(),lhs.ncols(),implementation='generic'))
            assert lhs==rhs, (torsion,index,j)
        receipt['blocks'].append(dict(torsion=torsion,block=index,
                                     columns=oldm[0].ncols(),
                                     target_unitriangular=True,all_three_identities=True))
    print('torsion',torsion,'PASS',round(time.monotonic()-started,2),flush=True)
receipt['seconds']=round(time.monotonic()-started,3)
receipt['verdict']='All32 complete block identities hold with actual invertible basis changes.'
args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
print(receipt['verdict'],flush=True)
