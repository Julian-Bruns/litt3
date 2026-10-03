#!/usr/bin/env sage
"""NEW three-polynomial original-oper gate over fixed20 Cartier classes.

Read the saved fixed20 algebra/gauge only. No pencil replay, Groebner
basis, elimination solve, resultant, factorization, point or incidence
test. The source pairing factors through a horizontal pole10 function;
three exact unit pivots leave only t,c. Record all remaining polynomials.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser=argparse.ArgumentParser()
parser.add_argument('--fixed-pencils',required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
input_path=Path(args.fixed_pencils)
source_path=Path(args.source)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'two_variable_oper_gate.sobj').exists()
(k,Kq,parameter,Q,E,R,Ffixed,Gfixed,norm,Ufixed,Vfixed,
 denominator,denominator_inverse,unit_matrix,old_identities)=load(str(input_path))
alpha=k.gen()
A,B=k(1)-alpha,k(2)-alpha
q0=Q.gen()
q=E(q0)
e=E.gen()
s=3*B/A*e*(q^2-1)
z=e/(3*A)
D=2*(B+e^2)

def qinverse(p):
    p=Q(p)
    gcd,bezout,_=p.lift().xgcd(parameter)
    assert gcd.degree()==0 and gcd!=0
    inv=Q(bezout/gcd[0])
    assert p*inv==1
    return inv

Din=E(qinverse(2*B*(1+q0)))
G2inv=s^2*E(qinverse(B*(1+q0)))
rho=3*z*G2inv
vbar_constant=B/A*q*(q-1)
abar_constant=3*B^2/A^2*q^3*(q-1)
S=PolynomialRing(E,names=('t','c'),order='degrevlex')
t,c=S.gens()
T=PolynomialRing(S,'x')
x=T.gen()
H=A*x^5+B*x^4-1
sigma=s+e*x
r=z-t

def embed(p):return T([S(z) for z in p.list()])
def add(p,q):return (p[0]+q[0],p[1]+q[1])
def scale(p,z):return (z*p[0],z*p[1])
def P(p):
    even,odd=p
    return (H*odd.derivative()+2*B*x^3*odd-sigma*even,
            even.derivative()-sigma*odd)

g=(c+(s*Din-z+t)*x+3*e*Din*x^2,T(Din))
Pg=P(g)
assert Pg[1]==-r and Pg[0].degree()==3 and Pg[0][3]==1
abar=abar_constant+e*c-e*vbar_constant*t+(e^2-B)*t^2
beta=3*D*rho-D*s*t*r+3*s^2*t+3*D*e*c*t+D*abar*r
aa=x^2+(vbar_constant-e*t)*x+abar
fixed=(embed(Ffixed),embed(Gfixed))
residual=add(add(scale(P(Pg),t),scale(Pg,2*aa)),scale(g,2*beta))
residual=add(residual,scale(fixed,-rho))
assert residual[0].degree()<=5 and residual[1].degree()<=2
high_even=[residual[0][i] for i in (3,4,5)]
all_odd=[residual[1][i] for i in range(3)]
assert all(p==0 for p in high_even+all_odd)
equations=[S(residual[0][i]) for i in range(3)]
summary={
 'scope':'NEW necessary original d0 constant-oper gate for20 s!=0 classes; no source decision',
 'sage_version':SAGE_VERSION,'threads':1,
 'source_sha256':hashlib.sha256(source_path.read_bytes()).hexdigest(),
 'input_sha256':hashlib.sha256(input_path.read_bytes()).hexdigest(),
 'new_groebner_basis':False,'search_or_samples':False,'solved':False,
 'parameter_degree':10,'e_sign_count':2,'t_nonzero_hypothesis_retained':True,
 'higher_even_identity_zero_flags':[bool(p==0) for p in high_even],
 'all_odd_identity_zero_flags':[bool(p==0) for p in all_odd],
 'remaining_equation_zero_flags':[bool(p==0) for p in equations],
 'remaining_total_degrees':[int(p.total_degree()) for p in equations],
 'remaining_monomial_counts':[len(p.monomials()) for p in equations],
 'elapsed_seconds':time.monotonic()-start,
}
save((k,Kq,parameter,Q,E,S,T,abar,beta,rho,g,Pg,fixed,residual,equations),str(out/'two_variable_oper_gate.sobj'))
(out/'equations.txt').write_text('\n'.join('even_x'+str(i)+' = '+str(p) for i,p in enumerate(equations))+'\n')
(out/'pivots.txt').write_text('rho = '+str(rho)+'\na0_times_t = '+str(abar)+'\nb0_times_t = '+str(beta)+'\n')
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
