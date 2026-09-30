#!/usr/bin/env python3
"""Independently test the original H-row module, without idealization."""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix, singular


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('tensor',type=Path)
    ap.add_argument('--source-stratum',type=int,choices=range(10),required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    tensor=np.load(args.tensor,allow_pickle=False)['H']
    assert tensor.shape==(30,15,10)
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'w')([2,4,1]))
    dec=lambda c:k(int(c)%5)+k(int(c)//5)*k.gen()
    j=args.source_stratum
    names=[f'b{i}' for i in range(j+1,10)]
    R=PolynomialRing(k,names,order='degrevlex')
    b=[R.zero() if i<j else R.one() if i==j else R(f'b{i}') for i in range(10)]
    H=matrix(R,30,15,[sum(dec(tensor[r,c,i])*b[i] for i in range(10))
                      for r in range(30) for c in range(15)])
    receipt=dict(status='RUNNING',source_stratum=j,variables=names,
                 input_sha256=hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
                 scope='Direct F25 Singular module standard basis of actual H rows, with no square-zero ideal or radical.')
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    start=time.time();m=singular(H.transpose())
    print('DIRECT MODULE',j,'variables',len(names),flush=True)
    singular.eval(f'module inputH={m.name()};module basisH=std(inputH);')
    remainder=singular.eval('reduce(freemodule(15),basisH)')
    full=int(singular.eval('size(reduce(freemodule(15),basisH))'))==0
    receipt.update(status='COMPLETE',full_row_module=full,
                   basis_size=int(singular.eval('size(basisH)')),
                   seconds=time.time()-start,remainder=remainder,
                   basis=singular.eval('basisH'))
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('COMPLETE',full,receipt['seconds'],flush=True)


if __name__=='__main__':main()
