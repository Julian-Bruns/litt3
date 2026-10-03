#!/usr/bin/env sage
"""Universal full constant-chart regular gauges and leading coefficients.

Polynomial identities over F5 with A,B and all seven chart parameters.
No Groebner basis, reductions, samples, divisors or source decisions.
"""
import argparse
import itertools
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
R=PolynomialRing(GF(5),names=('A','B','a0','a1','u','b0','b1','b2','b4'))
A,B,a0,a1,u,b0,b1,b2,b4=R.gens()
Rx=PolynomialRing(R,'x');x=Rx.gen()
H=A*x^5+B*x^4-1;h=2*B*(A*x^5-1)
zero=(Rx.zero(),Rx.zero());one=(Rx.one(),Rx.zero())
def add(p,q):return tuple(p[i]+q[i] for i in range(2))
def scale(p,z):return tuple(z*p[i] for i in range(2))
def mul(p,q):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def D(p):return (H*p[1].derivative()+2*B*x^3*p[1],p[0].derivative())
def conn(v):
    dv=[D(z) for z in v]
    return (add(dv[0],scale(v[1],-2)),add(dv[1],scale(v[2],-3)),
            add(dv[2],scale(v[3],-4)),add(dv[3],mul((h,Rx.zero()),v[0])))
def det(columns):
    n=len(columns);result=zero
    for p in itertools.permutations(range(n)):
        term=one
        for j in range(n):term=mul(term,columns[j][p[j]])
        sign=(-1)^sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))
        result=add(result,scale(term,sign))
    return result
a=(a0+a1*x+u*x^2,Rx.zero())
b=(b0+b1*x+b2*x^2,b4+2*u*x)
v=(zero,one,a,b);cols=[v]
for j in range(2):cols.append(conn(cols[-1]))
cov=[]
for omitted in range(4):
    minor=[tuple(col[i] for i in range(4) if i!=omitted) for col in cols]
    cov.append(scale(det(minor),(-1)^omitted))
ann=[scale(cov[3],GF(5)(4)^-1),scale(cov[2],GF(5)(3)^-1),
     scale(cov[1],GF(5)(2)^-1),cov[0]]
expected=add(add(scale(D(D(a)),2),scale(D(b),4)),
             add(add(scale(mul(a,D(a)),3),scale(mul(a,b),2)),scale(mul(mul(a,a),a),3)))
assert ann[0]==expected
assert ann[0][0][6]==3*u^3
assert ann[0][1]==2*(b4-a1)*a[0]+4*b1+3*b2*x
assert ann[1][0][7]==3*A*u^2
assert ann[2][1][6]==2*A*u^2
assert ann[3][0][10]==3*A^2*u^2
assert ann[3][1][8]==2*A*u^3
J1=-H.derivative()/2
J2=J1.derivative()*H-3*J1*H.derivative()/2
L1=scale(ann[0],H^2)
L2=add(scale(ann[0],J1*H/2),mul(ann[1],(Rx.zero(),H)))
L3=add(add(scale(ann[0],J2/6),mul(ann[1],(Rx.zero(),J1))),scale(ann[2],H))
L4=add(add(scale(ann[0],2*A*B*x^6+4*B^2*x^5+3*B*x),
             mul(ann[1],(Rx.zero(),3*B*x^2))),
       add(scale(ann[2],2*B*x^3),mul(ann[3],(Rx.zero(),Rx.one()))))
L=[L1,L2,L3,L4];gauges=[]
for j in range(1,5):
    p=zero
    for i in range(j,5):p=add(p,scale(L[i-1],binomial(i,j)*(-x)^(i-j)))
    gauges.append(p)
assert gauges[3]==L4
assert gauges[3][0].degree()==13 and gauges[3][0][13]==2*A^2*u^3
assert gauges[3][1].degree()<=10
assert gauges[0][0].degree()<=15
assert gauges[0][1].degree()==13 and gauges[0][1][13]==-2*A^2*u^2
assert gauges[1][0].degree()<=14 and gauges[1][1].degree()<=11
assert gauges[2][0].degree()<=13 and gauges[2][1].degree()<=11
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
save((R,Rx,H,h,ann,L,gauges),str(out/'universal_constant_gauges.sobj'))
(out/'universal_constant_gauges.txt').write_text('annihilator = '+str(ann)+'\n'+
    'regular L1,L2,L3,L4 = '+str(L)+'\n'+
    'polynomial gauges = '+str(gauges)+'\n')
summary={'scope':'universal full constant-chart polynomial identities; horizontality and source hypotheses separate',
         'threads':1,'groebner_basis':False,'field':'F5[A,B,a0,a1,u,b0,b1,b2,b4]',
         'general_first_coordinate_formula':'PASS','general_first_coordinate_odd_part':'2*(b4-a1)*a+4*b1+3*b2*x',
         'leading_minor_coefficients':'PASS','regular_gauge_functionals':'displayed exactly',
         'gauge_pair_degrees':[[int(z.degree()) for z in p] for p in gauges],
         'G0_pole31_coefficient_odd_sqrtA_suppressed':'-2*A^2*u^2',
         'G3_exact_pole26_coefficient':'2*A^2*u^3',
         'G1_ambient_pole_bound':28,'G2_ambient_pole_bound':27,
         'actual_horizontal_ratio_next_allowed_pole_bound':26,
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n');print(json.dumps(summary,default=int))
