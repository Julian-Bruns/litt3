"""Exact reflection calculation; run with sage -python.

Imports and reruns the complete ten-Tango certificate in the same directory.
No twists are enumerated. See HOSHI_GENUS6_EXACT_TANGO_COUNT.md, Section 4.
"""

import HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE as m
from sage.all import PolynomialRing, matrix, identity_matrix

k,L = m.k,m.L
x,y,w = m.x,m.y,m.w
xp,yp = m.xp,m.yp
zeta = m.zeta

# The elliptic reflection is (x,y) -> (xp,-yp), where (xp,yp)=Q-P.
f_reflected = (xp+3)*(-yp)+4*xp**2+4*xp+3
assert f_reflected*w**6 == 4
s2 = (-yp+1)/(xp-1)
x2 = s2**2-xp-1
y2 = -yp-s2*(xp-x2)
assert x2 == x and y2 == y

# The four elliptic fixed points: one rational point and a cubic orbit.
R = PolynomialRing(m.prime_field, "X")
X = R.gen()
half_y = 3*X**3+X**2+X+4
cubic = X**3+3*X**2+2
assert cubic.is_irreducible()
assert half_y**2-(X**3+3*X+2) == 4*(X-2)*(X-1)**2*cubic
assert half_y(2) == 4
f_half = (X+3)*half_y+4*X**2+4*X+3
assert f_half(2) == 2
assert f_half % cubic == 3
# x=1 arose from clearing (x-1)^2; neither P nor -P is fixed.
assert cubic(1) != 0 and cubic(2) != 0

def reflection_even(c):
    a,b,c2,d = c
    return ((2-a) % 5, b, (-c2) % 5, (-d) % 5)

def reflection_odd(c):
    a,b,c2,d = c
    return ((2-a) % 5, (2*b+3*c2) % 5,
            (4*b+3*c2) % 5, d)

linear_even = matrix(m.prime_field,
                     [[4,0,0,0],[0,1,0,0],[0,0,4,0],[0,0,0,4]])
linear_odd = matrix(m.prime_field,
                    [[4,0,0,0],[0,2,3,0],[0,4,3,0],[0,0,0,1]])
I = identity_matrix(m.prime_field,4)
assert (linear_even-I).right_kernel().dimension() == 1
assert (linear_odd-I).right_kernel().dimension() == 2

for a,action,genus,rank,number_base_fixed,linear in [
        (k(2),reflection_even,2,1,3,linear_even),
        (k(2)*zeta,reflection_odd,3,2,1,linear_odd)]:
    assert a**6 == 4
    assert a**3 == (3 if genus == 2 else 2)
    # Under Q -> P-Q, the translated coordinates become (x,-y).
    r24 = -a**2*(x-1)/(w**6*m.v4)
    r33 = -a**3*(-y-2*x-2)/(w**6*m.v3)
    r42 = -a**4*(-y+2*x**2+4*x)/(w**6*m.v2)
    pulled_forms = [
        -m.beta,
        r24*m.eta4-r42*m.eta2,
        L(m.lam)*(r24*m.eta4+r42*m.eta2),
        L(m.mu)*r33*m.eta3,
    ]
    original_forms = [qi*m.dw for qi in m.q]
    for j in range(4):
        assert pulled_forms[j] == sum(
            (L(linear[i,j])*original_forms[i] for i in range(4)),
            m.beta-m.beta)
    # tau*dw=-a*w^-2 dw, hence tau*nabla_0=nabla_0+2 beta.
    frame_factor = -a/w**2
    assert -m.D(frame_factor)/frame_factor == 2/w
    assert set(map(action,m.expected)) == set(m.expected)
    assert all(action(action(c)) == c for c in m.expected)
    assert all(action(c) != c for c in m.expected)
    pairs = [(c,action(c)) for c in m.expected if c < action(c)]
    assert len(pairs) == 5
    number_fixed = 2*number_base_fixed
    assert 2*6-2 == 2*(2*genus-2)+number_fixed
    print("Lift w -> a/w, a =",a)
    print("Fixed points:",number_fixed,"quotient genus:",genus,
          "quotient p-rank:",rank)
    print("Five Tango transpositions:",pairs)

print("PASS: both reflection classes, ramification, differential actions,")
print("affine connection actions and all ten Tango permutations verified.")
