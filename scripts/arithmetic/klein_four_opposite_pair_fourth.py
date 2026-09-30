#!/usr/bin/env python3
"""Two opposite-type pairs at each endpoint, allowing distinct phases.

Each endpoint is fixed by the square of root-type rotation. Common-phase
first endpoints are handled by separate results; this run covers all
mixed-phase first endpoints after complete phase/root normalization.
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
    start=time.time();cached=lru_cache(maxsize=2000)(M.sums)
    M.sums=lambda labels:cached(tuple(labels))
    pairs=[(29*i+j,29*(i+2)+j) for i in range(2) for j in range(29)]
    second=[tuple(sorted(a+b)) for a,b in itertools.combinations_with_replacement(pairs,2)]
    assert len(second)==len(set(second))==1711
    out=dict(status='RUNNING',scope='Both endpoint multisets fixed by square root-type rotation, first has two phases',
             total_cases=13688,completed=0,status_counts={},unresolved=[],isolated_count=0,
             survivors=[],families=[])
    tally=Counter();digest=hashlib.sha256()
    for parity in range(2):
        for phase in [1,2,4,8]:
            q=sorted([0,58,29*parity+phase,29*(parity+2)+phase]);family=Counter()
            for h in second:
                cert=M.analyze(q,h);status=cert['status'];tally[status]+=1;family[status]+=1
                digest.update(json.dumps([q,h,status,cert['rank']],separators=(',',':')).encode()+b'\n')
                if status in ['positive_dimensional_affine_quadric','affine_quadric_retained']:
                    out['unresolved'].append(dict(q=q,h=h,certificate=cert))
                for p in cert.get('tested_isolated_points',[]):
                    if not p['valid_nonzero_scale']:continue
                    out['isolated_count']+=1
                    rs=residuals(q,h,tuple(p['x_M2']),tuple(p['y_M6']),tuple(p['epsilon']))
                    if all(r==F.F0 for r in rs):out['survivors'].append(dict(q=q,h=h,point=p))
                out['completed']+=1
            out['families'].append(dict(parity=parity,phase=phase,status_counts=dict(family)))
            out.update(elapsed=time.time()-start,status_counts=dict(tally),case_digest=digest.hexdigest())
            path.write_text(json.dumps(out,indent=2)+'\n')
            print(parity,phase,'tested',out['completed'],'isolated',out['isolated_count'],
                  'unresolved',len(out['unresolved']),'survivors',len(out['survivors']),
                  'seconds',round(out['elapsed'],1),flush=True)
    assert out['completed']==out['total_cases']
    out.update(status='COMPLETE',elapsed=time.time()-start)
    path.write_text(json.dumps(out,indent=2)+'\n')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    main(p.parse_args().output)
