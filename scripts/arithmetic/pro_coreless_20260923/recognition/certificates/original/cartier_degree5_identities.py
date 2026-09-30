"""Exact symbolic identities used in the degree-five exclusion.

Run: python cartier_degree5_identities.py
Requires SymPy. This checks the normal-form and critical-value formulas;
the arithmetic contradiction is explained in the accompanying proof.
"""
import sympy as S

s, ell, v = S.symbols("s ell v")


def mod5(expr):
    """Canonical representative of a polynomial over F_5."""
    return S.Poly(S.expand(expr), s, ell, v, modulus=5).as_expr()


D = s * (s - 1)
B = s**3 + (ell - 2)*s**2 - ell*s + ell
U = S.expand((2*s**3 + (ell-1)*s**2 + (ell**2-2*ell-1)*s)*D
             - ell**2*(s-1) - (ell-1)**2*s)
assert mod5(S.diff(U, s)*D - U*S.diff(D, s) - B**2) == 0
assert mod5(S.discriminant(B, s) - 2*ell*(ell-1)*(ell+2)**2) == 0
print("degree_five_normal_form_derivative=verified")

# The finite critical values are the values U(s)/D(s) at B(s)=0.
R = S.Poly(S.resultant(B, U-v*D, s), v, ell, modulus=5)
raw_coeffs = S.Poly(R.as_expr(), v).all_coeffs()
lc = S.Poly(raw_coeffs[0], ell, modulus=5)
coeffs = []
for coeff in raw_coeffs:
    quotient, remainder = S.div(S.Poly(coeff, ell, modulus=5), lc)
    assert remainder.is_zero
    coeffs.append(quotient.as_expr())
assert coeffs[0] == 1
b, c, d = coeffs[1:]
p_actual = mod5(c - 2*b**2)
q_actual = mod5(d - 2*b*c + b**3)
p_claim = 2*(ell+2)**4*(ell**2-ell+1)
q_claim = -2*(ell+2)**5*(ell**4-2*ell**3-ell**2+2*ell-2)
assert mod5(p_actual-p_claim) == 0
assert mod5(q_actual-q_claim) == 0
print("centered_critical_value_coefficients=verified")

nu = ell*(1-ell)
invariant_numerator = -2*(nu+1)*(1-nu)**3
invariant_denominator = (nu**2+2*nu-2)**2
assert mod5(p_claim**3*invariant_denominator
            - q_claim**2*invariant_numerator) == 0
print("critical_value_invariant_has_degree_four_in_nu=verified")

qK = 25**4
powers = [pow(qK, j, 29) for j in range(1, 8)]
assert powers[-1] == 1 and all(x != 1 for x in powers[:-1])
print("order_of_25_to_the_fourth_modulo_29=7")
print("all_degree_five_identity_checks=passed")
