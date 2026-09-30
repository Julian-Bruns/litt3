#!/usr/bin/env sage-python
"""Exact profile (5,3,3,1,1,1) search for the fixed genus-six repair.

One source branch point is moved to infinity and is a singleton fiber.
Use --all-charts for all fourteen choices. This does not test the remaining
profile (3,3,3,3,1,1). A Jacobian factor is never used as a curve map.
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
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    source = Path(args.model)
    data = json.loads(source.read_text())
    assert data['label'] == 'pair_4_5'
    k = GF(5**20, 'a')
    r = PolynomialRing(k, 'x')
    x = r.gen()
    key = lambda a: tuple(int(c) for c in a.polynomial())
    tau = sorted(r(data['field_modulus']).roots(multiplicities=False), key=key)[0]
    dec = lambda v: sum(k(c)*tau**i for i,c in enumerate(v))
    f0 = r([dec(c) for c in data['hyperelliptic_polynomial']])
    branch = sorted(f0.roots(multiplicities=False), key=key)
    assert len(branch) == 13
    enc = lambda a: [int(a.polynomial()[i]) for i in range(20)]

    def square_quartic(v):
        if len(v) != 5 or v[4] == 0:
            return False
        a,b = 4*v[4]*v[2]-v[3]**2, 8*v[4]**2
        return v[1]*b == v[3]*a and v[0]*b*b == v[4]*a*a

    start = time.monotonic()
    charts, planes = [], set()
    for chart,c in enumerate([None]+(branch if args.all_charts else [])):
        if c is None:
            f, roots = f0, branch
        else:
            f = sum(f0[i]*x**(14-i)*(c*x+1)**i for i in range(14))
            roots = sorted([k(0)]+[1/(a-c) for a in branch if a!=c], key=key)
        assert f.degree()==13 and all(f(a)==0 for a in roots)
        fm = f.monic()
        inv_derivatives = [1/fm.derivative()(a) for a in roots]
        tested, first, hits = 0,0,[]
        for full in itertools.combinations(range(13),5):
            b = r.one()
            for i in full:
                b *= x-roots[i]
            bv = b.list()
            remain = [i for i in range(13) if i not in full]
            weights0 = {i:b(roots[i])**2*inv_derivatives[i] for i in remain}
            for singles in itertools.combinations(remain,2):
                u,v = [roots[i] for i in singles]
                six = [i for i in remain if i not in singles]
                D,rem = fm.quo_rem(b*(x-u)*(x-v))
                assert rem==0 and D.degree()==6
                columns, weights = {},{}
                for i in six:
                    a = roots[i]
                    w = weights0[i]*(a-u)*(a-v)
                    q,rem = D.quo_rem(x-a)
                    assert rem==0
                    weights[i] = w
                    columns[i] = [w*(q[j]-bv[j]) for j in range(5)]
                # Each unordered 3+3 partition is represented by the triple
                # containing the first point. The complementary numerator is -N.
                for pair in itertools.combinations(six[1:],2):
                    triple = (six[0],)+pair
                    tested += 1
                    nv = [sum(columns[i][j] for i in triple) for j in range(5)]
                    if not square_quartic(nv):
                        continue
                    first += 1
                    n = r(nv)
                    top = sum(weights[i] for i in triple)
                    values = [k(0),1-top,-top]
                    if len(set(values)) != 3:
                        continue
                    valid = True
                    other = [i for i in six if i not in triple]
                    for tri,lam in [(triple,values[1]),(other,values[2])]:
                        tpoly = r.one()
                        for i in tri:
                            tpoly *= x-roots[i]
                        q,rem = (n-lam*b).quo_rem(tpoly)
                        assert rem==0
                        if q.degree()!=2 or q[1]**2 != 4*q[2]*q[0] or q.gcd(tpoly)!=1:
                            valid = False
                            break
                    if not valid:
                        continue
                    for a in (u,v):
                        lam = n(a)/b(a)
                        if lam in values:
                            valid=False
                            break
                        q,rem = (n-lam*b).quo_rem(x-a)
                        assert rem==0
                        if q(a)==0 or not square_quartic(q.list()):
                            valid=False
                            break
                        values.append(lam)
                    if not valid:
                        continue
                    w = n.derivative()*b-n*b.derivative()
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
                    hits.append({'full_fiber':list(full),'singles':list(singles),
                                 'first_triple':list(triple),'original_coordinate_plane':list(plane),
                                 'finite_target_branches':[enc(a) for a in values],
                                 'identity_constant':enc(constant)})
                    print('CERTIFIED NEW PROFILE MAP',chart,flush=True)
        assert tested==360360
        charts.append({'chart':chart,'old_point_at_new_infinity':None if c is None else enc(c),
                       'partitions':tested,'first_square_passes':first,'maps':hits})
        print('chart',chart,'first square passes',first,'maps',len(hits),flush=True)
    if args.all_charts:
        assert sum(len(c['maps']) for c in charts)==3*len(planes)
    result={'status':'PASS bounded profile search','scope':__doc__,
            'all_charts':args.all_charts,'model_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'field_modulus':[int(a) for a in k.modulus()],'tau':enc(tau),
            'charts':charts,'unique_map_planes':len(planes),'seconds':time.monotonic()-start}
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('PASS map planes:',len(planes),flush=True)


if __name__=='__main__':
    main()
