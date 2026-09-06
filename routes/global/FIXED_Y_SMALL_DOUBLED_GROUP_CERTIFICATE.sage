"""Exhaustive 64-element doubled two-primary group on the fixed Y.

Cost is exponential in v2(#J)-2g=6, not in 2g=50.
All group elements are checked through reduced Mumford arithmetic.
"""
from collections import Counter
from pathlib import Path
import runpy
from time import monotonic
started = monotonic()
data = runpy.run_path(str(Path(__file__).resolve().parent /
                         'FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py'))
cardinality = Integer(data['j_125'])
assert cardinality.valuation(2) == 56
odd_part = cardinality // 2**56

# Independent small resultant for det(pi^3+I).
rem = [ZZ(0), ZZ(0), ZZ(0)]
for i, coefficient in enumerate(data['p_desc']):
    exponent = 50-i
    rem[exponent % 3] += coefficient*(-1)**(exponent//3)
aa, bb, cc = rem
uu, vv = aa-cc, bb+cc
plus = (aa-bb+cc)*(uu**2+uu*vv+vv**2)
assert plus.valuation(2) == 51

k = GF(125, 'a')
R = PolynomialRing(k, 't')
t = R.gen()
L = t**25+t**5+t
f = L*(L-1)*(t-4)
assert f.degree() == 51 and gcd(f, f.derivative()) == 1
assert len(f.roots()) == 51  # all Weierstrass points, plus infinity, rational
J = HyperellipticCurve(f).jacobian()(k)
zero = J(0)

def key(point):
    return (tuple(point[0].list()), tuple(point[1].list()))

group = {key(zero): zero}
generators = []
for x0 in k:
    value = f(x0)
    if not value or not value.is_square():
        continue
    y0 = value.sqrt()
    point = 2*odd_part*J([t-x0, R(y0)])
    assert 64*point == zero
    if key(point) in group:
        continue
    generators.append(point)
    enlarged = dict(group)
    multiple = point
    while key(multiple) not in group:
        for old in group.values():
            new = old+multiple
            enlarged[key(new)] = new
        multiple += point
    group = enlarged
    assert len(group) <= 64
    if len(group) == 64:
        break

assert len(group) == 64
for point in group.values():
    assert 64*point == zero
    for generator in generators:
        assert key(point+generator) in group
    U, V = point[0], point[1]
    assert U.is_monic() and U.degree() <= 25
    assert V.degree() < U.degree() and (V**2-f) % U == 0
degrees = Counter(point[0].degree() for point in group.values())
assert degrees == {0:1, 22:4, 24:3, 25:56}
assert min(point[0].degree() for point in group.values() if point != zero) == 22
print('PASS: complete doubled group size64; reduced degrees', sorted(degrees.items()))
print('Elapsed seconds:', round(monotonic()-started, 2))
