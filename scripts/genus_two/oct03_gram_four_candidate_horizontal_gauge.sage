#!/usr/bin/env sage
"""Extract a rational horizontal generator of the candidate annihilator."""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--point',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(60)
start=time.monotonic()
E,alpha,point,factor,annihilator,gcd,adj_norm,mumford_u,mumford_v=load(args.point)
Rx=annihilator[0][0].parent()
x0=Rx.gen()
F=Rx.fraction_field()
x=F(x0)
A,B,C=1+4*alpha,2+4*alpha,E(-1)
H=A*x^5+B*x^4+C
zero=(F.zero(),F.zero())
one=(F.one(),F.zero())
def add(p,q):return (p[0]+q[0],p[1]+q[1])
def scale(p,z):return (p[0]*z,p[1]*z)
def mul(p,q):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def inverse(p):
    norm=p[0]^2-H*p[1]^2
    return (p[0]/norm,-p[1]/norm)
def div(p,q):return mul(p,inverse(q))
def power(p,n):
    result=one
    for _ in range(n):result=mul(result,p)
    return result
def derivative(p):return (p[0].derivative(),p[1].derivative()+H.derivative()*p[1]/(2*H))
def iter_derivative(p,n):
    for _ in range(n):p=derivative(p)
    return p
u=[tuple(F(z) for z in p) for p in annihilator]
g=(F.zero(),1/H)
gp,gpp,gppp=[iter_derivative(g,n) for n in (1,2,3)]
e1=mul(u[0],g)
e2=add(scale(mul(u[0],gp),1/E(2)),mul(u[1],power(g,2)))
e3=add(add(scale(mul(u[0],gpp),1/E(6)),mul(u[1],mul(g,gp))),mul(u[2],power(g,3)))
e4=add(add(scale(mul(u[0],gppp),1/E(24)),mul(u[1],add(scale(mul(g,gpp),1/E(3)),scale(power(gp,2),1/E(4))))),
          add(scale(mul(u[2],mul(power(g,2),gp)),3/E(2)),mul(u[3],power(g,4))))
eps=[e1,e2,e3,e4]
# Coefficients in horizontal [x_second^j] basis, constants omitted.
horizontal=[]
for j in range(1,5):
    coefficient=zero
    for i in range(j,5):coefficient=add(coefficient,scale(eps[i-1],binomial(i,j)*(-x)^(i-j)))
    horizontal.append(coefficient)
gauge=horizontal[-1]
assert gauge!=zero
ratios=[div(p,gauge) for p in horizontal]
assert all(derivative(p)==zero for p in ratios)
delta=div(e1,gauge)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((E,alpha,horizontal,gauge,ratios,delta,mumford_u,mumford_v),str(out/'horizontal.sobj'))
(out/'horizontal.txt').write_text('delta coefficient of dx = '+str(delta)+'\n'+
    'horizontal ratios = '+str(ratios)+'\n'+
    'Mumford U = '+str(mumford_u)+'\nMumford V = '+str(mumford_v)+'\n')
summary={'scope':'candidate annihilator only; no actual finite source',
         'all_horizontal_ratios_derivative_zero':'PASS',
         'delta_even_numerator_degree':int(delta[0].numerator().degree()),
         'delta_even_denominator_degree':int(delta[0].denominator().degree()),
         'delta_odd_numerator_degree':int(delta[1].numerator().degree()),
         'delta_odd_denominator_degree':int(delta[1].denominator().degree()),
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
