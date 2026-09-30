#!/usr/bin/env python3
"""Independent absolute-field check of every radius-three Lee-ball collision."""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path);args=ap.parse_args()
    start=time.monotonic();K=GF(5**14,'z');R=PolynomialRing(K,'t');t=R.gen()
    beta=(t*t-t-3).roots(multiplicities=False)[0]
    dec=lambda c:K(c%5)+K(c//5)*beta
    xi=K.multiplicative_generator()**((5**14-1)//29)
    assert xi**29==1 and xi!=1
    words=[()]
    words.extend(((i,a),) for i in range(29) for a in [1,2,3,4])
    words.extend(((i,a),(j,b)) for i,j in itertools.combinations(range(29),2)
                 for a,b in itertools.product([1,2,3,4],repeat=2)
                 if min(a,5-a)+min(b,5-b)<=3)
    words.extend(tuple(zip(ijk,abc)) for ijk in itertools.combinations(range(29),3)
                 for abc in itertools.product([1,4],repeat=3))
    assert len(words)==34221
    rows=[]
    for s in range(1,25):
        cols=[dec(s)*xi**(17*j%29)-xi**(4*j%29) for j in range(29)]
        seen={};collisions=0
        for word in words:
            image=sum((a*cols[i] for i,a in word),K.zero())
            if image not in seen:seen[image]=word;continue
            collisions+=1;old=dict(seen[image]);new=dict(word)
            assert all(old.get(i,0)==new.get(i,0) for i in range(1 if s==1 else 0,29))
        rows.append(dict(scalar=s,distinct=len(seen),collisions=collisions))
    assert rows[0]['collisions']==3364 and all(r['collisions']==0 for r in rows[1:])
    result=dict(status='PASS',ball_size=len(words),rows=rows,seconds=time.monotonic()-start,
                method='independent absolute F5^14 arithmetic and complete Lee-ball dictionary')
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)

if __name__=='__main__':main()
