#!/usr/bin/env python3
"""Small independent canonical projection checks for the new fourth jets."""
from sage.all import GF, PolynomialRing

P=PolynomialRing(GF(5),'b');b=P.gen()
F=GF(25,'b',modulus=b*b-b-3);b=F.gen()
code=lambda n:F(n%5)+F(n//5)*b
P=PolynomialRing(F,'a')
K=P.quotient(P([code(n) for n in [5,2,6,7,1]]),'a');a=K.gen()
row=lambda ns:sum(K(code(n))*a**i for i,n in enumerate(ns))
c,e,f,g=[row(ns) for ns in [[22,7,9,23],[1,3,8,15],[20,12,13,8],[21,21,20,2]]]
project=lambda v,l:sum(K(GF(5)(l)**(-i))*v**(25**i) for i in range(4))/4
cs=[project(c,l) for l in [1,2,3,4]]
es=[project(e,l) for l in [1,2,3,4]]
fs=[project(f,l) for l in [1,2,3,4]]
gs=[project(g,l) for l in [1,2,3,4]]
assert all(cs) and es[2]==0 and es[1]==cs[1] and es[3]==code(12)*cs[3]
assert [cs[0],es[0],fs[0],gs[0]]==[K(code(n)) for n in [20,8,12,4]]
assert all(gs[i]==code(r)*cs[i] for i,r in enumerate([13,17,0,7]))
assert all(fs[i]==code(r)*es[i]**125 for i,r in [(0,3),(1,14),(3,20)])
J=cs[3]
assert J*J==code(15) and fs[3]==code(17)*J and gs[3]==code(7)*J
assert (code(17)+code(24))/(1-code(24))==code(9)
assert code(9)/code(12)==code(20) and code(20)**5!=code(20)
print('PASS: all canonical eigenvalue identities, opposite-pair four-coordinate model, and one-balanced obstruction constants.')
