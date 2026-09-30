#!/usr/bin/env sage-python
"""Exact profile (3,3,3,3,1,1) search on the fixed genus-six repair.

With a singleton source branch at infinity, partition the other twelve
non-singleton branches into four triples. Normalize three target values
to 0,infinity,1. The first two fibers force N=A*l^2,D=B*m^2. On the
third triple, l/m takes specified square-root values, up to four sign
patterns. Three-point Mobius interpolation therefore lists ALL candidates.
No abelian factor is assumed to come from a curve map.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('model')
    ap.add_argument('--all-charts', action='store_true')
    ap.add_argument('--chart', type=int, default=0)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    source = Path(args.model)
    data = json.loads(source.read_text())
    assert data['label'] == 'pair_4_5'
    k = GF(5**40, 'a')
    r = PolynomialRing(k, 'x')
    x = r.gen()
    key = lambda a: tuple(int(c) for c in a.polynomial())
    tau = sorted(r(data['field_modulus']).roots(multiplicities=False), key=key)[0]
    dec = lambda v: sum(k(c)*tau**i for i,c in enumerate(v))
    f0 = r([dec(c) for c in data['hyperelliptic_polynomial']])
    branch = sorted(f0.roots(multiplicities=False), key=key)
    assert len(branch) == 13
    assert all(a**(5**20)==a for a in branch)
    enc = lambda a: [int(a.polynomial()[i]) for i in range(40)]

    def square_quartic(v):
        if len(v) != 5 or v[4] == 0:
            return False
        a,b = 4*v[4]*v[2]-v[3]**2, 8*v[4]**2
        return v[1]*b == v[3]*a and v[0]*b*b == v[4]*a*a

    def partitions(points):
        if len(points)==3:
            yield (tuple(points),)
            return
        for pair in itertools.combinations(points[1:],2):
            first = (points[0],)+pair
            rest = [i for i in points if i not in first]
            for tail in partitions(rest):
                yield (first,)+tail

    start = time.monotonic()
    charts, planes = [], set()
    cs = [None]+branch
    indices = range(14) if args.all_charts else [args.chart]
    for chart in indices:
        c=cs[chart]
        if c is None:
            f,roots=f0,branch
        else:
            f=sum(f0[i]*x**(14-i)*(c*x+1)**i for i in range(14))
            roots=sorted([k(0)]+[1/(a-c) for a in branch if a!=c],key=key)
        assert f.degree()==13 and all(f(a)==0 for a in roots)
        differences = {(i,j):(roots[i]-roots[j]).sqrt()
                       for i in range(13) for j in range(13) if i!=j}
        polys, sqvalues = {},{}
        for tri in itertools.combinations(range(13),3):
            p=r.one()
            for i in tri:
                p*=x-roots[i]
            polys[tri]=p
            for i in range(13):
                if i not in tri:
                    sqvalues[tri,i]=differences[i,tri[0]]*differences[i,tri[1]]*differences[i,tri[2]]
        count, candidates, fourth_passes, hits=0,0,0,[]
        for single in range(13):
            other=[i for i in range(13) if i!=single]
            for groups in partitions(other):
                count+=1
                A,B,C,D=groups
                aa,bb=polys[A],polys[B]
                c1,c2,c3=[roots[i] for i in C]
                v1,v2,v3=[sqvalues[B,i]/sqvalues[A,i] for i in C]
                # Global simultaneous sign does not change the rational map.
                for sign2,sign3 in ((1,1),(1,-1),(-1,1),(-1,-1)):
                    w1,w2,w3=v1,sign2*v2,sign3*v3
                    if w1==w2 or w1==w3 or w2==w3:
                        continue
                    k1=(w3-w2)*(c3-c1)
                    k2=(w3-w1)*(c3-c2)
                    l1=w1*k1-w2*k2
                    l0=-w1*k1*c2+w2*k2*c1
                    m1=k1-k2
                    m0=-k1*c2+k2*c1
                    if not l1 or not m1 or l1*m0==l0*m1:
                        continue
                    candidates+=1
                    numer,denom=None,None
                    ok=True
                    for i in D:
                        li=l1*roots[i]+l0
                        mi=m1*roots[i]+m0
                        ni=(sqvalues[A,i]*li)**2
                        di=(sqvalues[B,i]*mi)**2
                        if not ni or not di:
                            ok=False
                            break
                        if numer is None:
                            numer,denom=ni,di
                        elif ni*denom!=di*numer:
                            ok=False
                            break
                    if not ok:
                        continue
                    fourth_passes+=1
                    n=aa*(l1*x+l0)**2
                    b=bb*(m1*x+m0)**2
                    if n.gcd(b).degree()!=0:
                        continue
                    values=[k(0),k(1),numer/denom,n[5]/b[5],n(roots[single])/b(roots[single])]
                    if len(set(values))!=5:
                        continue
                    for tri,lam in [(C,k(1)),(D,values[2])]:
                        q,rem=(n-lam*b).quo_rem(polys[tri])
                        assert rem==0
                        if q.degree()!=2 or q[1]**2!=4*q[2]*q[0] or q.gcd(polys[tri]).degree()!=0:
                            ok=False
                            break
                    if not ok or not square_quartic((n-values[3]*b).list()):
                        continue
                    q,rem=(n-values[4]*b).quo_rem(x-roots[single])
                    assert rem==0
                    if q(roots[single])==0 or not square_quartic(q.list()):
                        continue
                    w=n.derivative()*b-n*b.derivative()
                    left=b
                    for lam in values:
                        left*=n-lam*b
                    right=f*w*w
                    constant=left.leading_coefficient()/right.leading_coefficient()
                    assert left==constant*right
                    if c is None:
                        nn,bb=n,b
                    else:
                        nn=sum(n[j]*(x-c)**(5-j) for j in range(6))
                        bb=sum(b[j]*(x-c)**(5-j) for j in range(6))
                    mat=matrix(k,[[p[j] for j in range(6)] for p in (nn,bb)]).echelon_form()
                    plane=tuple(tuple(enc(a)) for a in mat.list())
                    planes.add(plane)
                    hits.append({'singleton':single,'triples':[list(a) for a in groups],
                                 'signs':[sign2,sign3],'original_coordinate_plane':list(plane),
                                 'finite_target_branches':[enc(a) for a in values],
                                 'identity_constant':enc(constant)})
                    print('CERTIFIED FOUR-TRIPLE MAP',chart,single,flush=True)
            print('chart',chart,'singleton',single,'partitions',count,'fourth passes',fourth_passes,'maps',len(hits),flush=True)
        assert count==200200
        charts.append({'chart':chart,'old_point_at_new_infinity':None if c is None else enc(c),
                       'partitions':count,'candidates':candidates,'fourth_triple_passes':fourth_passes,'maps':hits})
    if args.all_charts:
        assert sum(len(c['maps']) for c in charts)==2*len(planes)
    result={'status':'PASS bounded profile search','scope':__doc__,
            'all_charts':args.all_charts,'model_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'field_modulus':[int(a) for a in k.modulus()],'tau':enc(tau),
            'charts':charts,'unique_map_planes':len(planes),'seconds':time.monotonic()-start}
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('PASS map planes:',len(planes),flush=True)


if __name__=='__main__':
    main()
