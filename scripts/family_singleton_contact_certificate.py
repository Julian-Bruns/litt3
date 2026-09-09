"""Exact polynomial certificate for the generic-parameter NO in characteristic 5.

Dependency: SymPy.  Run: sage -python scripts/family_singleton_contact_certificate.py
All identities are checked in polynomial rings over GF(5).
The symbols t, u and X are indeterminates; no finite-field point identities
such as t**5 == t or X**5 == X are imposed.

The contact/intersection argument accompanying this file is mathematical,
not a numerical search.  This file verifies its polynomial identities.
"""
import sympy as sp

u, t, X = sp.symbols("u t X")
Z0, Z1, Z2, Z3 = sp.symbols("Z0 Z1 Z2 Z3")
Z = (Z0, Z1, Z2, Z3)


def check(label, expression, variables):
    remainder = sp.Poly(sp.expand(expression), *variables, modulus=5)
    if not remainder.is_zero:
        raise AssertionError(f"{label}: nonzero remainder {remainder.as_expr()}")
    print(f"PASS: {label}")


def reduced(expression, variables):
    return sp.Poly(sp.expand(expression), *variables, modulus=5).as_expr()


G = lambda x: x * (x - 1) * (x - 2) * (x - 3)
g = G(t)
tau = t**5
F = reduced(G(u) * (u - t), (u, t))
F2 = sp.Poly(F**2, u)
c4, c3, c9, c8 = [reduced(F2.nth(i), (t,)) for i in (4, 3, 9, 8)]

check("Cartier coefficient c4", c4 - (t+1)*(1-2*t), (t,))
check("Cartier coefficient c3", c3 + 2*t*(t+1), (t,))
check("Cartier coefficient c9", c9 + 2*(t+1), (t,))
check("Cartier coefficient c8", c8 - (t+1)*(t-2), (t,))
check("ordinary determinant", c4*c8-c3*c9-3*(t+1)**4, (t,))
check("tangent image, first coordinate", c4+t*c9-(t+1)**2, (t,))
check("tangent image, second coordinate", c3+t*c8-t*(t+1)**2, (t,))
check("nonzero local denominator", t-tau+(t+1)*g, (t,))

# For lambda**2=t+1, f_lambda=A-2*lambda*v*(u-t)**2.
A = (u-t)**3 * (u+1)**2
B_squared = 4*(t+1)*(u-t)**4
check("auxiliary norm", A**2-F*B_squared-(u-t)**5*(u**5-t), (u,t))

# The supplied quadric, with coefficients in t and twisted curve parameter t**5.
cs = [
    t**8*(t+1)*(t**5-2*t**4+t**2-2*t-1),
    -2*t**7*(t+1)*(t**4-t**3-t**2-t+1),
    t**2*(-2*t**10+t**9+2*t**7-2*t**6-2*t**4+2*t**3+t-2),
    t**4*(t+1)*(t**4-2*t**3+t**2-1),
    t**6*(t**2+t+1),
    t**2*(t+1)*(-2*t**4+2*t**3+2*t**2+2*t-2),
    -t**3*(t+1)*(2*t**2+t+2),
    (t+1)*(-t**5-2*t**4+t**3-2*t+1),
    (t+1)*(-t**4+t**2-2*t+1),
    (t+1)**4,
]
Q = 0
k = 0
for i in range(4):
    for j in range(i,4):
        Q += cs[k]*Z[i]*Z[j]
        k += 1

D = X-tau
H = tau**2*X**2 + (tau-tau**2)*X - tau
ZX = (D, (X+tau)*D, tau*X*D, H)

# Check the conic parametrization against the problem's w convention.
f2_tw, f3_tw, f4_tw = -(tau+1), tau+1, -(tau+1)
SX, PX = X+tau, tau*X
correction = f2_tw + f3_tw*SX + f4_tw*SX**2 + SX*(SX**2-PX)
check("Kummer conic coordinate", H-G(X)+D*correction, (X,t))

substitution = dict(zip(Z, ZX))
check("quartic contact identity", Q.subs(substitution)-g**6*(X-t)**4, (X,t))
check("normal derivative identity", sp.diff(Q,Z3).subs(substitution)
      -2*(t+1)**2*g**3*(X-t)**2, (X,t))

print("All 12 polynomial identities verified.")
print("Exceptional polynomial: E(t) = t**5 - t.")
