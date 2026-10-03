#!/usr/bin/env python3
"""Independent small symbolic check of the NEW degree42 norm coefficients.

No endpoint enumeration, old certificate replay, or Groebner calculation.
The human proof remains the canonical record.
"""
import json
from pathlib import Path
import sympy as sp

w, q, b, d, e, a, lam, s, n = sp.symbols('w q b d e a lam s n')
variables = (w, q, b, d, e, a, lam, s, n)

def red(expr):
    pa = sp.Poly(sp.expand(expr), a)
    expr = sum(coef * (4*q)**(i//2) * a**(i % 2)
               for (i,), coef in pa.terms())
    return sp.Poly(sp.expand(expr), *variables, modulus=5).as_expr()

phi = w**5 + q*w**4 + lam*w + s
U = w**3 + b*w**2 + d*w + e

def mul(x, z):
    return (red(x[0]*z[0] + phi*x[1]*z[1]),
            red(x[0]*z[1] + x[1]*z[0]))

def deriv(x):
    return (red(phi*sp.diff(x[1], w) + 3*sp.diff(phi,w)*x[1]),
            red(sp.diff(x[0], w)))

def add(x, z, sign=1):
    return (red(x[0]+sign*z[0]), red(x[1]+sign*z[1]))

def power(x, k):
    z = (sp.Integer(1), sp.Integer(0))
    for _ in range(k):
        z = mul(z, x)
    return z

def coeff(x, j):
    return red(sp.Poly(x,w).nth(j))

F = (U, a)
D = deriv(F)
Z = (3*q*w**2+n, a)
g = add(add(mul(D,D),mul(F,deriv(D))),mul(power(F,2),Z),-1)
h = deriv(mul(F,g))
L = red(b*b+2*d+b*q+4*q*q)
t = coeff(h[1],8)
assert red(coeff(g[0],7)-L) == 0
assert red(coeff(g[1],4)+a*L) == 0
assert red(coeff(h[0],10)-a*(t+n)) == 0
tau = red(t*t-L**3)
# Only the top coefficients can contribute to the two tested powers.
# Extract them from the independently constructed original g and h.
ge7, ge6 = coeff(g[0],7), coeff(g[0],6)
go4, go3 = coeff(g[1],4), coeff(g[1],3)
he10, he9 = coeff(h[0],10), coeff(h[0],9)
ho8, ho7 = coeff(h[1],8), coeff(h[1],7)
norm18 = red(2*he10*ho8-3*ge7**2*go4-2*a*tau)
norm17 = red(2*(he10*ho7+he9*ho8)
             -3*(ge7**2*go3+2*ge7*ge6*go4)
             -go4**3-2*a*b*tau)
assert red(norm18-2*a*n*t) == 0
R = red(3*d*d+3*b*e+2*b*b*d+2*q*q*d
        +2*q*b**3+4*b*q**3+3*b*b*q*q+4*q**4+4*lam)
assert red(coeff(mul(F,g)[0],8).subs(n,0)-R) == 0
S = red(q*(4*e+2*q*d)+4*lam)
assert red((R+(q-2*b)*t+3*L*L).subs(n,0)-S) == 0
# The precise nonzero factor multiplying the claimed w17 bracket.
assert red(norm17.subs(n,0)-a*t.subs(n,0)*S) == 0
target = Path(__file__).resolve().parents[3] / 'litt3-computation-data' / 'oct03_backup42_independent_audit'
target.mkdir(parents=True,exist_ok=True)
(target/'high_coefficient_receipt.json').write_text(json.dumps({
    'result':'PASS', 'relation':'a^2=4q',
    'checks':['g leading parity','h leading parity','norm odd w18',
              'Fg even w8','bracket simplification','norm odd w17'],
    'method':'independent symbolic polynomial multiplication modulo five'
},indent=2)+'\n')
print('PASS: six independent degree42 high-coefficient identities')
