#!/usr/bin/env python3
"""Independent direct-field samples and exact polynomial identity checks.

This reverses the tower used by the exhaustive C++ endpoint enumeration.
Its bounded endpoint samples check implementation, not completeness.
The separate exhaustive evaluator certifies all 853615 forced tuples.
"""
import argparse
import itertools
import json
from pathlib import Path
import random
import check_klein_four_constant_character_jet as C

F=C.F

def endpoint_checks():
    data=F.construct_data()
    roots=list(map(tuple,data['alpha_roots']))
    bases=list(map(tuple,data['B_base']))
    omega=(F.ZERO,F.ONE)+(F.ZERO,)*5
    powers=[C.power(omega,i) for i in range(29)]
    assert C.power(omega,29)==C.O
    constants=[]
    for alpha in roots:
        ap=F.ev(F.f.der(F.f.A),alpha)
        leading=F.es(F.ei(ap),13)
        correction=F.ea(F.em(F.ev(F.f.der(F.f.P),alpha),F.ei(F.ev(F.f.P,alpha))),
                        F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),alpha),F.ei(ap))))
        constants.append((leading,correction))
    rng=random.Random(26092671)
    result=[]
    for tags in itertools.combinations_with_replacement(range(4),4):
        phases=[(0,0,0,0),(0,0,1,2),(0,1,1,1),(0,1,2,3)]
        phases += [(0,*[rng.randrange(29) for _ in range(3)]) for _ in range(4)]
        for phase in phases:
            labels=[]
            for root,exponent in zip(tags,phase):
                b=C.times(C.lift(bases[root]),powers[exponent])
                a=C.times(C.lift(constants[root][0]),C.power(b,4))
                c=C.times(C.times(b,a),C.lift(constants[root][1]))
                labels.append((C.lift(roots[root]),b,a,c))
            fs=[]
            for signs in C.G.SIGNS:
                row=[]
                for coordinate in range(4):
                    value=C.Z
                    for label,sign in zip(labels,signs):
                        value=C.plus(value,C.scalar(label[coordinate],sign))
                    row.append(value)
                fs.append(row)
            zero_denominators=sum(row[1]==C.Z for row in fs)
            entry={'roots':tags,'phases':phase,'zero_denominators':zero_denominators}
            if zero_denominators:
                assert zero_denominators>=2
                for row in fs:
                    if row[1]==C.Z: assert row[0]==row[2]==row[3]==C.Z
            else:
                value=derivative=C.Z
                for i in range(3):
                    j,k=(i+1)%3,(i+2)%3
                    value=C.plus(value,C.times(fs[i][0],C.times(fs[j][1],fs[k][1])))
                    derivative=C.plus(derivative,C.times(fs[i][2],C.times(fs[j][1],fs[k][1])))
                    derivative=C.plus(derivative,C.times(fs[i][0],C.plus(
                        C.times(fs[j][3],fs[k][1]),C.times(fs[j][1],fs[k][3]))))
                entry['zero_value_sum']=value==C.Z
                entry['zero_derivative_sum']=derivative==C.Z
                assert (value==C.Z)==(tags[0]==tags[-1])
                assert value!=C.Z or derivative!=C.Z
            result.append(entry)
    assert len(result)==280
    return result

def polynomial_checks():
    # Independent sparse formal expansion over F5, in variables (x,t1,t2,t3,f1,f2,f3).
    variables=7
    def monomial(i):
        exponent=[0]*variables; exponent[i]=1
        return {tuple(exponent):1}
    one={(0,)*variables:1}
    def add(*polys):
        out={}
        for p in polys:
            for m,a in p.items():
                out[m]=(out.get(m,0)+a)%5
                if not out[m]:del out[m]
        return out
    def scale(p,a):return {m:a*c%5 for m,c in p.items() if a*c%5}
    def mul(*polys):
        out=one
        for p in polys:
            new={}
            for m,a in out.items():
                for n,b in p.items():
                    e=tuple(x+y for x,y in zip(m,n))
                    new[e]=(new.get(e,0)+a*b)%5
            out={m:a for m,a in new.items() if a}
        return out
    def power(p,n):
        out=one
        for _ in range(n):out=mul(out,p)
        return out
    x=monomial(0); ts=[monomial(i) for i in (1,2,3)]; fs=[monomial(i) for i in (4,5,6)]
    high=add(power(x,29),one)
    bs=[add(mul(high,t),mul(power(x,7),f)) for t,f in zip(ts,fs)]
    total=mul(*ts)
    lin=add(*[mul(fs[i],ts[(i+1)%3],ts[(i+2)%3]) for i in range(3)])
    quad=add(*[mul(fs[i],fs[j],ts[k]) for i,j,k in ((0,1,2),(0,2,1),(1,2,0))])
    g=add(mul(power(x,7),quad),scale(mul(high,lin),2),scale(mul(power(x,22),total),2))
    rhs=add(*[mul(bs[i],bs[j],ts[k]) for i,j,k in ((0,1,2),(0,2,1),(1,2,0))],
            scale(mul(power(add(power(x,29),scale(one,-1)),2),total),2))
    assert mul(power(x,7),g)==rhs
    assert add(one,power(add(power(x,29),scale(one,-1)),5))==power(x,145)
    return {'global_identity_terms':len(rhs),'fifth_power_approximation':'exact','status':'PASS'}

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    poly=polynomial_checks()
    endpoints=endpoint_checks()
    result={'status':'PASS','scope':'280 independent bounded endpoint samples, plus exact multivariate polynomial identities; exhaustive coverage is the separate C++ evaluator.',
            'polynomial_checks':poly,'endpoint_checks':endpoints}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: exact polynomial identities and',len(endpoints),'direct endpoint samples')

if __name__=='__main__':main()
