"""New exact BACKUP order-four elliptic-reflection CM test; one CPU.

Enumerate all15 paired two-torsion choices and all8 sign selections
modulo common sign. Count the monic quartic reflection models directly
over F5^6. No accepted ordinarity certificate is rerun.
"""
import argparse
import itertools
import json
import time
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', required=True)
args = parser.parse_args()
started = time.monotonic()
R0 = PolynomialRing(GF(5), 'z')
z = R0.gen()
K = GF(5**6, name='a', modulus=z**6+z**4+4*z**3+z**2+2)
a = K.gen()
alpha = a**3+2*a**2+4*a+1
assert alpha**3+alpha+1 == 0
assert a.multiplicative_order() == K.order()-1

def encode(x):
    return [int(c) for c in x.polynomial().list()]+[0]*(6-len(x.polynomial().list()))

values = [K.zero()]
v = K.one()
for e in range(K.order()-1):
    values.append(v)
    v *= a
assert len(set(values)) == K.order()
quadratic = {K.zero(): 0}
v = K.one()
for e in range(K.order()-1):
    quadratic[v] = 1 if e % 2 == 0 else -1
    v *= a
assert len(quadratic) == K.order()

labels = ['0','1','2','3','alpha','infinity']
branch = [K(0),K(1),K(2),K(3),alpha,None]
P = PolynomialRing(K, 'u')
u = P.gen()
rows = []
cache = {}
for paired in itertools.combinations(range(6), 2):
    ia, ib = paired
    pa, pb = branch[ia], branch[ib]
    assert pa is not None
    unpaired = [i for i in range(6) if i not in paired]
    squares = []
    for i in unpaired:
        w = branch[i]
        if pb is None:
            assert w is not None
            squares.append(w-pa)
        elif w is None:
            squares.append(K.one())
        else:
            squares.append((w-pa)/(w-pb))
    roots = []
    for sq in squares:
        assert sq and sq.is_square()
        r = sq.sqrt()
        r = min([r,-r], key=encode)
        assert r*r == sq
        roots.append(r)
    assert len(set(squares)) == 4
    for signs in itertools.product([1,-1], repeat=3):
        selected = [roots[0]]+[roots[i+1]*signs[i] for i in range(3)]
        assert len(set(selected)) == 4
        r1,r2,r3,r4 = selected
        A = (r1-r3)*(r2-r4)
        C = (r1-r4)*(r2-r3)
        lam = A/C
        j = K(256)*(lam*lam-lam+1)**3/(lam*lam*(1-lam)**2)
        quartic = prod(u-r for r in selected)
        key = tuple(encode(j))
        # Exact MONIC-quartic point count, including its TWO rational infinities.
        total_character = 0
        coeff = quartic.list()
        for x in values:
            val = (((x+coeff[3])*x+coeff[2])*x+coeff[1])*x+coeff[0]
            total_character += quadratic[val]
        points = K.order()+2+total_character
        trace = K.order()+1-points
        assert trace*trace <= 4*K.order()
        discriminant = trace*trace-4*K.order()
        ordinary = trace % 5 != 0
        minus_square = discriminant < 0 and ZZ(-discriminant).is_square()
        row = dict(pair=[labels[i] for i in paired],
                   unpaired=[labels[i] for i in unpaired], signs=[1]+list(signs),
                   squared_roots=[encode(x) for x in squares],
                   selected_roots=[encode(x) for x in selected],
                   quartic=[encode(x) for x in coeff],j=encode(j),
                   field_points=int(points),trace=int(trace),
                   discriminant=int(discriminant),ordinary=ordinary,
                   cm_Q_i_candidate=bool(ordinary and minus_square))
        rows.append(row)
        cache.setdefault(key, set()).add(int(trace*trace))
    print('finished pair', [labels[i] for i in paired], flush=True)
assert len(rows) == 120
assert all(len(traces) == 1 for traces in cache.values())
result = dict(status='complete', characteristic=5,field_degree=6,
              field_order=int(K.order()),field_modulus=[int(c) for c in K.modulus().list()],
              parameter=encode(alpha),parameter_minpoly=[1,1,0,1],
              paired_choices=15,sign_choices_per_pair=8,rows=len(rows),
              distinct_j=len(cache),ordinary=sum(r['ordinary'] for r in rows),
              supersingular=sum(not r['ordinary'] for r in rows),
              cm_Q_i_candidates=sum(r['cm_Q_i_candidate'] for r in rows),
              candidate_rows=[i for i,r in enumerate(rows) if r['cm_Q_i_candidate']],
              normalization='monic quartic; two rational infinity points; common sign fixed on first root',
              elapsed_seconds=time.monotonic()-started,records=rows)
target = Path(args.output)
target.parent.mkdir(parents=True, exist_ok=True)
target.write_text(json.dumps(result, indent=2, default=int)+'\n')
print(json.dumps({k:v for k,v in result.items() if k != 'records'}, indent=2, default=int))
