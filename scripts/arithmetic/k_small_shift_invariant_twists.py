#!/usr/bin/env python3
"""Exact invariant Pic0 twists of K(sO), for small shifts s=0..4.

A nonzero invariant section is retained as an obstruction to vanishing,
not called an etale realization. The negative extension line has no
sections in this range, so the connecting kernel is the section space.
"""
import argparse
from collections import Counter
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--shift',type=int,choices=range(5),required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();start=time.time()
    k=GF(5**8,'b');R=PolynomialRing(k,'x');x=R.gen()
    a=(x*x-x-3).roots(multiplicities=False)[0]
    decode=lambda n:k(n%5)+(n//5)*a
    P=R([decode(v) for v in (11,22,18,5,19,20,15,16,9,22,1)])
    roots=sorted(P.roots(multiplicities=False),key=lambda v:tuple(v.polynomial()))
    assert len(roots)==10 and P.is_squarefree()
    C=R([decode(v) for v in reversed((2,16,16,7,1,2,7,1,24,11))])
    histogram=Counter();sources=Counter();bad=[]
    for digits in itertools.product(range(3),repeat=9):
        digits=digits+(0,);A=R.one();B=R.one()
        for root,digit in zip(roots,digits):
            if digit==1:A*=x-root
            if digit==2:B*=x-root
        den=[R.one(),B,A*B];w=A.degree()+2*B.degree()
        factors=[A*B,P//B,P//A]
        dim=0;size=0;blocks=[]
        for j in range(3):
            target=(j+2)%3
            upper=(6+args.shift-w-10*j+3*den[j].degree())//3
            low=(-5+args.shift-w-10*target+3*den[target].degree())//3
            n=max(0,upper+1);rows=range(low+1,0)
            polynomial=C*factors[j]
            M=matrix(k,len(rows),n,[polynomial[r-i+10] if r-i+10>=0 else 0
                                  for r in rows for i in range(n)])
            rank=M.rank();dim+=n-rank;size+=n
            blocks.append([len(rows),int(n),int(rank)])
        histogram[int(dim)]+=1;sources[int(size)]+=1
        if dim:bad.append({'digits':digits,'dimension':int(dim),'blocks':blocks})
    assert sum(histogram.values())==19683
    out={'status':'COMPLETE','shift':args.shift,'scope':'All19683 geometric C3-invariant Pic0 classes only.',
         'coefficient_field_modulus':[int(v) for v in k.modulus().list()],
         'F25_generator':[int(v) for v in a.polynomial().list()],
         'roots':[[int(v) for v in root.polynomial().list()] for root in roots],
         'kernel_histogram':dict(histogram),'source_histogram':dict(sources),
         'nonzero_cases':bad,'seconds':time.time()-start}
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('COMPLETE shift',args.shift,'kernel',dict(histogram),'sources',dict(sources),flush=True)


if __name__=='__main__':main()
