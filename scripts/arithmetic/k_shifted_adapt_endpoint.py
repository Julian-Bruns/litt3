#!/usr/bin/env python3
"""Use the four allowable initial infinity jets as cubic-net coordinates.

Sage Python. Retains the exact invertible basis change and all sections.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('sections',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.sections.read_text());old=data['sections'];assert len(old)==7
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
    decode=lambda n:k(n%5)+(n//5)*a
    def code(v):
        t=v.polynomial();return int(t[0])+5*int(t[1])
    def coeff(section,index,r,m):
        return decode(next((c for rr,mm,c in section['other_chart'][index] if (rr,mm)==(r,m)),0))
    jets=[(0,0,-24),(15,0,31),(10,1,9),(5,2,-13)]
    rows=[[coeff(s,*j) for s in old] for j in jets]
    assert matrix(k,rows).rank()==4
    for i in range(7):
        row=[k(int(i==j)) for j in range(7)]
        if matrix(k,rows+[row]).rank()>len(rows):rows.append(row)
        if len(rows)==7:break
    C=matrix(k,rows);inv=C.inverse();assert C*inv==matrix.identity(k,7)
    sections=[]
    for column in range(7):
        s={}
        for chart in ['affine','other_chart']:
            coords=[]
            for index in range(16):
                terms={}
                for j in range(7):
                    for r,m,c in old[j][chart][index]:terms[r,m]=terms.get((r,m),k.zero())+inv[j,column]*decode(c)
                coords.append([[r,m,code(c)] for (r,m),c in sorted(terms.items()) if c])
            s[chart]=coords
        assert [coeff(s,*j) for j in jets]==[k(int(i==column)) for i in range(4)]
        sections.append(s)
    data['sections']=sections
    data['coordinate_change']={'old_parameters_from_new':[[code(v) for v in row] for row in inv.rows()],
                               'new_parameters_from_old':[[code(v) for v in row] for row in C.rows()],
                               'determinant':code(C.det()),'first_four_jets':jets}
    data['scope']='Exact invertible endpoint-jet coordinates for the complete seven-dimensional invariant cubic section space.'
    args.output.write_text(json.dumps(data,separators=(',',':'))+'\n')
    print('PASS: four independent endpoint jets; exact invertible coordinate change, determinant',code(C.det()))

if __name__=='__main__':main()
