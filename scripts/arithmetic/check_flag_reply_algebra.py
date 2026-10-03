#!/usr/bin/env python3
"""Reconstruct the retained positive and quadratic September 23 checks.

The referenced bundle_certificate.zip was not attached to the conversation.
This is a separate reconstruction from the printed coefficients and formulas,
not an execution of that unavailable package. The later sharp K line theorem
replaces the degree-zero twist census and cup-minor argument. Generated
receipts stay outside the research workspace and preserve the original receipt.
"""
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

started = time.time()
out = Path(__file__).resolve().parents[3] / "litt3-computation-data/flag_replies_20260923"
out.mkdir(parents=True, exist_ok=True)
K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
a = K.gen()
R = PolynomialRing(K, "x")
x = R.gen()
decode = lambda n: K(n % 5) + (n // 5)*a
poly = lambda cs: R([decode(c) for c in cs])
P = poly([11,22,18,5,19,20,15,16,9,22,1])
cs = [2,16,16,7,1,2,7,1,24,11]
b0 = poly([13,12,9,11,19,18,1,17,23,12,8,10,9,13,8,
           0,9,10,4,23,24,24,2,2,12,0,19,14,1,24,
           8,5,6,7,17,18,18,21,8,11,13,5,20,14,1])
C25 = sum(decode(c)*x**(25*(9-i)) for i,c in enumerate(cs))
a0, rem = (P**17*C25*b0).quo_rem(x**250)
assert [a0.degree(),rem.degree(),b0.degree()] == [189,205,44]
assert a0.gcd(b0) == 1 and a0.gcd(P) == 1
positive = {
    "a0_degree": int(a0.degree()), "remainder_degree": int(rem.degree()),
    "b0_degree": int(b0.degree()), "gcd_a0_b0": str(a0.gcd(b0)),
    "gcd_a0_P": str(a0.gcd(P)), "infinity_orders": [135,-142],
}
print("Positive Frobenius presentation: PASS", flush=True)

# Universal polynomial identities, independent of any specific curve.
Q = PolynomialRing(GF(5), ["a1","a2","a3","b1","b2","b3","s","t","c"])
a1,a2,a3,b1,b2,b3,s,t,c = Q.gens()
mult = matrix(Q, [
    [a1*a1, a1*b1, b1*b1],
    [2*a1*a2, a1*b2+a2*b1, 2*b1*b2],
    [a2*a2+2*a1*a3, a1*b3+a2*b2+a3*b1, b2*b2+2*b1*b3]])
assert mult.det() == (a1*b2-a2*b1)**3
Qf = PolynomialRing(Q, "f")
f = Qf.gen()
quad = lambda ss,tt,ff: 4*ss**2*ff+2*ss*tt*ff**2+2*tt**2*ff**3
shift = quad(s-3*c*t,t,f+c)-quad(s,t,f)
assert shift.degree() <= 0
raw = quad(s,t,f)
assert raw.derivative() == (2*s+t*f)**2

# Local Smith forms of the canonical quadratic map at adjunction orders 0,1,2.
# The mixed-basis coefficient is half the st coefficient, since
# (s*v+t*w)^2=s^2*v^2+2st*v*w+t^2*w^2.
Z = PolynomialRing(GF(5), "tau")
tau = Z.gen()
simple = matrix(Z, [[3*tau,0,0],[0,2,0],[0,0,4]])
double = matrix(Z, [[2,0,0],[0,3*tau,0],[0,0,tau]])
assert simple.det().valuation(tau) == 1
assert double.det().valuation(tau) == 2
assert simple.change_ring(Z.quotient(tau)).rank() == 2
assert double.change_ring(Z.quotient(tau)).rank() == 1
QT = PolynomialRing(GF(5), ["z","eps"])
z,eps = QT.gens()
square = ((3*z*z*eps+3*z*eps**2+eps**3)**2)
square = sum(coef*z**powers[0]*eps**powers[1]
             for powers,coef in square.dict().items() if powers[1] < 5)
assert square == 3*z**3*(3*z*eps**2+eps**3)
print("Quadratic maps, primitive shift, determinant and local square: PASS", flush=True)
report = {
    "status":"PASS",
    "provenance":"Independent reconstruction from inline response; original ZIP unavailable",
    "positive_presentation":positive,
    "quadratic_multiplication_determinant":True,
    "primitive_shift_invariance_mod_constants":True,
    "local_quadratic_defects":{"simple":[0,0,1],"double":[0,1,1]},
    "new_line_square_saturation_order":3,
    "seconds":time.time()-started,
}
(out/"positive_and_quadratic_reconstruction.json").write_text(json.dumps(report,indent=2)+"\n")
print(json.dumps(report,indent=2), flush=True)
