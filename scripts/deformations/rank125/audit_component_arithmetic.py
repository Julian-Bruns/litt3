#!/usr/bin/env python3
"""Independent finite checks of the returned exact convolution's native ABI.

The comparison uses plain Python integer products and polynomial reductions,
without Kronecker packing or the returned multiplication for its expected
answers. A proof of the packing bound is recorded in the canonical proof.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import random
import sys


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--modulus',type=int,choices=(625,3125,15625),required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[3]
    assert not args.output.resolve().is_relative_to(root)
    os.environ['LITT3_REFERENCE_MODULUS']=str(args.modulus)
    os.environ['LITT3_REFERENCE_PRECISION']='256'
    sys.path.insert(0,str(args.engine_dir.resolve()))
    import numpy as np
    import batch_witt as b
    import neutral5_gmp_convolution as simple
    m=args.modulus
    rng=random.Random(14625)

    def product(a,c):
        nc=max(a.shape[0],c.shape[0]);na=a.shape[-1];nb=c.shape[-1]
        out=np.zeros((nc,12,na+nb-1),dtype=np.int64)
        for k in range(nc):
            raw=[[[0]*(na+nb-1) for _ in range(5)] for _ in range(7)]
            aa=a[0 if len(a)==1 else k];bb=c[0 if len(c)==1 else k]
            for ia in range(12):
                ja,ta=divmod(ia,3)
                for ib in range(12):
                    jb,tb=divmod(ib,3)
                    for x in range(na):
                        for y in range(nb):raw[ja+jb][ta+tb][x+y]+=int(aa[ia,x])*int(bb[ib,y])
            for j in range(7):
                for t in (4,3):
                    for n in range(na+nb-1):
                        raw[j][t-2][n]-=raw[j][t][n]
                        raw[j][t-3][n]-=raw[j][t][n]
            for j in (6,5,4):
                for t in range(3):
                    for n in range(na+nb-1):raw[j-4][t][n]+=b.TEICH2*raw[j][t][n]
            for j in range(4):
                for t in range(3):out[k,j*3+t]=[x%m for x in raw[j][t]]
        return out

    cases=[]
    for ca,cb,na,nb,dense in [(1,1,4,5,True),(1,35,2,3,False),(35,1,3,2,False),(35,35,2,2,False)]:
        a=np.array([m-1 if dense else rng.randrange(m) for _ in range(ca*12*na)],dtype=np.int64).reshape(ca,12,na)
        c=np.array([m-1 if dense else rng.randrange(m) for _ in range(cb*12*nb)],dtype=np.int64).reshape(cb,12,nb)
        expected=product(a,c)
        assert np.array_equal(b.multiply(a,c),expected)
        assert np.array_equal(b.multiply(a,c,no=2),expected[:,:,:2])
        x=b.Ser(a);y=b.Ser(c)
        assert ((x*y).sigma()-x.sigma()*y.sigma()).iszero()
        cases.append({'component_axes':[ca,cb],'lengths':[na,nb],'all_coefficients_maximal':dense,
                      'full_and_truncated_products_equal':True,'Frobenius_multiplicative':True})
    for na,nb in [(1,1),(7,9),(31,19)]:
        a=[rng.randrange(m) for _ in range(na)];c=[rng.randrange(m) for _ in range(nb)]
        expected=[sum(a[i]*c[k-i] for i in range(na) if 0<=k-i<nb) for k in range(na+nb-1)]
        assert list(map(int,simple.conv(a,c)))==expected
    sources={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
             [Path(__file__),args.engine_dir/'exact_batch_conv.cpp',args.engine_dir/'batch_witt.py',
              args.engine_dir/'neutral5_gmp_convolution.py']}
    result={'status':'PASS','modulus':m,'independent_expected_arithmetic':'plain Python integer convolution, T^3=-T-1 and zeta^4=Teich(2)',
            'native_extension_cases':cases,'native_integer_cases':3,'source_sha256':sources}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: independent native convolution and Frobenius checks modulo',m)


if __name__=='__main__':main()
