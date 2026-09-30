#!/usr/bin/env sage -python
"""Exploratory universal second-height determinantal coefficient matrix.

This computes a polynomial condition over F5[T], rather than searching
parameter points. The current experiment treats one selected block.
No geometric theorem is asserted by this driver.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--twist',choices=['trivial','fixed_pair','moving_pair'],default='fixed_pair')
    ap.add_argument('--part',type=int,choices=[0,1],default=1)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    started=time.monotonic();P=PolynomialRing(GF(5),'T');T=P.gen();k=P.fraction_field()
    U=PolynomialRing(k,'u');u=U.gen();F=u*(u-1)*(u-2)*(u-3)*(u-T)
    twist={'trivial':U(1),'fixed_pair':u*(u-3),'moving_pair':u-T}[args.twist]
    block=build_polynomial_blocks(F,twist,25)[args.part]
    matrices=block['matrices'];n=matrices[0].ncols()
    R=PolynomialRing(GF(5),names=['l0','l1','l2','T']);l0,l1,l2,tt=R.gens();ls=[l0,l1,l2]
    def lift(c):
        c=k(c);assert c.denominator()==1
        return R(c.numerator()(tt))
    M=matrix(R,n+2,n,[sum(ls[h]*lift(matrices[h][i,j]) for h in range(3))
                      for i in range(n+2) for j in range(n)])
    powers=[tuple(e) for e in IntegerVectors(n,3)]
    rows=[];minor_terms=[]
    print('block',args.twist,args.part,'columns',n,'coefficient matrix',len(powers),flush=True)
    for index,ids in enumerate(itertools.combinations(range(n+2),n)):
        minor=M.matrix_from_rows(ids).det()
        row={e:P(0) for e in powers}
        for ex,c in minor.dict().items():row[tuple(ex[:3])]+=P(c)*T**ex[3]
        rows.append([row[e] for e in powers]);minor_terms.append(len(minor.dict()))
        if index%5==0:print('minor',index,'seconds',float(time.monotonic()-started),flush=True)
    coefficient=matrix(P,rows)
    print('computing univariate determinant',coefficient.nrows(),flush=True)
    determinant=coefficient.det();assert determinant
    factors=[dict(polynomial=str(f.monic()),degree=int(f.degree()),multiplicity=int(e)) for f,e in determinant.factor()]
    result=dict(status='exploratory_symbolic_block',twist=args.twist,part=args.part,columns=n,
                coefficient_matrix_size=len(powers),minor_term_counts=minor_terms,
                degree=int(determinant.degree()),factors=factors,
                determinant=str(determinant),seconds=float(time.monotonic()-started),
                source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                builder_sha256=hashlib.sha256(Path(__file__).with_name('pointed_frobenius_polynomial.py').read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('degree',result['degree'],'factors',[(x['degree'],x['multiplicity']) for x in factors],flush=True)


if __name__=='__main__':main()
