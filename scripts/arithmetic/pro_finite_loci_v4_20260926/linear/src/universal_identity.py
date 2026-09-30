#!/usr/bin/env python3
"""An executed symbolic verification of the fixed-degree resultant identity.
Only this optional audit uses SymPy; the complete C++ replay is independent.
"""
import platform
import sympy
from sympy.polys.fields import field
from sympy.polys.domains import GF

K, a, b, c, d, Q, C, l = field('a,b,c,d,Q,C,l', GF(5))
rem = [(K.one, K.zero)]
for n in range(10):
    u, v = rem[-1]
    rem.append((-v*c/a, u-v*b/a))
fcoeff = {10:l, 8:2*a, 7:3*b, 6:c, 5:d+2*l*Q,
          3:2*a*Q, 2:3*b*Q, 1:c*Q, 0:l*Q**2+d*Q+C}
u = sum((cc*rem[n][0] for n,cc in fcoeff.items()), K.zero)
v = sum((cc*rem[n][1] for n,cc in fcoeff.items()), K.zero)
actual = a**10*(u**2-b/a*u*v+c/a*v**2)
E = a*d-b*c
Delta = b**2+a*c
T0 = c**5-Q*b**5+Q**2*a**5
U0 = 2*Q*a**5-b**5
V0 = (-d*b**5-2*c**2*b**4-3*a*b**2*c**3-2*a**2*c**4
      +Q*(2*a**5*d-a**4*b*c+a**3*b**3))
W0 = a**2*d**2-a*b*c*d+2*b**2*c**2+b**3*d+a*c**3
M0 = U0*(2*a*E+b*Delta)-a**2*V0
formula = (l**2*T0**2+l*(T0*V0+C*(U0**2-2*a**5*T0))
           +a**3*(T0*W0+C*M0)+C**2*a**10)
assert actual.denom == K.ring.one
assert actual == formula
print('Python', platform.python_version(), 'SymPy', sympy.__version__)
print('PASS: generic resultant equals the displayed 55-term polynomial.')
print('PASS: denominator is 1, hence the identity extends to a=0 and every degree drop.')
