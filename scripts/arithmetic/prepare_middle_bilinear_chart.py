#!/usr/bin/env python3
"""Prepare an actual residual H(b)s chart, with no field-point restriction.

Only a necessary subsystem is used: emptiness excludes the corresponding
actual quotient window, but nonemptiness does not construct a return.
Source and map scales are normalized independently because H is bilinear.
"""
import argparse
import hashlib
import json
from pathlib import Path
import numpy as np
from sage.all import GF, PolynomialRing


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('tensor', type=Path)
    ap.add_argument('--source-stratum', type=int, choices=range(10), required=True)
    ap.add_argument('--degree', type=int, choices=range(8), required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    H = np.load(args.tensor, allow_pickle=False)['H']
    assert H.shape == (30, 15, 10)
    j, d = args.source_stratum, args.degree
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'v')([2,4,1]))
    names = [f'b{i}' for i in range(j+1,10)]
    names += [f'p{i}' for i in range(d)]+[f'c{i}' for i in range(7)]
    R = PolynomialRing(k, names, order='degrevlex')
    b = [R.zero() if i<j else R.one() if i==j else R(f'b{i}') for i in range(10)]
    s = [R(f'p{i}') if i<d else R.one() if i==d else R.zero() for i in range(8)]
    s += [R(f'c{i}') for i in range(7)]
    decode = lambda c:k(int(c)%5)+(int(c)//5)*k.gen()
    equations = [sum(decode(H[r,u,v])*s[u]*b[v]
                     for u in range(15) for v in range(10)) for r in range(30)]
    equations = [f for f in equations if f]
    receipt = {'status':'PREPARED',
               'scope':'Necessary residual map equations only; any positive locus still needs J, full Hom ranks and stability.',
               'input_sha256':hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
               'source_stratum':j,'polynomial_degree':d,
               'normalizations':f'b0=...=b{j-1}=0,b{j}=1;p{d}=1,p_i=0 for i>{d}',
               'variables':names,'equations':[str(f) for f in equations]}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PREPARED',len(names),'variables',len(equations),'equations',flush=True)


if __name__ == '__main__':
    main()
