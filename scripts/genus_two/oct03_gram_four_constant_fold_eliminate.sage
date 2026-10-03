#!/usr/bin/env sage
"""Bounded elimination of the actual constant-jet fold system.

Inputs are produced by oct03_gram_four_global_constant_jet.sage.
The local fold conditions are a3=0,b5=2*a2,a2!=0.
"""
import argparse
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser = argparse.ArgumentParser()
parser.add_argument('--input', required=True)
parser.add_argument('--output', required=True)
parser.add_argument('--seconds', type=int, default=60)
parser.add_argument('--groebner', action='store_true')
parser.add_argument('--simple-slice', action='store_true')
args=parser.parse_args()
signal.alarm(args.seconds)
start=time.monotonic()
R,Rx,k,H,h,det,rows=load(args.input)
names=('a0','a1','a2','b0','b1','b2','b3','b4','inv_a2')
S=PolynomialRing(k,names=names,order='degrevlex')
a0,a1,a2,b0,b1,b2,b3,b4,inv_a2=S.gens()
sub=R.hom((a0,a1,a2,0,b0,b1,b2,b3,b4,2*a2),S)
equations=[sub(row[2]) for row in rows if sub(row[2])]
equations.append(a2*inv_a2-1)
if args.simple_slice:
    # An explicitly bounded slice, not the whole system.
    equations.extend((b3,b4-a1,b2))
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
essential=[]
for ch,j,eq in rows:
    reduced=sub(eq)
    if reduced and j>=10:
        essential.append(f'{ch}[x^{j}] = {reduced.factor()}')
(out/'leading_reduced.txt').write_text('\n'.join(essential)+'\n')
save((S,equations),str(out/'reduced_system.sobj'))
summary={'status':'reduced_necessary_equations_not_solved',
         'sage_version':SAGE_VERSION,'threads':1,'variable_count':8,
         'equation_count':len(equations),
         'actual_fold_conditions':'a3=0; b5=2*a2; a2 invertible'}
if args.groebner:
    ideal=S.ideal(equations)
    try:
        basis=ideal.groebner_basis(algorithm='libsingular:slimgb')
        save(basis,str(out/'groebner.sobj'))
        summary.update({'groebner_length':len(basis),
                        'unit_ideal':basis==[S.one()],
                        'status':'complete_necessary_system_empty' if basis==[S.one()]
                                 else 'necessary_system_nonunit_groebner_complete',
                        'groebner_max_degree':max(int(p.degree()) for p in basis)})
        (out/'groebner.txt').write_text('\n'.join(str(p) for p in basis)+'\n')
    except Exception as error:
        summary.update({'status':'bounded_elimination_incomplete',
                        'error_type':type(error).__name__,
                        'error':str(error)})
if args.simple_slice:
    summary['scope']='ONLY b3=0,b4=a1,b2=0 slice; no whole conclusion'
summary['elapsed_seconds']=time.monotonic()-start
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
