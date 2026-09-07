"""Small exact inputs for cyclic_cubic_low_abel_torsion; no cover search."""
from pathlib import Path
import json
import re

root = Path(__file__).resolve().parents[1]
source = root / 'routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage'
text = source.read_text()

def retained_polynomial(name, variables):
    match = re.search(r'\b' + name + r' = \((.*?)\n\)', text, re.S)
    assert match is not None
    return sage_eval('(' + match.group(1) + ')', locals=variables)

R = PolynomialRing(GF(5), 'u')
k = GF(25, 'a', modulus=R([2,4,1]))
a = k.gen()
S = PolynomialRing(k, 'x')
x = S.gen()
F = retained_polynomial('fX', {'a': a, 'x': x})
factors = F.factor()
assert all(e == 1 for f,e in factors)
degrees = sorted(int(f.degree()) for f,e in factors)
assert degrees == [1,1,4,4]
D = lcm(degrees)

Z = PolynomialRing(ZZ, 'T')
T = Z.gen()
P = retained_polynomial('PX', {'T': T})
g = P.degree() // 2
resultants = [ZZ(P.resultant(T**n - 1)) for n in [D,3*D]]
valuations = [int(v.valuation(3)) for v in resultants]
assert valuations == [10,30]
aa = valuations[0] - g
bb = valuations[1] - 3*g - aa
assert (aa,bb) == (1,2)

# Check the ramified-adic expansion and the coprime-factor identity.
E = CyclotomicField(3, 'rho')
rho = E.gen()
lam = 1-rho
A = PolynomialRing(E, 'U')
U = A.gen()
V = U**2 - rho**2*lam*U - rho**2
assert lam**2 == -3*rho
assert (1+lam*U)**3-1 == lam**3*U*V
assert V-U*(U-rho**2*lam) == -rho**2
assert 1+11*10+binomial(11,3) == 276
print(json.dumps(dict(status='PASS', branch_factor_degrees=degrees,
    branch_period=int(D), resultant_3_valuations=valuations,
    a=int(aa), b=int(bb), cubic_torsion_field_degree=3*int(D),
    lambda_exponent=3+max(int(aa),int(bb)), torsion_order_bound=27,
    W3_three_torsion_classes=276,
    scope='Arithmetic and identities only; author proof supplies geometry. '
          'No order9/27 absence or common-cover exclusion claimed.'), default=int))
