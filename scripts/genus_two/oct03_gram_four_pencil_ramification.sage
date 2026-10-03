#!/usr/bin/env sage
"""Test the proposed ramification implication on the fixed witness.

Differentiates on the genuine relative target Y1, not its flat pullback.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--point',required=True)
parser.add_argument('--incidence',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
E,alpha,point,factor,annihilator,U,adj_norm,mumford_u,mumford_v=load(args.point)
E2,conditions,sections,connection_matrix,kernel,flat_sections,image0,image1,image_polynomial,p0,p1=load(args.incidence)
assert E2==E
Rx=U.parent()
x0=Rx.gen()
F=Rx.fraction_field()
x=F(x0)
A,B,C=1+4*alpha,2+4*alpha,E(-1)
H=A*x^5+B*x^4+C
def mul(p,q,H):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def inverse(p,H):
    norm=p[0]^2-H*p[1]^2
    return (p[0]/norm,-p[1]/norm)
f0,f1=[tuple(F(z) for z in p) for p in flat_sections]
ratio=mul(f1,inverse(f0,H),H)
R1=PolynomialRing(E,'X')
X0=R1.gen()
F1=R1.fraction_field()
X=F1(X0)
def descend_polynomial(p):
    assert all(i%5==0 for i,c in enumerate(p.list()) if c)
    return R1({i//5:c for i,c in enumerate(p.list()) if c})
def descend_fraction(f):
    return F1(descend_polynomial(f.numerator()))/descend_polynomial(f.denominator())
# W on Y1 pulls to w^5=H(x)^2*w. Coefficients stay fixed over k.
descended=(descend_fraction(ratio[0]),descend_fraction(ratio[1]/H^2))
H1=A^5*X^5+B^5*X^4+C^5
dr=(descended[0].derivative(),descended[1].derivative()+H1.derivative()*descended[1]/(2*H1))
pulled_dr=(F(dr[0](x^5)),F(dr[1](x^5)*H^2))
for f,g in annihilator:
    if g.gcd(U).degree()==0:
        sheet=(-f*g.inverse_mod(U))%U
        break
# Use a length-six local Taylor algebra at all six R points. The pair
# coefficients of a globally regular ratio can separately have poles
# at the conjugate x-values, so reducing their denominators would be
# invalid. Hasse coefficient five gives the DESCENDED derivative.
AR=Rx.quotient(U,'xbar')
xbar=AR.gen()
assert AR(Rx(H)).is_unit()
PR=PowerSeriesRing(AR,'epsilon',default_prec=6)
epsilon=PR.gen()
local_x=PR(xbar)+epsilon
local_H=Rx(H)(local_x)
local_w=PR(-sheet(xbar))
for _ in range(3):local_w=(local_w+local_H/local_w)/2
assert (local_w^2-local_H).valuation()>=6
local_f0=flat_sections[0][0](local_x)+flat_sections[0][1](local_x)*local_w
local_f1=flat_sections[1][0](local_x)+flat_sections[1][1](local_x)*local_w
assert local_f0[0].is_unit()
local_ratio=local_f1/local_f0
assert all(local_ratio[i]==0 for i in range(1,5))
finite_dr=local_ratio[5].lift()
finite_ramification_count=int(U.gcd(finite_dr).degree())
# P is evaluated in its regular descended parameter Z; r(P) is finite.
PS=PowerSeriesRing(E,'Z',default_prec=40)
Z=PS.gen()
s=1+(B^5/A^5)*Z^2+(C^5/A^5)*Z^10
root=PS.one()
for _ in range(6):root=(root+s/root)/2
LS=LaurentSeriesRing(E,'Z',default_prec=40)
z=LS.gen()
xx=z^-2
ww=E.gen()^5*z^-5*LS(root)
r_series=descended[0](xx)+descended[1](xx)*ww
assert r_series.valuation()>=0
assert r_series[0]==p1/p0
ramification_index_at_P=int((r_series-r_series[0]).valuation())
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((E,descended,dr,finite_dr,ramification_index_at_P),str(out/'ramification.sobj'))
summary={'scope':'one exact witness; test of proposed universal constant-p ramification shortcut',
         'threads':1,'finite_adjunction_zeros':6,
         'finite_adjunction_zeros_that_are_trigonal_ramification_points':finite_ramification_count,
         'trigonal_ramification_index_at_P':ramification_index_at_P,
         'all_seven_are_ramification_points':finite_ramification_count==6 and ramification_index_at_P>=2,
         'relative_target_equation':'W^2=A^5 X^5+B^5 X^4-1; k-coefficients unchanged under relative pullback',
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
