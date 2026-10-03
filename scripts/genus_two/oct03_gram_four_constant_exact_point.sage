#!/usr/bin/env sage
"""Exact geometric determinant point and saturated Cartier-line degree.

Only a necessary horizontal-kernel point is constructed. No original
constant source, degree-ten row or pair of etale maps is constructed.
"""
import argparse
import itertools
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser=argparse.ArgumentParser()
parser.add_argument('--lex')
parser.add_argument('--system')
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(60)
start=time.monotonic()
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
names=('a0','a1','a2','b0','b1','b2','b3','b4','inv_a2')
if args.lex:
    gb=load(args.lex)
    T=gb[0].parent()
    k=T.base_ring()
    U=PolynomialRing(k,'t')
    t=U.gen()
    univariate=U(gb[-1](0,0,0,0,0,0,0,0,t))
    factors=list(univariate.factor())
    factor=min((p for p,n in factors),key=lambda p:p.degree())
else:
    P=PolynomialRing(GF(5),'u')
    uu=P.gen()
    k=GF(125,name='alpha',modulus=uu^3+uu+1)
    aa=k.gen()
    U=PolynomialRing(k,'t')
    t=U.gen()
    factor=t^3+2*t^2+(4*aa^2+3*aa+2)*t+aa^2+3*aa+3
    factors=[(factor,1)]
assert factor.is_irreducible()
# A relative tower avoids unrelated absolute-field embedding choices.
E0=k.extension(factor,'rho')
rho0=E0.gen()
A0=E0(1+4*k.gen())
assert not A0.is_square()
ES=PolynomialRing(E0,'s')
ss=ES.gen()
E=E0.extension(ss^2-A0,'sigma')
embedding=lambda z:E(z)
alpha=embedding(k.gen())
rho=E(rho0)
sqrtA=E.gen()

def eval_T(p,point):
    return sum(embedding(coefficient)*prod(point[i]^j for i,j in enumerate(exponents))
               for exponents,coefficient in p.dict().items())

point=[E.zero() for _ in names]
point[-1]=rho
if args.lex:
    for index in range(8):
        p=next(p for p in gb if p.degree(T.gen(index))==1)
        assert p.coefficient({T.gen(index):1})==1
        point[index]=-eval_T(p,point)
    assert all(eval_T(p,point)==0 for p in gb)
else:
    point[0]=(4*alpha^2+4*alpha+2)*rho^2+(2*alpha^2+3*alpha+1)*rho+alpha^2+2*alpha+3
    point[2]=(4*alpha^2+2)*rho^2+(3*alpha^2+4)*rho+3*alpha+2
    point[3]=(3*alpha^2+2*alpha+3)*rho^2+(alpha^2+4*alpha+3)*rho+alpha+1
full_point=[point[0],point[1],point[2],E.zero(),point[3],point[4],point[5],point[6],point[7],2*point[2]]
if args.system:
    R,Rx0,k0,H0,h0,det0,equations=load(args.system)
    assert k0==k
    assert all(eval_T(R(p),full_point)==0 for ch,j,p in equations)
assert point[2]!=0 and point[2]*rho==1

Rx=PolynomialRing(E,'x')
x=Rx.gen()
c=2+4*alpha
A,B,C=c-1,c,E(-1)
H=A*x^5+B*x^4+C
h=2*B*(A*x^5+C)
zero=(Rx.zero(),Rx.zero())
one=(Rx.one(),Rx.zero())
def add(p,q):return (p[0]+q[0],p[1]+q[1])
def scale(p,z):return (z*p[0],z*p[1])
def mul(p,q):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def D(p):return (H*p[1].derivative()+2*B*x^3*p[1],p[0].derivative())
def conn(v):
    dv=[D(z) for z in v]
    return (add(dv[0],scale(v[1],-2)),add(dv[1],scale(v[2],-3)),
            add(dv[2],scale(v[3],-4)),add(dv[3],mul((h,Rx.zero()),v[0])))
def determinant(columns):
    n=len(columns)
    result=zero
    for permutation in itertools.permutations(range(n)):
        term=one
        for j in range(n):term=mul(term,columns[j][permutation[j]])
        sign=(-1)^sum(permutation[i]>permutation[j] for i in range(n) for j in range(i+1,n))
        result=add(result,scale(term,sign))
    return result
a=(point[0]+point[1]*x+point[2]*x^2,Rx.zero())
b=(point[3]+point[4]*x+point[5]*x^2+point[6]*x^3,point[7]+2*point[2]*x)
v=(zero,one,a,b)
columns=[v]
for _ in range(3):columns.append(conn(columns[-1]))
assert determinant(columns)==zero
covector=[]
for omitted in range(4):
    minor=[tuple(column[i] for i in range(4) if i!=omitted) for column in columns[:3]]
    covector.append(scale(determinant(minor),(-1)^omitted))
assert any(z!=zero for z in covector)
for column in columns:
    dot=zero
    for z,l in zip(column,covector):dot=add(dot,mul(z,l))
    assert dot==zero
# Native alternating form P14=4,P23=3,P32=2,P41=1.
# covector=u^t P, giving u=(cov4/4,cov3/3,cov2/2,cov1).
annihilator=[scale(covector[3],1/E(4)),scale(covector[2],1/E(3)),
             scale(covector[1],1/E(2)),covector[0]]
affine_generators=[]
for f,g in annihilator:
    affine_generators.extend(((f,g),(H*g,f)))
gcd=Rx.zero()
for p,q in itertools.combinations(affine_generators,2):
    gcd=gcd.gcd(p[0]*q[1]-p[1]*q[0])
assert gcd
finite_zero_degree=int(gcd.degree())
gcd=gcd.monic()
adjunction_norm=annihilator[0][0]^2-H*annihilator[0][1]^2
adjunction_reduced_norm,remainder=adjunction_norm.quo_rem(gcd)
assert remainder==0
finite_adjunction_degree=int(adjunction_reduced_norm.degree())
finite_adjunction_squarefree=adjunction_reduced_norm.gcd(adjunction_reduced_norm.derivative()).degree()==0
# In this point the common-zero divisor projects injectively to x.
# Reduce its degree-zero class D-6P by the hyperelliptic ideal algorithm.
assert finite_zero_degree==gcd.degree() and gcd.gcd(gcd.derivative()).degree()==0
for f,g in annihilator:
    if g.gcd(gcd).degree()==0:
        reduced_v=(-f*g.inverse_mod(gcd))%gcd
        break
else:
    raise AssertionError('No single affine coefficient determines the sheet')
assert (H-reduced_v^2)%gcd==0
mumford_u,mumford_v=gcd,reduced_v
while mumford_u.degree()>2:
    mumford_u=((H-mumford_v^2)//mumford_u).monic()
    mumford_v=(-mumford_v)%mumford_u
assert (H-mumford_v^2)%mumford_u==0

PS=PowerSeriesRing(E,'z',default_prec=100)
z=PS.gen()
s=1+(B/A)*z^2+(C/A)*z^10
root=PS.one()
for _ in range(7):root=(root+s/root)/2
assert (root^2-s).valuation()>=100
LS=LaurentSeriesRing(E,'z',default_prec=100)
zz=LS.gen()
xx=zz^-2
assert sqrtA^2==A
ww=sqrtA*zz^-5*LS(root)
eta=-2*zz^-3/ww
def eval_pair(p):return p[0](xx)+p[1](xx)*ww
av,bv=eval_pair(a),eval_pair(b)
v_eps=[LS.zero(),eta^2,eta*eta.derivative()+av*eta^3,
       eta*eta.derivative(2)/3+eta.derivative()^2/4+
       3*av*eta^2*eta.derivative()/2+bv*eta^4]
assert min(p.valuation() for p in v_eps if p)==1
v_flat=[sum(v_eps[i-1]*binomial(i,j)*(-zz)^(i-j) for i in range(j,5))
        for j in range(1,5)]
assert min(p.valuation() for p in v_flat if p)==1
v_first=[p[1] for p in v_flat]
v_second=[p[2] for p in v_flat]
assert any(v_first)
assert all(v_first[i]*v_second[j]-v_first[j]*v_second[i]==0
           for i,j in itertools.combinations(range(4),2))
q1,q2,q3,q4=[eval_pair(p) for p in annihilator]
e1=q1*eta
e2=q1*eta.derivative()/2+q2*eta^2
e3=q1*eta.derivative(2)/6+q2*eta*eta.derivative()+q3*eta^3
e4=q1*eta.derivative(3)/24+q2*(eta*eta.derivative(2)/3+eta.derivative()^2/4)+q3*(3*eta^2*eta.derivative()/2)+q4*eta^4
infinity_valuations=[int(p.valuation()) if p else None for p in (e1,e2,e3,e4)]
infinity_zero_order=min(z for z in infinity_valuations if z is not None)
line_degree=finite_zero_degree+infinity_zero_order
assert line_degree%5==0
infinity_adjunction_order=infinity_valuations[0]-infinity_zero_order
assert finite_adjunction_degree+infinity_adjunction_order==2-line_degree
summary={'scope':'constant-p necessary horizontal rank-three kernel; no actual source row or maps',
         'sage_version':SAGE_VERSION,'threads':1,
         'minimal_relative_factor_degree':int(factor.degree()),
         'univariate_factor_degrees':[int(p.degree()) for p,n in factors],
         'point_field':'relative cubic over GF125, then quadratic square-root extension','rank_of_differential_closure':3,
         'all_original_determinant_equations':'PASS',
         'saturated_O_P_line_zero_order':1,
         'second_fundamental_form_at_P':'zero PASS',
         'finite_zero_degree':finite_zero_degree,
         'infinity_coefficient_valuations':infinity_valuations,
         'infinity_zero_order':infinity_zero_order,
         'degree_FstarQ':line_degree,'degree_Q':line_degree//5,
         'degree_K':2+line_degree//5,
         'desired_degree_one':line_degree==-5,
         'finite_adjunction_zero_degree':finite_adjunction_degree,
         'finite_adjunction_norm_squarefree':finite_adjunction_squarefree,
         'infinity_adjunction_order':infinity_adjunction_order,
         'all_seven_adjunction_zeros_simple':finite_adjunction_squarefree and infinity_adjunction_order==1,
         'annihilator_divisor_class_mumford_degree':int(mumford_u.degree()),
         'annihilator_FstarQ_not_O_minus_5P':mumford_u.degree()!=0,
         'elapsed_seconds':time.monotonic()-start}
save((E,alpha,point,factor,annihilator,gcd,adjunction_reduced_norm,mumford_u,mumford_v),str(out/'point.sobj'))
(out/'point.txt').write_text('alpha = '+str(alpha)+'\nrho = '+str(rho)+'\n'+
    '\n'.join(name+' = '+str(z) for name,z in zip(names,point))+'\n'+
    'annihilator = '+str(annihilator)+'\nfinite gcd = '+str(gcd)+'\n'+
    'Mumford U = '+str(mumford_u)+'\nMumford V = '+str(mumford_v)+'\n')
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
