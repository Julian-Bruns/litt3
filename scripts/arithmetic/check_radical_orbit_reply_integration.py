#!/usr/bin/env python3
"""Focused exact checks for the six 23 September orbit replies.

Use Sage's Python. The supplied certificates are executed separately;
this checks their coefficient conventions against the existing ones,
the new logarithmic form, and equality of supplied/rebuilt receipts.
"""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing

data = (Path(__file__).resolve().parents[3] / "litt3-computation-data"
        / "radical_orbit_replies_20260923")
K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
a = K.gen()
R = PolynomialRing(K, "x")
x = R.gen()
decode = lambda c: K(c % 5) + K(c // 5)*a
poly = lambda cs: R([decode(c) for c in cs])
r = [poly([19, 1]), poly([0])-poly([16, 1]), poly([20, 14, 15])]
phi = [poly([5, 21]), poly([8, 9]), poly([3, 8, 1])]
scale = phi[0][1]/r[0][1]
assert all(fi == scale*ri for fi, ri in zip(phi, r))
A = poly([1, 21, 14, 22, 13])
V = poly([20, 3, 24, 23, 4])
assert V == decode(20)*A
assert V == -(scale**5)*A

L = GF(125, "alpha", modulus=PolynomialRing(GF(5), "z")([1, 1, 0, 1]))
alpha = L.gen()
S = PolynomialRing(L, "u")
u = S.gen()
H = u*(u-1)*(u-2)*(u-3)*(u-alpha)
t = alpha**2+3*alpha+4
s = alpha**2+4*alpha+4
assert s**2 == H(t)
ap = s*((alpha**2+4*alpha)*u**3
        +(3*alpha**2+4*alpha+1)*u**2
        +(3*alpha**2+alpha+2)*u+alpha**2+alpha+1)
c = 3*alpha**2+4
assert 2*ap+(u-alpha)*ap.derivative() == c*(u+1)*(u-alpha)
assert 2*H+(u-alpha)*H.derivative()/2 == c*(u+1)*(u-alpha)*ap
for name in ["cartier_HX_frobenius_certificate.json", "cartier_orbit_certificate.json"]:
    assert json.loads((data/"original"/name).read_text()) == json.loads(
        (data/"executed"/name).read_text())
report = {
    "status": "PASS",
    "supplied_and_recomputed_json_equal": True,
    "quotient_rows_scalar_equivalent": True,
    "branch_polynomials_scalar_equivalent": True,
    "logarithmic_form": "(3*alpha^2+4)*(u+1)*du/v",
    "logarithmic_identity_verified_in_quadratic_function_field": True,
    "scope": "Focused exact arithmetic; prose arguments checked separately.",
}
(data/"integration_check.json").write_text(json.dumps(report, indent=2)+"\n")
print(json.dumps(report, indent=2))
