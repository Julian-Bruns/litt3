#!/usr/bin/env sage
"""Exact generic-family Raynaud quadric from a four-square determinant.
See Sol_raynaud_genus_two_determinant.md. No generic singleton exclusion.
"""
import time,json
from cysignals.alarm import alarm,cancel_alarm
started=time.monotonic();alarm(60)
try:
    k=PolynomialRing(GF(5),'t').fraction_field();t=k.gen()
    R=PolynomialRing(k,'u');u=R.gen();F=u*(u-1)*(u-2)*(u-3)*(u-t)
    C=matrix(k,[[(F**2)[j-i] for i in range(7)] for j in [4,9,14]],implementation='generic')
    A=matrix(k,C.right_kernel().basis_matrix().rows(),implementation='generic')
    assert C.rank()==3 and A.rank()==4 and (C*A.transpose()).is_zero()
    assert A.matrix_from_columns(A.pivots()).det()==1
    H=matrix(k,[[(F**2)[5*i-j] for j in [1,2]] for i in [1,2]],implementation='generic')
    assert H.det()==3*(t+1)**4
    print('Cartier rank minor',C.matrix_from_columns(C.pivots()).det().factor(),flush=True)
    print('kernel denominator lcm',lcm(c.denominator() for c in A.list()).factor(),flush=True)
    P=PolynomialRing(k,names=['S','P','q0','q1']);S,Pi,q0,q1=P.gens()
    columns=[]
    for row in A:
        cs=R(row.list())*F**2
        columns.append([q1*(cs[r]-Pi*cs[r+10]-S*Pi*cs[r+15])-
                        q0*(cs[r+5]+S*cs[r+10]+(S**2-Pi)*cs[r+15]) for r in range(4)])
    determinant=matrix(P,columns).transpose().det()
    print('four-square determinant terms',len(determinant.monomials()),'seconds',time.monotonic()-started,flush=True)
    B=PolynomialRing(k,names=['S','P','w']);s,p,w=B.gens()
    U=PolynomialRing(B,'u');uu=U.gen()
    F1=U([c**5 for c in F.list()]);rr=F1%(uu**2-s*uu+p);r0,r1=rr[0],rr[1]
    f=F1.list();z=w+f[2]+f[3]*s+f[4]*s**2+f[5]*s*(s**2-p)
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
            assert not remainder, ('failed norm factor',beta)
            quotient=partial
        assert quotient*res==poly
        return quotient
    delta=s**2-4*p
    kum=delta*z**2-(2*s*r1+4*r0)*z+r1**2
    assert kum.degree(w)==2 and kum.total_degree()==4
    d0,d1,d2=[out.coefficient({w:i}) for i in range(3)]
    k0,k1,k2=[kum.coefficient({w:i}) for i in range(3)]
    target=[divide_norm(delta*d0-k0*d2),divide_norm(delta*d1-k1*d2)]
    mons0=[B.one(),s,p,s**2,s*p,p**2];mons1=[B.one(),s,p]
    columns=[(delta*m,B.zero()) for m in mons0]+[(B.zero(),delta*m) for m in mons1]+[(-k0,-k1)]
    exps=sorted(set(ex for pol in target+[f for col in columns for f in col] for ex in pol.dict()))
    MM=matrix(k,[[col[j].dict().get(ex,0) for col in columns] for j in range(2) for ex in exps],implementation='generic')
    rhs=vector(k,[target[j].dict().get(ex,0) for j in range(2) for ex in exps])
    cc=MM.solve_right(rhs);assert MM*cc==rhs
    quotient=sum(cc[i]*m for i,m in enumerate(mons0))+w*sum(cc[6+i]*m for i,m in enumerate(mons1))+cc[9]*w**2
    assert delta*(out-res*quotient)==(d2-res*cc[9])*kum
    print('Raynaud quadric modulo Kummer: degree',quotient.total_degree(),
          'terms',len(quotient.monomials()),'seconds',time.monotonic()-started,flush=True)
    mons=[B.one(),s,p,w,s**2,s*p,s*w,p**2,p*w,w**2]
    coeff=[quotient.monomial_coefficient(mon) for mon in mons]
    fixed=GF(125,name='alpha',modulus=GF(5)['a']([1,1,0,1]));aa=fixed.gen()
    evaluate=lambda value:value.numerator()(aa)/value.denominator()(aa)
    special=[evaluate(co) for co in coeff];special=[co/special[0] for co in special]
    expected=[[1,0,0],[1,3,4],[4,1,3],[2,3,4],[4,0,3],[2,4,4],[3,1,0],[0,2,0],[2,4,3],[4,4,4]]
    assert special==[sum(fixed(c)*aa**i for i,c in enumerate(cs))**5 for cs in expected]
    denominator=t**2*(t+1)**4
    polynomials=[co*denominator for co in coeff]
    assert all(co.denominator()==1 for co in polynomials)
    expected_polynomials=[[0,0,0,0,0,0,0,0,4,2,4,1,3,4,1],
        [0,0,0,0,0,0,0,3,0,4,4,0,3],[0,0,3,1,0,2,3,0,3,2,0,1,3],
        [0,0,0,0,4,4,1,4,4,1],[0,0,0,0,0,0,1,1,1],
        [0,0,3,0,4,4,0,3],[0,0,0,3,2,2,3],[1,4,3,1,4,2,4],
        [1,4,4,1,4,4],[1,4,1,4,1]]
    assert [[int(c) for c in co.numerator().list()] for co in polynomials]==expected_polynomials
    print('SPECIALIZATION PASS versus independent 12-point quadric',flush=True)
    print(json.dumps({'coefficient_order':['00','01','02','03','11','12','13','22','23','33'],
                      'primitive_polynomial_coefficients':[[int(c) for c in co.numerator().list()] for co in polynomials]},default=int),flush=True)
except AlarmInterrupt:
    print('TIME CAP; no generic determinant conclusion',time.monotonic()-started,flush=True)
finally:cancel_alarm()
