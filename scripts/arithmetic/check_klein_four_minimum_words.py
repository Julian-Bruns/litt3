#!/usr/bin/env python3
"""Independent direct polynomial check of the minimum-word endpoint test.

This reconstructs the vanishing polynomial from the actual complementary
roots and solves the *quotient* coefficient equations, rather than using
the exhaustive evaluator's elementary-symmetric cofactor routine.
The samples validate formulas and arithmetic, not exhaustive coverage.
"""
import argparse
import itertools
import json
import random
from pathlib import Path
import klein_four_constant_character_jet as J

f=J.F.f
D=J.F.D7
Z=(0,)*7
O=(1,)+(0,)*6
ADD=J.F.ADD;MUL=J.F.MUL;NEG=J.F.NEG


def add(a,b):return tuple(ADD[x][y] for x,y in zip(a,b))
def neg(a):return tuple(NEG[x] for x in a)
def sub(a,b):return add(a,neg(b))
def scale(a,c):return tuple(MUL[x][c] for x in a)
def mul(a,b):
    r=[0]*13
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b):
                if y:r[i+j]=ADD[r[i+j]][MUL[x][y]]
    for i in range(12,6,-1):
        if r[i]:
            x=r[i]
            for j,c in enumerate(D):r[i-7+j]=ADD[r[i-7+j]][NEG[MUL[x][c]]]
    assert not any(r[7:])
    return tuple(r[:7])
def power(a,n):
    out=O
    while n:
        if n&1:out=mul(out,a)
        a=mul(a,a);n//=2
    return out
def inv(a):
    assert a!=Z
    b=power(a,25**7-2);assert mul(a,b)==O
    return b
def pmul(a,b):
    r=[Z]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):r[i+j]=add(r[i+j],mul(x,y))
    return r
def polyval(p,x):
    v=Z
    for c in reversed(p):v=add(mul(v,x),c)
    return v
def kernel_one(rows,ncols):
    a=[list(row) for row in rows];piv=[];k=0
    for c in range(ncols):
        j=next((j for j in range(k,len(a)) if a[j][c]!=Z),None)
        if j is None:continue
        a[k],a[j]=a[j],a[k];v=inv(a[k][c]);a[k]=[mul(x,v) for x in a[k]]
        for j in range(len(a)):
            if j!=k and a[j][c]!=Z:
                v=a[j][c];a[j]=[sub(x,mul(v,y)) for x,y in zip(a[j],a[k])]
        piv.append(c);k+=1
        if k==len(a):break
    free=[j for j in range(ncols) if j not in piv]
    assert len(free)==1
    v=[Z]*ncols;v[free[0]]=O
    for row,c in enumerate(piv):v[c]=neg(a[row][free[0]])
    for row in rows:
        total=Z
        for x,y in zip(row,v):total=add(total,mul(x,y))
        assert total==Z
    return v


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    zeta=(0,1,0,0,0,0,0)
    zs=[power(zeta,i) for i in range(29)]
    assert power(zeta,29)==O and len(set(zs))==29
    rng=random.Random(26092617);results=[]
    for d in range(6):
        n=13-2*d
        choices=[list(range(n))]+[sorted([0]+rng.sample(range(1,29),n-1)) for _ in range(3)]
        for subset in choices:
            complement=[i for i in range(29) if i not in subset]
            C=[O]
            for i in complement:C=pmul(C,[neg(zs[i]),O])
            degree_q=6-d
            def coeff(i):return C[i] if 0<=i<len(C) else Z
            matrix=[[coeff(j-r) for r in range(degree_q+1)] for j in range(16+d,22)]
            Q=kernel_one(matrix,degree_q+1)
            F=pmul(C,Q)
            assert all(F[j]==Z for j in range(16+d,22))
            T=[scale(F[22+r],3) for r in range(d+1)]
            assert any(t!=Z for t in T)
            # A second kernel, now using the elementary-complement formulas.
            E=[O]
            for i in subset:E=pmul(E,[O,neg(zs[i])])
            def hv(i):return E[i] if 0<=i<len(E) else Z
            HM=[[hv(7-2*d+row+r) for r in range(d+1)] for row in range(d)]
            for row in HM:
                value=Z
                for x,y in zip(row,T):value=add(value,mul(x,y))
                assert value==Z
            q0=Z;qi=Z
            for r,t in enumerate(T):
                q0=add(q0,mul(t,hv(6-2*d+r)))
                qi=add(qi,mul(t,hv(7-d+r)))
            qi=neg(qi)
            assert F[0]==scale(mul(C[0],q0),2)
            assert F[15+d]==scale(qi,2)
            zeros=[i for i,z in enumerate(zs) if polyval(F,z)==Z]
            assert zeros==complement
            norms=[]
            for numer,denom in ((q0,T[0]),(qi,T[-1])):
                if denom==Z:norms.append(None)
                else:
                    norm=power(mul(numer,inv(denom)),29)
                    norms.append(list(norm))
            results.append({'d':d,'complementary_nodes':subset,
                            'zero_set_exact':True,'endpoint_norms':norms})
    out={'status':'PASS','scope':'24 direct polynomial reconstructions, independent of the exhaustive cofactor algorithm; this sample check does not replace exhaustive orbit coverage.',
         'count':len(results),'checks':results}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS:',len(results),'direct quotient-polynomial reconstructions and both endpoint identities.')


if __name__=='__main__':main()
