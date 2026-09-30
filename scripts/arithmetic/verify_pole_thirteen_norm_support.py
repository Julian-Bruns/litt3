#!/usr/bin/env python3
"""Independent division-free replay of every pole13 norm obstruction.

Standard library only. Sage's rational-function or gcd code is not used.
The Bézout identity is checked by multiplication; the residuals are
independently reconstructed with a common power of the linear denominator.
"""
import argparse
import functools
import json
import time
import verify_pole_ten_norm_support as F

F.add = functools.lru_cache(maxsize=200000)(F.add)
F.mul = functools.lru_cache(maxsize=200000)(F.mul)
F.neg = functools.lru_cache(maxsize=100000)(F.neg)
F.inv = functools.lru_cache(maxsize=10000)(F.inv)
add, mul, neg, inv = F.add,F.mul,F.neg,F.inv
pa, ps, pm, trim = F.padd,F.psub,F.pmul,F.trim

def scale(p,c): return trim([mul(v,c) for v in p])
def power(p,n):
    q=[1]
    while n:
        if n&1:q=pm(q,p)
        p=pm(p,p);n//=2
    return q
def divide(p,q):
    p=trim(p); q=trim(q); result=[0]*max(0,len(p)-len(q)+1)
    z=inv(q[-1])
    while len(p)>=len(q):
        i=len(p)-len(q); c=mul(p[-1],z);result[i]=c
        p=ps(p,[0]*i+scale(q,c))
    return trim(result),p
def coefficient(p,i): return p[i] if 0<=i<len(p) else 0
def cube_in_x(polys):
    ans=[[] for _ in range(3*len(polys)-2)]
    for i,a in enumerate(polys):
        for j,b in enumerate(polys):
            for k,c in enumerate(polys):
                ans[i+j+k]=pa(ans[i+j+k],pm(pm(a,b),c))
    return ans

def main():
    ap=argparse.ArgumentParser();ap.add_argument('certificate');a=ap.parse_args()
    data=json.load(open(a.certificate));assert data['patterns']==560
    assert not data['survivors']; seen=set();start=time.monotonic()
    for row in data['records']:
        w=tuple(row['weights']);assert len(w)==4 and min(w)>=0 and sum(w)==13 and w not in seen
        seen.add(w); S=[1]
        for root,n in zip(F.roots,w):S=pm(S,power([neg(root),1],n))
        G=[]
        for i in range(14):
            G.append(trim([F.sub(coefficient(S,i),coefficient(F.P,i-3)),
                neg(mul(3,coefficient(F.P,i-2))),
                neg(mul(3,coefficient(F.P,i-1))),neg(coefficient(F.P,i))]))
        assert G[13]==[]
        ell=G[12];assert len(ell)==2
        ep=[power(ell,n) for n in range(12)]
        n3=scale(G[11],2)
        n2=scale(ps(pm(G[10],ell),scale(pm(n3,n3),3)),2)
        n1=scale(ps(ps(pm(G[9],ep[2]),scale(pm(n3,n2),1)),power(n3,3)),2)
        n0=scale(ps(ps(ps(pm(G[8],ep[3]),pm(n3,n1)),scale(pm(n2,n2),3)),scale(pm(pm(n3,n3),n2),3)),2)
        v=[n0,pm(ell,n1),pm(ep[2],n2),pm(ep[3],n3),ep[4]]
        cube=cube_in_x(v)
        raw=[ps(pm(ep[11],G[j]),cube[j]) for j in range(13)]
        assert all(not raw[j] for j in range(8,13))
        total=[]
        assert len(row['active_indices'])==len(row['residual_numerators'])==len(row['bezout'])
        for j,num,mult in zip(row['active_indices'],row['residual_numerators'],row['bezout']):
            assert 0<=j<8 and num and raw[j]
            reduced=raw[j]
            while True:
                q,r=divide(reduced,ell)
                if r:break
                reduced=q
            # Cancellation of a power of ell can change only a unit factor.
            assert reduced==scale(num,mul(reduced[-1],inv(num[-1])))
            total=pa(total,pm(num,mult))
        assert row['gcd']==[1] and total==[1]
        b0=mul(neg(ell[0]),inv(ell[1]));assert row['boundary_parameter']==b0
        boundary=trim([F.peval(g,b0) for g in G])
        assert boundary and len(boundary)-1==row['boundary_degree']
        bd=len(boundary)-1; ob=row['boundary_obstruction']
        if bd%3:
            assert ob=={'noncube_degree':bd}
        else:
            m=bd//3; normalized=scale(boundary,inv(boundary[-1]));q=[0]*m+[1]
            for j in range(m-1,-1,-1):
                r=ps(normalized,F.pcube(q));q[j]=mul(coefficient(r,2*m+j),2)
            r=ps(normalized,F.pcube(q));assert r
            assert ob=={'degree':len(r)-1,'coefficient':r[-1]}
        if len(seen)%40==0:print('PASS',len(seen),'patterns;',round(time.monotonic()-start,2),'seconds',flush=True)
    assert len(seen)==560
    print('PASS: every geometric supported norm of pole order13 is excluded.',flush=True)

if __name__=='__main__':main()
