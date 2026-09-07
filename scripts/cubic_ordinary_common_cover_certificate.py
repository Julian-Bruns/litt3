"""Exact fixed genus-four pair; run with sage -python. No search or approximations."""
from sage.all import GF, PolynomialRing, QQ, ZZ, euler_phi
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "Research/computations/cubic_ordinary_common_cover_certificate.json"
R0 = PolynomialRing(GF(5), "b")
b = R0.gen()
F = GF(25, name="a", modulus=b*b+2)
a = F.gen()
RF = PolynomialRing(F,"t")
t = RF.gen()
A = t**3+4*a*t**2+t+2*a+4
B = t**3+(4*a+3)*t**2+(a+4)*t+4*a+1
assert A.is_monic() and B.is_monic() and (A*B).is_squarefree()
assert A.degree()==B.degree()==3 and A.gcd(B)==1
R = PolynomialRing(QQ,"z")
z = R.gen()
RT = PolynomialRing(R,"T")
T = RT.gen()
RX = PolynomialRing(ZZ,"X")
X = RX.gen()

def count(n):
    moduli = {2:b**4+4*b**2+4*b+2, 3:b**6+b**4+4*b**3+b**2+2,
              4:b**8+b**4+3*b**2+4*b+2}
    E = F if n==1 else GF(5**(2*n),name="e%d" % n,modulus=moduli[n])
    if n==1:
        ae = a
    else:
        RE = PolynomialRing(E,"r")
        ae = min((RE.gen()**2+2).roots(multiplicities=False),
                 key=lambda c:tuple(int(v) for v in c.polynomial().list()))
    ac,bc = [[E(int(c[0]))+int(c[1])*ae for c in poly.list()] for poly in [A,B]]
    cubes = {c**3 for c in E if c}
    plus = minus = 3  # monic A,B: three rational points over infinity
    for s in E:
        av = ((s+ac[2])*s+ac[1])*s+ac[0]
        bv = ((s+bc[2])*s+bc[1])*s+bc[0]
        if not av or not bv:
            plus += 1  # simple zero of AB
            minus += 1  # simple zero OR pole of A/B
        else:
            plus += 3 if av*bv in cubes else 0
            minus += 3 if av/bv in cubes else 0
    return [int(plus),int(minus)],{"degree_over_F25":n,
        "modulus_over_F5":str(E.modulus()),"image_of_a":str(ae)}

def weil(counts):
    q = ZZ(25)
    s = [None]+[q**n+1-counts[n-1] for n in range(1,5)]
    c = [ZZ(1)]
    for k in range(1,5):
        v = -sum(c[k-i]*s[i] for i in range(1,k+1))
        assert v % k==0
        c.append(v//k)
    return X**8+c[1]*X**7+c[2]*X**6+c[3]*X**5+c[4]*X**4+q*c[3]*X**3+q**2*c[2]*X**2+q**3*c[1]*X+q**4

def quotient_test(P,Q,same=False):
    result = R(RT(P.list()).resultant(sum(RT(Q[i])*z**(8-i)*T**i for i in range(9))))
    removed = 0
    if same:
        while result(1)==0:
            result,rem = result.quo_rem(z-1)
            assert rem==0
            removed += 1
        assert removed==8
    factors = list(result.factor())
    assert all(not f.is_cyclotomic() for f,e in factors)
    # phi(m)<=64 forces m<=8192 because m/phi(m)^2<=2.
    eligible = [m for m in range(1,8193) if euler_phi(m)<=64]
    assert all(result.gcd(R.cyclotomic_polynomial(m)).degree()==0 for m in eligible)
    return {"passes":True,"removed_z_minus_one_multiplicity":removed,
            "remaining_resultant_coefficients_low_to_high":[str(c) for c in result.list()],
            "factors":[{"coefficients_low_to_high":[str(c) for c in f.list()],
                        "multiplicity":int(e)} for f,e in factors],
            "cyclotomic_factors":[],"direct_cyclotomic_gcd_orders":[],
            "direct_cyclotomic_orders_tested":eligible}

counted = [count(n) for n in range(1,5)]
counts = [pair for pair,field in counted]
assert counts==[[33,33],[615,657],[16095,15726],[392427,391017]]
P,Q = [weil([row[i] for row in counts]) for i in [0,1]]
assert P==X**8+7*X**7+19*X**6+175*X**5+1525*X**4+4375*X**3+11875*X**2+109375*X+390625
assert Q==X**8+7*X**7+40*X**6+199*X**5+931*X**4+4975*X**3+25000*X**2+109375*X+390625
assert P.is_irreducible() and Q.is_irreducible()
assert P[4]%5==0 and Q[4]%5!=0
record = {"status":"fixed_pair_exact_arithmetic_certificate_verified",
          "source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          "base_field":"F5[a]/(a^2+2)","cubic_A":str(A),"cubic_B":str(B),
          "cubic_coefficients_A_B_low_to_high":[[[int(c[0]),int(c[1])] for c in poly.list()] for poly in [A,B]],
          "squarefree_and_coprime_monic_cubics":True,"plus_curve":"y^3=A*B","minus_curve":"w^3=A/B",
          "extension_fields":[field for pair,field in counted],
          "counts_n_1_2_3_4_plus_minus":counts,
          "P_plus_coefficients_low_to_high":[int(c) for c in P.list()],
          "P_minus_coefficients_low_to_high":[int(c) for c in Q.list()],
          "irreducible_plus":True,"irreducible_minus":True,"plus_ordinary":False,"minus_ordinary":True,
          "plus_self_ratio_test":quotient_test(P,P,True),
          "minus_self_ratio_test":quotient_test(Q,Q,True),"cross_ratio_test":quotient_test(P,Q)}
OUT.write_text(json.dumps(record,indent=2)+"\n")
print(record["status"],record["source_sha256"],flush=True)
