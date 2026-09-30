#!/usr/bin/env python3
"""Independent Sage reconstruction of the old determinant on all503 pairs.

Rebuilds the matrices by evaluations, rather than importing the primary
coefficient formula or arithmetic. Also checks all canonical constants
used to derive the trace-zero endpoint matching.
"""
import argparse
import csv
import json
from collections import Counter
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def main(source, output):
    P=PolynomialRing(GF(5),'h')
    k=GF(5**7,'h',modulus=P([4,4,2,3,3,2,2,1]));theta=k.gen()
    B=PolynomialRing(k,'b');b=B.gen();K=B.quotient(b*b-b-3,'b');b=K.gen()
    code=lambda n:K(n%5)+K(n//5)*b
    P=PolynomialRing(K,'a');a=P.gen()
    F=P.quotient(P([code(v) for v in [5,2,6,7,1]]),'a');a=F.gen()
    eta=F(code(22));d=sum(k(v)*theta**i for i,v in enumerate([1,2,4,1,3,0,1]))
    z=(theta+(2*b-1)*d)/2
    assert z**29==1 and z!=1 and z**(5**7)==1/z
    coord=lambda v:vector(k,[k(F(v).lift()[i].lift()[j]) for i in range(4) for j in range(2)])
    embed=lambda x,y:F(K(x)+K(y)*b)
    row=lambda ns:sum(F(code(n))*a**i for i,n in enumerate(ns))
    c,e,u,v=[row(ns) for ns in [[22,7,9,23],[1,3,8,15],[20,12,13,8],[21,21,20,2]]]
    project=lambda v,lam:sum(F(GF(5)(lam)**(-i))*v**(25**i) for i in range(4))/4
    assert project(e,3)==project(v,3)==0
    assert project(e,2)==project(c,2)
    assert project(v,2)==code(17)*project(c,2)
    assert project(u,4)==code(17)*project(c,4)
    assert all(project(w,lam) for w,lam in [(c,2),(c,4),(u,4),(v,2)])
    # The absolute verifier's degree14 modulus is exactly f7 times its
    # coefficient fifth-power conjugate, so its Z denotes the same orbit.
    R=PolynomialRing(K,'Z');Z=R.gen();f=R([code(n) for n in [4,22,7,20,21,7,24,1]])
    fb=R([code(n)**5 for n in [4,22,7,20,21,7,24,1]])
    assert f*fb==R([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]) and f(z)==0
    tables=[]
    for i in range(4):
        for j in range(29):tables.append((c**(25**i)*z**(5*j),e**(25**i)*z**(8*j)))
    totals=lambda ls:tuple(sum((tables[j][i] for j in ls),F.zero()) for i in range(2))
    counts=Counter();last=[]
    rows=list(csv.DictReader(source.open(),delimiter='\t'));assert len(rows)==503
    for entry in rows:
        q=[int(entry['q'+str(i)]) for i in range(4)];h=[int(entry['h'+str(i)]) for i in range(4)]
        cq,eq=totals(q);ch,eh=totals(h)
        def det(v):
            x=embed(v[0],v[1]);y=embed(v[2],v[3])
            xb=embed(v[0]+v[1],-v[1]);yb=embed(v[2]+v[3],-v[3])
            return (eq/eta-xb)*(eh/eta-x)-(cq/eta-y)*(ch/eta-yb)
        zero=vector(k,[0]*4);constant=coord(det(zero));cols=[]
        for j in range(4):
            w=vector(k,list(zero));w[j]=1;cols.append(coord(det(w))-constant)
        mat=matrix(k,7,4,lambda i,j:cols[j][i+1]);rhs=-constant[1:];rank=mat.rank()
        if mat.augment(matrix(k,7,1,list(rhs))).rank()>rank:
            counts['linear_inconsistent']+=1;continue
        assert rank==4
        point=mat.solve_right(rhs);value=det(point);assert value
        assert not any(coord(value)[1:])
        counts['quadratic_inconsistent']+=1
        last.append(dict(Q=q,H=h,unique_linear_point=[str(a) for a in point],nonzero_determinant=str(value)))
    assert dict(counts)==dict(linear_inconsistent=502,quadratic_inconsistent=1)
    output.write_text(json.dumps(dict(status='COMPLETE',pairs=503,counts=dict(counts),last=last),indent=2)+'\n')
    print('PASS: direct determinant reconstruction;502 inconsistent linear systems and one nonzero scalar determinant.')
    print('PASS: matching constants, all projection zero/nonzero claims and degree14 field bridge.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();main(a.source,a.output)
