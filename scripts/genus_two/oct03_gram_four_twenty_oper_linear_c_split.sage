#!/usr/bin/env sage
"""NEW exact linear-c split of the saved tiny original-oper gate.

No GB, resultant, factorization, sample, root solving or gauge replay.
Read only saved low equations; preserve t=tstar and t!=tstar explicitly.
Construct denominator-cleared two univariate necessities and check their
coefficient mapback. Test only the exceptional equation's fixed finite
algebra unit, recording its exact norm/gcd/inverse when available.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser=argparse.ArgumentParser()
parser.add_argument('--oper-gate',required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
inp=Path(args.oper_gate)
source=Path(args.source)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'linear_c_split.sobj').exists()
(k,Kq,parameter,Q,E,S,T,abar,beta,rho,g,Pg,fixed,residual,equations)=load(str(inp))
alpha=k.gen()
A,B=k(1)-alpha,k(2)-alpha
q0=Q.gen()
q=E(q0)
e=E.gen()
t,c=S.gens()
R=PolynomialRing(E,'tau')
tau=R.gen()

def univar_at_c0(p):
    return sum((R(a)*tau^mon[0] for mon,a in p.dict().items() if mon[1]==0),R(0))

def c_coefficient(p,j):
    return sum((R(a)*tau^mon[0] for mon,a in p.dict().items() if mon[1]==j),R(0))

def embedR(p):
    return sum((S(a)*t^i for i,a in enumerate(p.list())),S(0))

P0,P1,P2=equations
assert P2.degree(c)==1
L=c_coefficient(P2,1)
N=univar_at_c0(P2)
assert L==e*(3*e*tau+B/A)
assert P2==embedR(L)*c+embedR(N)
gcd_q,q_bezout,_=q0.lift().xgcd(parameter)
assert gcd_q.degree()==0 and gcd_q!=0
qinv=Q(q_bezout/gcd_q[0])
assert q0*qinv==1
einv=e*E(qinv)/B
assert e*einv==1
tstar=-B/(3*A)*einv
assert tstar!=0 and L(tstar)==0
exceptional=S(N(tstar))
assert P2(t=tstar)==exceptional
exceptional_original=[S(p(t=tstar)) for p in (P0,P1)]

def clear_c(p):
    assert p.degree(c)<=2
    return sum((R(a)*tau^mon[0]*(-N)^mon[1]*L^(2-mon[1])
                for mon,a in p.dict().items()),R(0))

cleared=[clear_c(p) for p in (P0,P1)]
# Cross-multiplication mapback uses cL+N=0 without dropping L=0.
L_S=embedR(L)
N_S=embedR(N)
mapbacks=[]
for p,denominator_cleared in zip((P0,P1),cleared):
    diff=L_S^2*p-embedR(denominator_cleared)
    # The divisor is monic in c only AFTER accounting for its exact L power.
    # Verify the hand identity c^j L^j-(-N)^j is divisible by cL+N.
    quotient=S(0)
    for mon,a in p.dict().items():
        power=mon[1]
        if power==1:
            quotient+=S(a)*t^mon[0]*L_S
        elif power==2:
            quotient+=S(a)*t^mon[0]*(c*L_S-N_S)
    assert diff==P2*quotient
    mapbacks.append(quotient)

# The exceptional low equation is an element of the SAME fixed20 algebra.
element=E(exceptional)
element_coeff=element.list()
assert len(element_coeff)<=2
even=Q(element_coeff[0]) if element_coeff else Q(0)
odd=Q(element_coeff[1]) if len(element_coeff)>1 else Q(0)
norm=even^2-B*q0*odd^2
norm_gcd,norm_bezout,_=norm.lift().xgcd(parameter)
exceptional_unit=(norm_gcd.degree()==0 and norm_gcd!=0)
inverse=None
if exceptional_unit:
    norm_inverse=Q(norm_bezout/norm_gcd[0])
    assert norm*norm_inverse==1
    inverse=(E(even)-e*E(odd))*E(norm_inverse)
    assert element*inverse==1

summary={
 'scope':'NEW exact linear-c oper split; no source decision or univariate solve',
 'sage_version':SAGE_VERSION,'threads':1,
 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
 'input_sha256':hashlib.sha256(inp.read_bytes()).hexdigest(),
 'new_groebner_basis':False,'resultant_or_factorization':False,
 'search_or_samples':False,'solved':False,
 'linear_c_pivot_identity':True,'tstar_nonzero':bool(tstar!=0),
 'original_t_nonzero_retained':True,'tstar_stratum_retained':True,
 'denominator_cleared_degrees':[int(p.degree()) for p in cleared],
 'denominator_cleared_term_counts':[len(p.list())-sum(a==0 for a in p.list()) for p in cleared],
 'mapback_identity_flags':[True,True],
 'exceptional_equation_zero':bool(element==0),
 'exceptional_equation_unit':bool(exceptional_unit),
 'exceptional_norm_gcd_degree':int(norm_gcd.degree()),
 'exceptional_original_c_degrees':[int(p.degree(c)) for p in exceptional_original],
 'elapsed_seconds':time.monotonic()-start,
}
save((k,Kq,parameter,Q,E,S,R,L,N,tstar,cleared,mapbacks,element,norm,
      norm_gcd,norm_bezout,inverse,exceptional_original),str(out/'linear_c_split.sobj'))
(out/'exact_split.txt').write_text(
    'L = '+str(L)+'\nN = '+str(N)+'\ntstar = '+str(tstar)+'\n'
    +'exceptional = '+str(element)+'\nexceptional_norm = '+str(norm)
    +'\nexceptional_norm_gcd = '+str(norm_gcd)+'\n'
    +'cleared_E0 = '+str(cleared[0])+'\ncleared_E1 = '+str(cleared[1])+'\n'
    +'exceptional_E0 = '+str(exceptional_original[0])+'\n'
    +'exceptional_E1 = '+str(exceptional_original[1])+'\n')
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
