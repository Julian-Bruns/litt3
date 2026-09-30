#!/usr/bin/env python3
"""Test every pair retained by the complete odd-scalar endpoint matching.

The input matching list is necessary, not sufficient. The exact old
linear/quadric reduction covers all K-valued moment pairs; retain any
positive-dimensional case explicitly. No integer pole weights are assumed.
"""
import argparse
import csv
import hashlib
import json
import time
from collections import Counter
from pathlib import Path

from klein_four_general_fourth_traces import F, M, residuals


def run(source, output):
    start=time.time();counts=Counter();unresolved=[];points=[]
    with source.open() as f:
        rows=list(csv.DictReader(f,delimiter='\t'))
    for i,row in enumerate(rows):
        q=[int(row['q'+str(j)]) for j in range(4)]
        h=[int(row['h'+str(j)]) for j in range(4)]
        cert=M.analyze(q,h);counts[cert['status']]+=1
        if cert['status'] in ['positive_dimensional_affine_quadric','affine_quadric_retained']:
            unresolved.append(dict(Q=q,H=h,certificate=cert))
        for p in cert.get('tested_isolated_points',[]):
            if not p['valid_nonzero_scale']:continue
            ep=tuple(p['epsilon'])
            odd=F.sigma(F.sigma(ep))==F.fn(ep)
            rs=residuals(q,h,tuple(p['x_M2']),tuple(p['y_M6']),ep)
            points.append(dict(Q=q,H=h,point=p,odd_scalar=odd,
                               fourth_residuals=rs,passes=odd and all(r==F.F0 for r in rs)))
        if (i+1)%50==0:
            print('Checked',i+1,'pairs; unresolved',len(unresolved),'old points',len(points),flush=True)
    result=dict(status='COMPLETE',scope='All two-sided endpoint matches for trace-zero quartic scalar, old moments and both fourth traces',
                source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                endpoint_pairs=len(rows),status_counts=dict(counts),unresolved=unresolved,
                isolated_points=points,survivors=sum(p['passes'] for p in points),elapsed=time.time()-start)
    output.write_text(json.dumps(result,indent=2)+'\n')
    print('COMPLETE',len(rows),'pairs;',len(unresolved),'unresolved;',len(points),'old points;',
          result['survivors'],'survivors; seconds',round(result['elapsed'],3))


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('source',type=Path);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();run(a.source,a.output)
