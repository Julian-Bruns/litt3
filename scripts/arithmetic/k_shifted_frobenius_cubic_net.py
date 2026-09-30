#!/usr/bin/env python3
"""Reconstruct the C3-invariant cubic norm space for F^*K(O).

Standard-library exact section calculation. The output contains basis
vectors and both charts, not a square-locus or all-twist decision.
"""
import argparse
import json
from pathlib import Path
import pro_quadratic_twist_vanishing as q
from k_fifth_twist_probe import reconstruct,serialize

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    columns,rows,full=q.system(15,3)
    ids=[i for i,(j,r,m) in enumerate(columns) if j%5==0 and (r-j)%3==0]
    subcolumns=[columns[i] for i in ids]
    matrix=[[row[i] for i in ids] for row in full]
    rr,pivots=q.rref(matrix);free=[i for i in range(len(ids)) if i not in pivots]
    assert (len(ids),len(pivots),len(free))==(42,35,7)
    assert q.prime_field_rank(matrix)==70
    sections=[]
    for fi in free:
        vector=[0]*len(ids);vector[fi]=1
        for row,pivot in enumerate(pivots):vector[pivot]=q.NEG[rr[row][fi]]
        affine,other=reconstruct(subcolumns,vector,15,3)
        assert all(not v or j%5==0 for j,v in enumerate(affine))
        for j,v in enumerate(affine):assert all((r-j)%3==0 for r,m in v)
        sections.append({'free_column':subcolumns[fi],'vector':vector,'affine':serialize(affine),'other_chart':serialize(other)})
    result={'status':'PASS','scope':'Full C3-invariant section space of Sym3(F_abs^*K)(3O); no all-twist decision.',
            'O_shift':1,'columns':subcolumns,'rows':rows,'matrix':matrix,'rank':35,'F5_rank':70,'sections':sections}
    args.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('PASS: invariant cubic section space dimension7; rank35/42 and independent F5 rank70.')

if __name__=='__main__':main()
