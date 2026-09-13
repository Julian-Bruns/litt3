#!/usr/bin/env python3
"""Remove constant-row redundancy with explicit polynomial certificates."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix
from scripts.atlases.native.atlas_native_rref import NativeRref

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('source', type=Path)
p.add_argument('out', type=Path)
p.add_argument('--start-row', type=int, default=0)
args = p.parse_args()
args.out.mkdir(exist_ok=False)
start = time.monotonic()
raw = args.source.read_bytes()
data = json.loads(raw)
k = GF(5**data['field_degree'], 'a', modulus=PolynomialRing(GF(5), 'z')(data['field_modulus']))
R = PolynomialRing(k, len(data['variables']), names=data['variables'], order='degrevlex')
equations = [R({tuple(e): k(c) for e,c in f}) for f in data['equations']]
polys = equations[args.start_row:]
monomials = sorted({tuple(e) for f in polys for e in f.dict()},
                   key=lambda e: (sum(e), tuple(-x for x in reversed(e))), reverse=True)
index = {e:i for i,e in enumerate(monomials)}
M = matrix(k, len(polys), len(monomials),
           {(i,index[tuple(e)]):c for i,f in enumerate(polys) for e,c in f.dict().items()},
           sparse=False, implementation='generic')
engine = NativeRref(k)
A,C = engine.rref(M, audit_sage=True)
assert A == C*M
encode = lambda f: [[list(e), list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
new = [R({e:c for e,c in zip(monomials,row) if c}) for row in A]
rows = equations[:args.start_row]+new
one = encode(R.one())
weights = [[[i,one]] for i in range(args.start_row)]
weights += [[[args.start_row+j,encode(R(c))] for j,c in enumerate(row) if c] for row in C]
certificate = dict(variables=data['variables'], field_degree=data['field_degree'],
                   field_modulus=data['field_modulus'], source_sha256=hashlib.sha256(raw).hexdigest(),
                   source=str(args.source.resolve()), equations=[encode(f) for f in rows],
                   polynomial_multipliers=weights,
                   scope='Constant row identities; source proof chain separately required')
(args.out/'identities.json').write_text(json.dumps(certificate,separators=(',',':'))+'\n')
output = dict(prime=5, field_degree=data['field_degree'], field_modulus=data['field_modulus'],
              variables=data['variables'], equations=certificate['equations'], scope=certificate['scope'],
              provenance=str((args.out/'identities.json').resolve()))
(args.out/'source.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
result = dict(status='complete', rows_before=len(polys), rows_after=len(new),
              columns=len(monomials), terms_before=sum(len(f.dict()) for f in polys),
              terms_after=sum(len(f.dict()) for f in new),
              degrees=[int(f.total_degree()) for f in new], seconds=time.monotonic()-start,
              unit=any(f and f.total_degree()==0 for f in new))
(args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
