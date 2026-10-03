#!/usr/bin/env sage
"""New bounded exact packet probe, not an unmarked cover decision.

For the fixed F125 genus-two curve, retain all fifteen nonzero two-torsion
characters B. In the primitive m=1, residual-degree10 case, a double
quotient forces P into the unique divisor of omega*A*B, while the actual
canonical norm forces [32](P-O)=-A. Test both points of every divisor.
Use explicit Cantor addition; no old certificate is replayed.
"""
from sage.all import *
from cysignals.alarm import alarm, cancel_alarm
from pathlib import Path
import itertools, json, time

start=time.monotonic()
base=PolynomialRing(GF(5),'a')
k=GF(125,'alpha',modulus=base([1,1,0,1]))
alpha=k.gen()
R=PolynomialRing(k,'u');u=R.gen()
F=u*(u-1)*(u-2)*(u-3)*(u-alpha)

def add_pair(a,b,F0=F):
    u1,v1=a;u2,v2=b
    d1,e1,e2=u1.xgcd(u2)
    d,c1,c2=d1.xgcd(v1+v2)
    uu=(u1*u2)//(d*d)
    numerator=c1*(e1*u1*v2+e2*u2*v1)+c2*(v1*v2+F0)
    vv=(numerator//d)%uu
    while uu.degree()>2:
        uu=((F0-vv*vv)//uu).monic()
        vv=(-vv)%uu
    uu=uu.monic()
    assert (vv*vv-F0)%uu==0
    return uu,vv

def multiple(a,n,F0=F):
    out=(a[0].parent().one(),a[0].parent().zero())
    while n:
        if n%2:out=add_pair(out,a,F0)
        n//=2
        if n:a=add_pair(a,a,F0)
    return out

point=(alpha**25,alpha**5)
assert point[1]**2==F(point[0])
D=(u-point[0],R(point[1]))
assert multiple(D,10)==(R.one(),R.zero())
A=multiple(D,4)
minusA=(A[0],(-A[1])%A[0])
assert multiple(A,5)==(R.one(),R.zero()) and A!=(R.one(),R.zero())
encode=lambda c:[int(v) for v in k(c).polynomial().list()]
encode_poly=lambda p:[encode(c) for c in p.list()]
records=[]
alarm(30)
try:
    branches=[k(0),k(1),k(2),k(3),alpha]
    for size in (1,2):
        for subset in itertools.combinations(branches,size):
            B=(prod(u-r for r in subset),R.zero())
            assert multiple(B,2)==(R.one(),R.zero())
            C=add_pair(A,B)
            # C represents the unique effective divisor of omega*A*B.
            assert C[0].degree() in (1,2)
            rows=[]
            if C[0].degree()==1:
                rows.append({'degree':1,'point':'O','multiplicity':1,
                             'norm32_matches':False})
            for factor, exponent in C[0].factor():
                degree=factor.degree()
                if degree==1:
                    x0=-factor[0]/factor[1]
                    y0=C[1](x0)
                    P=(u-x0,R(y0))
                    answer=multiple(P,32)==minusA
                    rows.append({'factor':encode_poly(factor),'multiplicity':int(exponent),
                                 'degree':1,'point':[encode(x0),encode(y0)],'norm32_matches':answer})
                else:
                    ext=k.extension(factor,'z')
                    RR=PolynomialRing(ext,'u');xx=RR.gen()
                    FF=RR(F.list());x0=ext.gen();y0=RR(C[1].list())(x0)
                    P=(xx-x0,RR(y0));target=(RR(minusA[0].list()),RR(minusA[1].list()))
                    answer=multiple(P,32,FF)==target
                    rows.append({'factor':encode_poly(factor),'multiplicity':int(exponent),
                                 'degree':int(degree),'norm32_matches':answer})
            records.append({'two_torsion_branch_subset':[encode(r) for r in subset],
                            'divisor_u':encode_poly(C[0]),'divisor_v':encode_poly(C[1]),'points':rows})
    result={'scope':'Fixed backup F125 primitive m=1/residualdegree10 with a double quotient ONLY',
            'curve':'v^2=u(u-1)(u-2)(u-3)(u-alpha); alpha^3+alpha+1=0',
            'A':'4[(alpha^25,alpha^5)-O]',
            'required_norm':'32[P-O]=-A',
            'characters':15,'geometric_points_counted_with_multiplicity':30,
            'records':records,
            'all_excluded':not any(p['norm32_matches'] for r in records for p in r['points']),
            'elapsed_seconds':time.monotonic()-start}
    out=Path('../litt3-computation-data/oct02_primitive_double_quotient_packet.json')
    out.write_text(json.dumps(result,indent=2,default=int)+'\n')
    print(json.dumps({k:result[k] for k in ('scope','characters','all_excluded','elapsed_seconds')},default=int),flush=True)
finally:
    cancel_alarm()
