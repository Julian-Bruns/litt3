#!/usr/bin/env python3
"""Focused independent checks of the complete native common-endpoint scan.

Checks EVERY retained endpoint pair with the complete elementary routine,
and every predetermined arithmetic sample with an independent direct Sage
determinant construction. The full rejected native enumeration is not
independently rerun by this verifier; that limit is explicit in its output.
"""
import argparse
import csv
import json
from collections import Counter
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector
from klein_four_general_fourth_traces import F as FF, M, residuals


def main(prefix, output):
    P=PolynomialRing(GF(5),'h');k=GF(5**7,'h',modulus=P([4,4,2,3,3,2,2,1]));theta=k.gen()
    B=PolynomialRing(k,'b');b=B.gen();K=B.quotient(b*b-b-3,'b');b=K.gen()
    code=lambda n:K(n%5)+K(n//5)*b
    P=PolynomialRing(K,'a');a=P.gen();F=P.quotient(P([code(v) for v in [5,2,6,7,1]]),'a');a=F.gen()
    eta=F(code(22));d=sum(k(v)*theta**i for i,v in enumerate([1,2,4,1,3,0,1]));z=(theta+(2*b-1)*d)/2
    coord=lambda v:vector(k,[k(F(v).lift()[i].lift()[j]) for i in range(4) for j in range(2)])
    embed=lambda x,y:F(K(x)+K(y)*b)
    row=lambda ns:sum(F(code(n))*a**i for i,n in enumerate(ns))
    c,e=[row(ns) for ns in [[22,7,9,23],[1,3,8,15]]]
    tables=[(c**(25**i)*z**(5*j),e**(25**i)*z**(8*j)) for i in range(4) for j in range(29)]
    totals=lambda ls:tuple(sum((tables[j][i] for j in ls),F.zero()) for i in range(2))
    decode=lambda n:sum(k((n//5**i)%5)*theta**i for i in range(7))
    def read(suffix):
        with Path(str(prefix)+suffix).open() as f:return list(csv.DictReader(f,delimiter='\t'))
    def labels(r):return tuple(int(r['q'+str(i)]) for i in range(4)),tuple(int(r['h'+str(i)]) for i in range(4))
    samples=read('.samples.tsv');assert len(samples)==2008
    for r in samples:
        q,h=labels(r);cq,eq=totals(q);ch,eh=totals(h)
        def det(v):
            x=embed(v[0],v[1]);y=embed(v[2],v[3]);xb=embed(v[0]+v[1],-v[1]);yb=embed(v[2]+v[3],-v[3])
            return (eq/eta-xb)*(eh/eta-x)-(cq/eta-y)*(ch/eta-yb)
        zero=vector(k,[0]*4);constant=coord(det(zero));cols=[]
        for j in range(4):
            v=vector(k,list(zero));v[j]=1;cols.append(coord(det(v))-constant)
        mat=matrix(k,7,4,lambda i,j:cols[j][i+1]);rhs=-constant[1:];rank=mat.rank()
        if mat.augment(matrix(k,7,1,list(rhs))).rank()>rank:status=-1
        elif rank<4:status=rank
        else:status=-2 if det(mat.solve_right(rhs)) else 4
        assert status==int(r['status']),(q,h,status,r)
    print('PASS: all2008 predetermined native arithmetic samples independently reconstructed.',flush=True)
    candidates=read('.candidates.tsv');counts=Counter();points=[];unresolved=[]
    for r in candidates:
        q,h=labels(r);cert=M.analyze(q,h);counts[cert['status']]+=1
        assert cert['rank']==int(r['rank'])
        if cert['rank']==4:
            native=[int(r[n]) for n in ['x0','x1','y0','y1']]
            assert native==cert['particular']
        if cert['status'] in ['positive_dimensional_affine_quadric','affine_quadric_retained']:
            unresolved.append(dict(Q=q,H=h,certificate=cert))
        for p in cert.get('tested_isolated_points',[]):
            if not p['valid_nonzero_scale']:continue
            rs=residuals(q,h,tuple(p['x_M2']),tuple(p['y_M6']),tuple(p['epsilon']))
            points.append(dict(Q=q,H=h,point=p,fourth_residuals=rs,passes=all(v==FF.F0 for v in rs)))
    ref=json.loads(Path(str(prefix)+'.json').read_text());assert ref['status']=='COMPLETE'
    assert ref['H_count']==7940751 and len(ref['cases'])==8
    assert sum(c['retained'] for c in ref['cases'])==len(candidates)
    result=dict(status='COMPLETE',native_cases=8*7940751,independent_arithmetic_samples=len(samples),
                retained_pairs=len(candidates),counts=dict(counts),unresolved=unresolved,isolated_points=points,
                survivors=sum(p['passes'] for p in points),
                independence_limit='Full native rejected enumeration is not independently replayed; all retained pairs and2008 fixed arithmetic samples are checked.')
    output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: retained pairs',len(candidates),'unresolved',len(unresolved),'old nonzero-scale points',len(points),'fourth survivors',result['survivors'])


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('prefix',type=Path);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();main(a.prefix,a.output)
