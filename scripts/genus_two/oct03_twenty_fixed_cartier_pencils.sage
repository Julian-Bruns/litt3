#!/usr/bin/env sage
"""NEW exact degree-twenty Cartier gauge and fixed-pencil construction.

No input-family replay, sample, factorization, Groebner basis, parameter
search or source decision. Both signs of e and repeated divisor roots
remain in the finite reduced parameter algebra. A fixed20x20 matrix
certifies the sheet denominator as a UNIT, not merely nonzero.
Run only after root inspection and a bounded one-thread lease.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser=argparse.ArgumentParser()
parser.add_argument('--output',required=True)
parser.add_argument('--source',required=True)
args=parser.parse_args()
signal.alarm(10)
started=time.monotonic()
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'fixed_pencils.sobj').exists()
F5=GF(5)
Ka=PolynomialRing(F5,'alpha')
alpha=Ka.gen()
k=GF(125,name='alpha',modulus=alpha^3+alpha+1)
alpha=k.gen()
A,B=k(1)-alpha,k(2)-alpha
Kq=PolynomialRing(k,'q')
q=Kq.gen()
parameter=(B^5*q^2*(q^2-1)^4-3*A^4).monic()
assert parameter.degree()==10
assert parameter.gcd(parameter.derivative())==1
assert all(parameter(c)!=0 for c in (k(0),k(1),k(-1)))
Q=Kq.quotient(parameter,'q')
qroot=Q.gen()

def qinverse(value):
    value=Q(value)
    gcd,bz,_=value.lift().xgcd(parameter)
    assert gcd.degree()==0 and gcd!=0
    inv=Q(bz/gcd[0])
    assert value*inv==1
    return inv

Ke=PolynomialRing(Q,'e')
e=Ke.gen()
E=Ke.quotient(e^2-B*qroot,'e')
e=E.gen()
q=E(qroot)
s=3*B/A*e*(q^2-1)
assert s^4==3*B
assert e^5==2*A*B*s+B^2*e
sinv=s^3/(3*B)
einv=e*E(qinverse(B*qroot))
assert s*sinv==1 and e*einv==1

R=PolynomialRing(E,'x')
x=R.gen()
H=A*x^5+B*x^4-1
G=1+2*e*sinv*x+(2*s^2+e^2*sinv^2)*x^2
F=-2*e*sinv^2+s*x-e*x^2+(-s^3+e^2*sinv)*x^3
F+=(3*e*s^2-e^3*sinv^2)*x^4+2*A*(B+e^2)*einv*sinv^2*x^5
identities={
    'horizontal_even':H*G.derivative()+2*B*x^3*G-(s+e*x)*F,
    'horizontal_odd':F.derivative()-(s+e*x)*G,
}
assert all(value==0 for value in identities.values())
norm=F^2-H*G^2
assert norm.degree()==10
assert all(norm[i]==0 for i in range(11) if i not in (0,5,10))
nu=Q(qroot*((3-qroot)*(qroot^2-1)+2*qroot))*qinverse(3*A*(1+qroot)^2*(qroot^2-1))
kappa=Q(qroot*(1+3*qroot))*qinverse(3*A^2*(1+qroot)^2)
leading=Q(3*A^2*(1+qroot)^2)*qinverse(qroot)
assert norm[10]==E(leading) and norm[5]==E(leading*nu) and norm[0]==E(leading*kappa)
nu,kappa=E(nu),E(kappa)
U=x^2+nu*x+kappa
H1=A^5*x^5+B^5*x^4-1
Ft=R([c^5 for c in F.list()])
Gt=R([c^5 for c in G.list()])
Fr=Ft.quo_rem(U)[1]
Gr=Gt.quo_rem(U)[1]
assert Gr.degree()<=1
aa,bb=Gr[1],Gr[0]
denominator=bb^2-aa*bb*nu+aa^2*kappa
basis=[q^i for i in range(10)]+[e*q^i for i in range(10)]

def vector20(value):
    value=E(value).lift()
    return vector(k,[Q(value[j]).lift()[i] for j in range(2) for i in range(10)])

unit_matrix=matrix(k,[vector20(denominator*z) for z in basis]).transpose()
rhs=vector20(E.one())
solution=unit_matrix.solve_right(rhs)
denominator_inverse=sum((basis[i]*solution[i] for i in range(20)),E.zero())
assert denominator*denominator_inverse==1
inverse_numerator=-aa*x+bb-aa*nu
assert (Gr*inverse_numerator).quo_rem(U)[1]==denominator
V=(-Fr*inverse_numerator*denominator_inverse).quo_rem(U)[1]
assert V.degree()<=1
sheet_identity=(V^2-H1).quo_rem(U)[1]
assert sheet_identity==0
summary={
    'scope':'NEW exact twenty fixed Cartier gauges/pencils; no original incidence or source decision',
    'sage_version':SAGE_VERSION,'threads':1,
    'source_sha256':hashlib.sha256(Path(args.source).read_bytes()).hexdigest(),
    'new_groebner_basis':False,'factorization':False,'samples':False,
    'parameter_degree':10,'parameter_separable':True,'both_e_signs_retained':True,
    'horizontal_identity_zero_flags':{name:bool(value==0) for name,value in identities.items()},
    'norm_exact_quadratic_in_x5':True,'norm_formula_readback':True,
    'sheet_denominator_unit_matrix_rank':int(unit_matrix.rank()),
    'sheet_denominator_inverse_checked':True,'relative_sheet_identity_zero':True,
    'repeated_divisor_roots_retained':True,
    'elapsed_seconds':time.monotonic()-started,
}
save((k,Kq,parameter,Q,E,R,F,G,norm,U,V,denominator,denominator_inverse,unit_matrix,identities),str(out/'fixed_pencils.sobj'))
(out/'exact_formulas.txt').write_text('parameter = '+str(parameter)+'\nF = '+str(F)+'\nG = '+str(G)+'\nU_C1 = '+str(U)+'\nV_C1 = '+str(V)+'\n')
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
