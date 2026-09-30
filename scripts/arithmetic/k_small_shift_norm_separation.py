#!/usr/bin/env python3
"""A linear relaxation of the cubic norm for K(2O).

The determinant-twisted sections have one character-zero direction
and three directions of the other character. Once the former is one,
its cube must lie in the span of the ten cubes from the latter and
the nine wedge-times-net products. Test that necessary containment.
"""
import argparse
import hashlib
import json
from itertools import combinations_with_replacement
from math import factorial
from pathlib import Path
import pro_quadratic_twist_vanishing as q
from verify_k_shifted_norm_identities import product


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('source',type=Path);ap.add_argument('net',type=Path)
    ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
    source=json.loads(args.source.read_text())['sections']
    net=json.loads(args.net.read_text())['sections']
    assert [s['C3_character'] for s in source]==[0,1,1,1]
    assert [s['C3_character'] for s in net]==[0,0,0]
    read=lambda s,i:{(r,m):c for r,m,c in s['affine'][i]}
    p=[read(source[0],i) for i in range(2)]
    qs=[[read(s,i) for i in range(2)] for s in source[1:]]
    gs=[[read(s,i) for i in range(4)] for s in net]
    columns=[product([p,p,p])];labels=['p^3']
    for inds in combinations_with_replacement(range(3),3):
        scale=6
        for i in range(3):scale//=factorial(inds.count(i))
        columns.append([q.add({},f,scale%5) for f in product([qs[i] for i in inds])])
        labels.append(['q-cube',list(inds)])
    for i,v in enumerate(qs):
        h=q.add(q.multiply(p[0],v[1]),q.multiply(p[1],v[0]),4)
        assert all(r==0 and 0<=m<=5 for r,m in h)
        for j,g in enumerate(gs):
            columns.append([q.multiply(h,f) for f in g]);labels.append(['wedge-net',i,j])
    rows=sorted({(i,r,m) for col in columns for i,f in enumerate(col) for r,m in f})
    M=[[col[i].get((r,m),0) for col in columns] for i,r,m in rows]
    rank=len(q.rref(M)[1]);other=len(q.rref([row[1:] for row in M])[1])
    rank5=q.prime_field_rank(M);assert rank5==2*rank
    receipt={'status':'COMPLETE','scope':'Exact linear relaxation; separation would exclude the mixed-character norm.',
             'columns':labels,'rows':rows,'matrix':M,'rank':rank,'other_rank':other,
             'separates':rank>other,'independent_F5_rank':rank5,
             'input_hashes':[hashlib.sha256(p.read_bytes()).hexdigest() for p in [args.source,args.net]]}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    rr,piv=q.rref(M)
    monomials=['1']
    for label in labels[1:]:
        if label[0]=='q-cube':
            monomials.append('*'.join(f'd{i}' for i in label[1]))
        else:
            monomials.append(f'(-d{label[1]}*g{label[2]})')
    equations=[]
    for row in rr[:len(piv)]:
        terms=[f'({c%5}+{c//5}*a)*({m})' for c,m in zip(row,monomials) if c]
        equations.append('+'.join(terms))
    prepared={'status':'PREPARED','scope':'Exact mixed-character norm for K(2O), normalized character-zero coefficient1.',
              'variables':['d0','d1','d2','g0','g1','g2'],
              'equations':equations,'input_sha256':hashlib.sha256(args.output.read_bytes()).hexdigest()}
    args.output.with_name(args.output.stem+'_prepared.json').write_text(json.dumps(prepared,separators=(',',':'))+'\n')
    print('COMPLETE',len(rows),'x',len(columns),'rank',rank,'other',other,'separates',rank>other,flush=True)


if __name__=='__main__':main()
