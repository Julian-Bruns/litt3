#!/usr/bin/env python3
"""Returned exact identities for the genus-two residue resolution.

Requires SymPy (available in the local Sage Python). This checks the
variable-parameter identities and adjoint normalization, not the open
rank-one implication for stable Frobenius pullbacks.
"""
import sympy as sp

u, t, T = sp.symbols('u t T')


def reduce5(expression, variables=(T, t, u)):
    return sp.Poly(sp.expand(expression), *variables, modulus=5).as_expr()


def assert_zero(expression, variables=(T, t, u)):
    assert sp.Poly(sp.expand(expression), *variables, modulus=5).is_zero


f = reduce5(u*(u-1)*(u-2)*(u-3)*(u-t))
a = [sp.Poly(f, u).nth(j) for j in range(6)]
w = reduce5(T*T + 3*a[4]*T + 3*a[3])
d = reduce5(-a[2] + (a[4]+2*T)*w)
psi = reduce5(2*a[0] - 2*a[1]*T + a[2]*w - d*w)

# Take the discriminant before reduction: the derivative drops degree.
disc = reduce5(sp.discriminant(psi, T), (t,))
assert_zero(disc + (t*(t-1)*(t-2)*(t-3))**2, (t,))
print('PASS: Disc_T(Psi) = -[t(t-1)(t-2)(t-3)]^2.')

H = reduce5(2*u**3 + T*u*u + w*u + d)
N = reduce5(2*sp.diff(f,u)**2 - f*sp.diff(f,u,2) + H*f)
numerator = reduce5(2*(sp.diff(N,u,2)*f*f
                       - 4*sp.diff(N,u)*f*sp.diff(f,u)
                       - 2*N*f*sp.diff(f,u,2)
                       + 6*N*sp.diff(f,u)**2) - N*N)
assert_zero(numerator - f*f*(2*T+2*u+a[4])*psi)
print('PASS: 2 r_T\'\' - r_T^2 = (2T+2u+a_4)Psi(T)/f^2.')

Hp = sp.Poly(H, T)
assert_zero(Hp.nth(3)-2)
assert_zero(Hp.nth(2)-(u+2*a[4]))
assert_zero(Hp.nth(1)-(u*u+3*a[4]*u+3*a[4]**2+a[3]))
print('PASS: the nonconstant coefficients give a bicanonical basis.')

z, r, r1 = sp.symbols('z r r1')
h0, h1, h2, h3, h4 = hs = sp.symbols('h0:5')
variables = (z, r, r1, *hs)
sol_a = 1 + 3*r*z*z + r1*z**3 + r*r*z**4
sol_b = z + r*z**3 + 3*r1*z**4
h = sum(hs[j]*z**j for j in range(5))
rjet = r + r1*z + 4*r*r*z*z + r*r1*z**3 + (4*r1*r1+2*r**3)*z**4
Ah = sp.diff(h,z,3) + rjet*sp.diff(h,z) + 3*sp.diff(rjet,z)*h
for solution in (sol_a, sol_b):
    wronskian = (solution*sp.diff(Ah,z)-sp.diff(solution,z)*Ah).subs(z,0)
    cartier = sp.Poly(sp.expand(solution*h),z).nth(4)
    assert_zero(wronskian - 4*cartier, variables)
print('PASS: the complementary operator is four times the Cartier adjoint.')

# A concrete smooth curve where the nonreduced extension is needed.
f_collision = u**5 + u**3 + u
assert sp.gcd(sp.Poly(f_collision,u,modulus=5),
              sp.Poly(sp.diff(f_collision,u),u,modulus=5)).degree() == 0
w_collision = T*T + 3
d_collision = 2*T*w_collision
psi_collision = reduce5(-2*T-d_collision*w_collision)
assert_zero(psi_collision-3*T**3*(T*T+1))
print('PASS: smooth v^2=u^5+u^3+u has dormant algebra Psi=3T^3(T^2+1).')
print('These checks do not prove the rank-one stable-pullback exclusion.')
