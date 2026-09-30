#!/usr/bin/env python3
"""Reconstruct a complete symmetric-power section space of the actual K."""
import argparse
import json
from pathlib import Path
import pro_quadratic_twist_vanishing as q
from k_fifth_twist_probe import reconstruct, serialize


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--degree',type=int,required=True)
    ap.add_argument('--twist',type=int,default=0)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();n=args.degree
    columns,rows,M=q.system(n,twist=args.twist)
    rr,piv=q.rref(M);rank5=q.prime_field_rank(M)
    assert rank5==2*len(piv)
    free=[j for j in range(len(columns)) if j not in piv]
    sections=[]
    for j in free:
        v=[0]*len(columns);v[j]=1
        for i,p in enumerate(piv):v[p]=q.NEG[rr[i][j]]
        affine,other=reconstruct(columns,v,n,twist=args.twist)
        characters={(r+n-i)%3 for i,f in enumerate(affine) for r,m in f}
        assert len(characters)==1
        sections.append({'free_column':columns[j],'coordinates':v,
                         'affine':serialize(affine),'other_chart':serialize(other),
                         'C3_character':next(iter(characters))})
    receipt={'status':'PASS','scope':'Complete section space of the actual symmetric-power bundle.',
             'symmetric_degree':n,'twist':args.twist,'columns':columns,'rows':rows,
             'matrix':M,'rank':len(piv),'independent_F5_rank':rank5,'sections':sections}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PASS',len(M),'x',len(columns),'rank',len(piv),'h0',len(free),
          'characters',[s['C3_character'] for s in sections],flush=True)


if __name__=='__main__':main()
