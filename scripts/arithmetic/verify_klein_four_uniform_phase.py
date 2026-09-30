#!/usr/bin/env python3
"""Independent Sage tower-field and direct determinant replay of1750 cases.

Construct matrices by evaluating the actual moment determinant, not the
producer's coefficient formula. Solve in the norm-fixed field and check
both fourth traces directly. No endpoint or phase case is sampled.
"""
import argparse
import json
import itertools
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def main(path):
    ref=json.loads(path.read_text())
    P=PolynomialRing(GF(5),'h')
    k=GF(5**7,'h',modulus=P([4,4,2,3,3,2,2,1]));theta=k.gen()
    B=PolynomialRing(k,'b');b=B.gen();K=B.quotient(b*b-b-3,'b');b=K.gen()
    c=lambda n:K(n%5)+K(n//5)*b
    P=PolynomialRing(K,'a');a=P.gen();L=P.quotient(P([c(x) for x in [5,2,6,7,1]]),'a');a=L.gen()
    eta=L(c(22));d=sum(k(x)*theta**i for i,x in enumerate([1,2,4,1,3,0,1]))
    z=(theta+(2*b-1)*d)/2
    assert z**29==1 and z!=1 and z**(5**7)==1/z
    decode=lambda n:sum(k((n//5**i)%5)*theta**i for i in range(7))
    coord=lambda v:vector(k,[k(L(v).lift()[i].lift()[j]) for i in range(4) for j in range(2)])
    embed=lambda x,y:L(K(x)+K(y)*b)
    row=lambda cs:sum(L(c(v))*a**i for i,v in enumerate(cs))
    coeffs=[row(cs) for cs in [[22,7,9,23],[1,3,8,15],[20,12,13,8],[21,21,20,2]]]
    table=[]
    for i in range(4):
        for phase in range(29):
            table.append([f**(25**i)*z**(phase*r) for f,r in zip(coeffs,[5,8,17,4])])
    totals=lambda labels:[sum((table[j][i] for j in labels),L.zero()) for i in range(4)]
    counts=[t for t in itertools.product(range(5),repeat=4) if sum(t)==4]
    reps=[t for t in counts if t==min(t[i:]+t[:i] for i in range(4))]
    expected={(tuple([29*i for i,n in enumerate(q) for _ in range(n)]),
               tuple([29*i+p for i,n in enumerate(h) for _ in range(n)]))
              for q in reps for h in counts for p in [0,1,2,4,8]}
    assert len(expected)==1750
    seen=set();nr=0;np=0
    for index,case in enumerate(ref['cases']):
        q,h=case['q'],case['h'];key=(tuple(q),tuple(h));assert key not in seen;seen.add(key)
        cq,eq,uq,vq=totals(q);ch,eh,uh,vh=totals(h)
        def determinant(v):
            x=embed(v[0],v[1]);y=embed(v[2],v[3])
            xb=embed(v[0]+v[1],-v[1]);yb=embed(v[2]+v[3],-v[3])
            return (eq/eta-xb)*(eh/eta-x)-(cq/eta-y)*(ch/eta-yb)
        zero=vector(k,[0]*4);constant=coord(determinant(zero))
        cols=[]
        for j in range(4):
            v=vector(k,list(zero));v[j]=1
            cols.append(coord(determinant(v))-constant)
        mat=matrix(k,7,4,lambda i,j:cols[j][i+1]);rhs=-constant[1:]
        rank=mat.rank();assert rank==case['rank']
        if index%250==0:print('replayed matrices',index+1,flush=True)
        if mat.augment(matrix(k,7,1,list(rhs))).rank()!=rank:
            assert case['status']=='linear_inconsistent';continue
        particular=mat.solve_right(rhs);kernel=mat.right_kernel().basis()
        if len(kernel)>1:
            assert q==[0,29,58,87] and len({j//29 for j in h})==4 and len({j%29 for j in h})==1
            assert case['status']=='affine_quadric_retained';nr+=1;continue
        points=[]
        if not kernel:
            if not determinant(particular):points=[particular]
        else:
            # Recover a degree<=2 scalar polynomial from0,+1,-1; verify
            # independently that all seven other coordinates vanish.
            kv=kernel[0];v0=coord(determinant(particular));vp=coord(determinant(particular+kv));vm=coord(determinant(particular-kv))
            assert not any(v0[1:]) and not any(vp[1:]) and not any(vm[1:])
            T=PolynomialRing(k,'s');s=T.gen()
            pol=T(v0[0])+(vp[0]-vm[0])/2*s+((vp[0]+vm[0])/2-v0[0])*s*s
            assert pol
            if pol.degree()>0:points=[particular+r*kv for r in pol.roots(multiplicities=False)]
        actual=[]
        for point in points:
            x=embed(point[0],point[1]);y=embed(point[2],point[3])
            aa,bb=eq-eta*x**(5**7),cq-eta*y
            cc,dd=ch-eta*y**(5**7),eh-eta*x
            if not aa and not bb:
                assert cc or dd;continue
            ep=cc/aa if aa else dd/bb
            if not ep or ep*aa!=cc or ep*bb!=dd:continue
            r0=ep*uq+vq-eta*(ep*x**625-y**(5**8))
            r1=uh+ep*vh-eta*(x**(5**11)-ep*y**5)
            assert r0 or r1
            actual.append(tuple(point));np+=1
        assert set(actual)=={tuple(decode(x) for x in p['point']) for p in case['points']}
        if index%250==0:print('replayed',index+1,'cases',flush=True)
    assert seen==expected and nr==5 and np==6
    print('PASS: all1750 orbit cases; only five balanced loci require the separate balanced theorem.')
    print('PASS: every other isolated moment point (six total) fails a fourth trace.')
    print('Thus no actual configuration has a common label phase at each endpoint.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('certificate',type=Path)
    main(p.parse_args().certificate)
