"""Reconstruct only the two separating rank25 components in their normal form.

Run with sage -python. The geometric support theorem and the accepted
complete covariant basis are prerequisites; finite data alone do not give
universality. No third cotangent component or unused parameter is fitted.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, LaurentPolynomialRing, PolynomialRing, matrix, vector

root = Path(__file__).resolve().parents[3]
ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--output', type=Path,
                default=root/'Research/computations/rank25_transverse_curve_reconstruction.json')
args = ap.parse_args()
sources = {name: root/'Research/computations'/filename for name, filename in {
    'space': 'rank25_fifth_covariant_reconstruction_space.json',
    'normal_form': 'rank25_transverse_normal_form.json',
    'curve': 'rank25_one_parameter_full_exclusion.json',
}.items()}
d = {name: json.loads(path.read_text()) for name, path in sources.items()}
pt = PolynomialRing(GF(5), 't'); tt = pt.gen()
k = GF(625, 't', modulus=tt**4+4*tt**3+tt**2+4*tt+3); t = k.gen()

def val(c):
    return sum(k(c//5**i % 5)*t**i for i in range(4))

def code(c):
    return sum(int(k(c).polynomial()[i])*5**i for i in range(4))

def digits(s):
    return sum(k(int(c))*t**i for i, c in enumerate(s))

P = LaurentPolynomialRing(k, ['A', 'B', 'q']); A, B, q = P.gens()

def read_pol(rows):
    out = P(0)
    for e, c in rows:
        assert e[0] == e[4] == e[5] == 0
        out += val(c)*A**e[1]*B**e[2]*q**e[3]
    return out

space = d['space']; normal_form = d['normal_form']; curve = d['curve']
assert normal_form['transverse_dimension'] == normal_form['restriction_dimension'] == 11
assert normal_form['source_sha256'] == hashlib.sha256(sources['space'].read_bytes()).hexdigest()
known = list(map(read_pol, space['known_nonFrobenius_normal_part']))
rows = [[read_pol(p) for p in row] for row in space['root_cotangent_rows'][:2]]
particular = list(map(read_pol, space['particular_cotangent_root_section'][:2]))
normal_basis = []
for degree in [-1, 0, 1, 2, 3]:
    normal_basis.extend([[q**degree, P(0)], [P(0), q**degree]])
normal_basis.append(list(map(read_pol, normal_form['exceptional_columns'][0])))

PL = PolynomialRing(k, 'l'); l = PL.gen()
G = PL(list(map(val, curve['G_monic'])))
assert G.degree() == 30 and G[0] and G.gcd(G.derivative()) == 1
Q = PL.quotient(G, 'z'); z = Q.gen(); n = G.degree()

def cv(a):
    co = list(Q(a).lift())
    return vector(k, co+[k(0)]*(n-len(co)))

fm = matrix(k, [cv(z**(5*i)) for i in range(n)]).transpose()
fi = fm.inverse()

def froot(a):
    b = fi*cv(a)
    answer = Q(list(c**125 for c in b))
    assert answer**5 == a
    return answer

def restrict(p):
    return sum((c*(z**5)**e[2] for e, c in p.dict().items()
                if e[0] == e[1] == 0), Q(0))

target = [Q(0)]*9
target[5], target[6] = [Q(PL(list(map(val, p))))
                        for p in curve['residual_polynomials_mod_G']]
pure_normal = [froot(a-restrict(b)) for a, b in zip(target, known)]
wanted = [sum((restrict(a)*b for a, b in zip(row, pure_normal)), Q(0))
          for row in rows]
columns = [[restrict(p) for p in col] for col in normal_basis]
mat = matrix(k, [sum((list(cv(p)) for p in col), []) for col in columns]).transpose()
rhs = vector(k, sum((list(cv(w-restrict(p))) for w, p in zip(wanted, particular)), []))
assert mat.rank() == mat.augment(matrix(k, len(rhs), 1, rhs)).rank() == 11
weights = mat.solve_right(rhs)
pure = [particular[j]+sum((w*col[j] for w, col in zip(weights, normal_basis)), P(0))
        for j in range(2)]
assert pure == [val(542)*q**2, val(316)*q**2]
actual = [p**5+sum((a**5*b for a, b in zip(row, known)), P(0))
          for p, row in zip(pure, rows)]
expected = [q**2*(digits(c0)+digits(c1)*q**4+digits(c2)*q**8)
            for c0, c1, c2 in [('4442', '0220', '4003'), ('0141', '1313', '1014')]]
assert actual == expected
separator = q**-2*((digits('2013')+digits('3340')*q**4)*actual[0]
                   +(digits('1413')+digits('4410')*q**4)*actual[1])
assert separator == 1

def serial(p):
    return [[list(map(int, e)), code(c)] for e, c in sorted(p.dict().items())]

out = {
    'status': 'PASS exact transverse reconstruction and unit identity; geometric support is a prerequisite',
    'curve_degree': 30, 'transverse_unknown_dimension': 11,
    'restriction_rank': 11, 'augmented_rank': 11,
    'normal_form_coefficients': [code(c) for c in weights],
    'pure_root_transverse_components': [serial(p) for p in pure],
    'actual_transverse_components': [serial(p) for p in actual],
    'variable_order': ['A', 'B', 'q'],
    'coefficient_encoding': 'a0+5*a1+25*a2+125*a3 represents a0+a1*t+a2*t^2+a3*t^3',
    'unit_separator': 'q^-2*((2013+3340*q^4)*omega_A+(1413+4410*q^4)*omega_B)=1',
    'source_sha256': {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
                      for path in sources.values()},
}
args.output.write_text(json.dumps(out, indent=2)+'\n')
print('PASS: eleven coefficients uniquely determined; both transverse components and unit separator match.')
