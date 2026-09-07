"""Exact fixed-pair certificate; run with sage -python. No search or approximations."""
from sage.all import GF, PolynomialRing, QQ, ZZ, euler_phi
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "Research/computations/picard_cubic_common_cover_certificate.json"
R0 = PolynomialRing(GF(5), "b")
b = R0.gen()
F = GF(25, name="a", modulus=b*b+2)
a = F.gen()
R = PolynomialRing(QQ, "z")
z = R.gen()
RT = PolynomialRing(R, "T")
T = RT.gen()
RX = PolynomialRing(ZZ, "X")
X = RX.gen()

def count(n):
    modulus = {2: b**4+4*b**2+4*b+2, 3: b**6+b**4+4*b**3+b**2+2}
    E = F if n == 1 else GF(5**(2*n), name="e%d" % n, modulus=modulus[n])
    if n == 1:
        ae = a
    else:
        RE = PolynomialRing(E, "r")
        ae = min((RE.gen()**2+2).roots(multiplicities=False),
                 key=lambda c: tuple(int(v) for v in c.polynomial().list()))
    cubes = {c**3 for c in E if c}
    plus = minus = 1  # unique point at infinity, gcd(3,4)=1
    for t in E:
        p = t*(t-1)*(t-ae)*(t-ae-2)
        m = t*(1-t)*(1-ae*t)*(1-(ae+2)*t)
        plus += 1 if not p else (3 if p in cubes else 0)
        minus += 1 if not m else (3 if m in cubes else 0)
    return [int(plus),int(minus)], {"degree_over_F25":n,
            "modulus_over_F5":str(E.modulus()),"image_of_a":str(ae)}

def weil(counts):
    q = ZZ(25)
    s = [None]+[q**n+1-counts[n-1] for n in [1,2,3]]
    c = [ZZ(1)]
    for k in [1,2,3]:
        v = -sum(c[k-i]*s[i] for i in range(1,k+1))
        assert v % k == 0
        c.append(v//k)
    return X**6+c[1]*X**5+c[2]*X**4+c[3]*X**3+q*c[2]*X**2+q*q*c[1]*X+q**3

def quotient_test(P,Q,same=False):
    result = R(RT(P.list()).resultant(sum(RT(Q[i])*z**(6-i)*T**i for i in range(7))))
    removed = 0
    if same:
        while result(1)==0:
            result,rem = result.quo_rem(z-1)
            assert rem==0
            removed += 1
        assert removed==6
    factors = list(result.factor())
    assert all(not f.is_cyclotomic() for f,e in factors)
    # phi(m)<=36 forces m<=2592, since m/phi(m)^2<=2.
    eligible = [m for m in range(1,2593) if euler_phi(m)<=36]
    assert all(result.gcd(R.cyclotomic_polynomial(m)).degree()==0 for m in eligible)
    return {"passes":True,"removed_z_minus_one_multiplicity":removed,
            "remaining_resultant_coefficients_low_to_high":[str(c) for c in result.list()],
            "factors":[{"coefficients_low_to_high":[str(c) for c in f.list()],
                        "multiplicity":int(e)} for f,e in factors],
            "cyclotomic_factors":[],"direct_cyclotomic_gcd_orders":[],
            "direct_cyclotomic_orders_tested":eligible}

assert a*a+2==0 and len({F(0),F(1),a,a+2})==4
counted = [count(n) for n in [1,2,3]]
counts = [pair for pair,field in counted]
assert counts==[[26,17],[590,509],[15431,15566]]
P,Q = [weil([row[i] for row in counts]) for i in [0,1]]
assert P==X**6-18*X**4-65*X**3-450*X**2+15625
assert Q==X**6-9*X**5-18*X**4+385*X**3-450*X**2-5625*X+15625
assert P.is_irreducible() and Q.is_irreducible()
record = {"status":"fixed_pair_exact_arithmetic_certificate_verified",
          "source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          "base_field":"F5[a]/(a^2+2)","parameters":{"lambda":"a","mu":"a+2"},
          "plus_curve":"w^3=t(t-1)(t-a)(t-a-2)",
          "minus_curve":"z^3=x(1-x)(1-a*x)(1-(a+2)*x)",
          "extension_fields":[field for pair,field in counted],
          "counts_n_1_2_3_plus_minus":counts,
          "P_plus_coefficients_low_to_high":[int(c) for c in P.list()],
          "P_minus_coefficients_low_to_high":[int(c) for c in Q.list()],
          "irreducible_plus":True,"irreducible_minus":True,
          "plus_self_ratio_test":quotient_test(P,P,True),
          "minus_self_ratio_test":quotient_test(Q,Q,True),
          "cross_ratio_test":quotient_test(P,Q)}
OUT.write_text(json.dumps(record,indent=2)+"\n")
print(record["status"],record["source_sha256"],flush=True)
