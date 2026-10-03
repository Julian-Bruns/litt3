#!/usr/bin/env sage
"""Focused literal source-boundary and new norm-tail identity verification."""
from sage.all import *
import argparse,json,sys,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--roots',default='145049,211895,211959');args=ap.parse_args();start=time.time()
archive=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(archive/'src'))
from exact import Field,Poly
from concentrated_source_ranks import eliminate
data=args.work/'data';k=Field(args.work/'cache');p=Poly(k)
ranks=json.loads((data/'concentrated_source_ranks.json').read_text())
family=json.loads((data/'concentrated_d0_source_family.json').read_text());records=[]
for root in map(int,args.roots.split(',')):
    model=next(r for r in ranks['records'] if (r['root_K_code'],r['d'],r['m'])==(root,0,12))
    source=next(r for r in family['records'] if r['root_K_code']==root)
    rows=model['polynomial_matrix'];reduced=eliminate(p,rows,True)
    index=reduced['pivot_columns'].index(13)
    target=reduced['row_echelon'][index];weights=reduced['row_transform'][index]
    for col in range(14,18):
        unit=next(i for i,row in enumerate(rows) if row[col]==[1] and all(not row[j] for j in range(18) if j!=col))
        weights[unit]=p.sub(weights[unit],target[col]);target[col]=[]
    assert target[13]==source['common_denominator'] and target[0]==p.neg(source['v0_numerator'])
    assert all(not target[col] for col in range(18) if col not in (0,13))
    for col in range(18):
        value=[]
        for coefficient,row in zip(weights,rows):value=p.add(value,p.mul(coefficient,row[col]))
        assert value==target[col]
    cert=load(str(data/f'concentrated_d0_norm_square_tails_{root}.sobj'))
    g=cert['gcd'];unit=cert['unit'];m=cert['unit_power_bound']
    assert g and unit and cert['remaining_gcd'].degree()==0
    assert sum((a*f for a,f in zip(cert['bezout_multipliers'],cert['tails'])),g.parent().zero())==g
    assert g*cert['unit_power_quotient']==unit**m
    records.append({'root':root,'source_boundary_original_rows':rows,'source_boundary_row_weights':weights,
                    'source_boundary_target':target,'tail_indices':cert['tail_indices'],
                    'tail_degrees':[int(f.degree()) for f in cert['tails']],
                    'gcd_degree':int(g.degree()),'unit_power_bound':m,'literal_checks':'PASS'})
    print('ROOT_PASS',root,'SECONDS',time.time()-start,flush=True)
(data/'concentrated_d0_focused_identity_checks.json').write_text(json.dumps({'scope':'new source-boundary witness and literal norm-tail certificates only; no settled audited program replay','records':records},separators=(',',':'))+'\n')
