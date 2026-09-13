#!/usr/bin/env python3
"""Exact algebraic checks for the W4 defect calculation.

Run with Python 3 and SymPy:
    python3 w4_defect_algebra_certificate.py

This file verifies the rational-function, local-jet, residue, and finite-field
identities in the accompanying calculation. The geometric comparison between
the inverse-Cartier obstruction and the indicated Frobenius Bockstein is a
mathematical argument, not a black-box claim certified by this script.

All arithmetic below is exact. No numerical interpolation or sampling is used.
"""
from __future__ import annotations

import sympy as sp
from sympy.polys.matrices import DomainMatrix

u, x, t, B, C = sp.symbols("u x t B C")
q = (t + 1) ** 2
K = sp.GF(5).frac_field(t)


def mod_rat(expr: sp.Expr, variables=(t,), p=5) -> sp.Expr:
    """Reduce a rational function, first clearing rational coefficients."""
    n, d = sp.fraction(sp.cancel(expr))
    pn = sp.Poly(n, *variables, domain=sp.QQ)
    pd = sp.Poly(d, *variables, domain=sp.QQ)
    den = sp.ilcm(*[a.q for a in pn.coeffs() + pd.coeffs()], 1)
    pn = sp.Poly(sp.expand(den * n), *variables, modulus=p)
    pd = sp.Poly(sp.expand(den * d), *variables, modulus=p)
    if pd.is_zero:
        raise ZeroDivisionError("Denominator vanishes modulo p")
    # Cancel in the finite-field polynomial ring, not over QQ.
    gcd = sp.gcd(pn, pd)
    pn, pd = pn.exquo(gcd), pd.exquo(gcd)
    inv = pow(int(pd.LC()) % p, -1, p)
    pn, pd = pn.mul_ground(inv), pd.mul_ground(inv)
    return pn.as_expr() / pd.as_expr()


def eq5(a: sp.Expr, b: sp.Expr = sp.Integer(0), variables=(t,)) -> None:
    assert mod_rat(a - b, variables) == 0, (a, b)


def ok(message: str) -> None:
    print("PASS:", message, flush=True)


# 1. Hyperelliptic coordinate and normalized defect representative.
G = u * (u - 1) * (u - 2) * (u - 3)
F = G * (u - t)
a = q / (G * (u - t) ** 2)
ux = 3 / (1 - x**2)
D = (1 - x**2) * (x**2 + 2) * (2*x**2 + 1) * (t*x**2 + 3 - t)
S = 3*q*(x**6 + x**2)
eq5(a.subs(u, ux) * sp.diff(ux, x)**4 * D**2, S, (x, t))
assert (2 * 4 * 2) % 5 == 1  # two residues of (2y/x)(4 dx^2/y)
eq5(S / x**5, 3*q*(x + x**-3), (x, t))
ok("coordinate, square-Hasse coefficient, and normalized defect principal part")

# 2. First canonical branch digits. F acts on coefficients, so B^5 and C^5
#    occur rather than B and C in the branch-centre equations.
h = (3*u**7 + (4-2*t)*u**6 - (3+4*t)*u**5 + q*u**4
     + (2*t**2+4*t)*u**3 + 2*t**2*u**2) / q
eq5(sp.diff(h, u), 1/a - u**4, (u, t))
eq5(h.subs(u, 0)); eq5(h.subs(u, 1))
B5 = (t**2+1)/q
C5 = (t**2+t+2)/q
eq5(h.subs(u, 2)+1, B5)
eq5(h.subs(u, 3)+3, C5)
eq5(4*B5+2*C5, (q+2)/q)
ok("canonical branch equations B^5=(t^2+1)/q, C^5=(t^2+t+2)/q")

# 3. The necessary horizontal-section residue equations determine Q uniquely.
Q0 = (t**3+t**2+2*t+1)/(3*q)
Q1 = (2*t**3-t)/(3*q)
Q2 = 2*t
Q = Q0 + Q1*u + Q2*u**2
kt = K.gens[0]
zero, one = K.zero, K.one
rows = []  # coefficients in the order: constant, Q0, Q1, Q2
for b0 in [0, 1, 2, 3]:
    Gb = sp.Poly(sp.cancel(G/(u-b0)), u)
    g0 = K.convert(Gb.eval(b0))
    g1 = K.convert(Gb.diff().eval(b0))
    g2 = K.convert(Gb.diff().diff().eval(b0))
    d0 = K.convert(b0)-kt
    pr = [K.convert(b0**3), one, K.convert(b0), K.convert(b0**2)]
    pp = [K.convert(3*b0**2), zero, one, K.convert(2*b0)]
    row = [(pp[i]-pr[i]*(2*g1/g0+3/d0))/(g0*g0*d0**3) for i in range(4)]
    # The residue of 2 G'^2/(G^3 (u-t)^2) is the second derivative
    # of G'^2/(Gb^3 (u-t)^2) at u=b0.
    row[0] += (3*g2/g0-4*g1*g1/(g0*g0)-4*g1/(g0*d0)+6/d0**2)/(g0*d0**2)
    row[0] += 3/(g0*d0**4)
    rows.append(row)
Gt = K.from_sympy(G.subs(u,t))
Lt = K.from_sympy(sp.diff(G,u).subs(u,t))/Gt
Mt = K.from_sympy(sp.diff(G,u,2).subs(u,t))/Gt
Nt = K.from_sympy(sp.diff(G,u,3).subs(u,t))/Gt
pr = [kt**3,one,kt,kt**2]
pp = [3*kt**2,zero,one,2*kt]
ppp = [6*kt,zero,zero,K.convert(2)]
row = [(ppp[i]-4*pp[i]*Lt+pr[i]*(6*Lt**2-2*Mt))/(2*Gt**2) for i in range(4)]
row[0] += 2*(2*Lt*Mt-3*Lt**3)/Gt
row[0] += (-6*Lt**3+6*Lt*Mt-Nt)/(2*Gt)
rows.append(row)
qvalues = [K.from_sympy(sp.cancel(v)) for v in (Q0,Q1,Q2)]
for row in rows:
    assert row[0]+sum((row[i+1]*qvalues[i] for i in range(3)),zero) == zero
assert DomainMatrix([row[1:] for row in rows],(5,3),K).rank() == 3
minor = DomainMatrix([row[1:] for row in rows[:3]],(3,3),K).det()
expected_minor = 2*(t+1)**2*(t+2)/(t**4*(t-1)**4*(t-2)**4)
assert minor - K.from_sympy(sp.cancel(expected_minor)) == K.zero
# This minor is a unit at every admissible t, not just at the generic point.
ok("all five residues vanish; an explicit 3x3 minor is a unit for every admissible t")

# The mixed-characteristic identity producing those equations (formal symbols
# L=G'/G, M=G''/G, d=u-t, H=(u^3+Q)/F) is exact over Q.
L, M, d, H = sp.symbols("L M d H")
Rbase = M/4 - 3*L**2/16 + L/(8*d) - 3/(16*d**2)
Ppart = -3*M/4 + 7*L/(8*d) + 5*H
fdd = -M/2 + 3*L**2/4 + L/d + 2/d**2
assert sp.cancel(Rbase+Ppart-fdd - 5*(H-3*L**2/16-7/(16*d**2))) == 0
eq5(-sp.Rational(3,16), 2); eq5(-sp.Rational(7,16), 3)
ok("exact mixed-characteristic identity R_2-f_0''/f_0 = 5K")

# 4. The weight-rescaled adjoint Frobenius: the diagonal v' terms contribute.
f,g,j12,j22,V,Vp,Vb,p = sp.symbols("f g j12 j22 V Vp Vb p")
J = sp.Matrix([[f,j12],[g,j22]])
Jadj = sp.Matrix([[j22,-j12],[-g,f]])
scaled = sp.Matrix([[-p*Vp/2,p*p*Vb],[V,p*Vp/2]])
assert sp.expand((Jadj*scaled*J)[1,0] - (f*f*V+p*f*g*Vp-p*p*g*g*Vb)) == 0
ok("full lower-left adjoint matrix identity, including p*f*g*F(v')")

# A separate check of the direct Taylor/jet comparison.  Work formally to
# order p^3.  The coordinate change is x_U=x_D+p^2*Z*v, and ZF denotes
# sigma(Z) (specializing to Z^5).  J' = J*A-x^4*N*J.
Z, ZF, FV, FVp, rx, xfour = sp.symbols("Z ZF FV FVp rx xfour")
N = sp.Matrix([[0,0],[1,0]])
Hdiag = sp.diag(1,-1)
Aoper = sp.Matrix([[0,rx],[1,0]])
Jprime = J*Aoper-xfour*N*J
Delta = p*p*Z*xfour*V-p*ZF*FV
TaylorJet = sp.eye(2)+N*Delta+(p*p*ZF*FVp/2)*Hdiag
normal = sp.expand((Jadj*TaylorJet*(J+p*p*Z*V*Jprime))[1,0])
expected = p*p*Z*V*J.det()-p*ZF*(f*f*FV+p*f*g*FVp)
remainder = sp.Poly(sp.expand(normal-expected),p)
for degree in range(3):
    assert remainder.coeff_monomial(p**degree) == 0
ok("direct Taylor/jet comparison: p^2 Z v - p sigma(Z)(f^2 F(v)+p fg F(v'))")

# 5. Finite mixed-characteristic local jet at the branch u=c.
b,c,tau = sp.symbols("b c tau")
Sc0 = 1/c + 1/(c-1) + 1/(c-b)
Sc = Sc0 + 1/(c-tau)
Hc = c*(c-1)*(c-b)
Qc = sp.symbols("Qc")
Pc = -sp.Rational(3,2)*(c-tau)*Hc*Sc0 + sp.Rational(7,8)*Hc + 5*(c**3+Qc)
Rlocal = -sp.Rational(3,2) + c*Sc/2 + 4*c*Pc/(Hc*(c-tau))
D2overD0 = c*Sc-5
U0 = 2-sp.Rational(7,3)*c*Sc0
assert sp.cancel(Rlocal/3-D2overD0/2 - U0
                 - 5*c/(6*(c-tau))
                 - 20*(c**3+Qc)/(3*(c-1)*(c-b)*(c-tau))) == 0
assert sp.cancel(U0.subs({b:2,c:3})) == -sp.Rational(65,6)
eq5(U0.subs({b:2,c:3})/5, 2)
eq5(sp.diff(U0,b).subs({b:2,c:3}), 3)
eq5(sp.diff(U0,c).subs({b:2,c:3}), 4)
Q3 = Q.subs(u,3)
Ljet = 2+3*B+4*C+(1+4*Q3)/(3-t)
eq5(3*q*Ljet, q*(4*B+2*C)+2*t**2+t, (t,B,C))
ok("divided local jet L=(R_x(0)/3-D_2/(2D_0))/5")

# 6. The off-diagonal term needs the x^9 jet, not just the Hasse coefficient.
Dsq = sp.Poly(sp.expand(D**2),x)
Ej = lambda j: Dsq.coeff_monomial(x**j)
eq5(Ej(6)-Ej(2), 3*q)
jet9 = (Ej(8)-Ej(4)+Ej(0))/7 + (Ej(4)-Ej(0))/3
eq5(jet9, 3*Ej(8)-Ej(4)+Ej(0))
eq5(jet9, 2*(t+1))
beta = q*(4*B+2*C)+2*q+1
eq5(3*q*Ljet-jet9, beta, (t,B,C))
ok("off-diagonal residue is 2(t+1); beta=q(4B+2C)+2q+1")

# 7. Retain Frobenius on coefficients when eliminating B,C.
R = 3*(t+1)**10 + 2*(t+1)**8 + 1
eq5(q**5*(4*B5+2*C5)+(2*q+1)**5, R)
E = t**8-2*t**7+t**6-t**5+2*t**4-t**3-2*t**2+1
eq5(R, 3*(t-1)*(t-2)*E)
eq5(sp.diff(R,t), (t+1)**7)
EP = sp.Poly(E,t,modulus=5)
assert EP.is_irreducible
# Explicit Rabin irreducibility certificate for degree 8: 8 has only the
# prime divisor 2, so test the fourth and eighth Frobenius iterates.
xbar = sp.Poly(t,t,modulus=5)
frob = xbar
for degree in range(1,9):
    frob = (frob**5).rem(EP)
    if degree == 4:
        assert sp.gcd(frob-xbar,EP).degree() == 0
assert (frob-xbar).is_zero
for a0 in range(5):
    assert int(sp.Poly(E,t,modulus=5).eval(a0)) % 5 != 0
ok("beta^5=R(t); R=3(t-1)(t-2)E; E is irreducible of degree eight")

# 8. Exact debugging specialization over F_625.
modulus = sp.Poly(t**4+4*t**3+t**2+4*t+3,t,modulus=5)
assert modulus.is_irreducible

def ff(expr: sp.Expr) -> sp.Poly:
    return sp.Poly(expr,t,modulus=5).rem(modulus)

def fpow(a0: sp.Poly, n: int) -> sp.Poly:
    result = ff(1)
    while n:
        if n & 1:
            result = (result*a0).rem(modulus)
        a0 = (a0*a0).rem(modulus)
        n >>= 1
    return result

betaf = ff(3*t**2+t+2)
alphaf = ff(2*t**3+t**2+1)
assert fpow(betaf,5) == ff(R)
assert (fpow(alphaf,4)*betaf).rem(modulus) == ff(1)
for a0 in range(5):
    z = (ff(a0)*alphaf).rem(modulus)
    assert (z-betaf*fpow(z,5)).rem(modulus).is_zero
ok("F_625: beta=3t^2+t+2; roots are F_5*(2t^3+t^2+1)")
print("\nAll algebraic checks passed.")
print("Resulting polynomial: P_t(z) = z - beta_t*z^5 (up to a nonzero t-factor).")
print("Geometric comparison and the degree bound must be read with the accompanying proof.")
