#!/usr/bin/env python3
"""Exact universal check, not a specialization or a square-locus decision."""
import json
from pathlib import Path
import sympy
from sympy.polys.rings import ring
from sympy.polys.domains import GF

R, a,b,c,d,Q,C,l = ring('a,b,c,d,Q,C,l', GF(5))
E = a*d-b*c
Delta = b*b+a*c
T = c**5-Q*b**5+Q**2*a**5
U = 2*Q*a**5-b**5
V = -d*b**5-2*c**2*b**4-3*a*b**2*c**3-2*a**2*c**4+Q*(2*a**5*d-a**4*b*c+a**3*b**3)
W = a*a*d*d-a*b*c*d+2*b*b*c*c+b**3*d+a*c**3
M = U*(2*a*E+b*Delta)-a*a*V
D2 = T*T
D1 = T*V+C*(U*U-2*a**5*T)
D0 = a**3*(T*W+C*M)+C*C*a**10
formula = D0+l*D1+l*l*D2
# For a != 0 let r_i = a^(i-1) Z^i mod (a Z^2+b Z+c).
# Its coefficients satisfy A_(i+1)=-b A_i+a B_i, B_(i+1)=-c A_i.
AA, BB = [R.zero]*11, [R.zero]*11
AA[1], BB[1] = R.one, R.zero
for i in range(1,10):
    AA[i+1], BB[i+1] = -b*AA[i]+a*BB[i], -c*AA[i]
f = {10:l, 8:2*a, 7:3*b, 6:c, 5:2*l*Q+d,
     3:2*a*Q, 2:3*b*Q, 1:c*Q, 0:l*Q**2+Q*d+C}
rr1,rr0 = R.zero,a**9*f[0]
for i in range(1,11):
    rr1 += f.get(i,R.zero)*a**(10-i)*AA[i]
    rr0 += f.get(i,R.zero)*a**(10-i)*BB[i]
residual = c*rr1*rr1-b*rr1*rr0+a*rr0*rr0-a**9*formula
assert residual == 0
Theta = Q*a**3+d*Delta+2*b*c*c
VV = T*Theta+C*Delta*U
assert D1*D1-4*D2*D0 == Delta**3*VV**2
summary = {
 'sympy_version': sympy.__version__,
 'coefficient_ring':'F5[a,b,c,d,Q,C,l]',
 'universal_resultant_identity':'PASS',
 'fixed_degree_resultant':'degrees 10 and 2; extends to a=0 by polynomial identity',
 'scale_discriminant_identity':'PASS',
 'resultant_expanded_terms':len(formula),
 'square_locus_decision':'NOT OBTAINED'
}
print(json.dumps(summary,indent=2))
