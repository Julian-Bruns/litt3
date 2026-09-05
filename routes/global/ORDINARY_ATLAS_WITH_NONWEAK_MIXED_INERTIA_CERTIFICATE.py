"""Scalar checks for the explicit ordinary atlas with G2 nontrivial.

Run with sage -python. Global covers and quotient-stack descent are proved
in ORDINARY_ATLAS_WITH_NONWEAK_MIXED_INERTIA.md, not inferred numerically.
"""

from sage.all import GF, PolynomialRing, QQ

k = GF(5)
R = PolynomialRing(k, "x")
x = R.gen()
f1 = x*(x-1)
f2 = (x-2)*(x-3)
f3 = x-4
assert f1*f2*f3 == x**5-x
for polynomial in (f1*f2, f1*f3, f2*f3):
    assert polynomial.is_squarefree()
    assert polynomial.degree() in (3, 4)
    coefficient = (polynomial**2)[4]
    assert coefficient == k(3)
    print("elliptic factor", polynomial, "Cartier coefficient", coefficient)

y_polynomial = x**5-x
y_squared = y_polynomial**2
y_cartier = [[y_squared[5*i-j] for j in (1, 2)] for i in (1, 2)]
assert y_polynomial.is_squarefree()
assert y_cartier == [[0, 0], [0, 0]]
print("Y0 Cartier matrix", y_cartier)

assert 10-1 + 2*(5-1) == 17
assert 17 < 2*10
assert 20*(-2+QQ(17)/10+QQ(1)/2) == 2*3-2
assert 10*(-2+QQ(17)/10+QQ(1)/2) == 2*2-2
assert 2*5-2 == 4*(2*2-2) == 2*(2*3-2)

# Label 5 denotes infinity; translate only the five finite labels.
blocks = frozenset((frozenset((0, 1)), frozenset((2, 3)), frozenset((4, 5))))
translated = frozenset(frozenset(5 if a == 5 else (a+1) % 5 for a in block)
                       for block in blocks)
assert translated != blocks
print("PASS: ordinary genus3 X; genus2 Y0 has p-rank0; wild e10 d17 G2=C5.")
