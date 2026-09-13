#!/usr/bin/env python3
"""Exact checks for the cyclic-trigonal two-torsion/carrier dictionary.

The fixed-X equations are a necessary norm parametrization, not an
enumeration of its two-torsion and not an exclusion of a common cover.
The independent constructed example tests actual unramified geometry.
Run with sage -python; --genus requests normalization/genus of that example.
"""
import argparse
import json
import time
from sage.all import GF, QQ, PolynomialRing, FunctionField

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--genus',action='store_true')
args=p.parse_args();started=time.monotonic()

# Four even-sign sums of three square roots. Verify the quartic before
# imposing any characteristic or norm identity.
S=PolynomialRing(QQ,names=['a','b','c','z'])
a,b,c,z=S.gens()
roots=[a+b+c,a-b-c,-a+b-c,-a-b+c]
poly=S.one()
for root in roots:poly*=z-root
ss=a*a+b*b+c*c
tt=a*a*b*b+a*a*c*c+b*b*c*c
assert poly==z**4-2*ss*z**2-8*a*b*c*z+ss**2-4*tt

# Specialize the cyclic conjugate squares P+Q*y, P+zeta*Q*y,
# P+zeta^2*Q*y. Their elementary symmetric sums are 3P,3P^2,R^2.
R=PolynomialRing(GF(5),names=['P','R','z','F','Q'])
P,Rr,z,F,Q=R.gens()
quartic=z**4+4*P*z**2+2*Rr*z+2*P**2
disc=quartic.discriminant(z)
assert disc==3*(Rr**2-P**3)**2

# Standard cubic resolvent: u^3-Au^2-4Cu+(4AC-B^2).
# Translating u -> 3P-v reduces it to -v^3+R^2-P^3.
V=PolynomialRing(R,'v');v=V.gen()
A=4*P;B=2*Rr;C=2*P**2
res=(3*P-v)**3-A*(3*P-v)**2-4*C*(3*P-v)+(4*A*C-B**2)
assert res==-v**3+Rr**2-P**3

# Pole-semigroup check on y^3=F_10: L(18O) contains no y^2 term.
basis=[(i,j) for j in range(3) for i in range(7) if 3*i+10*j<=18]
assert basis==[(i,0) for i in range(7)]+[(i,1) for i in range(3)]
assert len(basis)==10

# An actual smooth genus-nine playground, constructed from a norm square.
# Q=1, gcd(P,F)=1. Thus every finite zero of P+y is on a unique
# unramified cubic sheet and has even order, because its norm is R^2.
# The pole at O has order18. It is not a square: a square root would
# belong to L(9O)=<1,x,x^2,x^3>, which has no y term.
K=GF(5);Px=PolynomialRing(K,'x');x=Px.gen()
pp=x**6+1;rr=x**9+4*x**3+x;ff=rr**2-pp**3
assert ff.degree()==10 and ff.gcd(ff.derivative())==1
assert pp.gcd(ff)==1
Z=PolynomialRing(Px,'z');zz=Z.gen()
carrier=zz**4+4*pp*zz**2+2*rr*zz+2*pp**2
assert carrier.discriminant()==3*ff**2
result=dict(status='PASS',norm='P^3+F*Q^3=R^2',degree_bounds=[6,2,9],
    carrier='z^4+4P*z^2+2R*z+2P^2',
    discriminant='3*(R^2-P^3)^2=3*F^2*Q^6',
    resolvent_after_translation='v^3-F*Q^3',
    playground_F=str(ff),playground_P=str(pp),playground_R=str(rr),
    scope='Dictionary arithmetic and an actual example; fixed-X carrier enumeration not done')
print(json.dumps(result,indent=2),flush=True)
if args.genus:
    Fx=FunctionField(K,'x');xx=Fx.gen();Zf=PolynomialRing(Fx,'z');zz=Zf.gen()
    ppf=Fx(pp);rrf=Fx(rr)
    L=Fx.extension(zz**4+4*ppf*zz**2+2*rrf*zz+2*ppf**2,'s')
    genus=L.genus()
    assert genus==8
    print('NORMALIZED_ACTUAL_CARRIER_GENUS',genus,flush=True)
print('SECONDS',round(time.monotonic()-started,6),flush=True)
