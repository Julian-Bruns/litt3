#!/usr/bin/env python3
"""All type multiplicities when each endpoint has one common label phase.

Retain all positive-dimensional moment loci. Only exact isolated moment
solutions are rejected with the necessary fourth trace identities here.
"""
import argparse
import json
import time
from pathlib import Path
from klein_four_general_fourth_traces import F, M, residuals


def main(path):
    start=time.time()
    counts=[(a,b,c,4-a-b-c) for a in range(5) for b in range(5-a) for c in range(5-a-b)]
    rot=lambda t,i:t[i:]+t[:i]
    reps=[c for c in counts if c==min(rot(c,i) for i in range(4))]
    assert len(counts)==35 and len(reps)==10
    phases=[0,1,2,4,8]
    assert {p*pow(25,i,29)%29 for p in phases for i in range(7)}==set(range(29))
    out=dict(status='RUNNING',scope='One phase at each endpoint, all type multiplicities',
             first_type_representatives=reps,phases=phases,cases=[],unresolved=[],survivors=[])
    for qi,qcounts in enumerate(reps):
        q=[29*i for i,n in enumerate(qcounts) for _ in range(n)]
        for hcounts in counts:
            for phase in phases:
                h=[29*i+phase for i,n in enumerate(hcounts) for _ in range(n)]
                cert=M.analyze(q,h)
                row=dict(q=q,h=h,status=cert['status'],rank=cert['rank'],points=[])
                if cert['status'] in ['positive_dimensional_affine_quadric','affine_quadric_retained']:
                    out['unresolved'].append(dict(q=q,h=h,certificate=cert))
                for p in cert.get('tested_isolated_points',[]):
                    if not p['valid_nonzero_scale']:continue
                    rs=residuals(q,h,tuple(p['x_M2']),tuple(p['y_M6']),tuple(p['epsilon']))
                    entry=dict(point=p['point'],epsilon=p['epsilon'],fourth_residuals=rs)
                    row['points'].append(entry)
                    if all(r==F.F0 for r in rs):out['survivors'].append(dict(q=q,h=h,**entry))
                out['cases'].append(row)
        out['elapsed']=time.time()-start;path.write_text(json.dumps(out,indent=2)+'\n')
        print('first type',qi+1,'/10; cases',len(out['cases']),'unresolved',len(out['unresolved']),
              'survivors',len(out['survivors']),'seconds',round(out['elapsed'],2),flush=True)
    out.update(status='COMPLETE',elapsed=time.time()-start)
    path.write_text(json.dumps(out,indent=2)+'\n')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    main(p.parse_args().output)
