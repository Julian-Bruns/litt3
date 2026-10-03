#!/usr/bin/env python3
"""Serialize globally valid last source rows, including H=0."""
import argparse,json,sys,time
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from concentrated_source_ranks import eliminate
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();data=args.work/'data';start=time.time();k=Field(args.work/'cache');p=Poly(k)
ranks=json.loads((data/'concentrated_source_ranks.json').read_text());family=json.loads((data/'concentrated_d10m6_source_family.json').read_text());out=[]
for source in family['records']:
    root=source['root'];model=next(r for r in ranks['records'] if (r['root_K_code'],r['d'],r['m'])==(root,10,6));rows=model['polynomial_matrix'];reduced=eliminate(p,rows,True);index=reduced['pivot_columns'].index(16);target=reduced['row_echelon'][index];weights=reduced['row_transform'][index]
    assert target[0]==source['R'] and target[16]==source['H'] and target[17]==source['C'];assert not any(target[j] for j in range(18) if j not in (0,16,17))
    for col in range(18):
        total=[]
        for number,row in zip(weights,rows):total=p.add(total,p.mul(number,row[col]))
        assert total==target[col]
    aa,bb=source['H_R_bezout'];assert p.add(p.mul(aa,source['H']),p.mul(bb,source['R']))==[1]
    assert p.mul(source['C_over_H'],source['H'])==source['C']
    out.append({'root':root,'original_rows':rows,'row_weights':weights,'target':target,'H_R_bezout':source['H_R_bezout'],'C_over_H':source['C_over_H'],'literal_identity_checks':'PASS'})
    print('BOUNDARY_PASS',root,'SECONDS',time.time()-start,flush=True)
(data/'concentrated_d10m6_source_boundary_verification.json').write_text(json.dumps({'scope':'globally valid sourceHrow and HRunit witnesses; no slope denominator','records':out},separators=(',',':'))+'\n')
