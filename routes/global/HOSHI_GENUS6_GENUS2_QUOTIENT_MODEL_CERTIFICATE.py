"""Explicit genus-two quotient and quadratic equation; exact Sage certificate.

Run: sage -python HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py
No twists or point-count searches are performed.
"""

import HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE as m
from sage.all import PolynomialRing, matrix

# Invariant holomorphic basis for the reflection w -> 2/w.
nu1_coefficient = 1-2/m.w**2
t = m.q[1]/nu1_coefficient
v = m.D(t)/nu1_coefficient
assert m.D(t) != 0

R = PolynomialRing(m.prime_field,"T")
T = R.gen()
F = 2*T**6+2*T**4+3*T**2+4
A = 2*T**8+4*T**6+2
B = T**2+4
assert F.is_squarefree()
factors = [T**2+2,T**2+2*T+4,T**2+3*T+4]
assert all(q.is_irreducible() for q in factors)
assert F == 2*factors[0]*factors[1]*factors[2]
assert v**2 == 2*t**6+2*t**4+3*t**2+4

anti_invariant = m.w-2/m.w
h = t**5*anti_invariant
assert h != 0
assert h**2 == 2*t**8+4*t**6+2+(t**2+4)*v
assert A**2-B**2*F == 4*T**10*(T**6+4*T**4+4*T**2+2)

# In the basis dt/v,t dt/v, this matrix agrees with the independent
# invariant-differential calculation for the genus-two quotient.
cartier = matrix(m.prime_field,2,2,
                 lambda i,j:(F**2)[5*(i+1)-(j+1)])
assert cartier == matrix(m.prime_field,[[0,0],[0,1]])

# Reproduce the exact constant-coefficient reconstruction. Each row
# comes from clearing rational w-denominators in one z coefficient.
# This is exact coefficient algebra, not pointwise interpolation.
def relation_matrix(functions):
    rows = []
    for j in range(5):
        coefficients = [(f.list()+[m.F(0)]*5)[j] for f in functions]
        denominator = m.F(1).denominator().parent()(1)
        for c in coefficients:
            denominator = denominator.lcm(c.denominator())
        polynomials = [c.numerator()*(denominator//c.denominator())
                       for c in coefficients]
        for degree in range(max(p.degree() for p in polynomials)+1):
            rows.append([p[degree] for p in polynomials])
    return matrix(m.k,rows)

M1 = relation_matrix([t**i for i in range(7)]+[v**2])
assert M1.dimensions() == (69,8)
assert M1.right_kernel().dimension() == 1
assert tuple(M1.right_kernel().basis()[0]) == (1,0,2,0,3,0,3,1)
M2 = relation_matrix([t**i for i in range(11)]
                     +[v*t**i for i in range(8)]
                     +[anti_invariant**2*t**10])
assert M2.dimensions() == (109,20)
assert M2.right_kernel().dimension() == 1
assert tuple(M2.right_kernel().basis()[0]) == (
    1,0,0,0,0,0,2,0,1,0,0,2,0,3,0,0,0,0,0,2)

print("Genus-two quotient: v^2 =",F)
print("Quadratic cover: h^2 =",A,"+ (",B,") v")
print("Exact generators: t=(eta2-eta4)/nu1, v=dt/nu1,")
print("nu1=(w-2/w) beta, h=t^5(w-2/w).")
print("Hyperelliptic factorization:",F.factor())
print("Cartier matrix:",cartier)
print("PASS: exact identities and both unique reconstruction relations.")
