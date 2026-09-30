#!/usr/bin/env python3
"""Independent literal multiplication checks for the small-shift cup maps."""
import argparse
import itertools
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input',type=Path);ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();data=json.loads(args.input.read_text())
    assert sum(data['kernel_histogram'].values())==19683 and not data['nonzero_cases']
    prime=GF(5);k=GF(5**8,'b',modulus=PolynomialRing(prime,'t')(data['coefficient_field_modulus']))
    b=k.gen();lift=lambda row:sum(k(v)*b**i for i,v in enumerate(row))
    alpha=lift(data['F25_generator']);assert alpha**2==alpha+3
    decode=lambda v:k(v%5)+(v//5)*alpha
    R=PolynomialRing(k,'x');x=R.gen()
    P=R([decode(v) for v in (11,22,18,5,19,20,15,16,9,22,1)])
    roots=list(map(lift,data['roots']));assert len(set(roots))==10 and all(not P(r) for r in roots)
    C=R([decode(v) for v in reversed((2,16,16,7,1,2,7,1,24,11))])
    checks=[];hist={};shift=data['shift']
    for ds in itertools.product(range(3),repeat=9):
        ds=ds+(0,);A=R.one();B=R.one()
        for r,s in zip(roots,ds):
            if s==1:A*=x-r
            if s==2:B*=x-r
        den=[R.one(),B,A*B];weight=sum(ds)
        bounds=[(6+shift-weight-10*j+3*den[j].degree())//3 for j in range(3)]
        size=sum(max(0,int(v)+1) for v in bounds)
        if not size or hist.get(size,0)>=8:continue
        blocks=[]
        for j in range(3):
            target=(j+2)%3
            num=C*P**((j+2)//3)*den[target]
            polynomial,remainder=num.quo_rem(den[j]);assert not remainder
            lower=(-5+shift-weight-10*target+3*den[target].degree())//3
            rows=range(int(lower)+1,0);n=max(0,int(bounds[j])+1)
            M=matrix(prime,8*len(rows),8*n)
            for ri,r in enumerate(rows):
                for ci in range(n):
                    v=polynomial[r-ci+10] if r-ci+10>=0 else k.zero()
                    for col in range(8):
                        row=(v*b**col).polynomial()
                        for digit in range(8):M[8*ri+digit,8*ci+col]=row[digit]
            rank=int(M.rank());assert rank==8*n
            blocks.append([len(rows),n,rank])
        hist[size]=hist.get(size,0)+1
        checks.append({'digits':ds,'source_dimension':size,'prime_field_blocks':blocks})
        if all(hist.get(int(size),0)>=min(8,count) for size,count in data['source_histogram'].items() if int(size)):
            break
    receipt={'status':'PASS','scope':'Independent literal rational-function multiplication and restriction-of-scalars checks, covering every nonzero source dimension; complete coverage remains the separate enumeration.',
             'shift':shift,'histogram':hist,'checks':checks}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS',len(checks),'independent full maps',hist,flush=True)


if __name__=='__main__':main()
