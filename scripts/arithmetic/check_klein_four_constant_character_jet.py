#!/usr/bin/env python3
"""Independent field evaluation of the retained first-jet determinant.

The exhaustive C++ verifier uses sparse exponent evaluation. This check
instead computes in the field K[omega]/D7, building all three jet rows
and their determinant directly. Bounded test coverage is explicit; it
does not replace the exhaustive label enumeration.
"""
from pathlib import Path
import argparse
import importlib.util
import json
import random
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
import klein_four_constant_character_jet as G
F=G.F
Z=(F.ZERO,)*7
O=(F.ONE,)+(F.ZERO,)*6


def plus(a,b): return tuple(F.ea(x,y) for x,y in zip(a,b))
def neg(a): return tuple(F.en(x) for x in a)
def minus(a,b): return plus(a,neg(b))
def lift(c): return (tuple(c),)+(F.ZERO,)*6
def scalar(a,s): return tuple(F.es(x,s) for x in a)


def times(a,b):
    r=[F.ZERO]*13
    for i,x in enumerate(a):
        if x==F.ZERO: continue
        for j,y in enumerate(b):
            if y!=F.ZERO: r[i+j]=F.ea(r[i+j],F.em(x,y))
    for e in range(12,6,-1):
        if r[e]!=F.ZERO:
            c=r[e]
            for j,d in enumerate(F.D7):
                r[e-7+j]=F.ea(r[e-7+j],F.en(F.es(c,d)))
    assert all(c==F.ZERO for c in r[7:])
    return tuple(r[:7])


def power(a,n):
    out=O
    while n:
        if n&1:out=times(out,a)
        a=times(a,a);n//=2
    return out


def det(rows):
    return plus(minus(times(rows[0][0],minus(times(rows[1][1],rows[2][2]),times(rows[1][2],rows[2][1]))),
                      times(rows[0][1],minus(times(rows[1][0],rows[2][2]),times(rows[1][2],rows[2][0])))),
                times(rows[0][2],minus(times(rows[1][0],rows[2][1]),times(rows[1][1],rows[2][0]))))


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('data',type=Path)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    data=json.loads(args.data.read_text())
    old=F.construct_data()
    assert data['root_data']==old
    roots=list(map(tuple,old['alpha_roots']))
    bases=list(map(tuple,old['B_base']))
    omega=(F.ZERO,F.ONE)+(F.ZERO,)*5
    powers=[power(omega,i) for i in range(29)]
    assert power(omega,29)==O and omega!=O
    constants=[]
    for alpha in roots:
        p=F.ev(F.f.P,alpha);apv=F.ev(F.f.der(F.f.A),alpha)
        c=F.es(F.ei(apv),13)
        v=F.ea(F.em(F.ev(F.f.der(F.f.P),alpha),F.ei(p)),
               F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),alpha),F.ei(apv))))
        constants.append((c,v))
    rng=random.Random(260926)
    checks=[]
    for case in data['cases']:
        tags=case['roots']
        for exponent in [(0,0,0,0),(0,0,1,2),(0,1,1,1),(0,1,2,3),(0,28,27,26)] + [(0,*[rng.randrange(29) for _ in range(3)]) for j in range(7)]:
            labels=[]
            for i,e in zip(tags,exponent):
                B=times(lift(bases[i]),powers[e])
                a=times(lift(constants[i][0]),power(B,4))
                c=times(times(B,a),lift(constants[i][1]))
                labels.append((lift(roots[i]),B,a,c))
            fs=[]
            for signs in G.SIGNS:
                row=[]
                for j in range(4):
                    value=Z
                    for sign,label in zip(signs,labels):value=plus(value,scalar(label[j],sign))
                    row.append(value)
                fs.append(row)
            rows=[[times(B,B),times(alpha,B),minus(times(a,B),times(alpha,c))]
                  for alpha,B,a,c in fs]
            direct=det(rows)
            sparse=Z
            for term in case['determinant']:
                exponent_sum=sum(a*b for a,b in zip(term[:4],exponent))%29
                sparse=plus(sparse,times(lift(term[4:]),powers[exponent_sum]))
            assert direct==sparse,(tags,exponent)
            open_checks=[b!=Z for alpha,b,a,c in fs]
            open_checks += [minus(times(fs[i][0],fs[j][1]),times(fs[j][0],fs[i][1]))!=Z
                            for i,j in ((0,1),(0,2),(1,2))]
            if all(open_checks):assert direct!=Z,(tags,exponent)
            checks.append({'roots':tags,'exponents':exponent,'open':all(open_checks),
                           'determinant_nonzero':direct!=Z})
    out={'status':'PASS','scope':'Independent direct field evaluation on84 specified/bounded samples; exhaustive coverage is the separate C++ run.',
         'checks':checks,'count':len(checks)}
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS:',len(checks),'independent direct field evaluations')


if __name__=='__main__':main()
