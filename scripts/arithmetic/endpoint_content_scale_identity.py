"""Check the first two small-critical-root coefficients in characteristic5.

The resultant factorization and norm parity are justified in the prose proof.
This symbolic check only verifies the displayed universal local coefficients.
Requires SymPy; no point sampling is used.
"""
import sympy as s

t, A, B, C2, D, d1, b1, m, m1, ell0, ell1, w1, w2, mu = s.symbols(
    "t A B C2 D d1 b1 m m1 ell0 ell1 w1 w2 mu")
W = w1*t+w2*t**2
M = m+m1*t
b = B+b1*t
d = D+d1*t
U = W**5+t**3*M
expr = s.Poly(s.expand(mu*U**2+U*(A*W**3+2*b*W**2+d)
                      -t**3*M*d+t**5*(ell0+ell1*t)), t)
generators = (A,B,C2,D,d1,b1,m,m1,ell0,ell1,w1,mu)
def zero_mod5(v):
    assert s.Poly(s.expand(v), *generators, modulus=5).is_zero

co5=expr.coeff_monomial(t**5)
co6=expr.coeff_monomial(t**6)
zero_mod5(co5-(ell0+D*w1**5+2*m*B*w1**2))
kappa=ell1+d1*w1**5+2*m1*B*w1**2+3*m*b1*w1**2+2*m*A*w1**3+m*C2*w1
zero_mod5(s.cancel(B*(co6-m**2*mu-kappa).subs(w2,(-b1*w1-A*w1**2-C2)/B)))
large=-B/A
large_value=mu*large**10+large**5*(A*large**3+2*B*large**2+D)
zero_mod5(s.cancel(A**10*large_value-B**5*(B**5*mu-A**3*B**3-A**5*D)))
print("PASS: exact tau^5 content and tau^6 affine-scale coefficients over F5")
print("PASS: exact large-critical-root linear factor after clearing A^10")
print("SymPy",s.__version__)
