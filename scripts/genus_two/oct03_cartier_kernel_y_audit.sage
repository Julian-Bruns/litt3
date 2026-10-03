#!/usr/bin/env sage
"""Small exact audit of the marked genus-two Cartier-jet calculation.

No finite-field search or common-cover realization is performed.  All
identities are checked symbolically in characteristic five, with geometric
parameters.  Run with: sage scripts/genus_two/oct03_cartier_kernel_y_audit.sage
"""

from sage.all import GF, PolynomialRing

names = (
    "a c d b e p0 p1 p2 h00 h01 h02 h03 h10 h11 "
    "q00 q01 q02 q03 q04 q10 q11 q12"
).split()
P = PolynomialRing(GF(5), names=names)
symbols = dict(zip(names, P.gens()))
globals().update(symbols)
k = P.fraction_field()
R = PolynomialRing(k, "z")
z = R.gen()

Phi = a*z**5 + c*z**4 + d
Phi1 = Phi.derivative()
Phi2 = Phi1.derivative()
Phi3 = Phi2.derivative()
F = b*z**2 + e*z**3
p = p0 + p1*z + p2*z**2
H0 = h00 + h01*z + h02*z**2 + h03*z**3
H1 = h10 + h11*z
Q0 = q00 + q01*z + q02*z**2 + q03*z**3 + q04*z**4
Q1 = q10 + q11*z + q12*z**2

U = F.derivative()*Phi - 2*c*z**3*F
Z1 = U - (F // z)*Phi
V1 = U.derivative() - c*z**2*F
T0 = c*z**4 + 3*Phi - 3*(F // z)*F.derivative()
R0 = Phi - (F // z)**2
S = Phi*(2*p.derivative()+H1) + 2*c*z**3*p
Cnum = (4*p.derivative(2)+2*h11)*Phi + 4*c*z**3*H1 + Q0
Todd = Phi*(4*H0.derivative()+Q1) + c*z**3*H0

# The two characters of g*C + 3*g'*B + g''*A.
E = z*Phi*Cnum + F*Todd + 3*Phi*S + 3*U*H0
O = (
    z*Phi*Todd + F*Phi*Cnum + 3*H0*Phi**2
    + 3*U*S + p*(U.derivative()*Phi-c*z**3*U)
)
reduced_full = (
    z*R0*(Q1+4*H0.derivative())
    + 3*Z1*(2*p.derivative()+H1) + p*V1 + T0*H0
)
assert z*O - F*E == z*Phi*reduced_full
assert E[0] == 3*d**2*(2*p1+h10)

def specialize_h10(f):
    return R([coeff.subs({h10: 3*p1}) for coeff in f.list()])

E0 = specialize_h10(E-z*Phi*Q0)
q, rem = E0.quo_rem(z*Phi)
assert rem == 0
Q0_solution = -q
assert Q0_solution.degree() <= 4
reduced = specialize_h10(reduced_full)
assert reduced == (
    z*R0*(Q1+4*H0.derivative())
    + 3*(4*p2+h11)*z*Z1 + p*V1 + T0*H0
)
assert reduced.degree() <= 8
print("PASS: both-character elimination; exact polynomial Q0; degree-eight gate")

# Local branch frame t=w.  q=dz/dt=2*w/Phi'; write q'=r.
# These are the rational (even) and w-multiplied (odd) components after
# applying the exact Hasse principal-parts coordinate transformation.
K = R.fraction_field()
r = K(2)/Phi1 - K(4)*Phi*Phi2/Phi1**3
q2 = K(4)*Phi/Phi1**2
q4 = Phi**2/Phi1**4
q_q2 = K(4)*Phi*r.derivative()/Phi1**2
A = K(p)/Phi
Ct_A = (
    q4*(4*p.derivative(2)/Phi)
    + 4*q2*r*A.derivative()
    + (4*q_q2+3*r**2)*A
)
Ct_A_expected = (
    K(2)*p.derivative()/Phi1**3
    + Phi*(4*p.derivative(2)*Phi1+Phi2*p.derivative()+p*Phi3)/Phi1**5
)
assert Ct_A == Ct_A_expected

# Odd h=H0/w^3 has coefficient H0/Phi^2 in the basis 1,w.
Ct_H0_w = (
    4*q4*(H0.derivative()/Phi**2+H0*Phi1/Phi**3)
    + 2*q2*r*H0/Phi**2
)
assert Ct_H0_w == 4*H0.derivative()/Phi1**4+3*H0*Phi2/Phi1**5
Ct_H1 = (
    q4*(4*(K(H1)/Phi).derivative()+3*h11/Phi)
    + 2*q2*r*H1/Phi
)
assert Ct_H1 == (
    2*Phi*h11/Phi1**4+2*H1/Phi1**3+3*Phi*Phi2*H1/Phi1**5
)
print("PASS: branch-frame regularity, including the indispensable 4*h' term")

# At infinity t=z^2/w, set T=Phi-c*z^4; T'=0.
# q=3*w^3/(z*T), q'=Phi^2/(z^3*T), q''=w^5/(z^5*T).
T = Phi-c*z**4
assert T.derivative() == 0
q2_inf = K(4)*Phi**3/(z**2*T**2)
q4_inf = Phi**6/(z**4*T**4)
r_inf = K(Phi**2)/(z**3*T)
assert r_inf.derivative() == K(2)*Phi/z**4
assert K(4)*3*Phi**4/(z**6*T**2)+3*r_inf**2 == 0
Ct_A_inf = q4_inf*(4*p.derivative(2)/Phi)+4*q2_inf*r_inf*A.derivative()
Ct_A_inf_expected = (
    Phi**3*(4*z*Phi**2*p.derivative(2)
             +T*(p.derivative()*Phi-p*Phi1))/(z**5*T**4)
)
assert Ct_A_inf == Ct_A_inf_expected
Ct_H1_inf = (
    q4_inf*(4*(K(H1)/Phi).derivative()+3*h11/Phi)
    + 2*q2_inf*r_inf*H1/Phi
)
assert Ct_H1_inf == (
    Phi**4*(c*h11*z**5+h10*(4*c*z**4+3*T))/(z**5*T**4)
)
print("PASS: infinity frame; exact cancellation of the h11 double pole")

# b=0 family.  Every p and h11 gives the following H0,H1,Q1.
F_e = e*z**3
H0_e = e*z*(p0+p1*z+h11*z**2)
H1_e = 3*p1+h11*z
Q1_e = 2*e*p0+3*e*p1*z-e*h11*z**2
U_e = F_e.derivative()*Phi-2*c*z**3*F_e
Z1_e = U_e-(F_e//z)*Phi
V1_e = U_e.derivative()-c*z**2*F_e
T0_e = c*z**4+3*Phi-3*(F_e//z)*F_e.derivative()
R_e = Phi-(F_e//z)**2
assert (
    z*R_e*(Q1_e+4*H0_e.derivative())
    + 3*(4*p2+h11)*z*Z1_e+p*V1_e+T0_e*H0_e
) == 0

S_e = Phi*(2*p.derivative()+H1_e)+2*c*z**3*p
Todd_e = Phi*(4*H0_e.derivative()+Q1_e)+c*z**3*H0_e
Cbase_e = (4*p.derivative(2)+2*h11)*Phi+4*c*z**3*H1_e
Ebase_e = z*Phi*Cbase_e+F_e*Todd_e+3*Phi*S_e+3*U_e*H0_e
q_e, rem_e = Ebase_e.quo_rem(z*Phi)
assert rem_e == 0
Q0_e = -q_e
assert Q0_e.degree() <= 4
Q0_one = R([coeff.subs({p0: 1,p1: 0,p2: 0,h11: 0}) for coeff in Q0_e.list()])
assert Q0_one == -c*z**2
print("PASS: geometric b=0 family for every p and h11; Q0(p=1)=-c*z^2")

# Independently verify the stated p=1 vector directly in k(z)[w]/(w^2-Phi).
def pair_derivative(v):
    even, odd = v
    return (even.derivative(), odd.derivative()+Phi1*odd/(2*Phi))

def pair_product(v, u):
    even, odd = v
    other_even, other_odd = u
    return (even*other_even+Phi*odd*other_odd,
            even*other_odd+odd*other_even)

g_one = (K(z), K(e*z**3)/Phi)
B_one = (K(2*c*z**3)/Phi**2, K(e*z)/Phi**2)
C_one = (-K(c*z**2)/Phi**2,
         K(e)/Phi**2+K(c*e*z**4)/Phi**3)
g_prime = pair_derivative(g_one)
g_second = pair_derivative(g_prime)
gC = pair_product(g_one, C_one)
gB = pair_product(g_prime, B_one)
assert all(gC[i]+3*gB[i]+g_second[i]/Phi == 0 for i in (0,1))

# Exact transformed coordinates at P.  Record even/odd components in 1,w.
At_one = K(4)*Phi**2/(z**2*T**2)
q3_odd = K(2)*Phi**4/(z**3*T**3)
q_qprime_odd = K(3)*Phi**3/(z**4*T**2)
Bt_even = q3_odd*B_one[1]*Phi
Bt_odd = q3_odd*B_one[0]+4*q_qprime_odd/Phi
assert Bt_even == K(2*e)*Phi**3/(z**2*T**3)
assert Bt_odd == Phi**2*(4*c*z**4+2*T)/(z**4*T**3)
Ct_even = q4_inf*C_one[0]+2*q2_inf*r_inf*B_one[0]
Ct_odd = q4_inf*C_one[1]+2*q2_inf*r_inf*B_one[1]
assert Ct_even == -K(c**2)*z**2*Phi**3/T**4
assert Ct_odd == K(e)*Phi**3*(4*T+2*c*z**4)/(z**4*T**4)

def infinity_order(v, odd=False):
    if not v:
        return float("inf")
    return 2*(v.denominator().degree()-v.numerator().degree())-(5 if odd else 0)

assert infinity_order(At_one) == 4
assert infinity_order(Bt_even) == 4
assert infinity_order(Bt_odd, odd=True) == 3
assert infinity_order(Ct_even) == 6
assert infinity_order(Ct_odd, odd=True) == 3
assert K(Bt_odd).numerator().leading_coefficient()/K(Bt_odd).denominator().leading_coefficient() == 2
print("PASS: explicit p=1 vector annihilates delta and is global with exact zero divisor 3P")
print("Geometric consequence: saturated O(3P) in H_e violates the original globally generated rank-three target")
print("Scope: marked b=0 branch excluded under the original source surjection; no whole-source or common-cover decision")

# Focused follow-up: all sections vanishing at least 3P in the full marked
# wild-zero chart.  The global jet bounds give p constant, H0 linear,
# H1=0, Q0 quadratic, and Q1 constant.
p_sc = p0
H_sc = h00+h01*z
q_sc = q10
Q0_sc = (
    4*b*h00+(e*h00-b*q_sc)*z
    +(2*e*h01-e*q_sc-c*p_sc)*z**2
)
S_sc = 2*c*z**3*p_sc
Todd_sc = Phi*(4*h01+q_sc)+c*z**3*H_sc
E_sc = z*Phi*Q0_sc+F*Todd_sc+3*Phi*S_sc+3*U*H_sc
assert E_sc == 0
gate_sc = z*R0*(q_sc+4*h01)+p_sc*V1+T0*H_sc
assert gate_sc[0] == d*(2*b*p_sc+3*h00)
assert gate_sc[2] == 4*b**2*h00
assert gate_sc[3] == -b**2*q_sc
assert gate_sc[6] == a*(q_sc+e*p_sc+2*h01)
assert gate_sc[5] == (
    (c-e**2)*(q_sc+3*h01)+2*a*b*p_sc+3*a*h00
)
gate_b_zero = R([
    coeff.subs({b: 0,h00: 0,h01: e*p_sc,q10: 2*e*p_sc})
    for coeff in gate_sc.list()
])
assert gate_b_zero == 0
Q0_b_zero = R([
    coeff.subs({b: 0,h00: 0,h01: e*p_sc,q10: 2*e*p_sc})
    for coeff in Q0_sc.list()
])
assert Q0_b_zero == -c*p_sc*z**2

# Sufficiency of the local bounds for the full evaluation kernel at -3P.
At_sc = K(4)*p_sc*Phi**2/(z**2*T**2)
Bt_sc_even = K(2)*Phi**3*H_sc/(z**3*T**3)
Bt_sc_odd = K(p_sc)*Phi**2*(4*c*z**4+2*T)/(z**4*T**3)
Ct_sc_even = K(c*p_sc)*Phi**3/(z**2*T**3)+Phi**4*Q0_sc/(z**4*T**4)
Ct_sc_odd = (
    Phi**3*(4*z*Phi*h01+(c*z**4+3*T)*H_sc)/(z**5*T**4)
    + K(q_sc)*Phi**4/(z**4*T**4)
)
assert infinity_order(At_sc) >= 3
assert infinity_order(Bt_sc_even) >= 3
assert infinity_order(Bt_sc_odd, odd=True) >= 3
assert infinity_order(Ct_sc_even) >= 3
assert infinity_order(Ct_sc_odd, odd=True) >= 3
print("PASS: full marked H(-3P) coefficient gate; quadratic Q0; complete sufficient infinity bounds")
print("Geometric consequence: h0(H(-3P))=1 exactly when b=0 in the saturated surjective marked chart")
