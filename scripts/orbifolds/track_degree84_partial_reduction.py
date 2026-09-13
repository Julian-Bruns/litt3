#!/usr/bin/env python3
"""Track exact reduction of every full equation by a proven partial basis.

No complete Gröbner-basis claim is needed: global polynomial division gives
identities with explicit multipliers. The output is equivalent on the
recorded affine chart after the basis's ideal-membership chain is replayed.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing
from sage.libs.singular.function import singular_function
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt
from scripts.atlases.algebra.sparse_polynomial_substitution import SparsePolynomialTransport

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('full_source', type=Path)
p.add_argument('affine_source', type=Path)
p.add_argument('basis', type=Path)
p.add_argument('basis_receipt', type=Path)
p.add_argument('out', type=Path)
p.add_argument('--seconds', type=int, default=180)
args = p.parse_args()
args.out.mkdir(exist_ok=False)
started = time.monotonic()
raw = args.full_source.read_bytes()
full = json.loads(raw)
aff = json.loads(args.affine_source.read_text())
basis_raw = args.basis.read_bytes()
partial = json.loads(basis_raw)
receipt = json.loads(args.basis_receipt.read_text())
assert receipt['status'] == 'independent_polynomial_basis_identities_PASS'
assert receipt['certificate_sha256'] == hashlib.sha256(basis_raw).hexdigest()
k = GF(5**full['field_degree'], 'a', modulus=PolynomialRing(GF(5), 'z')(full['field_modulus']))
R = PolynomialRing(k, len(full['variables']), names=full['variables'], order='degrevlex')
S = PolynomialRing(k, len(aff['variables']), names=aff['variables'], order='degrevlex')
decode = lambda ring, f: ring({tuple(e): k(c) for e, c in f})
encode = lambda f: [[list(e), list(map(int, c.polynomial().list()))] for e, c in f.dict().items()]
assert full['variables'] == aff['original_variables']
assert aff['variables'] == partial['variables']
subs = {name: decode(R, f) for name, f in aff['substitutions'].items()}
images = [S(subs.get(name, R.gen(i))) for i, name in enumerate(full['variables'])]
transport = SparsePolynomialTransport(R, S, images)
basis = [decode(S, f) for f in partial['equations']]
equations = [decode(R, f) for f in full['equations']]
result = dict(status='running', scope='Tracked necessary system; no exclusion',
              full_source_sha256=hashlib.sha256(raw).hexdigest())
alarm(args.seconds)
try:
    moved = [transport(f) for f in equations]
    print(json.dumps(dict(stage='all_equations_transported',
                          seconds=time.monotonic()-started)), flush=True)
    # The unbounded two-argument form computes a COMPLETE standard basis
    # of the divisor ideal first. The third argument bounds that work;
    # it does not promise degree-nonincreasing remainders for this native
    # algorithm. We use only the exact, untruncated identities checked below.
    division_degree=max(int(f.total_degree()) for f in moved if f)
    quotient, remainder = singular_function('division')(
        S.ideal(moved), S.ideal(basis), division_degree)
    assert quotient.nrows() == len(basis) and quotient.ncols() == len(moved)
    remainder = [S(f) for f in remainder]
    assert len(remainder) == len(moved)
    for j, (f, r) in enumerate(zip(moved, remainder)):
        assert f == r + sum(quotient[i,j]*b for i,b in enumerate(basis))
    source = dict(prime=5, field_degree=full['field_degree'],
                  field_modulus=full['field_modulus'], variables=aff['variables'],
                  equations=[encode(f) for f in basis+moved],
                  full_source=str(args.full_source.resolve()),
                  full_source_sha256=result['full_source_sha256'],
                  affine_source=str(args.affine_source.resolve()),
                  affine_source_sha256=hashlib.sha256(args.affine_source.read_bytes()).hexdigest(),
                  basis=str(args.basis.resolve()),
                  basis_sha256=hashlib.sha256(basis_raw).hexdigest())
    source_path = args.out/'reduction_source.json'
    source_path.write_text(json.dumps(source, separators=(',', ':'))+'\n')
    source_hash = hashlib.sha256(source_path.read_bytes()).hexdigest()
    one = encode(S.one())
    rows = list(basis)
    weights = [[[i, one]] for i in range(len(basis))]
    full_row_indices = []
    for j, r in enumerate(remainder):
        if not r:
            continue
        row = [[len(basis)+j, one]]
        row += [[i, encode(-quotient[i,j])] for i in range(len(basis)) if quotient[i,j]]
        rows.append(r)
        weights.append(row)
        full_row_indices.append(j)
    payload = dict(variables=aff['variables'], field_degree=full['field_degree'],
                   field_modulus=full['field_modulus'], source_sha256=source_hash,
                   equations=[encode(f) for f in rows], polynomial_multipliers=weights,
                   source=str(source_path.resolve()),
                   nonzero_residual_original_rows=full_row_indices,
                   scope='Explicit division identities; independent replay required')
    (args.out/'reduction_identities.json').write_text(json.dumps(payload, separators=(',', ':'))+'\n')
    candidate = dict(prime=5, field_degree=full['field_degree'],
                     field_modulus=full['field_modulus'], variables=aff['variables'],
                     equations=payload['equations'], scope=payload['scope'],
                     provenance=str((args.out/'reduction_identities.json').resolve()))
    (args.out/'source.json').write_text(json.dumps(candidate, separators=(',', ':'))+'\n')
    result.update(status='complete', division_degree=division_degree,
                  basis_rows=len(basis), nonzero_residuals=len(full_row_indices),
                  total_terms=sum(len(f.dict()) for f in rows),
                  residual_terms=sum(len(f.dict()) for f in remainder),
                  multiplier_terms=sum(len(w) for row in weights for _,w in row),
                  has_nonzero_constant=any(f and f.total_degree()==0 for f in rows))
except AlarmInterrupt:
    result['status'] = 'time_limit_no_verdict'
finally:
    cancel_alarm()
    result['seconds'] = time.monotonic()-started
    (args.out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result), flush=True)
if result['status'] != 'complete':
    raise SystemExit(3)
