"""Independent Sage audit of the saved whole-locus finite reconstruction.

The geometric finite-support proposition is audited separately in prose.
This verifier uses Sage finite-field arithmetic, not the producer's
NumPy finite-field elimination, to check its exact linear certificates.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import json
from pathlib import Path
import sys
import zipfile
import numpy as np
from sage.all import GF, PolynomialRing, matrix, vector

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "Research/computations"
pt = PolynomialRing(GF(5), "t")
tt = pt.gen()
modulus = tt**4 + 4*tt**3 + tt**2 + 4*tt + 3
assert modulus.is_irreducible()
k = GF(625, "t", modulus=modulus)
t = k.gen()
values = [sum(k(c//5**i % 5)*t**i for i in range(4)) for c in range(625)]
sys.path.insert(0, str(ROOT / "scripts"))
from scripts.deformations.rank25.rank25_pro_data_model import unpack

def km(a):
    return matrix(k, a.shape[0], a.shape[1], [values[int(c)] for c in a.flat])

checks = {}
def passed(name, value=True):
    assert value, name
    checks[name] = True
    print(name, "PASS", flush=True)

# Reconstruct the pairing identity in the actual finite deck algebra,
# directly checking the saved source/target actions against translations
# of the original 75 cochains. No averaging by the group order occurs.
with zipfile.ZipFile(ROOT / "Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip") as packet:
    raw = unpack(json.loads(packet.read("data.json")))
    fourth = unpack(json.loads(packet.read("fourth.json")))
def field_tuple(c): return sum(k(a)*t**i for i,a in enumerate(c))
N = matrix(k, [list(map(field_tuple,row)) for row in raw["kernel_basis"]]).transpose()
Lambda = matrix(k, [list(map(field_tuple,row)) for row in raw["obstruction_dual_rows"]])
H = matrix(k, [list(map(field_tuple,row)) for row in raw["additive_matrix"]])
pairdata = json.loads((OUT / "rank25_generalization_leverage.json").read_text())["constant_gradient_test"]["exact_pairing"]
Pair = matrix(k, [[field_tuple(map(int,c)) for c in row] for row in pairdata])
passed("constant_pairing_invertible", Pair.det() != 0)
PY = PolynomialRing(k, 9, names=tuple("Y"+str(i) for i in range(9)))
Y = PY.gens()
F = vector(PY, [field_tuple(c) for c in fourth["obstruction"]["constant"]])
for i,co in enumerate(fourth["obstruction"]["frobenius"]):
    F += Y[i]*vector(PY, [field_tuple(c) for c in co])
for i,j,co in fourth["obstruction"]["quadratic"]:
    F += Y[i]*Y[j]*vector(PY, [field_tuple(c) for c in co])
J = matrix(PY, [[f.derivative(y) for y in Y] for f in F])
passed("actual_fourth_jacobian_pairing_symmetric", Pair*J == (Pair*J).transpose())
DP = PolynomialRing(k, 2, names=("s1","s2"))
s1,s2 = DP.gens()
DI = DP.ideal(s1**5-H[0,0]*s1-H[0,1]*s2,
              s2**5-H[1,0]*s1-H[1,1]*s2)
dp = json.loads((OUT / "rank25_cotangent_pairing.json").read_text())
def deck_matrix(saved):
    return matrix(DP, [[sum((field_tuple(map(int,term["coefficient"]))*s1**term["exponents"][0]*s2**term["exponents"][1] for term in cell),DP(0)) for cell in row] for row in saved])
SS = deck_matrix(dp["source_deck_action"])
TO = deck_matrix(dp["target_deck_action"])
from math import comb
T = matrix(DP,75)
for i in range(5):
    for j in range(5):
        for a in range(i+1):
            for b in range(j+1):
                c = comb(i,a)*comb(j,b)*s1**(i-a)*s2**(j-b)
                for d in range(3): T[3*(5*a+b)+d,3*(5*i+j)+d] = c
passed("source_action_from_actual_75_cochains", N*SS == T*N)
passed("target_action_from_actual_75_cochains", TO*Lambda == Lambda*T)
twisted = SS.apply_map(lambda a: DI.reduce(a**5)).transpose()*Pair*TO-Pair
passed("actual_frobenius_twisted_deck_pairing", not twisted.apply_map(DI.reduce))

saved = np.load(OUT / "rank25_fifth_covariant_reconstruction_space.npz")
D = km(saved["difference"])
K = km(saved["homogeneous_basis"])
rows = saved["pivot_rows"].tolist()
cols = saved["pivot_columns"].tolist()
passed("difference_pivot_minor_rank_274", D.matrix_from_rows_and_columns(rows, cols).rank() == 274)
passed("nineteen_independent_kernel_vectors", K.rank() == 19 and D*K.transpose() == 0)
aug = km(saved["covariance_augmented"])
part = vector(k, [values[int(c)] for c in saved["particular"]])
passed("inhomogeneous_covariance_particular", aug[:, :-1]*part == aug.column(aug.ncols()-1))
passed("same_covariance_homogeneous_matrix", aug[:, :-1] == D)
rep = km(saved["representation"])
passed("cubic_section_dimension_293", rep.rank() == 293)

space = json.loads((OUT / "rank25_fifth_covariant_reconstruction_space.json").read_text())
recon = json.loads((OUT / "rank25_fifth_curve_reconstruction.json").read_text())
curve = json.loads((OUT / "rank25_one_parameter_full_exclusion.json").read_text())
P = PolynomialRing(k, "l")
l = P.gen()
G = P([values[c] for c in curve["G_monic"]])
passed("thirty_nonzero_reduced_curve_points", G.degree() == 30 and G[0] != 0 and G.gcd(G.derivative()) == 1)
Q = P.quotient(G, "z")
z = Q.gen()
n = G.degree()

def cv(a):
    return vector(k, [Q(a).lift()[i] for i in range(n)])

def ev(poly):
    result = Q(0)
    for e,c in poly:
        assert e[0] == e[4] == e[5] == 0
        if e[1] == e[2] == 0:
            result += values[c]*(z**5)**e[3]
    return result

normal = list(map(ev, space["known_nonFrobenius_normal_part"]))
rootrows = [[ev(p) for p in row] for row in space["root_cotangent_rows"]]
target = [Q(0)]*9
target[5], target[6] = [Q(P([values[c] for c in poly])) for poly in curve["residual_polynomials_mod_G"]]
target_cov = [sum((c**5*a for c,a in zip(row,target)), Q(0)) for row in rootrows]
known_cov = [sum((c**5*a for c,a in zip(row,normal)), Q(0)) for row in rootrows]
newpart = list(map(ev, recon["particular_cotangent_root_section"]))
passed("complete_curve_data_reproduced_without_root_algorithm", all(a+b**5 == c for a,b,c in zip(known_cov,newpart,target_cov)))

hom = [[ev(p) for p in col] for col in space["homogeneous_cotangent_root_sections"]]
curve_matrix = matrix(k, [sum((list(cv(p)) for p in col), []) for col in hom]).transpose()
passed("curve_restriction_rank_17", curve_matrix.rank() == 17)
rk = matrix(k, [[values[c] for c in row] for row in recon["remaining_in_invariant_basis"]])
passed("remaining_two_are_complete_curve_kernel", rk.rank() == 2 and curve_matrix*rk.transpose() == 0)
passed("remaining_two_have_globally_zero_transverse_components", all(not sec[0] and not sec[1] for sec in recon["remaining_cotangent_root_sections"]))

# Compare the delivered transverse polynomial calculation without the
# producer's custom polynomial implementation.
def poly_dict(p):
    return {tuple(e): values[c] for e,c in p}

def add(a,b):
    r = dict(a)
    for e,c in b.items():
        r[e] = r.get(e,k(0)) + c
        if not r[e]: del r[e]
    return r

def mul(a,b):
    r = {}
    for e,c in a.items():
        for f,d in b.items():
            g = tuple(x+y for x,y in zip(e,f))
            r[g] = r.get(g,k(0)) + c*d
    return {e:c for e,c in r.items() if c}

def frob(a):
    return {tuple(5*x for x in e): c**5 for e,c in a.items()}

total = []
for row,pure in zip(recon["root_cotangent_rows"], recon["particular_cotangent_root_section"]):
    result = frob(poly_dict(pure))
    for c,a in zip(row,recon["known_nonFrobenius_normal_part"]):
        result = add(result, mul(frob(poly_dict(c)),poly_dict(a)))
    total.append(result)
expected = [[374,60,379],[230,416,526]]
for i,cs in enumerate(expected):
    want = {(0,0,0,d,0,0):values[c] for d,c in zip([2,6,10],cs)}
    passed("global_transverse_polynomial_"+str(i), total[i] == want)
V = PolynomialRing(k,"v")
v = V.gen()
a = V([values[c] for c in expected[0]])
b = V([values[c] for c in expected[1]])
def digits(s): return sum(int(d)*5**i for i,d in enumerate(s))
pa = values[digits("2013")] + values[digits("3340")]*v
pb = values[digits("1413")] + values[digits("4410")]*v
passed("global_transverse_bezout", pa*a + pb*b == 1)

receipt = {"status":"PASS independent exact finite reconstruction audit; geometric audit separate",
           "auditor":"/root/audit_nodal25_descent", "date":"2026-09-13", "checks":checks}
(OUT / "rank25_whole_fifth_reconstruction_independent_audit.json").write_text(json.dumps(receipt,indent=2)+"\n")
