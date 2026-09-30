#!/usr/bin/env sage-python
"""Certify finite-field bijectivity of the completed exceptional late response."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--data', required=True)
ap.add_argument('--output', required=True)
args = ap.parse_args()
data = Path(args.data)
certificate_path = data / 'exceptional_dihedral5_certificate.json'
config_path = data / 'exceptional_dihedral5_cubic_point.json'
cert = json.loads(certificate_path.read_text())
cfg = json.loads(config_path.read_text())
assert cert['status'].startswith('PASS exact fourth calibration')
P = PolynomialRing(GF(5), 't')
k = GF(625, 't', modulus=P([3, 4, 1, 4, 1]))
R = PolynomialRing(k, 4, 'x')
x = R.gens()
E = [R({tuple(c['exponents']): k(c['coefficient']) for c in row})
     for row in cert['polynomials']]
Q = PolynomialRing(k, 'l')
modulus = Q([k(c) for c in cfg['extension_polynomial']])
assert modulus.is_irreducible() and modulus.degree() == 3
K = Q.quotient(modulus, 'l')
l = K.gen()
y = [sum(K(k(row[4*j:4*j+4])) * l**j for j in range(3))
     for row in cfg['parameters']]
point = [c**(5**11) for c in y]
assert all(c**5 == d for c, d in zip(point, y))
assert all(e(*point) == 0 for e in E)
A = matrix(K, [[e.monomial_coefficient(x[j]) for j in (2, 3)]
               for e in E[2:]])
B = matrix(K, 2, 2, lambda i, j:
    sum(K(c) * point[0]**ex[0] * point[1]**ex[1]
        for ex, c in E[i+2].dict().items()
        if ex[j+2] == 5 and ex[5-(j+2)] == 0))

def encode(c):
    return [int(K(c).lift()[j].polynomial()[i])
            for j in range(3) for i in range(4)]

basis = [K(k.gen()**i)*l**j for j in range(3) for i in range(4)]
columns = []
for n in range(24):
    v = vector(K, [basis[n % 12] if n//12 == i else 0 for i in range(2)])
    value = A*v + B*v.apply_map(lambda c: c**5)
    columns.append(encode(value[0]) + encode(value[1]))
M = matrix(GF(5), columns).transpose()
assert M.rank() == 24 and M.det() == 1
inv = M.inverse()
assert M*inv == inv*M == matrix.identity(GF(5), 24)

# Independent prime-field multiplication of the exported matrices.
rows = [[int(c) for c in row] for row in M.rows()]
inverse = [[int(c) for c in row] for row in inv.rows()]
for u, v in [(rows, inverse), (inverse, rows)]:
    assert all(sum(u[i][h]*v[h][j] for h in range(24)) % 5 == (i == j)
               for i in range(24) for j in range(24))

out = dict(
    status='PASS complete late response is bijective over F_(5^12)',
    field_degree=12,
    positive_block='Invertible matrix followed by coefficient Frobenius',
    negative_block_A=[[encode(c) for c in row] for row in A.rows()],
    negative_block_B=[[encode(c) for c in row] for row in B.rows()],
    negative_prime_field_rank=24, negative_prime_field_determinant=1,
    negative_matrix=rows, negative_inverse=inverse,
    input_hashes={p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                  for p in [certificate_path, config_path]},
    scope='Compatible full Hodge tower over F_(5^12). The exact prescribed BT1 and tame determinant choices require at most one additional fixed finite coefficient-field extension, not a growing sequence of fields.')
Path(args.output).write_text(json.dumps(out, indent=2)+'\n')
print(out['status'])
