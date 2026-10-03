#!/usr/bin/env python3
"""Focused independent original-field audit of the new native identities."""
import argparse,hashlib,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence')
sys.path.insert(0,str(ARCHIVE/'src'))
from field import K
from incidence import endpoint,f5rank,phase_polynomials
ap=argparse.ArgumentParser();ap.add_argument('--directory',required=True,type=Path);args=ap.parse_args()
result=json.loads((args.directory/'result.json').read_text());checks=0
for sector in result['sectors']:
    for sample in sector['samples']:
        ep=sample['source'];A=endpoint(ep);C,U=A['C'],A['U']
        assert f5rank(phase_polynomials(ep))==2
        e1=K.sub(K.mul(C[1],U[3]),K.mul(C[2],U[2]))
        e2=K.sub(K.scale(K.mul(C[0],U[2]),14),K.mul(C[1],U[1]))
        assert e1==K.decode(sample['first_residual_original_code'])
        assert e2==K.decode(sample['second_residual_original_code'])
        checks+=1
assert checks==8 and result['sources']==602667
assert result['first_identity_zero']==result['second_identity_zero']==0
paths=[args.directory/'field.txt',args.directory/'supports.txt',
    Path(__file__).parent/'wg_coefficient_boundary_scan.cpp',Path(__file__).parent/'prepare_wg_boundary.py',
    ARCHIVE/'src/projective_core.hpp',args.directory/'result.json']
meta=dict(independent_original_field_samples=checks,checked_residuals=2*checks,
    all_source_counts=result['sources'],first_identity_zero=0,second_identity_zero=0,
    input_and_source_sha256={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
    scope='NEW source coefficient invariants only; no full mixed-incidence decision',status='PASS')
(args.directory/'verification.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
