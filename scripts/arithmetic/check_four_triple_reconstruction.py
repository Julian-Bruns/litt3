#!/usr/bin/env sage-python
"""Positive control for the four-triple map reconstruction.

Start with an independent explicit rational map, construct its smooth
genus-six/genus-two etale cover, forget the map, and recover its pencil
from the four Weierstrass triples by the four-sign interpolation rule.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    k=GF(5**16,'a')
    r=PolynomialRing(k,'x');x=r.gen()
    a=sorted((x*x+4*x+2).roots(multiplicities=False),
             key=lambda a:tuple(int(c) for c in a.polynomial()))[0]
    N=x*(x*x-1)**2;D=(x*x-a)**2
    W=N.derivative()*D-N*D.derivative()
    fy=[k(0),2*a+4,k(0),k(4),k(0),k(1)]
    left=sum(fy[i]*N**i*D**(6-i) for i in range(6))
    f,rem=left.quo_rem(W**2)
    assert rem==0 and f.degree()==13 and f.gcd(f.derivative())==1
    roots=f.roots(multiplicities=False)
    assert len(roots)==13
    groups={}
    for u in roots:
        assert D(u)!=0
        lam=N(u)/D(u)
        groups.setdefault(lam,[]).append(u)
    assert sorted(len(v) for v in groups.values())==[1,3,3,3,3]
    triples=[v for v in groups.values() if len(v)==3]
    expected=matrix(k,[[p[j] for j in range(6)] for p in (N,D)]).echelon_form()
    recoveries=[]
    # All choices of which three of the four fibers normalize 0,infinity,1.
    for order in itertools.permutations(range(4)):
        A,B,C,E=[triples[j] for j in order]
        aa=r.one();bb=r.one()
        for u in A:aa*=x-u
        for u in B:bb*=x-u
        v=[(bb(u)/aa(u)).sqrt() for u in C]
        found=0
        for s2,s3 in ((1,1),(1,-1),(-1,1),(-1,-1)):
            c1,c2,c3=C;w1,w2,w3=v[0],s2*v[1],s3*v[2]
            if len({w1,w2,w3})!=3:continue
            k1=(w3-w2)*(c3-c1);k2=(w3-w1)*(c3-c2)
            l=(w1*k1-w2*k2)*x-w1*k1*c2+w2*k2*c1
            m=(k1-k2)*x-k1*c2+k2*c1
            if not l or not m or l.gcd(m).degree()!=0:continue
            assert all(l(u)==v0*m(u) for u,v0 in zip(C,(w1,w2,w3)))
            n=aa*l*l;b=bb*m*m
            if n.gcd(b).degree()!=0:continue
            mat=matrix(k,[[p[j] for j in range(6)] for p in (n,b)]).echelon_form()
            if mat==expected:found+=1
        assert found==1
        recoveries.append({'fiber_order':list(order),'known_pencil_recoveries':found})
    enc=lambda z:[int(z.polynomial()[j]) for j in range(16)]
    result={'status':'PASS independent positive map control',
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'field_modulus':[int(a) for a in k.modulus()],'quadratic_parameter':enc(a),
            'source_polynomial':[enc(c) for c in f],
            'target_polynomial':[enc(c) for c in fy],
            'map_numerator':[enc(c) for c in N],'map_denominator':[enc(c) for c in D],
            'smooth_source_genus':6,'smooth_target_genus':2,
            'full_cover_identity_verified':True,'recoveries':recoveries}
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: known etale degree-five map recovered in all 24 fiber orders')


if __name__=='__main__':main()
