#!/usr/bin/env sage
"""Exact d=b4-a1 branch structure in the saved generic-u b3=0 system.

No Groebner computation and no source or exceptional-u decision.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--reduced',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(15)
start=time.monotonic()
Pu,F,Q,pivots,solved,reduced=load(args.reduced)
P=PolynomialRing(F,names=('a0','b4','d','b0'),order='degrevlex')
a0,b4,d,b0=P.gens()
rows=[(ch,j,P(p(a0,b4-d,b0,b4))) for ch,j,p in reduced]
assert all(p.subs({d:0})==0 for ch,j,p in rows if ch=='odd')
divided=[]
for ch,j,p in rows:
    if ch=='odd':
        assert all(e[2]>=1 for e in p.dict())
        q=P({tuple(e[i]-(1 if i==2 else 0) for i in range(4)):c
             for e,c in p.dict().items()})
        assert d*q==p
        divided.append((ch,j,q))
    else:divided.append((ch,j,p))
target=next(p for ch,j,p in divided if ch=='odd' and j==6)
assert target.degree(b0)==1
coefficient=target.coefficient({b0:1})
assert coefficient.degree()==0 and coefficient
coefficient=F(coefficient.constant_coefficient())
solution=-(target-b0*coefficient)/coefficient
assert solution.degree(b0)<=0
Z=PolynomialRing(F,names=('a0','b4','b0'),order='degrevlex')
zero_rows=[]
for ch,j,p in rows:
    if ch=='even':
        q=Z(p(Z.gen(0),Z.gen(1),0,Z.gen(2)))
        if q:zero_rows.append((ch,j,q))
# The eliminated b1,b2 vanish identically on the whole d=0 slice.
for name in ('b1','b2'):
    values={'a0':a0,'a1':b4-d,'b0':b0,'b1':P.zero(),'b2':P.zero(),'b4':b4}
    original=solved[name]
    p=P(original(*[values[name] for name in original.parent().variable_names()]))
    assert p.subs({d:0})==0
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((Pu,F,P,rows,divided,coefficient,solution,Z,zero_rows),str(out/'difference_split.sobj'))
(out/'difference_split.txt').write_text(
    'Generic u=a2, b3=0, d=b4-a1. No exceptional-u or source decision.\n'+
    'All odd rows divisible by d.\nOdd[x^6]/d b0 pivot = '+str(coefficient)+'\n'+
    'Nonzero-d b0 = '+str(solution)+'\n'+
    '\n'.join('d=0 '+ch+'[x^'+str(j)+'] = '+str(p) for ch,j,p in zero_rows)+'\n'+
    '\n'.join('divided '+ch+'[x^'+str(j)+'] = '+str(p) for ch,j,p in divided)+'\n')
summary={'scope':'generic nonzero a2=u, b3=0; exact d=b4-a1 branch split only',
         'threads':1,'all_odd_rows_divisible_by_d':True,
         'd_zero_b1_b2_vanish':True,
         'd_zero_remaining_equations':len(zero_rows),
         'd_zero_maximum_degree':max(int(p.degree()) for ch,j,p in zero_rows),
         'nonzero_d_b0_pivot':str(coefficient),
         'nonzero_d_b0_solution_degree':int(solution.degree()),
         'divided_system_maximum_degree':max(int(p.degree()) for ch,j,p in divided),
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
