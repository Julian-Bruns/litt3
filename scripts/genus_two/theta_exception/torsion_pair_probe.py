#!/usr/bin/env sage-python
"""Determine whether two dormant theta divisors share tame torsion.

An actual prime-to-five line in a pair intersection, with two arithmetic
conjugates and one independent tame theta line, would give a rank-three
finite-etale-trivial simultaneous coefficient bundle. This is an
exploratory finite Jacobian calculation, not a common-cover construction.
"""
import argparse
import json
from pathlib import Path
from sage.all import *


def add(D,E,f):
    a,b=D;c,d=E
    g,h1,h2=a.xgcd(c)
    e,l1,l2=g.xgcd(b+d)
    s1=l1*h1;s2=l1*h2;s3=l2
    aa=(a*c)//(e*e)
    bb=((s1*a*d+s2*c*b+s3*(b*d+f))//e)%aa
    while aa.degree()>2:
        aa=((f-bb*bb)//aa).monic()
        bb=(-bb)%aa
    aa=aa.monic();bb=bb%aa
    assert (bb*bb-f)%aa==0
    return aa,bb


def times(n,D,f):
    R=f.parent();out=(R(1),R(0))
    while n:
        if n&1:out=add(out,D,f)
        D=add(D,D,f);n//=2
    return out


def order_jac(r):
    R=PolynomialRing(ZZ,'t');t=R.gen()
    return abs((t**4-8*t**3+182*t**2-1000*t+15625).resultant(t**r-1))


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    if args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3]):
        raise ValueError('Output must be outside litt3')
    L=GF(5**15,'r');R=PolynomialRing(L,'t');t=R.gen()
    alpha=(t**3+t+1).roots()[0][0]
    dec=lambda n:L(n%5)+L(n//5%5)*alpha+L(n//25)*alpha**2
    psi=sum(dec(a)*t**i for i,a in enumerate([63,81,75,53,6,1]))
    T=psi.roots()[0][0]
    A=[[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18]]
    z=lambda u:[sum(dec(a)*u**i for i,a in enumerate(row)) for row in A]
    z0=z(T)
    result=[]
    for shift in [1,2]:
        z1=z(T**(125**shift))
        S=PolynomialRing(L,'s');s=S.gen()
        p=-(z1[0]-z0[0]+(z1[1]-z0[1])*s)/(z1[2]-z0[2])
        ell=z0[0]+z0[1]*s+z0[2]*p
        c1,c2,c3,c4=map(dec,[106,48,107,48])
        polar=c1*s+2*c2*p+c3*s*p+2*c4*p*p+s*p*p
        K0=(c1*c1-2*c1*c3*p-4*c1*c4*s*p-4*c1*s*s*p
            +(2*c1-4*c2*c4+c3*c3)*p*p-4*c2*s*p*p-2*c3*p**3+p**4)
        q=(s*s-4*p)*ell*ell+2*polar*ell+K0
        fac=q.factor()
        print('pair shift',shift,'factor degrees',[(g.degree(),int(e)) for g,e in fac],flush=True)
        for factor,mult in fac:
            degree=int(factor.degree())
            K=GF(5**(15*degree),'w')
            emb=L.embeddings(K)[0]
            alpha_K=emb(alpha);T_K=emb(T)
            RK=PolynomialRing(K,'s')
            root=RK([emb(v) for v in factor]).roots()[0][0]
            ev=lambda poly:sum(emb(v)*root**i for i,v in enumerate(poly))
            sv=root;pv=ev(p);kv=-ev(ell);nv=(ev(polar)-(sv*sv-4*pv)*kv)/2
            X=PolynomialRing(K,'x');x=X.gen()
            f=sum(emb(dec(a))*x**i for i,a in enumerate([0,106,48,107,48,1]))
            u=x*x-sv*x+pv
            remainder=f%u;av=remainder[1];bv=remainder[0]
            slope_square=(av*sv+2*bv-2*nv)/(sv*sv-4*pv)
            ext=1
            if not slope_square.is_square():
                K2=GF(5**(30*degree),'v');embedding=K.embeddings(K2)[0]
                sv,pv,kv,nv,av,bv,slope_square,alpha_K,T_K=map(
                    embedding,[sv,pv,kv,nv,av,bv,slope_square,alpha_K,T_K])
                X2=PolynomialRing(K2,'x');f=X2([embedding(c) for c in f]);x=X2.gen()
                u=x*x-sv*x+pv;K=K2;ext=2
            slope=slope_square.sqrt()
            if slope:intercept=(av/slope-sv*slope)/2
            else:intercept=bv.sqrt()
            v=slope*x+intercept
            assert (v*v-f)%u==0
            assert intercept**2+sv*slope*intercept+pv*slope*slope==nv
            r=5*degree*ext;N=order_jac(r);pval=N.valuation(5);tame=N//5**pval
            D=(u,v)
            primary=times(tame,D,f)
            killed=primary[0].degree()==0
            primary_order=1;check=primary
            while check[0].degree()!=0:
                check=times(5,check,f);primary_order*=5
                assert primary_order<=5**pval
            assert times(N,D,f)[0].degree()==0
            row={'pair_shift':shift,'factor_degree':degree,'multiplicity':int(mult),
                 'field_degree_over_125':r,'jacobian_order':int(N),'five_valuation':int(pval),
                 'prime_to_five_order':bool(killed),'five_primary_order':primary_order,
                 'alpha':str(alpha_K),'T':str(T_K),
                 'u':str(u),'v':str(v),'f':str(f),
                 'primary_u':str(primary[0]),'primary_v':str(primary[1]),
                 'intersection_factor_over_L':str(factor),
                 'base_L_modulus':str(L.modulus()),
                 'field_modulus':str(K.modulus())}
            result.append(row)
            print({a:row[a] for a in ['pair_shift','factor_degree','field_degree_over_125','five_valuation','five_primary_order','prime_to_five_order']},flush=True)
    args.output.write_text(json.dumps({'status':'exploratory','results':result},indent=2)+'\n')


if __name__=='__main__':
    main()
