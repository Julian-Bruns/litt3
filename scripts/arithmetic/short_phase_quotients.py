#!/usr/bin/env python3
"""Exact quotients of two power sums with <=3 phases and F5 weights."""
import argparse,itertools,json,time,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent/'pro_mixed_quintic_20260927/src'))
from exact import F,Extension

def main():
    p=argparse.ArgumentParser();p.add_argument('output',type=Path);a=p.parse_args();start=time.monotonic()
    K=Extension([4,22,7,20,21,7,24,1]);z=K.element([0,1]);phase=[K.pow(z,i) for i in range(29)]
    assert K.pow(z,29)==K.one
    found=[];counts={}
    for size in [1,2,3]:
        count=0
        for support in itertools.combinations(range(29),size):
            for tail in itertools.product(range(1,5),repeat=size-1):
                weights=(1,)+tail;X=K.zero;Y=K.zero
                for j,w in zip(support,weights):
                    X=K.add(X,tuple(F.mul(w,c) for c in phase[17*j%29]))
                    Y=K.add(Y,tuple(F.mul(w,c) for c in phase[4*j%29]))
                pivot=next(i for i,c in enumerate(X) if c)
                scale=F.div(Y[pivot],X[pivot]);count+=1
                if tuple(F.mul(scale,c) for c in X)==Y:
                    found.append(dict(support=support,weights=weights,ratio_Y_X=scale))
        counts[size]=count
    data=dict(status='EXHAUSTIVE_F5_WEIGHTED_SUPPORTS_AT_MOST_THREE',counts=counts,solutions=found,seconds=time.monotonic()-start)
    a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(data,indent=2)+'\n')
    print('COUNTS',counts,'SOLUTIONS',len(found),flush=True)
    for r in found[:25]:print(r,flush=True)

if __name__=='__main__':main()
