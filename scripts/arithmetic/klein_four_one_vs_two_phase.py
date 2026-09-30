#!/usr/bin/env python3
"""One common phase against exactly two phases: complete necessary test.

Save only exceptional cases, summary counts and a deterministic digest;
all linear exclusions can be regenerated from this source. Balanced first
endpoints are already excluded by the separate theorem and are omitted.
"""
import argparse
import hashlib
import itertools
import json
import time
from collections import Counter
from functools import lru_cache
from pathlib import Path
from klein_four_general_fourth_traces import F, M, residuals


def main(path):
    start=time.time();cached_sums=lru_cache(maxsize=20000)(M.sums)
    M.sums=lambda labels:cached_sums(tuple(labels))
    counts=lambda n:[v for v in itertools.product(range(n+1),repeat=4) if sum(v)==n]
    first=[v for v in counts(4) if v==min(v[i:]+v[:i] for i in range(4)) and v!=(1,1,1,1)]
    splits=[(a,b) for n in [1,2,3] for a in counts(n) for b in counts(4-n)]
    pairs=[];covered=set()
    for p,r in itertools.combinations(range(29),2):
        if (p,r) in covered:continue
        orbit={tuple(sorted([p*pow(25,i,29)%29,r*pow(25,i,29)%29])) for i in range(7)}
        assert not covered.intersection(orbit);covered.update(orbit);pairs.append((p,r))
    assert len(first)==9 and len(splits)==260 and len(pairs)==58 and len(covered)==406
    out=dict(status='RUNNING',scope='One common-phase endpoint, other endpoint exactly two phases',
             first_type_representatives=first,phase_pair_representatives=pairs,
             total_cases=135720,completed=0,status_counts={},unresolved=[],survivors=[],isolated=[])
    tally=Counter();digest=hashlib.sha256()
    for iq,qc in enumerate(first):
        q=[29*i for i,n in enumerate(qc) for _ in range(n)]
        for p,r in pairs:
            for ac,bc in splits:
                h=sorted([29*i+p for i,n in enumerate(ac) for _ in range(n)]+
                         [29*i+r for i,n in enumerate(bc) for _ in range(n)])
                cert=M.analyze(q,h);status=cert['status'];tally[status]+=1
                digest.update(json.dumps([q,h,status,cert['rank']],separators=(',',':')).encode()+b'\n')
                if status in ['positive_dimensional_affine_quadric','affine_quadric_retained']:
                    out['unresolved'].append(dict(q=q,h=h,certificate=cert))
                for point in cert.get('tested_isolated_points',[]):
                    if not point['valid_nonzero_scale']:continue
                    rs=residuals(q,h,tuple(point['x_M2']),tuple(point['y_M6']),tuple(point['epsilon']))
                    entry=dict(q=q,h=h,point=point,fourth_residuals=rs)
                    out['isolated'].append(entry)
                    if all(v==F.F0 for v in rs):out['survivors'].append(entry)
                out['completed']+=1
        out.update(status_counts=dict(tally),case_digest=digest.hexdigest(),elapsed=time.time()-start)
        path.write_text(json.dumps(out,indent=2)+'\n')
        print('first',iq+1,'/9; tested',out['completed'],'isolated',len(out['isolated']),
              'unresolved',len(out['unresolved']),'survivors',len(out['survivors']),
              'seconds',round(out['elapsed'],1),flush=True)
    assert out['completed']==out['total_cases']
    out.update(status='COMPLETE',elapsed=time.time()-start)
    path.write_text(json.dumps(out,indent=2)+'\n')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    main(p.parse_args().output)
