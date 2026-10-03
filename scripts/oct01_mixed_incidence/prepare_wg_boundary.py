#!/usr/bin/env python3
"""Only regenerate compact marked field and support input for NEW identities."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence')
sys.path.insert(0,str(ARCHIVE/'src'))
from support_gap_orbits import affine_representatives_free,phases
ap=argparse.ArgumentParser();ap.add_argument('--output-dir',required=True,type=Path);args=ap.parse_args();args.output_dir.mkdir(parents=True,exist_ok=True)
field=json.loads((ARCHIVE/'evidence/projective_branch/input_metadata.json').read_text())['field']
lines=['PROJECTIVE 1',' '.join(map(str,field['L_modulus_ascending']))]
lines+=[' '.join(map(str,r)) for r in field['roots_L_polynomial_codes']]
lines+=[' '.join(map(str,field['quadratic_tower_to_original_basis'])),'0']+['0']*7
(args.output_dir/'field.txt').write_text('\n'.join(lines)+'\n')
lines=[]
for n in (4,5,6):
    supports=[phases(mask) for mask in affine_representatives_free(n)]
    lines.append(f'{n} {len(supports)}');lines+=[' '.join(map(str,S)) for S in supports]
(args.output_dir/'supports.txt').write_text('\n'.join(lines)+'\n')
