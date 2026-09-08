#!/usr/bin/env sage
"""Exact sheet-correct principal-theta pullback cubic; no intersection exclusion.
See Sol_raynaud_genus_two_determinant.md, version2.
"""
import time
from cysignals.alarm import alarm,cancel_alarm
started=time.monotonic();alarm(60)
try:
    k=PolynomialRing(GF(5),'t').fraction_field();t=k.gen()
    R=PolynomialRing(k,'u');u=R.gen();F=u*(u-1)*(u-2)*(u-3)*(u-t)
    P=PolynomialRing(k,names=['S','P','q0','q1']);S,Pi,q0,q1=P.gens()
    columns=[]
    for j in range(6):
        cs=u**j*F**2
        columns.append([cs[4]-Pi*cs[14],cs[9]+S*cs[14]]+
            [q1*(cs[r]-Pi*cs[r+10]-S*Pi*cs[r+15])-
             q0*(cs[r+5]+S*cs[r+10]+(S**2-Pi)*cs[r+15]) for r in range(4)])
    determinant=matrix(P,columns).transpose().det()
    print('six-square terms',len(determinant.monomials()),'seconds',time.monotonic()-started,flush=True)
    B=PolynomialRing(k,names=['S','P','w']);s,p,w=B.gens()
    U=PolynomialRing(B,'u');uu=U.gen()
    F1=U([c**5 for c in F.list()]);rr=F1%(uu**2-s*uu+p);r0,r1=rr[0],rr[1]
    f=F1.list();z=w+f[2]+f[3]*s+f[4]*s**2+s*(s**2-p)
    replace=[z**2,(r1-s*z)*z/2,(r0+p*z)*z,(r0+p*z)*(r1-s*z)/2,(r0+p*z)**2]
    out=B.zero()
    for (es,ep,e0,e1),co in determinant.dict().items():
        assert e0+e1==4
        out+=co*s**es*p**ep*replace[e0]
    res=p*prod(beta**2-s*beta+p for beta in [k(1),k(2),k(3),t**5])
    def divide_norm(poly):
        quotient=poly
        for beta in [k(0),k(1),k(2),k(3),t**5]:
            linear=p-s*beta+beta**2;partial=B.zero();remainder=quotient
            for degree in range(quotient.degree(p),0,-1):
                term=remainder.coefficient({p:degree})*p**(degree-1)
                partial+=term;remainder-=term*linear
            assert not remainder,('failed norm factor',beta)
            quotient=partial
        assert quotient*res==poly
        return quotient
    delta=s**2-4*p
    kum=delta*z**2-(2*s*r1+4*r0)*z+r1**2
    ds=[out.coefficient({w:i}) for i in range(3)]
    ks=[kum.coefficient({w:i}) for i in range(3)]
    target=[divide_norm(delta*ds[i]-ks[i]*ds[2]) for i in range(2)]
    mons=[[s**a*p**b for a in range(4-j) for b in range(4-j-a)] for j in range(3)]
    columns=[(delta*m,B.zero()) for m in mons[0]]+[(B.zero(),delta*m) for m in mons[1]]+[(-ks[0]*m,-ks[1]*m) for m in mons[2]]
    exps=sorted(set(ex for pol in target+[f for col in columns for f in col] for ex in pol.dict()))
    MM=matrix(k,[[col[j].dict().get(ex,0) for col in columns] for j in range(2) for ex in exps],implementation='generic')
    rhs=vector(k,[target[j].dict().get(ex,0) for j in range(2) for ex in exps])
    cc=MM.solve_right(rhs);assert MM*cc==rhs
    cubic=B.zero();offset=0
    for j in range(3):
        cubic+=w**j*sum(cc[offset+i]*mon for i,mon in enumerate(mons[j]));offset+=len(mons[j])
    assert delta*(out-res*cubic)==(ds[2]-res*cubic.coefficient({w:2}))*kum
    expected={(0,0,0):3*t**6*(t**3+2*t**2+t+3)*(t**3+2*t**2+4*t+2),
        (0,0,1):3*(t+1)*t**2*(t**2+t+1)**2,(0,0,2):3*(t+1)*(t+2),
        (0,1,0):(t+1)*t**3*(t**6+4*t**5+3*t**4+t**3+3*t**2+4*t+1),
        (0,1,1):3*(t+1)*(t**2+4*t+1),
        (0,2,0):4*(t+1)**2*(t**3+2*t**2+t+4)*(t**3+4*t**2+3*t+4),
        (0,2,1):t+1,(0,3,0):3*t*(t+1),
        (1,0,0):3*(t+1)*t**6*(t**2+t+1)**2,
        (1,0,1):4*t**2*(t+1)**2*(t**2+4*t+1),(1,0,2):4*(t+1),
        (1,1,0):3*(t+1)*t**5*(t**2+4*t+1),(1,1,1):2*t*(t+1),
        (1,2,0):(t+1)*t**2,(2,0,0):(t+1)*(t+3)*t**6,
        (2,0,1):4*(t+1)*t**2}
    assert cubic==B(expected), cubic-B(expected)
    print('CUBIC IDENTITY PASS degree',cubic.total_degree(),'terms',len(cubic.monomials()),'seconds',time.monotonic()-started,flush=True)
    for ex,co in sorted(cubic.dict().items()):print(ex,co.factor(),flush=True)
except AlarmInterrupt:
    print('TIME CAP; no conclusion',time.monotonic()-started,flush=True)
finally:cancel_alarm()
