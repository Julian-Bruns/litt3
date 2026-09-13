#!/usr/bin/env python3
"""Replay a polynomial identity excluding a beta subspace, not an atlas census."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import base64
import functools
import hashlib
import json
from pathlib import Path
from scripts.atlases.verify_atlas_weak_points import add, mul, parse

ROOT = Path(__file__).resolve().parents[2]

def verify():
    record = json.loads((ROOT / 'Research/computations/atlas_normalization_subspace.json').read_text())
    source = ROOT / record['source']
    assert hashlib.sha256(source.read_bytes()).hexdigest() == record['source_sha256']
    tensor = json.loads(source.read_text())
    values = base64.b64decode(record['L_base64'], validate=True)
    assert len(values) == 32*64 and all(x < 25 for x in values)
    L = [values[64*i:64*i+64] for i in range(32)]
    coeff = functools.lru_cache(None)(parse)
    count = 0
    for j in record['beta_support']:
        assert 0 <= j < 32
        N = [[coeff(tensor['N_tensor'][i][r][j]) for r in range(64)] for i in range(32)]
        R = [[coeff(tensor['R_tensor'][i][h][j]) for h in range(32)] for i in range(32)]
        for a in range(32):
            for b in range(a, 32):
                target = R[a][a] if a == b else add(R[a][b], R[b][a])
                actual = 0
                for r in range(64):
                    actual = add(actual, mul(L[a][r], N[b][r]))
                    if a != b:
                        actual = add(actual, mul(L[b][r], N[a][r]))
                assert actual == target, (j, a, b, actual, target)
                count += 1
    return {'status': 'PASS', 'coefficient_identities': count,
            'excluded_beta_subspace_dimension': len(record['beta_support']),
            'whole_representative_excluded': False,
            'geometric_scope': 'All algebraically closed field extensions; not finite-field sampling'}

if __name__ == '__main__':
    print(json.dumps(verify(), indent=2))
