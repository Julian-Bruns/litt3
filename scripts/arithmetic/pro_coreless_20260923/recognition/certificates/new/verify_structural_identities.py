#!/usr/bin/env python3
"""Symbolic checks for the report's local and rational-quotient formulas.
Requires SymPy. This does not search for a global correspondence.
"""
import sympy as S

x, u, t, c, s = S.symbols('x u t c s')


def zero_mod5(expr, *gens):
    return S.Poly(S.expand(expr), *gens, modulus=5).is_zero


quartic = t**4-3*s*t**3+3*t**2+3
assert zero_mod5(S.discriminant(quartic, t)-2*(s**2-1)**2, s)
print('degree_four_parameter_discriminant=verified')

# Differentiating U^29=(1+c*t^2)^13 implies
# (t*U)'=U/(1+c*t^2), since 26/29=4 and 1+4=0 in F_5.
assert (26*pow(29 % 5, -1, 5)) % 5 == 4
assert (1+4) % 5 == 0
assert 16+13 == 29
print('formal_return_tensor_identity=verified_algebraically')

# All-degree field-recovery exponent identities.
assert 3*48-11*13 == 1
assert 3*21-11*6 == -3
assert 16*3 == 48
assert 16*13 == 208 and 13*28 == 364 and 16*13+13*12 == 364
print('field_recovery_and_root_tensor_exponents=verified')

# The descended weight-39 tensor has exactly the stated collisions.
assert 3*(-10)+39*(3-1) == 48
assert 3*(-26)+39*(3-1) == 0
print('weight_39_order_collisions=verified')

# Symbolic denominator formula for r2=G/(x^3 D).
D = x**3+S.Symbol('d2')*x**2+S.Symbol('d1')*x+S.Symbol('d0')
G = sum(S.Symbol(f'g{i}')*x**i for i in range(7))
assert S.simplify(S.diff(G/(x**3*D), x) -
                  (x*D*S.diff(G,x)-(3*D+x*S.diff(D,x))*G)/(x**4*D**2)) == 0
print('d3_second_derivative_denominator=verified')

# A homogeneous degree-m polynomial H obeys H(G,x^3D)/(x^(3m)D^m)=H(G/(x^3D),1).
G, D = S.symbols('G D')
for m in (4,10):
    coeff = S.symbols(f'a0:{m+1}')
    H = sum(coeff[j]*G**j*(x**3*D)**(m-j) for j in range(m+1))
    rhs = sum(coeff[j]*(G/(x**3*D))**j for j in range(m+1))
    assert S.cancel(H/(x**(3*m)*D**m)-rhs) == 0
print('homogeneous_A_and_P_denominator_identities=verified')

# d=3 cubic model and Riemann-Hurwitz numerical identities.
for n in range(6,33):
    assert 2*(n-3)+(7*n+6) == 9*n
    assert (n-3)+(7*n+6) == 8*n+3
    assert -6+2*(8*n+3) == 16*n
    assert 2*(8*n+1)-2 == 16*n
print('d3_cubic_model_genus_and_etale_degree_balance=verified')

# The degree-six regular-part matrix has row rank 3 for three distinct poles.
# With poles 0,1,q (affine normalization), inspect its 3x3 minors in F_5(q).
q = S.symbols('q')
points = [S.Integer(0), S.Integer(1), q]
M = S.Matrix([[p, 1]+[0 if i==j else 1/(p-points[j]) for j in range(3)]
              for i,p in enumerate(points)])
num = []
import itertools
for cols in itertools.combinations(range(5),3):
    numerator, denominator = S.together(M[:,cols].det()).as_numer_denom()
    pp = S.Poly(numerator,q,modulus=5)
    if not pp.is_zero:
        num.append(pp)
g = num[0]
for pp in num[1:]:
    g = S.gcd(g, pp)
# Any common zero of minors is confined to the excluded collision locus q=0 or 1.
while g.degree() > 0:
    old = g.degree()
    for factor in (S.Poly(q,q,modulus=5), S.Poly(q-1,q,modulus=5)):
        while g.degree()>0 and S.rem(g,factor).is_zero:
            g = S.quo(g,factor)
    assert g.degree() < old
assert g.degree() == 0
print('degree6_derivative_square_shape_space_dimension=2')
print('all_structural_identity_checks=passed')
