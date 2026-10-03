#!/usr/bin/env python3
"""Exact F_abs^*K(O) cup maps for all19683 cubic-invariant Pic0 twists.

Run using Sage Python. This does not cover noninvariant twists.
"""
import argparse
from collections import Counter
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    args=p.parse_args();start=time.time()
    k=GF(5**8,'b');r=PolynomialRing(k,'x');x=r.gen()
    alpha=(x**2-x-3).roots(multiplicities=False)[0]
    decode=lambda n:k(n%5)+(n//5)*alpha
    P=r([decode(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
    roots=sorted(P.roots(multiplicities=False),key=lambda t:tuple(t.polynomial()))
    assert len(roots)==10 and P.is_squarefree()
    codes=(2,16,16,7,1,2,7,1,24,11)
    C5=sum(decode(a)**5*x**(5*(9-i)) for i,a in enumerate(codes))
    base=C5*P**3
    histogram=Counter();bad=[];tested=0
    for digits in itertools.product(range(3),repeat=9):
        ss=digits+(0,);A=r.one();B=r.one()
        for root,s in zip(roots,ss):
            if s==1:A*=x-root
            if s==2:B*=x-root
        AB=A*B;denoms=[r.one(),B,AB];weight=int(A.degree()+2*B.degree())
        factors=[B,A,P//AB];source=kernel=0;blocks=[]
        for j in range(3):
            target=(j+1)%3
            upper=(31-weight-10*j+3*int(denoms[j].degree()))//3
            target_upper=(-24-weight-10*target+3*int(denoms[target].degree()))//3
            ncols=max(0,upper+1)
            polynomial=base*factors[j];rows=range(target_upper+1,0)
            mm=matrix(k,len(rows),ncols,[polynomial[n-i+50] if n-i+50>=0 else k.zero()
                                      for n in rows for i in range(ncols)])
            rank=int(mm.rank());source+=ncols;kernel+=ncols-rank
            blocks.append([len(rows),ncols,rank])
        assert source==23
        histogram[kernel]+=1;tested+=1
        if kernel:bad.append({'digits':ss,'kernel':kernel,'blocks':blocks})
        if tested%4096==0:print('tested',tested,'nonzero kernels',len(bad),flush=True)
    assert tested==19683
    result={'status':'COMPLETED','scope':'All geometric cubic-invariant Pic0 classes represented by the19683 branch divisors; noninvariant classes are not covered.',
        'curve_P_codes':list((11,22,18,5,19,20,15,16,9,22,1)),
        'field_modulus':[int(a) for a in k.modulus().list()],
        'F25_generator':[int(a) for a in alpha.polynomial().list()],
        'ordered_roots':[[int(a) for a in v.polynomial().list()] for v in roots],
        'source_line_degree':31,'target_line_degree':-24,'character_shift':1,'O_shift':1,
        'tested':tested,'kernel_histogram':dict(histogram),'nonzero_cases':bad,'seconds':time.time()-start}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('COMPLETE:',tested,'twists; kernel histogram',dict(histogram),flush=True)

if __name__=='__main__':main()
