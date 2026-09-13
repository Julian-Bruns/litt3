#!/usr/bin/env sage
"""Exact Hasse matrix, degree bound, one good fiber and Cartier identities."""
from sage.all import *
import json

R=PolynomialRing(GF(5),['t','b']);t,b=R.gens()
S=PolynomialRing(R,'z');z=S.gen()
F=(b+z)*(b+z-1)*(b+z-2)*(b+z-3)*(b+z-t)
coeff=F.list();f0=coeff[0]
A=[R(1)]
for n in range(1,8):
    fn=coeff[n] if n<len(coeff) else R(0)
    A.append((fn*f0**(n-1)-sum(A[j]*A[n-j] for j in range(1,n)))/GF(5)(2))
    assert 2*A[n]+sum(A[j]*A[n-j] for j in range(1,n))==fn*f0**(n-1)
    assert A[n].degree(t)<=n
assert [a.degree(b) for a in A[1:]]==[3,7,11,15,20,23,27]
assert A[5].coefficient({b:20})==GF(5)(1)/2
H=[A[5]**2-A[4]*A[6],A[5]*A[6]-A[4]*A[7],A[6]**2-A[5]*A[7]]
assert [(h.degree(t),h.degree(b)) for h in H[:2]]==[(10,40),(11,43)]
assert H[0].coefficient({b:40})==GF(5)(1)/4
bound=40*11+43*10
assert bound==870

U=PolynomialRing(GF(5),'a');a=U.gen()
modulus=a**3+a+1
assert modulus.is_irreducible()
k=GF(125,'alpha',modulus=modulus)
B=PolynomialRing(k,'x');x=B.gen()
specialize=R.hom([k.gen(),x],B)
h1,h2=[specialize(h) for h in H[:2]]
d,u,v=h1.xgcd(h2)
assert d==1 and u*h1+v*h2==1

bad_modulus=a**2+4*a+2
assert bad_modulus.is_irreducible()
k2=GF(25,'beta',modulus=bad_modulus)
B2=PolynomialRing(k2,'x');x2=B2.gen()
specialize_bad=R.hom([k2.gen(),x2],B2)
bad_gcd=gcd([specialize_bad(h) for h in H])
assert bad_gcd.degree()==3
assert gcd(bad_gcd,specialize_bad(f0))==1

c4=(t+1)*(1-2*t);c3=-2*t*(t+1)
c9=-2*(t+1);c8=(t+1)*(t-2)
expected=[-2*t*(t+1),(t-1)*(t+1),-(t-2)*(t+1),
          2*(t-3)*(t+1),-2*(t+1)**2*(t**5-t)]
for branch,answer in zip([R(0),R(1),R(2),R(3),t],expected):
    assert c3-branch*c4+branch**5*c8-branch**6*c9==answer
assert c9==-2*(t+1)
print(json.dumps({'status':'PASS','minor_bidegrees':[[10,40],[11,43]],
                  'good_modulus':'a^3+a+1','good_gcd_degree':0,
                  'bezout_multiplier_degrees':[int(u.degree()),int(v.degree())],
                  'bad_modulus':'a^2+4a+2','bad_gcd_degree':3,
                  'exceptional_parameter_bound':bound,'cartier_tests':6},default=int))
