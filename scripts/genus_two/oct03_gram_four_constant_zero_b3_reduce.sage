#!/usr/bin/env sage
"""Bounded generic-a2 reduction on b3=0, retaining b0 as a variable.

The b3=0 source implication remains a separately audited antecedent.
Even a generic unit ideal leaves exceptional a2 values explicit.
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
parser.add_argument('--unit-lift',action='store_true')
args=parser.parse_args()
signal.alarm(30)
start=time.monotonic()
R,Rx,k,H,h,det,equations=load(args.input)
Pu=PolynomialRing(k,'u')
u=Pu.gen()
F=Pu.fraction_field()
P=PolynomialRing(F,names=('a0','a1','b0','b1','b2','b4'),order='degrevlex')
a0,a1,b0,b1,b2,b4=P.gens()
values=[a0,a1,P(u),P.zero(),b0,b1,b2,P.zero(),b4,P(2*u)]
def map_poly(p):
    return sum(P(c)*prod(values[i]^j for i,j in enumerate(e))
               for e,c in p.dict().items())
rows=[(ch,j,map_poly(eq)) for ch,j,eq in equations]
solved={}
pivots={}
for name,ch,degree in [('b2','odd',10),('b1','even',11)]:
    target=P.gen(P.variable_names().index(name))
    equation=next(p for character,j,p in rows if character==ch and j==degree)
    assert equation.degree(target)==1
    coefficient=equation.coefficient({target:1})
    assert coefficient.degree()==0 and coefficient
    coefficient=F(coefficient.constant_coefficient())
    solution=-(equation-target*coefficient)/coefficient
    assert solution.degree(target)<=0
    pivots[name]=coefficient
    solved[name]=solution
    rows=[(character,j,p.subs({target:solution})) for character,j,p in rows]
    solved={key:value.subs({target:solution}) for key,value in solved.items()}
Q=PolynomialRing(F,names=('a0','a1','b0','b4'),order='degrevlex')
reduced=[]
for ch,j,p in rows:
    assert p.degree(b1)<=0 and p.degree(b2)<=0
    converted=Q(p(Q.gen(0),Q.gen(1),Q.gen(2),0,0,Q.gen(3)))
    if converted:reduced.append((ch,j,converted))
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((Pu,F,Q,pivots,solved,reduced),str(out/'reduced.sobj'))
(out/'reduced.txt').write_text(
    'b3=0; a2=u generic nonzero. No exceptional-u conclusion.\n'+
    '\n'.join(name+' pivot = '+str(pivot) for name,pivot in pivots.items())+'\n'+
    '\n'.join(name+' = '+str(value) for name,value in solved.items())+'\n'+
    '\n'.join(ch+'[x^'+str(j)+'] = '+str(p) for ch,j,p in reduced)+'\n')
summary={'scope':'b3=0, a2=u generic; exceptional a2 values not decided',
         'threads':1,'free_unknowns':4,'remaining_equations':len(reduced),
         'maximum_remaining_degree':max(int(p.degree()) for ch,j,p in reduced),
         'pivots':{name:str(pivot) for name,pivot in pivots.items()},
         'status':'reduction_only'}
def checkpoint():
    summary['elapsed_seconds']=time.monotonic()-start
    (out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
checkpoint()
if args.groebner:
    I=Q.ideal([p for ch,j,p in reduced])
    basis=I.groebner_basis(algorithm='libsingular:slimgb')
    save(basis,str(out/'groebner.sobj'))
    (out/'groebner.txt').write_text('\n'.join(str(p) for p in basis)+'\n')
    summary.update({'status':'generic_groebner_completed',
                    'unit':list(basis)==[Q.one()],
                    'basis_length':len(basis),
                    'maximum_basis_degree':max(int(p.degree()) for p in basis)})
    if list(basis)!=[Q.one()]:summary['dimension_over_generic_a2']=int(I.dimension())
    checkpoint()
    if args.unit_lift and list(basis)==[Q.one()]:
        lifts=list(Q.one().lift(I))
        assert sum(c*p for c,(ch,j,p) in zip(lifts,reduced))==1
        denominator=Pu.one()
        for p in lifts+[p for ch,j,p in reduced]:
            for c in p.coefficients():denominator=denominator.lcm(Pu(c.denominator()))
        denominator=denominator.monic()
        save((lifts,denominator),str(out/'unit_lift.sobj'))
        (out/'unit_lift.txt').write_text('Exceptional u polynomial = '+str(denominator)+'\n'+
            '\n'.join(str(p) for p in lifts)+'\n')
        summary.update({'generic_unit_lift_verified':True,
                        'exceptional_a2_polynomial':str(denominator),
                        'exceptional_a2_polynomial_degree':int(denominator.degree())})
        checkpoint()
print(json.dumps(summary,default=int))
