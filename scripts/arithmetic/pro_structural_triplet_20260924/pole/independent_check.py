#!/usr/bin/env python3
"""Independent standard-library checker for the finite endpoint certificate.

Field addition uses 3+3+1 base-five digits (the C++ implementation uses 4+3).
The large certificate is checked by left-null-vector multiplication, not by
rerunning the generator's Gaussian elimination. Only the 30 exceptional
systems need rank calculations. Quadratic completeness is checked by
factorization or the nonsquare discriminant criterion, not a point scan.
"""
from __future__ import annotations
import argparse
import json
import struct
from pathlib import Path
from itertools import combinations

ROOT=Path(__file__).resolve().parents[1]
Q=5**7
ORDER=Q-1
ADD=[[0]*125 for _ in range(125)]
for a in range(125):
    for b in range(125):
        aa,bb,place,value=a,b,1,0
        for _ in range(3):
            value+=((aa%5+bb%5)%5)*place
            aa//=5;bb//=5;place*=5
        ADD[a][b]=value

def add(a:int,b:int)->int:
    return ADD[a%125][b%125]+125*ADD[(a//125)%125][(b//125)%125]+15625*((a//15625+b//15625)%5)

def slowmul(a:int,b:int)->int:
    aa=[];bb=[]
    for _ in range(7):
        aa.append(a%5);a//=5;bb.append(b%5);b//=5
    c=[0]*13
    for i,x in enumerate(aa):
        for j,y in enumerate(bb):
            c[i+j]=(c[i+j]+x*y)%5
    for i in range(12,6,-1):
        c[i-7]=(c[i-7]-c[i])%5
        c[i-6]=(c[i-6]-c[i])%5
    return sum(c[i]*5**i for i in range(7))

def times_generator(a:int)->int:
    # Multiplication by 9 = t+4 modulo t^7+t+1, independently of log tables.
    c=[]
    for _ in range(7):c.append(a%5);a//=5
    d=[4*c[0]-c[6],4*c[1]+c[0]-c[6]]+[4*c[i]+c[i-1] for i in range(2,7)]
    return sum((x%5)*5**i for i,x in enumerate(d))

EXP=[0]*(2*ORDER)
LOG=[-1]*Q
z=1
for i in range(ORDER):
    assert z!=0 and LOG[z]==-1, 'generator did not visit every nonzero residue exactly once'
    LOG[z]=i;EXP[i]=z;z=times_generator(z)
assert z==1 and all(i>=0 for i in LOG[1:])
EXP[ORDER:]=EXP[:ORDER]
NEG=[0]*Q
for i in range(Q):
    a=i;v=0;p=1
    for _ in range(7):v+=((-a%5)%5)*p;a//=5;p*=5
    NEG[i]=v

def sub(a:int,b:int)->int:return add(a,NEG[b])
def mul(a:int,b:int)->int:return EXP[LOG[a]+LOG[b]] if a and b else 0
def inv(a:int)->int:
    if not a:raise ZeroDivisionError
    return EXP[ORDER-LOG[a]]
def power(a:int,n:int)->int:
    if not n:return 1
    return EXP[(LOG[a]*n)%ORDER] if a else 0
S2=[mul(2,x) for x in range(Q)]
S3=[mul(3,x) for x in range(Q)]
FROB=[power(x,5) for x in range(Q)]

# C = F_{5^14} = F_{5^7}(j), j^2=2. Elements are (a,b)=a+b*j.
CZERO=(0,0);CONE=(1,0)
def ca(x,y):return (add(x[0],y[0]),add(x[1],y[1]))
def cn(x):return (NEG[x[0]],NEG[x[1]])
def cs(x,y):return ca(x,cn(y))
def cm(x,y):return (add(mul(x[0],y[0]),S2[mul(x[1],y[1])]),add(mul(x[0],y[1]),mul(x[1],y[0])))
def ci(x):
    d=inv(sub(mul(x[0],x[0]),S2[mul(x[1],x[1])]))
    return (mul(x[0],d),NEG[mul(x[1],d)])
def cp(x,n):
    r=CONE
    while n:
        if n&1:r=cm(r,x)
        x=cm(x,x);n//=2
    return r
def cf(x):return (FROB[x[0]],NEG[FROB[x[1]]])
def code(n):return ((n%5+3*(n//5))%5,n//5)

# L = C(alpha), A(alpha)=0, [1,alpha,alpha^2,alpha^3] basis.
LZERO=(CZERO,)*4
LONE=(CONE,CZERO,CZERO,CZERO)
MONIC=tuple(code(i) for i in (5,2,6,7))
def la(x,y):return tuple(ca(a,b) for a,b in zip(x,y))
def ln(x):return tuple(cn(a) for a in x)
def ls(x,y):return la(x,ln(y))
def lscale(x,c):return tuple(cm(a,c) for a in x)
def lm(x,y):
    out=[CZERO]*7
    for i in range(4):
        for j in range(4):out[i+j]=ca(out[i+j],cm(x[i],y[j]))
    for i in range(6,3,-1):
        for j in range(4):out[i-4+j]=cs(out[i-4+j],cm(out[i],MONIC[j]))
    return tuple(out[:4])
def lp(x,n):
    r=LONE
    while n:
        if n&1:r=lm(r,x)
        x=lm(x,x);n//=2
    return r
def row(values):return tuple(code(v) for v in values)
def flat(x):return [v for c in x for v in c]
def project(x):
    # Projection with kernel C^2 F, where C=2*[22], C^2=2+3j.
    return flat(x)[2:]+[sub(S3[x[0][0]],S2[x[0][1]])]

ZETA=(45685,35188)
ZPOW=[CONE]
for _ in range(28):ZPOW.append(cm(ZPOW[-1],ZETA))
assert cp(ZETA,29)==CONE and ZETA!=CONE
assert cp(ZETA,5**7)==ci(ZETA)
B=row((1,3,8,15));M=row((22,7,9,23))
EP=[]
for root in range(4):
    for exponent in range(29):
        EP.append((lscale(B,ZPOW[(8*exponent)%29]),lscale(M,ZPOW[(5*exponent)%29])))
    B=lp(B,25);M=lp(M,25)
assert B==row((1,3,8,15)) and M==row((22,7,9,23))
C0=cm(code(22),(2,0));CJ=cm(C0,(0,1));CSQ=cm(C0,C0)
assert CSQ==(2,3)

def system(case):
    z,f,g=case
    c=lscale(la(EP[0][0],EP[z][0]),(3,0));a=lscale(la(EP[0][1],EP[z][1]),(3,0))
    d=lscale(la(EP[f][0],EP[g][0]),(3,0));b=lscale(la(EP[f][1],EP[g][1]),(3,0))
    constant=ls(lm(c,d),lm(a,b))
    columns=[lscale(la(c,d),C0),lscale(ls(c,d),CJ),ln(lscale(la(a,b),C0)),lscale(ls(a,b),CJ)]
    cols=[project(v) for v in columns];rhs=[NEG[v] for v in project(constant)]
    augmented=[[cols[j][i] for j in range(4)]+[rhs[i]] for i in range(7)]
    return augmented,constant,columns

def norm(x):return sub(sub(mul(x[0],x[0]),S2[mul(x[1],x[1])]),sub(mul(x[2],x[2]),S2[mul(x[3],x[3])]))
def residual(constant,columns,x):
    v=constant
    for col,c in zip(columns,x):v=la(v,lscale(col,(c,0)))
    return la(v,(cm(CSQ,(norm(x),0)),CZERO,CZERO,CZERO))

def rank(matrix):
    a=[list(r) for r in matrix];rr=0
    for c in range(len(a[0])):
        p=next((i for i in range(rr,len(a)) if a[i][c]),None)
        if p is None:continue
        a[rr],a[p]=a[p],a[rr]
        for i in range(rr+1,len(a)):
            factor=mul(a[i][c],inv(a[rr][c]))
            for j in range(c,len(a[0])):a[i][j]=sub(a[i][j],mul(factor,a[rr][j]))
        rr+=1
        if rr==len(a):break
    return rr

def dot(a,b):
    out=0
    for x,y in zip(a,b):out=add(out,mul(x,y))
    return out

def fourier(x):
    moments=[CZERO]*29
    for start,value in ((2,(x[0],x[1])),(6,(x[2],x[3]))):
        e=start
        for _ in range(14):moments[e]=value;e=e*5%29;value=cf(value)
        assert e==start
    base=[]
    for i in range(29):
        v=CZERO
        for j in range(1,29):v=ca(v,cm(moments[j],ZPOW[(-i*j)%29]))
        v=cm(v,(4,0));assert v[1]==0 and 0<=v[0]<5
        base.append(v[0])
    return base

def check_exceptions(data):
    expected={(0,58,58)}|{(58,29+a,87+a) for a in range(29)}
    assert {tuple(s['case']) for s in data['systems']}==expected
    counts={3:0,4:0};candidates=0;distinct_counts={}
    for entry in data['systems']:
        aug,co,cols=system(entry['case'])
        assert aug==entry['augmented']
        r=rank([a[:4] for a in aug]);assert r==entry['rank']==rank(aug)
        counts[r]+=1
        particular=entry['particular']
        assert all(dot(a[:4],particular)==a[4] for a in aug)
        basis=entry['kernel']
        assert len(basis)==4-r and (not basis or rank(basis)==len(basis))
        for v in basis:assert all(dot(a[:4],v)==0 for a in aug)
        if r==4:
            value=residual(co,cols,particular)
            assert flat(value)==entry['full_residual'] and value!=LZERO
            continue
        v=basis[0]
        # Expand the residual polynomial directly, independently of the
        # generator's interpolation at 0,1,-1.
        bilinear=sub(sub(S2[mul(particular[0],v[0])],mul(4,mul(particular[1],v[1]))),sub(S2[mul(particular[2],v[2])],mul(4,mul(particular[3],v[3]))))
        linear=LZERO
        for col,c in zip(cols,v):linear=la(linear,lscale(col,(c,0)))
        linear=la(linear,(cm(CSQ,(bilinear,0)),CZERO,CZERO,CZERO))
        pol=[residual(co,cols,particular),linear,(cm(CSQ,(norm(v),0)),CZERO,CZERO,CZERO)]
        coeff=[]
        for value in pol:
            assert value[1:]==(CZERO,)*3
            c=cm(value[0],ci(CSQ));assert c[1]==0;coeff.append(c[0])
        assert coeff==entry['quadratic'] and coeff[2]!=0
        k0,k1,k2=coeff;roots=entry['roots']
        if not roots:
            disc=sub(mul(k1,k1),mul(4,mul(k0,k2)))
            assert disc!=0 and power(disc,ORDER//2)==4
        else:
            assert len(roots)==2 and roots[0]!=roots[1]
            assert k0==mul(k2,mul(*roots)) and k1==NEG[mul(k2,add(*roots))]
        assert len(entry['candidates'])==len(roots)
        for root,candidate in zip(roots,entry['candidates']):
            assert root==candidate['parameter']
            x=[add(a,mul(root,b)) for a,b in zip(particular,v)]
            assert x==candidate['moments'] and residual(co,cols,x)==LZERO
            base=fourier(x)
            assert base==candidate['fourier_base']
            number=len(set(base));assert number==candidate['distinct_values'] and number>=4
            distinct_counts[number]=distinct_counts.get(number,0)+1;candidates+=1
    assert counts=={3:29,4:1} and candidates==42 and distinct_counts=={4:7,5:35}
    print('PASS: independent checks of all 30 affine solution spaces and their ranks.',flush=True)
    print('PASS: exact factorization/nonsquare-discriminant checks exhaust the 29 quadratics.',flush=True)
    print('PASS: all 42 moment vectors verified; 7 rows have 4 residues, 35 have 5.',flush=True)

def check_all_witnesses(path:Path):
    blob=path.read_bytes();assert len(blob)==16+787176*28 and blob[:8]==b'SFCPLIN1'
    assert struct.unpack_from('<II',blob,8)==(787176,7)
    expected={(0,58,58)}|{(58,29+a,87+a) for a in range(29)}
    # Cache projected column components; the row construction here is
    # independent of C++ system_at (which builds the complete field equation).
    eb=[project(lscale(e[0],C0)) for e in EP]
    ejb=[project(lscale(e[0],CJ)) for e in EP]
    em=[project(lscale(e[1],C0)) for e in EP]
    ejm=[project(lscale(e[1],CJ)) for e in EP]
    pair_data=[]
    for f in range(116):
        for g in range(f,116):
            vals=[[S3[add(v[f][i],v[g][i])] for i in range(7)] for v in (eb,ejb,em,ejm)]
            pair_data.append((f,g,*vals))
    offset=16;total=0;bad=0;special=0
    for z in range(116):
        zb,zjb,zm,zjm=[[S3[add(v[0][i],v[z][i])] for i in range(7)] for v in (eb,ejb,em,ejm)]
        c=lscale(la(EP[0][0],EP[z][0]),(3,0));a=lscale(la(EP[0][1],EP[z][1]),(3,0))
        constants=[project(lscale(ls(lm(c,e[0]),lm(a,e[1])),(3,0))) for e in EP]
        for f,g,ib,ijb,im,ijm in pair_data:
            w=struct.unpack_from('<7I',blob,offset);offset+=28;total+=1
            assert all(v<Q for v in w)
            if not any(w):
                assert (z,f,g) in expected;special+=1;continue
            assert (z,f,g) not in expected
            cf0,cg0=constants[f],constants[g]
            d0=d1=d2=d3=d4=0
            for i,wi in enumerate(w):
                if not wi:continue
                d0=add(d0,mul(wi,add(zb[i],ib[i])))
                d1=add(d1,mul(wi,sub(zjb[i],ijb[i])))
                # Its negative is column 2; vanishing is unchanged.
                d2=add(d2,mul(wi,add(zm[i],im[i])))
                d3=add(d3,mul(wi,sub(zjm[i],ijm[i])))
                d4=add(d4,mul(wi,add(cf0[i],cg0[i])))
            assert (d0,d1,d2,d3,d4)==(0,0,0,0,4),(z,f,g)
            bad+=1
        if (z+1)%20==0 or z==115:
            print(f'  independent witness check: {total}/787176 cases',flush=True)
    assert offset==len(blob) and total==787176 and bad==787146 and special==30
    print('PASS: Python independently verified every one of the 787146 linear witnesses.',flush=True)

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--all-witnesses',action='store_true')
    args=parser.parse_args()
    # Exact field implementation checks with an independent multiplication routine.
    for a in range(0,Q,101):
        b=(a*a+37*a+11)%Q
        assert mul(a,b)==slowmul(a,b)
    assert power(2,ORDER//2)==4
    assert [pow(5,i,29) for i in range(14)]==[1,5,25,9,16,22,23,28,24,4,20,13,7,6]
    assert {2*pow(5,i,29)%29 for i in range(14)}|{6*pow(5,i,29)%29 for i in range(14)}==set(range(1,29))
    print('PASS: independent finite-field construction, multiplication cross-checks, and roots of unity.',flush=True)
    data=json.loads((ROOT/'data/consistent_systems.json').read_text())
    check_exceptions(data)
    if args.all_witnesses:check_all_witnesses(ROOT/'data/linear_witnesses.bin')
    print('RESULT: all requested independent certificate checks passed.',flush=True)

if __name__=='__main__':main()

