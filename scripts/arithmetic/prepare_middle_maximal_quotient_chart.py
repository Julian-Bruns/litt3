#!/usr/bin/env python3
"""Retain the nonzero projection to the saturated O(5O) quotient of K.

For the old section ( (PE*p)_+ + alpha, y*p ), the new projection is
y*r, where r = -( (PE)_- * p )_+ - alpha. This linear change keeps
the eight old p coordinates and replaces seven alpha coordinates by
the seven r coordinates. A genuine quotient-window map has r != 0.
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
    ap.add_argument('section', type=Path)
    ap.add_argument('--source-stratum', type=int, choices=range(3), required=True)
    ap.add_argument('--degree', type=int, choices=range(7), required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    H = np.load(args.tensor, allow_pickle=False)['H']
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 't')([2,4,1]))
    dec = lambda c: k(int(c)%5)+(int(c)//5)*k.gen()
    enc = lambda c: int(c.polynomial()[0])+5*int(c.polynomial()[1])
    P = [dec(c) for c in (11,22,18,5,19,20,15,16,9,22,1)]
    E = [dec(c) for c in (2,16,16,7,1,2,7,1,24,11)]
    pe = {}
    for i, v in enumerate(P):
        for m, c in enumerate(E, 1):
            pe[i-m] = pe.get(i-m, k.zero())+v*c
    section = json.loads(args.section.read_text())['sections'][0]
    assert section['affine'][1] == [[1,0,1]]
    assert {m:dec(c) for r,m,c in section['affine'][0]} == {i:c for i,c in pe.items() if i>=0 and c}
    # r = R*p - alpha, in ascending polynomial order.
    transform = [[-pe.get(i-j,k.zero()) if i-j<0 else k.zero() for j in range(8)] for i in range(7)]
    j, d = args.source_stratum, args.degree
    names = [f'b{i}' for i in range(j+1,10)]+[f'r{i}' for i in range(d)]+[f'p{i}' for i in range(8)]
    R = PolynomialRing(k, names, order='degrevlex')
    b = [R.zero() if i<j else R.one() if i==j else R(f'b{i}') for i in range(10)]
    r = [R(f'r{i}') if i<d else R.one() if i==d else R.zero() for i in range(7)]
    p = [R(f'p{i}') for i in range(8)]
    alpha = [sum(transform[i][v]*p[v] for v in range(8))-r[i] for i in range(7)]
    s = p+alpha
    equations = [sum(dec(H[row,u,v])*s[u]*b[v] for u in range(15) for v in range(10)) for row in range(30)]
    equations = [f for f in equations if f]
    receipt = {'status':'PREPARED', 'scope':'Necessary H equations with nonzero actual projection to O(5O); no positive realization inferred.',
               'source_stratum':j, 'new_projection_degree':d, 'variables':names,
               'equations':[str(f) for f in equations],
               'projection_transform':[[enc(c) for c in row] for row in transform],
               'input_hashes':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (args.tensor,args.section)}}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PREPARED O5 quotient, stratum',j,'degree',d,'variables',len(names),'equations',len(equations),flush=True)


if __name__ == '__main__':
    main()
