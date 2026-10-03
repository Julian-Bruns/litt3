#!/usr/bin/env sage
"""Find an exact geometric point of a saved bounded slice, if feasible."""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--input',required=True)
parser.add_argument('--output',required=True)
parser.add_argument('--b4-zero',action='store_true')
parser.add_argument('--lex',action='store_true')
args=parser.parse_args()
signal.alarm(60)
start=time.monotonic()
basis=load(args.input)
S=basis[0].parent()
k=S.base_ring()
gens=S.gens()
ideal=S.ideal(basis)
summary={'scope':'saved simple slice only','base_dimension':int(ideal.dimension())}
if args.b4_zero:
    ideal+=S.ideal(gens[S.variable_names().index('b4')])
    gb=ideal.groebner_basis(algorithm='libsingular:slimgb')
    summary.update({'b4_zero_unit':gb==[S.one()],
                    'b4_zero_dimension':int(ideal.dimension()),
                    'b4_zero_basis_length':len(gb)})
    save(gb,args.output+'.sobj')
    Path(args.output+'.txt').write_text('\n'.join(str(p) for p in gb)+'\n')
    if args.lex:
        T=PolynomialRing(k,names=S.variable_names(),order='lex')
        lex_ideal=T.ideal([T(p) for p in gb])
        lex_basis=lex_ideal.groebner_basis(algorithm='libsingular:slimgb')
        save(lex_basis,args.output+'_lex.sobj')
        Path(args.output+'_lex.txt').write_text('\n'.join(str(p) for p in lex_basis)+'\n')
        summary.update({'lex_length':len(lex_basis),
                        'lex_max_degree':max(int(p.degree()) for p in lex_basis)})
summary['elapsed_seconds']=time.monotonic()-start
Path(args.output+'.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
