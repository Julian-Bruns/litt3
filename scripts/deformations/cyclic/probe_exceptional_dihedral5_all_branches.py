#!/usr/bin/env sage-python
"""Bounded exact probe of ALL geometric fourth roots, beyond the even plane.

Uses the accepted complete fourth polynomials. This script does not itself
certify integral tuples or full effectivity at newly found points.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--data', required=True)
ap.add_argument('--output', required=True)
ap.add_argument('--certificate', help='Optional explicit ideal/Jacobian certificate output')
args = ap.parse_args()
source = Path(args.data) / 'exceptional_dihedral5_certificate.json'
cert = json.loads(source.read_text())
assert cert['status'].startswith('PASS exact fourth calibration')
P = PolynomialRing(GF(5), 't')
k = GF(625, 't', modulus=P([3, 4, 1, 4, 1]))
R = PolynomialRing(k, names=('u0', 'u1', 'v0', 'v1'), order='degrevlex')
u0, u1, v0, v1 = R.gens()
equations = []
for row in cert['polynomials']:
    terms = {}
    for term in row:
        ex = term['exponents']
        assert ex[0] % 5 == ex[1] % 5 == 0
        new_ex = (ex[0] // 5, ex[1] // 5, ex[2], ex[3])
        terms[new_ex] = k(term['coefficient'])
    equations.append(R(terms))
start = time.monotonic()
I = R.ideal(equations)
gb = I.groebner_basis()
dimension = I.dimension()
print('Groebner basis:', len(gb), 'dimension:', dimension, flush=True)
assert dimension == 0
basis = I.normal_basis()
length = len(basis)
print('Quotient length:', length, flush=True)
jac = matrix(R, [[e.derivative(x) for x in R.gens()] for e in equations])
det = jac.det()
singular = I + R.ideal(det)
singular_gb = singular.groebner_basis()
smooth = len(singular_gb) == 1 and singular_gb[0] == 1
print('Reduced/smooth:', smooth, flush=True)
assert smooth
# An explicit equality of ideals, not merely a quotient-dimension report.
gb_in_input = []
for b in gb:
    lift = list(b.lift(I))
    assert b == sum(a * e for a, e in zip(lift, equations))
    gb_in_input.append(lift)
assert all(e.reduce(gb) == 0 for e in equations)
spairs = 0
for i, b in enumerate(gb):
    for c in gb[:i]:
        lm = b.lm().lcm(c.lm())
        sb = (lm // b.lm()) * b / b.lc() - (lm // c.lm()) * c / c.lc()
        assert R(sb).reduce(gb) == 0
        spairs += 1
smooth_lift = list(R(1).lift(singular))
assert sum(a * e for a, e in zip(smooth_lift, equations + [det])) == 1
positive_jac = matrix(R, [[equations[i].derivative(x) for x in (u0, u1)]
                           for i in range(2)])
negative_A = matrix(R, [[equations[i].derivative(x) for x in (v0, v1)]
                         for i in range(2, 4)])
assert negative_A.det() in k and negative_A.det() != 0
assert det == positive_jac.det() * negative_A.det()
# Frobenius-linear part of the late response. The two odd parameters
# enter with powers 1 and 5; differentiate with respect to v_i^5.
frob_negative = matrix(R, 4, 2, lambda i, j:sum(
    k(ex[j+2] // 5) * coefficient * R.monomial(*(
        tuple(ex[a] - (5 if a == j+2 else 0) for a in range(4))))
    for ex, coefficient in equations[i].dict().items()
    if ex[j+2] >= 5))
frob_full = matrix(R, 4, 4, lambda i, j:
    equations[i].derivative((u0,u1)[j]) if j < 2 else frob_negative[i,j-2])
frob_unit = I + R.ideal(frob_full.det())
frob_gb = frob_unit.groebner_basis()
all_frob_invertible = len(frob_gb) == 1 and frob_gb[0] == 1
print('Frobenius linear block invertible at every root:', all_frob_invertible, flush=True)
def encode(poly):
    return [{'exponents':list(ex),
             'coefficient':[int(c.polynomial()[i]) for i in range(4)]}
             for ex,c in sorted(R(poly).dict().items())]
if args.certificate:
    payload = {'input_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
       'field_modulus':[3,4,1,4,1],
       'coordinates':'u0=x0^5,u1=x1^5,v0=x2,v1=x3',
       'order':'degrevlex', 'input_equations':[encode(e) for e in equations],
       'groebner_basis':[encode(b) for b in gb],
       'basis_in_input':[[encode(a) for a in row] for row in gb_in_input],
       'standard_monomials':[encode(b) for b in basis],
       'jacobian_determinant':encode(det),
       'jacobian_unit_witness':[encode(a) for a in smooth_lift],
       'frobenius_linear_determinant':encode(frob_full.det())}
    if all_frob_invertible:
        flift = list(R(1).lift(frob_unit))
        assert sum(a*e for a,e in zip(flift,equations+[frob_full.det()]))==1
        payload['frobenius_unit_witness']=[encode(a) for a in flift]
    Path(args.certificate).write_text(json.dumps(payload,separators=(',',':'))+'\n')
out = {
    'status': 'EXPLORATORY exact complete fourth-root calculation',
    'input_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'coordinates': 'u0=x0^5,u1=x1^5,v0=x2,v1=x3; geometric bijection',
    'dimension': int(dimension), 'quotient_length': length,
    'groebner_basis_count': len(gb), 'smooth_reduced': smooth,
    'critical_pairs_checked':spairs, 'ideal_equality_verified':True,
    'jacobian_unit_identity_verified':True,
    'frobenius_linear_block_everywhere_invertible':all_frob_invertible,
    'jacobian_determinant': str(det),
    'seconds': time.monotonic() - start,
    'scope': 'Polynomial scheme only; new roots require actual tuple/effectivity argument.'
}
Path(args.output).write_text(json.dumps(out, indent=2) + '\n')
print(out['status'], 'seconds:', out['seconds'], flush=True)
