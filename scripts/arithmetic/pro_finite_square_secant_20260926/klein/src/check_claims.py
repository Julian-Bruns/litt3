#!/usr/bin/env python3
"""Check claim-index file references and explicit status labels, not mathematical truth."""
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
data=json.loads((ROOT/'claims.json').read_text())
statuses={'proved','proved_conditional','proved_with_exact_computation','computationally_checked','open'}
ids=set(); refs=0
for claim in data['claims']:
    assert claim['id'] not in ids
    ids.add(claim['id'])
    assert claim['status'] in statuses
    if claim['status']=='proved_conditional': assert claim['hypothesis']
    assert claim['scope'] and claim['evidence']
    for ref in claim['evidence']:
        p=ROOT/ref['file']
        assert p.is_file() and ROOT in p.resolve().parents, ref
        refs+=1
assert data['archive_status']=='partial'
assert (ROOT/'inputs/problem.md').read_bytes()==(ROOT/'prior/inputs/problem.md').read_bytes()
assert (ROOT/'inputs/coefficients.json').read_bytes()==(ROOT/'prior/inputs/coefficients.json').read_bytes()
print('PASS: explicit statuses and',refs,'file references for',len(ids),'claims; exact input copies.')
print('This is an index-integrity check, not independent verification of mathematical truth.')
