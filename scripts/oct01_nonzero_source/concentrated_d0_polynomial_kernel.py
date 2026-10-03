#!/usr/bin/env python3
"""Unimodular polynomial kernel of the two concentrated d0 top forms."""
import argparse,json,sys
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from cubic_extension import CubicExtension
from shifted_concentrated_projection import extended_gcd


def column_reduce(p,ker):
    """Unimodular reduction until the leading column vectors are independent."""
    from concentrated_d0_quadratic_probe import kernel
    e=p.k;n=len(ker[0]);steps=[]
    while True:
        degrees=[max(len(row[j])-1 for row in ker) for j in range(n)]
        leading=np.array([[row[j][degrees[j]] if len(row[j])>degrees[j] else 0
                           for j in range(n)] for row in ker],dtype=np.uint64)
        relations,_=kernel(e,leading)
        if not len(relations):break
        relation=[int(v) for v in relations[0]]
        pivot=max((j for j in range(n) if relation[j]),key=lambda j:degrees[j])
        factors=[]
        for j in range(n):
            if j==pivot or not relation[j]:continue
            factor=[0]*(degrees[pivot]-degrees[j])+[e.div(relation[j],relation[pivot])]
            factors.append([j,factor])
            for row in ker:row[pivot]=p.add(row[pivot],p.mul(factor,row[j]))
        assert max(len(row[pivot])-1 for row in ker)<degrees[pivot]
        steps.append([pivot,factors])
    return ker,steps


def unimodular_kernel(p,rows):
    a=[[f[:] for f in row] for row in rows];m=len(a);n=len(a[0])
    v=[[[1] if i==j else [] for j in range(n)] for i in range(n)]
    for r in range(m):
        candidates=[j for j in range(r,n) if a[r][j]]
        assert candidates
        j=min(candidates,key=lambda j:len(a[r][j]))
        for matrix in (a,v):
            for row in matrix:row[r],row[j]=row[j],row[r]
        for j in sorted(range(r+1,n),key=lambda j:len(a[r][j])):
            b=a[r][j]
            if not b:continue
            f=a[r][r];g,x,y=extended_gcd(p,f,b)
            aa=p.exactdiv(f,g);bb=p.exactdiv(b,g)
            for matrix in (a,v):
                for row in matrix:
                    left,right=row[r],row[j]
                    row[r]=p.add(p.mul(x,left),p.mul(y,right))
                    row[j]=p.sub(p.mul(aa,right),p.mul(bb,left))
            assert a[r][r]==g and not a[r][j]
        assert a[r][r]==[1]
        for j in range(r):
            coefficient=a[r][j]
            for matrix in (a,v):
                for row in matrix:row[j]=p.sub(row[j],p.mul(coefficient,row[r]))
    assert a==[[[1] if i==j else [] for j in range(n)] for i in range(m)]
    for i in range(m):
        for j in range(n):
            value=[]
            for k in range(n):value=p.add(value,p.mul(rows[i][k],v[k][j]))
            assert value==a[i][j]
    return v,[row[m:] for row in v]


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    ap.add_argument('--root',type=int,default=145049);ap.add_argument('--sheet',default='')
    args=ap.parse_args();k=Field(args.work/'cache');e=CubicExtension(k);p=Poly(e)
    data=json.loads((args.work/'data/concentrated_d0_top_rank.json').read_text())
    record=next(r for r in data['records'] if r['root_K_code']==args.root and r['sheet_suffix']==args.sheet)
    v,ker=unimodular_kernel(p,record['compatibility_rows'])
    ker,steps=column_reduce(p,ker)
    for pivot,factors in steps:
        for j,factor in factors:
            for row in v:row[2+pivot]=p.add(row[2+pivot],p.mul(factor,row[2+j]))
    assert [row[2:] for row in v]==ker
    for row in record['compatibility_rows']:
        for j in range(6):
            total=[]
            for f,krow in zip(row,ker):total=p.add(total,p.mul(f,krow[j]))
            assert not total
    report={'scope':'global polynomial top-moment kernel over the full first-slope line',
            'root':args.root,'sheet':args.sheet,'unimodular_column_matrix':v,'kernel_columns':ker,
            'degree_reduction_elementary_steps':steps,
            'identity':'compatibility_matrix * unimodular_column_matrix = [I2,0]'}
    suffix=args.sheet
    (args.work/f'data/concentrated_d0_polynomial_kernel_{args.root}{suffix}.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({'root':args.root,'sheet':args.sheet,
                     'column_degrees':[max(len(ker[i][j])-1 for i in range(8)) for j in range(6)],
                     'transformation_max_degree':max(len(f)-1 for row in v for f in row)}))


if __name__=='__main__':main()
