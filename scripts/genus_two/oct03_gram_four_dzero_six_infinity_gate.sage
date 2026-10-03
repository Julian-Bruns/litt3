#!/usr/bin/env sage
"""NEW necessary |6P| gate for the actual d=0 constant source.

Read the saved annihilator and its saved GB only. Other marked classes
are already excluded theoretically. No GB, sample, coefficient search,
point replay or source construction. Actual application requires the
audited divisor bridge D=iota(R), and the original source's D in |6P|.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time

parser=argparse.ArgumentParser()
parser.add_argument('--annihilator',required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
started=time.monotonic()
input_path=Path(args.annihilator)
source_path=Path(args.source)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'linear_gate.sobj').exists()
R,Rx,G,H,ann,U,old_norm_remainders=load(str(input_path))
x=Rx.gen()
vs=dict(zip(R.variable_names(),R.gens()))
assert U.is_monic() and U.degree()==6
assert len(ann)==4 and len(G)>0
assert all(z==0 for z in old_norm_remainders)
zero=Rx.zero()
one=Rx.one()

def normal(p):
    return Rx([c.reduce(G) for c in p.list()])

def product(p,q):
    return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])

def remainder(p):
    return tuple(normal(z.quo_rem(U)[1]) for z in p)

basis=[(one,zero),(x,zero),(x^2,zero),(x^3,zero),(zero,one)]
row_tags=[(j,s,e) for j in range(1,4) for s in range(2) for e in range(6)]
columns=[]
for even,odd in basis:
    conjugate=(even,-odd)
    blocks=[remainder(product(ann[j],conjugate)) for j in range(1,4)]
    columns.append([pair[s][e] for pair in blocks for s in range(2) for e in range(6)])
M=matrix(R,36,5,lambda i,j:columns[j][i])
save((R,Rx,G,H,ann,U,basis,row_tags,M),str(out/'linear_gate.sobj'))

summary={
    'scope':'NEW necessary |6P| gate; actual d=0 divisor bridge required',
    'threads':1,
    'new_groebner_basis':False,
    'numeric_samples':False,
    'source_sha256':hashlib.sha256(source_path.read_bytes()).hexdigest(),
    'input_sha256':hashlib.sha256(input_path.read_bytes()).hexdigest(),
    'saved_basis_count':len(G),
    'matrix_dimensions':[36,5],
    'column_basis':['1','x','x^2','x^3','w'],
    'simple_root_or_nonbranch_assumption':False,
    'minors':[],
}

def checkpoint():
    summary['elapsed_seconds']=time.monotonic()-started
    (out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')

checkpoint()
# Fixed before execution, unchanged from the unexecuted three-class source.
# No adaptive row/minor search.
row_sets=[(2,3,4,5,11),(0,1,2,6,7)]
for rows in row_sets:
    determinant=M.matrix_from_rows(rows).determinant().reduce(G)
    inverse=None
    if determinant!=0 and len(determinant.monomials())==1:
        coefficient=determinant.coefficients()[0]
        exponent=determinant.exponents()[0]
        names=R.variable_names()
        forbidden=[n for n,e in zip(names,exponent) if e and n not in ('a2','inv_a2')]
        if not forbidden:
            inverse=R(1/coefficient)
            for n,e in zip(names,exponent):
                if n=='a2':inverse*=vs['inv_a2']^e
                if n=='inv_a2':inverse*=vs['a2']^e
            assert (determinant*inverse-1).reduce(G)==0
    summary['minors'].append({
        'rows':list(rows),'row_tags':[row_tags[i] for i in rows],
        'normal_form':str(determinant),'zero':bool(determinant==0),
        'explicit_unit_inverse':None if inverse is None else str(inverse),
        'explicit_unit_check':bool(inverse is not None),
    })
    checkpoint()
summary['completed_both_fixed_minors']=True
checkpoint()
print(json.dumps(summary,default=int))
