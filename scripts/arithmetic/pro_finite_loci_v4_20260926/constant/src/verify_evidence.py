#!/usr/bin/env python3
"""Independent Python verifier for the C++-generated exact certificates.

Uses only Python's standard library. No files from previous conversations,
external algebra packages, floating point arithmetic, or network are used.
"""
from array import array
from pathlib import Path
import json
import math

ROOT = Path(__file__).resolve().parents[1]
N = 390625
M = N - 1
A25 = [[(a % 5 + b % 5) % 5 + 5*((a//5+b//5) % 5)
        for b in range(25)] for a in range(25)]
M25 = [[((a%5)*(b%5)+3*(a//5)*(b//5)) % 5
        + 5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5)) % 5)
        for b in range(25)] for a in range(25)]
NEG25 = [(-a%5)+5*((- (a//5))%5) for a in range(25)]
# An addition table for two consecutive F25 digits.
A625 = array('I', (A25[a%25][b%25]+25*A25[a//25][b//25]
                  for a in range(625) for b in range(625)))

def add(a,b):
    return A625[(a%625)*625+b%625] + 625*A625[(a//625)*625+b//625]

def neg(a):
    return (NEG25[a%25] + 25*NEG25[(a//25)%25]
            + 625*NEG25[(a//625)%25] + 15625*NEG25[a//15625])

def sub(a,b):
    return add(a,neg(b))

def rawmul(a,b):
    aa=[(a//(25**i))%25 for i in range(4)]
    bb=[(b//(25**i))%25 for i in range(4)]
    c=[0]*7
    for i in range(4):
        for j in range(4):
            c[i+j]=A25[c[i+j]][M25[aa[i]][bb[j]]]
    for i in (6,5,4):
        for j,m in enumerate((5,2,6,7)):
            c[i-4+j]=A25[c[i-4+j]][NEG25[M25[c[i]][m]]]
    return sum(c[i]*(25**i) for i in range(4))

LOG=array('I',[M])*N
EXP=array('I',[0])*(2*M)
z=1
for i in range(M):
    assert z and LOG[z]==M, ('field cycle',i,z)
    LOG[z]=i
    EXP[i]=EXP[i+M]=z
    d=[(z//(25**j))%25 for j in range(4)]
    z=(NEG25[M25[d[3]][5]]
       +25*A25[d[0]][NEG25[M25[d[3]][2]]]
       +625*A25[d[1]][NEG25[M25[d[3]][6]]]
       +15625*A25[d[2]][NEG25[M25[d[3]][7]]])
assert z==1 and LOG[0]==M

def mul(a,b):
    return EXP[LOG[a]+LOG[b]] if a and b else 0

def inv(a):
    assert a, 'division by zero'
    return EXP[M-LOG[a]]

def div(a,b):
    return mul(a,inv(b))

def pw(a,n):
    if n<0:
        return pw(inv(a),-n)
    return 1 if n==0 else (EXP[(LOG[a]*n)%M] if a else 0)

assert div(neg(299833),232505)==15383
assert mul(5,5)==8

for i in range(150):
    a=(9173*i+257)%N
    b=(19391*i*i+3)%N
    assert rawmul(a,b)==mul(a,b)


def trim(a):
    while a and not a[-1]:
        a.pop()
    return a

def pa(a,b):
    c=[0]*max(len(a),len(b))
    for i,x in enumerate(a): c[i]=x
    for i,x in enumerate(b): c[i]=add(c[i],x)
    return trim(c)

def pn(a): return [neg(x) for x in a]
def ps(a,b): return pa(a,pn(b))
def sc(a,b): return trim([mul(x,b) for x in a])
def pm(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        if not x:continue
        for j,y in enumerate(b):
            if y:c[i+j]=add(c[i+j],mul(x,y))
    return trim(c)

def pp(a,n):
    b=[1]
    while n:
        if n&1:b=pm(b,a)
        n>>=1
        if n:a=pm(a,a)
    return b

def pr(a,b):
    assert b
    a=a.copy()
    q=[0]*max(0,len(a)-len(b)+1)
    ib=inv(b[-1])
    while a and len(a)>=len(b):
        i=len(a)-len(b)
        v=mul(a[-1],ib)
        q[i]=v
        for j,x in enumerate(b):a[i+j]=sub(a[i+j],mul(v,x))
        trim(a)
    return trim(q),a

def pd(a,b):
    q,r=pr(a,b)
    assert not r, 'inexact polynomial division'
    return q

def pe(a,x):
    s=0
    for y in reversed(a):s=add(mul(s,x),y)
    return s

def coeff(a,i):return a[i] if i<len(a) else 0

def mono(i,c=1):return [0]*i+[c] if c else []

P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L0=[18,20,20,15]
t=sc(pd(A,[neg(25),1]),inv(13))
assert [mul(Q[i],i%5) for i in range(1,len(Q))]==pm(P,pp(A,2))
pd(ps(Q,pp(B0,5)),pp(P,2))
pd(ps(Q,pp(L0,5)),pp(A,3))
assert pr(t,[neg(25),1])[1]  # alpha is the removed root, not a root of t
assert pd(A,t)==[mul(13,neg(25)),13]
# Direct squarefreeness checks via Euclid.
def pgcd(a,b):
    while b:a,b=b,pr(a,b)[1]
    return sc(a,inv(a[-1])) if a else []
def deriv(a):return trim([mul(a[i],i%5) for i in range(1,len(a))])
assert pgcd(P,deriv(P))==[1]
assert pgcd(A,deriv(A))==[1]
assert pgcd(P,A)==[1]
assert pgcd(t,deriv(t))==[1]


def cz():return [[],[],[]]
def cp(p):return [p,[],[]]
def cm(i,j,a=1):
    c=cz();c[j%3]=pm(mono(i,a),pp(P,j//3));return c

def ca(a,b):return [pa(a[j],b[j]) for j in range(3)]
def cn(a):return [pn(v) for v in a]
def cs(a,b):return ca(a,cn(b))
def cscale(a,b):return [sc(v,b) for v in a]
def cpm(a,p):return [pm(v,p) for v in a]
def cprod(a,b):
    c=cz()
    for i in range(3):
        for j in range(3):
            z=pm(a[i],b[j])
            if i+j>=3:z=pm(z,P)
            c[(i+j)%3]=pa(c[(i+j)%3],z)
    return c

def cdy(a,n):
    c=cz()
    for j in range(3):
        k=(j-n)%3
        c[k]=pd(a[j],pp(P,(n+k-j)//3))
    return c

def pole(a):return max((3*(len(v)-1)+10*j for j,v in enumerate(a) if v),default=-1)
def crp(a,p):return [pr(v,p)[1] for v in a]
def cry(a,n):return [pr(a[j],pp(P,(n-j+2)//3))[1] if n>j else [] for j in range(3)]

Bpow=[pp(pn(B0),i) for i in range(6)]
Lpow=[pp(pn(L0),i) for i in range(6)]
tpow=[pp(t,i) for i in range(6)]
ql=ps(Q,pp(L0,5))
Cterm=cpm(cm(0,10),tpow[3])

def constraints(G,constant):
    Nn=[cz() for _ in range(6)]
    if constant:Nn[0]=cp([1])
    for i in range(2,6):Nn[i]=G[i-2]
    if constant:Nn[5]=ca(Nn[5],cp(Q))
    rows={};num=0
    def record(c):
        nonlocal num
        for j in range(3):
            for i,v in enumerate(c[j]):
                if v:rows[(num,i,j)]=v
        num+=1
    for j in range(1,6):
        r=cz()
        for i in range(j+1):
            b=math.comb(5-i,j-i)%5
            if b:r=ca(r,cscale(cpm(Nn[i],Bpow[j-i]),b))
        record(cry(r,j))
    for j in range(5):
        r=cz()
        for i in range(6-j):
            b=math.comb(5-i,j)%5
            if b:r=ca(r,cscale(cpm(Nn[i],Lpow[5-i-j]),b))
        r=cpm(r,ql)
        if constant and j==0:r=ca(r,Cterm)
        record(crp(r,tpow[5-j]))
    for j in range(11):
        r=Nn[j] if j<=5 else cz()
        if j>=5:r=ca(r,cpm(Nn[j-5],Q))
        if constant and j==10:r=ca(r,Cterm)
        bound=10+12*j-max(0,j-5)
        record([trim([v if 3*i+10*k>bound else 0 for i,v in enumerate(r[k])])
                for k in range(3)])
    return rows


def determinant(a):
    a=[r.copy() for r in a]
    d=1
    for i in range(len(a)):
        j=next((j for j in range(i,len(a)) if a[j][i]),None)
        if j is None:return 0
        if i!=j:a[i],a[j]=a[j],a[i];d=neg(d)
        d=mul(d,a[i][i]);iv=inv(a[i][i])
        nz=[k for k in range(i+1,len(a)) if a[i][k]]
        for j in range(i+1,len(a)):
            f=mul(a[j][i],iv)
            if not f:continue
            for k in nz:a[j][k]=sub(a[j][k],mul(f,a[i][k]))
            a[j][i]=0
    return d


def series_mul(a,b):
    c=[0]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b[:7-i]):c[i+j]=add(c[i+j],mul(x,y))
    return c

def series_add(a,b):return [add(x,y) for x,y in zip(a,b)]
def series_scale(a,b):return [mul(x,b) for x in a]
def series_power(a,n):
    b=[1]+[0]*6
    for _ in range(n):b=series_mul(b,a)
    return b

def shift2(a):return [0,0]+a[:5]
Y=[1]+[0]*6
for i in range(1,7):
    target=P[10-i//3] if i%3==0 else 0
    Y[i]=mul(2,sub(target,series_power(Y,3)[i]))
Ypow=[series_power(Y,j) for j in range(3)]

def jet(c,offset):
    a=[0]*7
    for j in range(3):
        for i,v in enumerate(c[j]):
            if not v:continue
            k=offset-3*i-10*j
            assert k>=0
            for n in range(max(0,7-k)):
                a[n+k]=add(a[n+k],mul(v,Ypow[j][n]))
    return a

def fjet(G):
    a=series_scale(jet(G[0],35),3)
    b=series_scale(jet(G[1],46),2)
    c=jet(G[2],57)
    r=[0]*7
    for i in range(7):
        z=series_add(series_add(series_mul(a,series_power(r,2)),series_mul(b,r)),c)
        r[i]=div(neg(z[i]),b[0])
    assert series_add(series_add(series_mul(a,series_power(r,2)),series_mul(b,r)),c)==[0]*7
    first=series_add(jet(cp(Q),57),shift2(series_power(r,5)))
    second=series_add(jet(G[3],70),shift2(series_add(series_mul(a,series_power(r,3)),series_scale(series_mul(b,series_power(r,2)),2))))
    return series_add(series_mul(first,second),jet(Cterm,127)),r


def load(name):return json.loads((ROOT/'evidence'/name).read_text())

def evaluate_chart(chart,h,w):
    out=[]
    for curve in chart['G']:
        C=[]
        for poly in curve:
            row=[]
            for lp in poly:
                v=0
                for eh,ew,er,es,c in lp:
                    assert er==es==0
                    v=add(v,mul(c,mul(pw(h,eh),pw(w,ew))))
                row.append(v)
            C.append(trim(row))
        out.append(C)
    return out


def main():
    print('Python independent verifier; exact field arithmetic only.')
    print('Full field cycle, tower relations, Q identities, squarefreeness: PASS')
    B=load('source_basis.json')
    for j,G in enumerate(B['basis']):
        assert not constraints(G,j==0), ('source basis constraints',j)
    # The free-column submatrix proves independence of the six direction vectors.
    for j,G in enumerate(B['basis']):
        for k,col in enumerate(B['free_columns']):
            block,i,y=B['monomials'][col]
            assert y<3
            assert coeff(G[block][y],i)==(1 if j==k+1 else 0)
    rc=load('rank_certificate.json')
    cols=[]
    for index in range(len(B['monomials'])):
        block,i,y=B['monomials'][index]
        G=[cz() for _ in range(4)]
        G[block]=cm(i,y)
        cols.append(constraints(G,False))
    allkeys=set(constraints([cz() for _ in range(4)],True))
    for col in cols:allkeys.update(col)
    assert len(allkeys)==rc['row_count']==203
    matrix=[[cols[index].get(tuple(key),0) for index in rc['minor_columns']] for key in rc['minor_row_keys']]
    d=determinant(matrix)
    assert d and len(matrix)==149 and len(B['monomials'])==155
    print(f'149x149 source minor determinant = <{d}> != 0; affine dimension six: PASS')
    chart=load('chart.json')
    fibers=load('fibers.json')['fibers']
    for fi,data in enumerate(fibers):
        h,w=data['h'],data['w'];q=pw(w,3);H=mul(h,w)
        assert (H,q)==(data['H'],data['q']) and H and q not in (0,1,15383)
        G=evaluate_chart(chart,h,w)
        assert not constraints(G,True), ('source at fiber',fi)
        assert pole(cdy(G[0],2))==12
        eps=359499;eta=323761;Cd=219628
        assert coeff(G[0][2],4)==h
        assert coeff(G[2][0],19)==w
        assert coeff(G[1][1],12)==eps
        c=coeff(G[1][0],15)
        assert c==mul(Cd,w)
        z=div(mul(2,w),eps)
        assert coeff(G[2][2],12)==sub(neg(mul(c,z)),div(eta,mul(24,z)))
        assert coeff(G[3][2],16)==sub(neg(div(pw(w,2),eps)),mul(div(8,24),pw(z,5)))
        F,rho=fjet(G)
        psi=add(pe([89654,311173,214299,163299,315361,33043,356725,245794],q),mul(H,mul(q,add(299833,mul(232505,q)))))
        f6=div(psi,mul(q,pw(299619,2)))
        assert F[:6]==[0]*6 and F[6]==f6 and f6 and rho[0]==z
        L=pw(mul(3,mul(pw(h,3),mul(pw(eps,8),f6))),3)
        R=data['residual_lambda_coefficients']
        assert len(R)==7 and len(R[0])==141 and R[0][140]==L==data['leading']
        assert all(len(v)<141 for v in R[1:])
        Ar=[trim([coeff(R[j],140-m) for j in range(7)]) for m in range(141)]
        root=[[1]]
        for m in range(1,71):
            z=[]
            for i in range(1,m):z=pa(z,pm(root[i],root[m-i]))
            root.append(sc(ps(sc(Ar[m],inv(L)),z),3))
        equations=[]
        for m in range(71,data['tail_end']+1):
            z=[]
            for i in range(max(0,m-70),71):z=pa(z,pm(root[i],root[m-i]))
            equations.append(ps(Ar[m],sc(z,L)))
        assert equations==data['tail_equations']
        identity=[]
        for a,b in zip(equations,data['bezout']):identity=pa(identity,pm(a,b))
        assert identity==data['gcd']==[1]
        print(f'Fiber {fi+1:02d}: H=<{H}>, q=<{q}>; source, jets, tail equations, Bezout 1: PASS',flush=True)
    print('PASS. The complete geometric scheme is still UNRESOLVED.')

if __name__=='__main__':main()
