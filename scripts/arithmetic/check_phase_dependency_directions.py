#!/usr/bin/env python3
"""Inspect all normalized six-phase F25 dependencies independently in Sage."""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix

def main():
    p=argparse.ArgumentParser();p.add_argument('listing',type=Path);p.add_argument('output',type=Path)
    a=p.parse_args();start=time.monotonic()
    F=GF(5);R=PolynomialRing(F,'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
    dec=lambda c:B(c%5)+B(c//5)*b
    S=PolynomialRing(B,'z');z=S.gen();f=S([dec(c) for c in [4,22,7,20,21,7,24,1]])
    assert f.is_irreducible()
    K=B.extension(f,'z');z=K.gen();assert z**29==1 and z!=1
    phases=[[(z**i).lift()[j] for j in range(7)] for i in range(29)]
    code=lambda c:int(c[0])+5*int(c[1])
    def direction(c):
        x,y=int(c[0]),int(c[1]);assert x or y
        return ('finite',y*pow(x,-1,5)%5) if x else ('infinity',)
    records=[];hist={}
    for line in a.listing.read_text().splitlines():
        if not line.startswith('DEPENDENT '):continue
        e=[0]+[int(v) for v in line.split()[1:6]]
        M=matrix(B,[phases[i] for i in e]).transpose();ker=M.right_kernel_matrix()
        assert M.rank()==5 and ker.nrows()==1
        v=ker.row(0);assert all(v)
        directions=[direction(c) for c in v];count=len(set(directions))
        hist[count]=hist.get(count,0)+1
        rank_fp=int(matrix(F,[[int(c[j]) for c in phases[i] for j in [0,1]] for i in e]).rank())
        assert rank_fp==6
        two_signed_groups=False
        if count==2:
            groups=[[c for c,d in zip(v,directions) if d==label] for label in set(directions)]
            assert sorted(map(len,groups))==[3,3]
            two_signed_groups=all(all(c/g[0] in [B.one(),-B.one()] for c in g) for g in groups)
            assert not two_signed_groups
        records.append(dict(exponents=e,relation=[code(c) for c in v],directions=directions,direction_count=count,rank_F5=rank_fp,two_signed_groups=two_signed_groups))
    assert len(records)==126
    result=dict(status='EXACT_DEPENDENCY_DIRECTION_COUNTS',histogram=hist,records=records,seconds=time.monotonic()-start)
    a.output.write_text(json.dumps(result,indent=2)+'\n');print('HISTOGRAM',hist,flush=True)

if __name__=='__main__':main()
