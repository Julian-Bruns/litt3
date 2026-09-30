"""Small exact coefficient model for 435 genuine order-29 pair traces.

This computes a new symbolic model, not an endpoint-incidence scan.
The proof of its coverage is in the matching experiment note.
"""
import sys, json
from pathlib import Path
out = Path(sys.argv[1]); out.mkdir(parents=True, exist_ok=True)
k = GF(5); R = PolynomialRing(k, 'T'); T = R.gen()
d0, d1 = R(2), T
for n in range(2, 30):
    d0, d1 = d1, T*d1-d0
D29 = d1
p = D29-2
rr = (p//p.gcd(p.derivative())).monic()
assert rr.degree() == 15 and rr.gcd(rr.derivative()).is_one()
A = R.quotient(rr, names='c'); c = A.gen()
cols = [(c**(29+i)).lift().list()+[k.zero()]*15 for i in range(15)]
mat = matrix(k, 15, 15, lambda i,j: cols[j][i])
G = mat.charpoly('Z')
assert G.degree() == 15 and G.gcd(G.derivative()).is_one()
factors = G.factor()
assert sorted(f.degree() for f,m in factors) == [1,7,7]
assert all(m == 1 for f,m in factors)
assert G(2) == 0
Z = G.parent().gen()
Gamma = G(Z**29)
assert Gamma.degree() == 435 and Gamma.gcd(Gamma.derivative()).is_one()
assert A(G(c**29)) == 0
record = {'D29_minus_two': p, 'real_trace_support': rr,
          'power_image_matrix': mat, 'G': G, 'G_factorization': factors,
          'Gamma': Gamma}
save(record, str(out/'phase_pair_dickson_model'))
receipt = {'status': 'exact_symbolic_model',
           'scope': 'genuine unordered phase pairs, not rank-three exclusion',
           'real_trace_support': [int(x) for x in rr],
           'G': [int(x) for x in G],
           'G_factors': [[int(x) for x in f] for f,m in factors],
           'trace_support_degree': 435,
           'checks': ['squarefree real trace support', 'squarefree G and Gamma',
                      'factor degrees 1,7,7', 'quotient-ring annihilation identity']}
(out/'phase_pair_dickson_model.json').write_text(json.dumps(receipt, indent=2, default=int)+'\n')
print(json.dumps(receipt, default=int), flush=True)
