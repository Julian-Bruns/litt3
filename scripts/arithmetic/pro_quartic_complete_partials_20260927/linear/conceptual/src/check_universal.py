"""Exhaustive symbolic identities, not finite-field parameter sampling."""
from __future__ import annotations
import json,sys
from pathlib import Path
from sparse5 import Poly,variables
ROOT=Path(__file__).resolve().parents[2]

def check_discriminant():
    a,b,c,d,Q,C=variables(6)
    E=a*d-b*c;Delta=b*b+a*c
    T=c**5-Q*b**5+Q**2*a**5;U=2*Q*a**5-b**5
    V=-d*b**5-2*c*c*b**4-3*a*b*b*c**3-2*a*a*c**4+Q*(2*a**5*d-a**4*b*c+a**3*b**3)
    W=a*a*d*d-a*b*c*d+2*b*b*c*c+b**3*d+a*c**3
    M=U*(2*a*E+b*Delta)-a*a*V
    lead=T*T;middle=T*V+C*(U*U-2*a**5*T)
    constant=a**3*(T*W+C*M)+C*C*a**10
    Gamma=T*(a**3*Q+d*Delta+2*b*c*c)+C*Delta*U
    residual=middle**2-4*lead*constant-Delta**3*Gamma**2
    assert not residual
    return {'ring':'F5[a,b,c,d,Q,C]', 'identity':'disc_l Res = Delta^3 Gamma^2',
            'Gamma_terms':len(Gamma.terms),'residual_terms':len(residual.terms),
            'all_specializations_including_a_zero':True}

def curve_mul(u,v,P):
    out=[0,0,0]
    for i in range(3):
        for j in range(3):
            h=u[i]*v[j]
            if i+j>=3:h=h*P
            out[(i+j)%3]=out[(i+j)%3]+h
    return out

def adj(u,P):
    A,B,C=u
    return [A*A-B*C*P,C*C*P-A*B,B*B-A*C]

def norm(u,P):
    A,B,C=u
    return A**3+B**3*P+C**3*P**2-3*A*B*C*P

def check_adjugate():
    A,B,C,P=variables(4);u=[A,B,C];a=adj(u,P);N=norm(u,P)
    assert curve_mul(u,a,P)==[N,0,0]
    assert adj(a,P)==[N*v for v in u]
    assert norm(a,P)==N*N
    return {'ring':'F5[A,B,C,P], y^3=P','u_times_adj_u_equals_norm':True,
            'double_adjugate_equals_norm_times_u':True,'norm_adjugate_equals_norm_squared':True}

def check_quartic():
    a,b,c,T=variables(4)
    roots=[a+b+c,a-b-c,-a+b-c,-a-b+c]
    prod=1
    for r in roots:prod=prod*(T-r)
    s1=a*a+b*b+c*c;s2=a*a*b*b+a*a*c*c+b*b*c*c;J=a*b*c
    quartic=T**4-2*s1*T**2-8*J*T+s1*s1-4*s2
    assert prod==quartic
    disc=1
    for i in range(4):
        for j in range(i):disc=disc*(roots[i]-roots[j])**2
    assert disc==(2**12)*(a*a-b*b)**2*(a*a-c*c)**2*(b*b-c*c)**2
    return {'ring':'F5[a,b,c,T]','four_root_product':True,'quartic_discriminant_identity':True,
            'constant_2_power_12_mod_5':pow(2,12,5)}

def main():
    if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
    result={'scope':'universal symbolic identities; not a geometric-family search',
            'scale_discriminant':check_discriminant(), 'cubic_adjugate':check_adjugate(),
            'quartic_resolvent':check_quartic()}
    path=ROOT/'conceptual/evidence/universal_checks.json'
    path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
if __name__=='__main__':main()
