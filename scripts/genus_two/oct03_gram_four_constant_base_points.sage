#!/usr/bin/env sage
"""Find exact F125 points in the named b4=0 simplifying slice."""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--input',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(60)
start=time.monotonic()
R,Rx,k,H,h,det,rows=load(args.input)
alpha=k.gen()
points=[]
checked=0
for a2 in k:
    if not a2: continue
    a2sq=a2^2
    for a0 in k:
        checked+=1
        b0=(a0^2+(2*alpha-2)*a0*a2+(alpha^2+alpha-1)/a2sq
            +(-2*alpha^2+alpha+1))/2
        if a0^2*a2sq+b0^4-2*a2sq*b0+(alpha^2+alpha-1): continue
        if a0*a2^3+(alpha^2+alpha+2)*b0^4+(-alpha+2)*a2sq: continue
        if a0^4+(alpha^2+2*alpha)*b0^4-2*a0^2*b0-2*b0^2: continue
        values=(a0,0,a2,0,b0,0,0,0,0,2*a2)
        evaluate=R.hom(values,k)
        if any(evaluate(eq) for ch,j,eq in rows): continue
        points.append(values)
summary={'scope':'bounded F125 points ONLY in a1=a3=b1=b2=b3=b4=0 slice',
         'checked':checked,'point_count':len(points),
         'points':[[str(z) for z in row] for row in points],
         'elapsed_seconds':time.monotonic()-start,
         'status':'exact_global_rank_at_most_three_section_points' if points
                  else 'no_F125_point_in_this_slice'}
save((k,points),args.output+'.sobj')
Path(args.output+'.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
