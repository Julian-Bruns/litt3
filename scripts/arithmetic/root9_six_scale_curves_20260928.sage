"""Exact geometry of the six scale-leading boundary curves.

Run with sage -python and one output JSON path.  Does not decide squares.
All assertions concern the exact ratio cubic over the specified F_(5^8).
"""
from sage.all import GF, PolynomialRing
import json
import sys
from pathlib import Path

F5 = GF(5)
Z = PolynomialRing(F5, 'z'); z = Z.gen()
# Eliminate beta from alpha^4+(2+beta)alpha^3+(1+beta)alpha^2
# +2alpha+beta=0, retaining the exact coded embedding.
num = z**4+2*z**3+z**2+2*z
den = z**3+z**2+1
modulus = num*num+num*den-3*den*den
assert modulus.is_irreducible()
K = GF(5**8, name='alpha', modulus=modulus)
alpha = K.gen()
beta = -num(alpha)/den(alpha)
assert beta*beta-beta-3 == 0
def small(n):
    return K(n % 5) + K(n // 5) * beta
assert alpha**4+small(7)*alpha**3+small(6)*alpha**2+small(2)*alpha+small(5) == 0
def code(n):
    ans = K(0)
    for i in range(4):
        ans += K(small(n % 25)) * alpha**i
        n //= 25
    assert n == 0
    return ans
R = PolynomialRing(K, 'q'); q = R.gen()
F = R.fraction_field()
T = PolynomialRing(F, 'U'); U = T.gen()
def row(ns):
    return R([code(n) for n in ns])
a0 = row([350365,93449])
d = row([47171,357608])
b = row([90885,339126,362701,194731,371097,144818])
c = row([56518,278019,104390,351083,235630,246647,217983])
e = row([0,324104,260238,219737,136154,199269,240524,27757,108951,319279])
eps = K(small(24))+K(small(4))*alpha+K(small(23))*alpha**3
sigma0 = code(112400)
assert sigma0 == K(small(24))**2/(3*eps**2)
zet = K(small(12)); assert zet.multiplicative_order() == 6
sigmas = [112400,246025,215500,360225,164100,272625]
assert [sigma0*zet**i for i in range(6)] == [code(s) for s in sigmas]
answer = []
product = R(1)
for s in sigmas:
    a = a0-code(s)*d
    f = a*U**3+b*U**2+c*U+e
    disc = R(f.discriminant())
    assert disc == b*b*c*c+a*c**3+b**3*e+3*a*a*e*e+3*a*b*c*e
    assert a.degree() == 1 and b.degree() == 5 and c.degree() == 6 and e.degree() == 9
    assert disc.degree() == 24 and disc.gcd(disc.derivative()).degree() == 0
    assert a.gcd(b).degree() == 0 and a.gcd(disc).degree() == 0
    assert disc.gcd(product).degree() == 0
    assert a.gcd(b).gcd(c).gcd(e) == 1
    irreducible = f.is_irreducible()
    assert irreducible
    # The q=0 polynomial has one simple root U=0, giving a K-rational
    # smooth point in the projective cubic model and excluding a constant
    # extension of K in its connected function field.
    assert e[0] == 0 and c[0] != 0 and disc[0] != 0
    # Infinity has two simple branches U/q^2 = +/-sqrt(-e9/b5),
    # and one simple branch U/q^4=-b5/a1.  Thus it is unramified.
    assert a[1]*b[5]*e[9] != 0
    product *= disc.monic()
    answer.append(dict(sigma=s,irreducible_over_Kq=bool(irreducible),
        discriminant_degree=int(disc.degree()),squarefree=True,
        discriminant_factor_degrees=[int(h.degree()) for h,m in disc.factor() for _ in range(int(m))],
        smooth_K_point_at_q0_u0=True, infinity_pole_orders=[2,2,4],
        infinity_unramified=True, geometric_genus=10))
assert product.degree() == 144 and product.gcd(product.derivative()).degree() == 0
out=dict(status='PASS', scope='six fixed-s ratio curves, not square-locus emptiness',
    field_size=int(K.cardinality()), curves=answer,
    combined_simple_branch_values=144,
    geometric_irreducibility_reason='K(q)-irreducible separable cubic, smooth K-rational point, perfect K',
    genus_reason='separable degree 3 map to P1, 24 simple tame finite branches and no infinity ramification')
p=Path(sys.argv[1]);p.parent.mkdir(parents=True,exist_ok=True)
p.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
