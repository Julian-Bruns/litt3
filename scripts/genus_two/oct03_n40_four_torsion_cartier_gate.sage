#!/usr/bin/env sage
"""Fresh C(F8^2 sigma)=0 gate on the saved complete four-torsion algebra.

No torsion census, Bol calculation, ordinarity check, or source search is
repeated. Every saved norm is tested at all six Weierstrass origins.
"""
import hashlib
import json
import os
import time
from pathlib import Path

started = time.monotonic()
root = Path(__file__).resolve().parents[2]
source = root / '../litt3-computation-data/legacy_workspace_computations/backup_genus_two_four_torsion.json'
raw = source.read_bytes()
saved = json.loads(raw)
prime = GF(5)
P = PolynomialRing(prime, 'x')
field = GF(5**6, name='rho', modulus=P(saved['small_field_modulus']))
decode = lambda cs: field(P(cs))
encode = lambda a: [int(c) for c in field(a).polynomial().list()]
alpha = decode(saved['alpha_image'])
assert alpha**3 + alpha + 1 == 0
R = PolynomialRing(field, 'z')
z = R.gen()
branch = [field(0), field(1), field(2), field(3), alpha]
phi0 = prod(z - r for r in branch)

def change_origin(poly, w, exponent):
    # z^exponent poly(w+1/z), with degree(poly)<=exponent.
    assert poly.degree() <= exponent
    return sum((poly[i] * z**(exponent-i) * (w*z+1)**i
                for i in range(poly.degree()+1)), R.zero())

records = []
survivors = []
for row_index, row in enumerate(saved['halving_classes']):
    subset = [decode(cs) for cs in row['finite_branch_subset']]
    E = prod(z-r for r in subset)
    quotient = phi0 // E
    for solution_index, point in enumerate(row['solutions']):
        c0, c1, _, _ = [decode(cs) for cs in point['parameters']]
        C = c0+c1*z
        A0 = C**2*E+quotient
        B0 = 2*C
        # The saved accepted dictionary gives F8=A0+B0*y.
        for origin_index, w in enumerate([None]+branch):
            if w is None:
                phi, A, B = phi0, A0, B0
            else:
                # New y=y_old*z^3 and sigma=dz/y, div(sigma)=2w.
                phi = change_origin(phi0, w, 6)
                A = change_origin(A0, w, 4)
                B = change_origin(B0, w, 1)
            even = A**2+B**2*phi
            odd = 2*A*B
            numerator = even*phi**2
            # C(even dz/y)=0 iff numerator's 4 mod 5 coefficients vanish;
            # C(odd dz)=0 iff odd's 4 mod 5 coefficients vanish.
            indices_even = list(range(4, numerator.degree()+1, 5))
            indices_odd = list(range(4, odd.degree()+1, 5))
            values = [numerator[i] for i in indices_even]+[odd[i] for i in indices_odd]
            passed = not any(values)
            entry = {'class':[row_index,solution_index], 'origin_index':origin_index,
                     'even_indices':indices_even, 'odd_indices':indices_odd,
                     'cartier_coefficients':[encode(a) for a in values],
                     'vanishes':passed}
            records.append(entry)
            if passed:
                entry = dict(entry)
                entry.update({'phi':[encode(a) for a in phi.list()],
                              'A':[encode(a) for a in A.list()],
                              'B':[encode(a) for a in B.list()]})
                survivors.append(entry)
assert len(records) == 240*6
result = {'status':'complete fresh four-torsion Cartier gate',
          'source_sha256':hashlib.sha256(raw).hexdigest(),
          'field_modulus':saved['small_field_modulus'],
          'alpha':saved['alpha_image'], 'classes':240,'origins':6,
          'tests':len(records),'survivors':survivors,'records':records,
          'gate':'C(F8^2 sigma)=0',
          'threads':{key:os.environ.get(key) for key in
                     ['OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS']},
          'sage_version':str(version()),
          'seconds':time.monotonic()-started,
          'scope':'New gate only. Saved complete norm dictionary is reused; no census or previous determinants are replayed.'}
target = root / '../litt3-computation-data/oct03_n40_four_torsion_cartier_gate.json'
target.write_text(json.dumps(result, indent=1, default=int)+'\n')
print(json.dumps({k:result[k] for k in ['status','tests','seconds','sage_version']}, default=int))
print('survivors',len(survivors),[(a['class'],a['origin_index']) for a in survivors])
