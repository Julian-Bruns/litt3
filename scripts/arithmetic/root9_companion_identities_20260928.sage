#!/usr/bin/env sage
"""Universal discriminant and companion identities, independent of archive code."""
import json
import sys
from pathlib import Path
from sage.all import GF, PolynomialRing

R = PolynomialRing(GF(5), names=('b','c','e','u','U'))
b,c,e,u,U = R.gens()
K = R.fraction_field()
a = -(b*u**2+c*u+e)/u**3
f = a*U**3+b*U**2+c*U+e
g = b*u**2+2*c*u+3*e
D2 = c**2-4*b*e
C = c**2-3*b*e
J = D2*u**2+3*c*e*u+2*e**2
Q = a*U**2+(b+a*u)*U-e/u
assert f == (U-u)*Q
disc = b*b*c*c-4*a*c**3-4*b**3*e-27*a*a*e*e+18*a*b*c*e
assert disc == g*g*J/u**6
assert (3*c*e)**2-4*D2*(2*e**2) == e*e*C
assert ((2*D2*u+3*c*e)**2-e*e*C) == 4*D2*J
assert b*J-D2*g == -C*(2*c*u+3*e)
sum_u = 2*c*e/D2
prod_u = 2*e*e/D2
assert 4*c*c*prod_u+6*c*e*sum_u+9*e*e == 4*e*e

# The exact source-critical and selected-simple companion curves are
# birational over K(q); the parameters b,c,e are left independent here.
P = PolynomialRing(GF(5), names=('b','c','e','r'))
b,c,e,r = P.gens()
Fr = P.fraction_field()
g = b*r*r+2*c*r+3*e
D2 = c*c-4*b*e
C = c*c-3*b*e
sum_r, prod_r = -2*c/b, 3*e/b
assert c*c*prod_r+2*c*e*sum_r+4*e*e == -e*D2/b
assert c*c*prod_r+3*c*e*sum_r+9*e*e == 2*e*C/b
u = -e*r/(c*r+2*e)
J = D2*u*u+3*c*e*u+2*e*e
num = P(J.numerator())
assert num.reduce(P.ideal(g)) == 0
ar = -(b*r*r+c*r+e)/r**3
au = -(b*u*u+c*u+e)/u**3
assert P((ar-au).numerator()).reduce(P.ideal(g)) == 0
xi = b*r+c
assert (xi*xi-C).reduce(P.ideal(g)) == 0
assert P((u-e*(c+2*xi)/D2).numerator()).reduce(P.ideal(g)) == 0

# Inverse companion map, retaining the same cubic value s.
rr = -u*(c*u+e)/(2*(b*u*u+c*u+e))
assert P((rr-r).numerator()).reduce(P.ideal(g)) == 0

result = {'characteristic':int(5),
          'factorization_f':True,
          'disc_f_equals_g_squared_J_over_u6':True,
          'disc_J_equals_e_squared_C':True,
          'quadratic_normalization_identity':True,
          'critical_companion_identity_and_norms':True,
          'companion_map_preserves_s':True,
          'companion_and_inverse_exact':True,
          'square_property_transport': 'not proved or assumed'}
print(json.dumps(result,indent=2))
if len(sys.argv)>1:
    p=Path(sys.argv[1]);p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(result,indent=2)+'\n')
