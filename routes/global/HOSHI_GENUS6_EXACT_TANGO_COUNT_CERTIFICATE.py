"""Exact certificate: this genus-six curve has ten maximal Tango structures.

Run: sage -python HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py
Requires SageMath (tested with 10.9). No randomness or numerical arithmetic.
See HOSHI_GENUS6_EXACT_TANGO_COUNT.md for global regularity/completeness.
"""

from itertools import product
from sage.all import GF, PolynomialRing, FunctionField, PowerSeriesRing, matrix

prime_field = GF(5)
constant_polynomials = PolynomialRing(prime_field, "t")
t = constant_polynomials.gen()
constant_modulus = t**4 + 4*t**2 + 4*t + 2
assert constant_modulus.is_irreducible()
k = GF(625, name="u", modulus=constant_modulus)
u = k.gen()
lam = 2*u**3 + 2*u**2 + 2*u
mu = 3*u**3 + u**2 + 3*u + 1
assert lam**4 == 4 and mu**4 == 3

# A separating presentation of the smooth function field. Here z=x-1,
# and eliminating y from w^6=(x+3)y+4x^2+4x+3 gives this equation.
F = FunctionField(k, "w")
w = F.gen()
R = PolynomialRing(F, "z")
z = R.gen()
equation = 4*z**5 + (2*z**2 + z + 3)*w**6 + w**12
assert equation.is_irreducible()
assert equation.derivative() != 0
L = F.extension(equation, "z")
z = L.gen()
w = L(w)
x = z + 1
A = 4*x**2 + 4*x + 3
y = (w**6 - A)/(x+3)
assert y**2 == x**3 + 3*x + 2
assert w**6 == (x+3)*y + A

# Coordinates (xp,yp) of Q-P on E, P=(1,1).
slope = (y+1)/(x-1)
xp = slope**2 - x - 1
yp = -y + slope*(x-xp)
assert yp**2 == xp**3 + 3*xp + 2
v2 = xp - 1
v3 = yp - 2*xp - 2
v4 = yp + 2*xp**2 + 4*xp

# At Q=O the translated point is -P=(1,4). The exact jets prove
# ord_O(v_j)=j-1. Their only poles are order j at P.
S = PowerSeriesRing(k, "h", default_prec=5)
h = S.gen()
xs = 1+h
ys = S(4)
for unused in range(4):
    ys = (ys + (xs**3+3*xs+2)/ys)/2
assert (xs-1).valuation() == 1
assert (ys-2*xs-2).valuation() == 2
assert (ys+2*xs**2+4*xs).valuation() == 3

dw = w.differential()
beta = (1/w)*dw
assert beta == (1/(2*y))*x.differential()
eta2 = (v2*w**2)*beta
eta3 = (v3*w**3)*beta
eta4 = (v4*w**4)*beta
assert beta.cartier() == beta
assert (w*beta).cartier() == 0
assert ((1/w)*beta).cartier() == 0
assert eta2.cartier() == L(4)*eta4
assert eta3.cartier() == L(3)*eta3
assert eta4.cartier() == L(4)*eta2

# These four differentials are a complete F5-basis of Cartier-fixed
# regular differentials, expressed by coefficients relative to dw.
q = [1/w, v2*w-v4*w**3,
     lam*(v2*w+v4*w**3), mu*v3*w**2]
assert all((a*dw).cartier() == a*dw for a in q)

# The connection declaring dw horizontal is globally regular because
# div(dw)=10 P_Y. Every dormant canonical connection therefore has,
# uniquely, coefficient a=sum(c_i q_i), with c_i in F5.
D = L.derivation()
assert D(w) == 1
qd = [q]
for unused in range(3):
    qd.append([D(v) for v in qd[-1]])
assert all(D(qd[3][i]) + q[i]**5 == 0 for i in range(4))

def tango_polynomial(jets):
    a, da, d2a, d3a = jets
    return a**4-a**2*da+3*da**2+4*a*d2a-d3a

# One exact ordinary point of the affine presentation; denominators
# of all sixteen functions evaluated below are verified nonzero.
xx = u**3
yy = 3*u**3+4*u**2+4*u+1
ww = 2*u**3+3*u**2+u+1
zz = xx-1
assert yy**2 == xx**3+3*xx+2
assert ww**6 == (xx+3)*yy+4*xx**2+4*xx+3
assert 4*zz**5+(2*zz**2+zz+3)*ww**6+ww**12 == 0
assert (4*zz+1)*ww**6 != 0

def evaluate_at_point(v):
    answer = k(0)
    for i, coefficient in enumerate(v.list()):
        numerator = coefficient.numerator()(ww)
        denominator = coefficient.denominator()(ww)
        assert denominator != 0
        answer += numerator/denominator*zz**i
    return answer

values = [[evaluate_at_point(v) for v in row] for row in qd]
survivors = []
for c in product(range(5), repeat=4):
    jets = [sum(k(ci)*vi for ci,vi in zip(c,row)) for row in values]
    if tango_polynomial(jets) == 0:
        survivors.append(c)

# A nonzero evaluation rigorously rejects a connection. All surviving
# connections are tested identically in the function field, not merely
# at the point. Thus no false positive or false negative remains.
expected = [
    (0,0,0,0), (2,0,0,0), (3,0,0,0),
    (3,2,0,0), (3,4,2,0), (3,4,3,0),
    (4,0,0,0), (4,2,0,0), (4,4,2,0), (4,4,3,0),
]
assert survivors == expected
for c in survivors:
    jets = [sum(k(ci)*vi for ci,vi in zip(c,row)) for row in qd]
    assert tango_polynomial(jets) == 0
print("Cartier stable dimension: 4; dormant connections checked: 625.")
print("Exactly ten maximal Tango structures:", survivors)
print("PASS: all rejected tuples have nonzero evaluation; all ten survivors")
print("satisfy the Tango equation identically in the function field.")

# Bounded symmetry/affine-span extraction, not a search for other curves.
assert lam**2 == 3
zeta = lam+3
assert zeta.multiplicative_order() == 6
b1 = eta2-eta4
b2 = L(lam)*(eta2+eta4)
assert L(zeta**2)*eta2-L(zeta**4)*eta4 == L(2)*b1+b2
assert L(lam)*(L(zeta**2)*eta2+L(zeta**4)*eta4) == L(3)*b1+L(2)*b2
assert zeta**3 == -k(1)

# nabla_0 is invariant since sigma*(dw)=zeta*dw. Thus this is the
# linear action on connection coordinates, with no translation term.
def automorphism(c):
    a,b,c2,d = c
    return (a, (2*b+3*c2) % 5, (b+2*c2) % 5, (-d) % 5)

assert set(map(automorphism, expected)) == set(expected)
assert expected[0] == (0,0,0,0)
assert matrix(prime_field, expected).rank() == 3
assert all(c[3] == 0 for c in expected)
remaining = set(expected)
orbits = []
while remaining:
    first = min(remaining)
    orbit = []
    c = first
    while c not in orbit:
        orbit.append(c)
        c = automorphism(c)
    assert c == first
    remaining.difference_update(orbit)
    orbits.append(orbit)
assert sorted(map(len, orbits)) == [1,1,1,1,3,3]
print("Affine span: the dimension-three hyperplane c3=0.")
print("mu6 action: (c0,2*c1+3*c2,c1+2*c2,-c3), modulo five.")
print("mu6 orbits:", orbits)
