#!/usr/bin/env sage
"""Generic triangular elimination in the full constant-jet system.

The coefficient field treats a2,b3 as algebraically independent. All
vanishing pivot strata remain separate; generic decisions are scoped.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--input',required=True)
parser.add_argument('--output',required=True)
parser.add_argument('--groebner',action='store_true')
args=parser.parse_args()
signal.alarm(30)
start=time.monotonic()
R,Rx,k,H,h,det,equations=load(args.input)
Params=PolynomialRing(k,names=('u','t'))
u,t=Params.gens()
F=Params.fraction_field()
P=PolynomialRing(F,names=('a0','a1','b0','b1','b2','b4'),order='degrevlex')
a0,a1,b0,b1,b2,b4=P.gens()
values=[a0,a1,P(u),P.zero(),b0,b1,b2,P(t),b4,P(2*u)]
def map_poly(p):
    return sum(P(c)*prod(values[i]^j for i,j in enumerate(e)) for e,c in p.dict().items())
rows=[(ch,j,map_poly(eq)) for ch,j,eq in equations]
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
solved={}
pivots={}
for name,character,degree in [('b2','odd',10),('b1','even',11),('b0','even',10)]:
    target=P.gen(P.variable_names().index(name))
    equation=next(p for ch,j,p in rows if ch==character and j==degree)
    assert equation.degree(target)==1
    coefficient=equation.coefficient({target:1})
    assert coefficient.degree()==0 and coefficient
    coefficient=F(coefficient.constant_coefficient())
    solution=-(equation-target*coefficient)/coefficient
    assert solution.degree(target)==0
    pivots[name]=coefficient
    solved[name]=solution
    rows=[(ch,j,p.subs({target:solution})) for ch,j,p in rows]
    solved={key:value.subs({target:solution}) for key,value in solved.items()}
Q=PolynomialRing(F,names=('a0','a1','b4'),order='degrevlex')
reduced=[]
for ch,j,p in rows:
    assert all(p.degree(P.gen(P.variable_names().index(name)))<=0 for name in ('b0','b1','b2'))
    converted=Q(p(Q.gen(0),Q.gen(1),0,0,0,Q.gen(2)))
    if converted:reduced.append((ch,j,converted))
save((Params,F,Q,pivots,solved,reduced),str(out/'triangle.sobj'))
(out/'triangle.txt').write_text('GENERIC parameters a2=u,b3=t; vanishing pivots not covered\n'+
    '\n'.join(name+' pivot = '+str(pivot) for name,pivot in pivots.items())+'\n'+
    '\n'.join(name+' = '+str(solution) for name,solution in solved.items())+'\n'+
    '\n'.join(ch+'[x^'+str(j)+'] = '+str(p) for ch,j,p in reduced)+'\n')
summary={'scope':'generic a2,b3 over rational function coefficient field; exceptional pivots open',
         'threads':1,'free_unknowns':3,'remaining_equations':len(reduced),
         'maximum_remaining_degree':max(int(p.degree()) for ch,j,p in reduced),
         'pivots':{name:str(pivot) for name,pivot in pivots.items()},
         'status':'triangle_only'}
if args.groebner:
    try:
        basis=Q.ideal([p for ch,j,p in reduced]).groebner_basis(algorithm='libsingular:slimgb')
        save(basis,str(out/'groebner.sobj'))
        (out/'groebner.txt').write_text('\n'.join(str(p) for p in basis)+'\n')
        summary.update({'status':'generic_groebner_completed','unit':basis==[Q.one()],
                        'basis_length':len(basis),
                        'maximum_basis_degree':max(int(p.degree()) for p in basis)})
    except Exception as exc:
        summary.update({'status':'bounded_groebner_incomplete','exception':str(exc)})
summary['elapsed_seconds']=time.monotonic()-start
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
