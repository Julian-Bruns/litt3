#!/usr/bin/env sage
"""Correct x_second^4 flat-gauge numerator for the saved d=0 family.

Records quotient/support assertions separately; no source, effectivity
or Mumford divisor conclusion. No Groebner calculation or point replay.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--annihilator',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(15)
start=time.monotonic()
R,Rx,G,H,ann,U,remainders=load(args.annihilator)
x=Rx.gen();k=R.base_ring();alpha=k.gen();A=1+4*alpha;B=2+4*alpha
def normal(p):return Rx([c.reduce(G) for c in p.list()])
def add(p,q):return tuple(normal(p[i]+q[i]) for i in range(2))
def scale(p,z):return tuple(normal(z*p[i]) for i in range(2))
def mul(p,q):return (normal(p[0]*q[0]+H*p[1]*q[1]),normal(p[0]*q[1]+p[1]*q[0]))
# g=1/w. Derivatives g'=J1/w^3, g''=J2/w^5, g'''=J3/w^7.
J1=-H.derivative()/2
J2=J1.derivative()*H-3*J1*H.derivative()/2
J3=J2.derivative()*H # coefficient5 in derivative denominator vanishes
K2=J2/3+J1^2/4
zero=(Rx.zero(),Rx.zero())
# Correct epsilon^4 coefficient, multiplied by w^7.
numerator=scale(ann[0],J3/24)
numerator=add(numerator,mul(ann[1],(Rx.zero(),K2)))
numerator=add(numerator,scale(ann[2],3*H*J1/2))
numerator=add(numerator,mul(ann[3],(Rx.zero(),H)))
epsilon=[scale(ann[0],H^3),
         add(scale(ann[0],J1*H^2/2),mul(ann[1],(Rx.zero(),H^2))),
         add(add(scale(ann[0],J2*H/6),mul(ann[1],(Rx.zero(),J1*H))),scale(ann[2],H^2)),
         numerator]
flat_numerators=[]
for j in range(1,5):
    p=zero
    for i in range(j,5):p=add(p,scale(epsilon[i-1],binomial(i,j)*(-x)^(i-j)))
    flat_numerators.append(p)
assert flat_numerators[-1]==numerator
def D(p):return (normal(H*p[1].derivative()+H.derivative()*p[1]/2),normal(p[0].derivative()))
horizontal_cross_remainders=[]
for p in flat_numerators:
    horizontal_cross_remainders.append(add(mul(D(p),numerator),scale(mul(p,D(numerator)),-1)))
quotient_pair=[];branch_remainders=[]
for p in numerator:
    q,r=p.quo_rem(H)
    q,r=normal(q),normal(r)
    assert normal(H*q+r-p)==0
    quotient_pair.append(q);branch_remainders.append(r)
branch_cancel=all(p==0 for p in branch_remainders)
norm_quotient=None;support=[];descended=None
if branch_cancel:
    E,O=quotient_pair
    norm=normal(E^2-H*O^2)
    q,r=norm.quo_rem(U);q,r=normal(q),normal(r)
    assert normal(U*q+r-norm)==0
    if r==0:
        norm_quotient=q
        support=[j for j,c in enumerate(q.list()) if c]
        if all(j%5==0 for j in support):
            RX=PolynomialRing(R,'X');X=RX.gen()
            descended=RX([q[5*j] for j in range(1+q.degree()//5)])
            assert Rx(descended(x^5))==q
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
save((R,Rx,G,H,ann,U,numerator,tuple(quotient_pair),branch_remainders,norm_quotient,descended,
      flat_numerators,horizontal_cross_remainders),str(out/'flat_gauge.sobj'))
(out/'flat_gauge.txt').write_text('w^7 times correct flat gauge = '+str(numerator)+'\n'+
    'division by H remainders = '+str(branch_remainders)+'\n'+
    'polynomial gauge numerator after H cancellation = '+str(quotient_pair)+'\n'+
    'norm quotient by U = '+str(norm_quotient)+'\n'+
    'candidate Y1 polynomial = '+str(descended)+'\n')
summary={'scope':'correct flat-gauge algebra in existing d=0 necessary family only',
         'threads':1,'recomputed_groebner_basis':False,
         'numerator_pair_degrees':[int(p.degree()) for p in numerator],
         'flat_ratio_cross_products_zero':[bool(p==zero) for p in horizontal_cross_remainders],
         'H_cancellation':branch_cancel,
         'polynomial_gauge_pair_degrees':[int(p.degree()) for p in quotient_pair],
         'norm_quotient_degree':None if norm_quotient is None else int(norm_quotient.degree()),
         'norm_quotient_x_support':support,
         'candidate_Y1_polynomial_degree':None if descended is None else int(descended.degree()),
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n');print(json.dumps(summary,default=int))
