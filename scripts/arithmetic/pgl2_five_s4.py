#!/usr/bin/env python3
"""Exact small certificate for the S4 projective subgroup in PGL2(F5)."""
import argparse
import itertools
import json
from pathlib import Path


def norm(a):
    a=tuple(x%5 for x in a)
    scale=pow(next(x for x in a if x),-1,5)
    return tuple(x*scale%5 for x in a)


def mul(a,b):
    return norm((a[0]*b[0]+a[1]*b[2],a[0]*b[1]+a[1]*b[3],
                 a[2]*b[0]+a[3]*b[2],a[2]*b[1]+a[3]*b[3]))


ONE=(1,0,0,1)


def order(g):
    h=ONE
    for n in range(1,121):
        h=mul(h,g)
        if h==ONE:return n
    raise AssertionError('order exceeds group size')


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    group={norm(a) for a in itertools.product(range(5),repeat=4)
           if (a[0]*a[3]-a[1]*a[2])%5}
    assert len(group)==120
    generators=[norm(a) for a in [(0,1,2,0),(1,1,1,4),(0,1,3,0)]]
    assert [order(g) for g in generators]==[2,2,2]
    assert order(mul(generators[0],generators[1]))==3
    assert order(mul(generators[1],generators[2]))==3
    assert order(mul(generators[0],generators[2]))==2
    seen={ONE};pending=[ONE]
    while pending:
        g=pending.pop()
        for h in generators:
            gh=mul(g,h)
            if gh not in seen:seen.add(gh);pending.append(gh)
    assert len(seen)==24 and seen<=group
    receipt={'status':'PASS','field':5,'ambient_order':120,
             'generators':generators,'generated_order':24,
             'coxeter_orders':[2,2,2,3,3,2],
             'conclusion':'The Coxeter A3 relations give a quotient of S4; order24 makes it S4.',
             'scope':'This checks an embedded subgroup. Conjugacy of all geometric S4 subgroups is the cited classification input.'}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS PGL2(F5) contains the displayed S4')


if __name__=='__main__':main()
