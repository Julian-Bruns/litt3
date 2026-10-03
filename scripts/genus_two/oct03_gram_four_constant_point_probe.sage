#!/usr/bin/env sage
"""Exact small point probe in a named slice; no global common-cover claim."""
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
extension=GF(125^2,name='gamma')
embedding=k.embeddings(extension)[0]
# This slice has a0=a1=a3=b1=b2=b3=b4=0 and b5=2*a2.
# Two necessary coefficients force the displayed squared values.
b0_square=2/(alpha^2+2*alpha)
b0_fourth=b0_square^2
a2_square=-b0_fourth/(2*alpha^2-alpha-1)
results=[]
for b0 in embedding(b0_square).sqrt(all=True):
    for a2 in embedding(a2_square).sqrt(all=True):
        images=(0,0,a2,0,b0,0,0,0,0,2*a2)
        evaluate=R.hom(tuple(extension(z) for z in images),extension,
                       base_map=embedding)
        nonzero=[(ch,int(j)) for ch,j,eq in rows if evaluate(eq)]
        results.append({'a2':str(a2),'b0':str(b0),
                        'all_equations_zero':not nonzero,
                        'nonzero_coefficients':nonzero})
summary={'scope':'ONLY four points in specified a0=a1=b4=0 slice',
         'extension':str(extension),'embedding_alpha':str(embedding(alpha)),
         'b0_square':str(b0_square),'a2_square':str(a2_square),
         'results':results,'elapsed_seconds':time.monotonic()-start}
Path(args.output).write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
