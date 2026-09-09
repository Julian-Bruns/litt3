#!/usr/bin/env sage
"""Exact small-fiber arithmetic and polynomial degree checks; no solver."""
from sage.all import *
import time

started = time.monotonic()
R = PolynomialRing(GF(5), 'z'); z = R.gen()
modulus = z**3+z+1
assert modulus.is_irreducible()
counts = []
for n in (3, 6):
    k = GF(5**n, 'a')
    a = modulus.change_ring(k).roots(multiplicities=False)[0]
    count = 1
    for u in k:
        value = u*(u-1)*(u-2)*(u-3)*(u-a)
        count += 1 if not value else 2 if value.is_square() else 0
    counts.append(ZZ(count))
assert counts == [118,15926]
R = PolynomialRing(QQ, 'T'); T = R.gen()
s1, s2 = 126-counts[0], 15626-counts[1]
P = T**4-s1*T**3+(s1*s1-s2)/2*T**2-125*s1*T+125**2
assert P == T**4-8*T**3+182*T**2-1000*T+15625
assert [ZZ(P(e)).valuation(2) for e in (1,-1)] == [4,4]
print('PASS exact point counts', counts, 'Weil polynomial', P)

R = PolynomialRing(GF(5), ['t','b','A0','A1','A2','A3','B0','B1','z'])
t,b,A0,A1,A2,A3,B0,B1,z = R.gens()
S = PolynomialRing(R,'u'); u = S.gen()
F = u*(u-1)*(u-2)*(u-3)*(u-t)
A = u**4+A3*u**3+A2*u**2+A1*u+A0
B = B1*u+B0
equations = list((A*A-F*B*B-(u-b)**8).list())
assert len(equations)==8
assert all(e.total_degree() <= 8 for e in equations)
equations.append(z*(t**5-t)*F(b)*B(b)-1)
assert equations[-1].total_degree()==13
assert len(equations)==R.ngens()==9
print('PASS complete normalized norm system, total degrees',
      [e.total_degree() for e in equations], 'safe Bezout bound', 13**9)

c4=(t+1)*(1-2*t); c3=-2*t*(t+1)
c9=-2*(t+1); c8=(t+1)*(t-2)
expected=[-2*t*(t+1),(t-1)*(t+1),-(t-2)*(t+1),
          2*(t-3)*(t+1),-2*(t+1)**2*(t**5-t)]
for branch,answer in zip([R(0),R(1),R(2),R(3),t],expected):
    assert c3-branch*c4+branch**5*c8-branch**6*c9==answer
assert c9==-2*(t+1)
print('PASS all six double-zero Cartier eigenform exclusions')
print('ALL CHECKS PASS; no roots searched; seconds',round(time.monotonic()-started,3))
