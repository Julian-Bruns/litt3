#!/usr/bin/env python3
"""Independent standard-library arithmetic and certificate verifier.
This checks every stored Bezout identity and field/Psi data. With --circuit it
also reconstructs the first two complete-circuit equations from the residuals.
It never concludes anything about an unsampled ratio pair.
"""
import argparse
import json
import platform
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ADD25 = [[(a%5+b%5)%5+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
MUL25 = [[(a%5*(b%5)+3*(a//5)*(b//5))%5+5*((a%5*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5)
          for b in range(25)] for a in range(25)]
NEG25 = [(5-a%5)%5+5*((5-a//5)%5) for a in range(25)]
MOD = [5,2,6,7]

def add(a,b):
    c=0; power=1
    for _ in range(4):
        c += ADD25[a%25][b%25]*power
        a//=25; b//=25; power*=25
    return c

def neg(a):
    c=0; power=1
    for _ in range(4):
        c += NEG25[a%25]*power
        a//=25; power*=25
    return c

def sub(a,b): return add(a,neg(b))

def mul(a,b):
    if not a or not b: return 0
    aa=[];bb=[]
    for _ in range(4):
        aa.append(a%25);bb.append(b%25);a//=25;b//=25
    c=[0]*7
    for i in range(4):
        for j in range(4):
            c[i+j]=ADD25[c[i+j]][MUL25[aa[i]][bb[j]]]
    for i in range(6,3,-1):
        for j in range(4):
            c[i-4+j]=ADD25[c[i-4+j]][NEG25[MUL25[c[i]][MOD[j]]]]
    return sum(c[i]*25**i for i in range(4))

def power(a,n):
    if n<0:
        assert a
        a=power(a,390623);n=-n
    b=1
    while n:
        if n&1: b=mul(b,a)
        a=mul(a,a);n//=2
    return b

def ptr(p):
    while p and p[-1]==0:p.pop()
    return p

def padd(p,q):
    r=p[:]+[0]*max(0,len(q)-len(p))
    for i,c in enumerate(q):r[i]=add(r[i],c)
    return ptr(r)

def pneg(p): return [neg(c) for c in p]

def pmul(p,q):
    if not p or not q:return []
    r=[0]*(len(p)+len(q)-1)
    for i,c in enumerate(p):
        if c:
            for j,d in enumerate(q):
                if d:r[i+j]=add(r[i+j],mul(c,d))
    return ptr(r)

def pscale(p,c):return ptr([mul(a,c) for a in p])

def pfrob(p,n):
    if not p:return []
    r=[0]*(n*(len(p)-1)+1)
    for i,c in enumerate(p):r[n*i]=power(c,n)
    return ptr(r)

def pconv(a,b,n):
    r=[[] for _ in range(n)]
    for i,p in enumerate(a[:n]):
        if p:
            for j,q in enumerate(b[:n-i]):
                if q:r[i+j]=padd(r[i+j],pmul(p,q))
    return r

def eval_sparse(rows,H,q):
    out=0
    for h,e,c in rows:out=add(out,mul(c,mul(power(H,h),power(q,e))))
    return out

def sparse_product(a,b):
    out={}
    for h,q,c in a:
        for j,s,d in b:
            e=(h+j,q+s);out[e]=add(out.get(e,0),mul(c,d))
    return [[h,q,c] for (h,q),c in sorted(out.items()) if c]

def verify_all(circuit=False, selected=None):
    # Irreducibility by the primitive-element test: order alpha = 390624.
    assert power(25,390624)==1
    for p in (2,3,13,313):assert power(25,390624//p)!=1
    # Beta^2=beta+3, with the user's literal codes.
    assert mul(5,5)==add(5,3)
    cases=sorted((ROOT/'evidence').glob('sample_*.json'))
    assert len(cases)==10
    for path in cases:
        s=json.loads(path.read_text());r=s['r']
        if selected is not None and r!=selected:continue
        t0=time.monotonic()
        d=json.loads((ROOT/'data'/f'psi_{r}.json').read_text())
        assert s['H']==31 and s['w']==101 and s['q']==power(101,3)==64426
        assert s['q'] not in (0,d['pivot'],d['q_r'])
        assert s['F6']!=0
        assert sparse_product(d['Theta_H_q'],[[0,0,neg(d['pivot'])],[0,1,1]])==d['Psi_H_q']
        theta=eval_sparse(d['Theta_H_q'],s['H'],s['q'])
        denominator=mul(s['q'],sub(s['q'],d['pivot']))
        assert theta==mul(s['F6'],denominator)
        lead=[[0,q,c] for h,q,c in d['Theta_H_q'] if h==3]
        assert len(lead)==2 and lead[0][1]==2 and lead[1][1]==3
        assert lead[0][2]==neg(mul(lead[1][2],d['q_r']))
        E=s['square_equations_lambda']
        assert len(E)==70 and s['all70_gcd']==[1] and s['first2_gcd']==[1]
        a,b=s['first2_bezout']
        assert padd(pmul(a,E[0]),pmul(b,E[1]))==[1]
        if circuit:
            R=s['R_lambda_rows'];assert len(R)==7
            A=[]
            for j in range(73):
                A.append(ptr([row[140-j] if 140-j<len(row) else 0 for row in R]))
            A2=pconv(A,A,73);A3=pconv(A,A2,73)
            F5=[pfrob(p,5) for p in A2[:15]]
            F25=[pfrob(p,25) for p in A2[:3]]
            for target,index in ((71,0),(72,1)):
                out=[]
                for k in range(3):
                    for j in range(15):
                        i=target-25*k-5*j
                        if 0<=i<73:
                            out=padd(out,pmul(pmul(A3[i],F5[j]),F25[k]))
                assert out==E[index], (r,target,'circuit mismatch')
        print(f'r={r}: independent field, open condition, reduced F6 and Bezout PASS'
              + ('; E71,E72 regenerated PASS' if circuit else '')
              + f'; seconds={time.monotonic()-t0:.3f}',flush=True)
    print('No conclusion has been drawn for any other ratio pair.',flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--circuit',action='store_true');p.add_argument('--r',type=int)
    args=p.parse_args()
    print('Python',platform.python_version(),'; independent standard-library verifier',flush=True)
    verify_all(args.circuit,args.r)
