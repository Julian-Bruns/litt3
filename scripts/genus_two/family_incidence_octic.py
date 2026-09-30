#!/usr/bin/env sage-python
"""Degree-eight elimination via the Koszul H3 map (175 unknowns).

For five biforms (2,2), the displayed kernel is the space of octics
vanishing on the projected complete-intersection curve. Its actual
octic is obtained by a subsequent Cech transgression, not by calling
the kernel vector an octic coefficient vector.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--specialize',choices=['cubic','four']);args=ap.parse_args()
assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
start=time.monotonic();data=json.loads(args.tensor.read_text())
R=PolynomialRing(GF(5),'a');a=R.gen();F=R.fraction_field()
values=[[[F(s.replace('^','**')) for s in row] for row in f] for f in data['five_test_coefficients']]
if args.specialize:
    if args.specialize=='cubic':k=GF(125,'alpha',modulus=[1,1,0,1]);val=k.gen()
    else:k=GF(5);val=k(4)
    values=[[[v.numerator()(val)/v.denominator()(val) for v in row] for row in f] for f in values]
else:k=F
mon=lambda n:[tuple(w.count(i) for i in range(4)) for w in itertools.combinations_with_replacement(range(4),n)]
m2,m4=mon(2),mon(4);i4=list(itertools.combinations(range(5),4));i3=list(itertools.combinations(range(5),3))
B=matrix(k,1000,175)
for source,I in enumerate(i4):
    for pos,j in enumerate(I):
        target=i3.index(tuple(i for i in I if i!=j));sgn=(-1)**pos
        for cindex,n in enumerate(m2):
            for windex,w in enumerate(m2):
                m=tuple(x+y for x,y in zip(n,w));col=35*source+m4.index(m)
                for bindex in range(10):B[100*target+10*cindex+bindex,col]+=sgn*values[j][bindex][windex]
print('matrix1000x175 ready',time.monotonic()-start,flush=True)
if args.specialize:
    echelon={};selected=[]
    for original in range(1000):
        row=list(B[original])
        for pivot,v in sorted(echelon.items()):
            coeff=row[pivot]
            if coeff:
                for j in range(pivot+1,175):row[j]-=coeff*v[j]
                row[pivot]=k.zero()
        support=[i for i,v in enumerate(row) if v]
        if support:
            pivot=support[0];scale=row[pivot]
            echelon[pivot]=[v/scale for v in row];selected.append(original)
        if original%200==0:print('scalar row',original,'rank',len(echelon),flush=True)
    free=[j for j in range(175) if j not in echelon];basis=[]
    for j in free:
        v=[k.zero() for _ in range(175)];v[j]=k.one()
        for pivot,row in sorted(echelon.items(),reverse=True):
            v[pivot]=-sum(row[col]*v[col] for col in range(pivot+1,175))
        basis.append(v)
    for v in basis:
        assert all(not sum(B[i,j]*v[j] for j in range(175)) for i in range(1000))
    rank=len(echelon)
else:
    ker=B.right_kernel();basis=[list(v) for v in ker.basis()]
    assert all(not B*v for v in ker.basis());rank=175-len(basis)
print('kernel dimension',len(basis),'seconds',time.monotonic()-start,flush=True)
out={'base':str(k),'specialization':args.specialize,'rank':rank,'kernel_dimension':len(basis),
     'source_subsets':[list(t) for t in i4],'source_quartic_monomials':[list(t) for t in m4],
     'kernel_basis':[[str(v) for v in row] for row in basis],
     'interpretation':'Koszul H3 kernel; an octic requires the Cech transgression',
     'seconds':time.monotonic()-start}
if args.specialize:
    columns=sorted(echelon);entries=[[B[row,col] for col in columns] for row in selected];det=k.one()
    for j in range(rank):
        pivotrow=next(i for i in range(j,rank) if entries[i][j])
        if pivotrow!=j:entries[j],entries[pivotrow]=entries[pivotrow],entries[j];det=-det
        pivot=entries[j][j];det*=pivot
        for i in range(j+1,rank):
            if not entries[i][j]:continue
            factor=entries[i][j]/pivot
            for col in range(j+1,rank):entries[i][col]-=factor*entries[j][col]
            entries[i][j]=k.zero()
    assert det
    out['rank_minor_rows']=[int(i) for i in selected]
    out['rank_minor_columns']=[int(i) for i in columns]
    out['rank_minor_determinant']=str(det)
    out['rank_minor_check']='literal scalar Gaussian elimination, all pivots nonzero'
    print('independent rank minor',det,flush=True)
args.output.write_text(json.dumps(out,indent=2)+'\n')
