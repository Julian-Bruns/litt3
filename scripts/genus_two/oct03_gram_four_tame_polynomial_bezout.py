#!/usr/bin/env python3
"""Tiny exact fixed-field Bezout certificate for the new tame divisor gate.

No search, Groebner basis, point replay or curve/source conclusion.
"""
import argparse
import json
from pathlib import Path
import signal
import time

parser=argparse.ArgumentParser()
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(5)
start=time.monotonic()
ZERO=(0,0,0);ONE=(1,0,0);ALPHA=(0,1,0)
def add(a,b):return tuple((a[i]+b[i])%5 for i in range(3))
def neg(a):return tuple(-z%5 for z in a)
def mul(a,b):
    c=[0]*5
    for i in range(3):
        for j in range(3):c[i+j]=(c[i+j]+a[i]*b[j])%5
    # alpha^3=-alpha-1, alpha^4=-alpha^2-alpha.
    c[0]=(c[0]-c[3])%5;c[1]=(c[1]-c[3]-c[4])%5;c[2]=(c[2]-c[4])%5
    return tuple(c[:3])
def power(a,n):
    z=ONE
    while n:
        if n&1:z=mul(z,a)
        a=mul(a,a);n//=2
    return z
def inv(a):
    assert a!=ZERO
    z=power(a,123);assert mul(a,z)==ONE;return z
def trim(p):
    p=list(p)
    while p and p[-1]==ZERO:p.pop()
    return p
def padd(p,q):return trim([add(p[i] if i<len(p) else ZERO,q[i] if i<len(q) else ZERO) for i in range(max(len(p),len(q)))])
def pneg(p):return trim([neg(c) for c in p])
def pscale(p,c):return trim([mul(z,c) for z in p])
def pmul(p,q):
    if not p or not q:return []
    z=[ZERO]*(len(p)+len(q)-1)
    for i,a in enumerate(p):
        for j,b in enumerate(q):z[i+j]=add(z[i+j],mul(a,b))
    return trim(z)
def divmodp(p,q):
    assert q
    r=trim(p);s=[ZERO]*max(0,len(p)-len(q)+1);il=inv(q[-1])
    while len(r)>=len(q):
        j=len(r)-len(q);c=mul(r[-1],il);s[j]=add(s[j],c)
        r=padd(r,pneg([ZERO]*j+pscale(q,c)))
    return trim(s),r
def xgcd(p,q):
    r0,r1=p,q;s0,s1=[ONE],[];t0,t1=[],[ONE]
    while r1:
        d,r=divmodp(r0,r1);r0,r1=r1,r
        s0,s1=s1,padd(s0,pneg(pmul(d,s1)));t0,t1=t1,padd(t0,pneg(pmul(d,t1)))
    c=inv(r0[-1]);return pscale(r0,c),pscale(s0,c),pscale(t0,c)
def c(n):return (n%5,0,0)
T=[c(2),c(1),ZERO,c(4),ONE]
P=[ONE,ONE,c(3),c(3),ONE,ONE]
A=add(ONE,mul(c(4),ALPHA));B=add(c(2),mul(c(4),ALPHA))
lam=mul(power(A,4),inv(power(B,5)))
F=padd(P,[ZERO]*5+[neg(lam)])
g,S,V=xgcd(T,F)
assert g==[ONE] and padd(pmul(S,T),pmul(V,F))==[ONE]
# Irreducibility of T over F5: no factor of degree one or two.
q25=[ZERO]*26;q25[25]=ONE;q25[1]=neg(ONE)
r25=divmodp(q25,T)[1]
g2,S2,V2=xgcd(T,r25)
assert g2==[ONE] and padd(pmul(S2,T),pmul(V2,r25))==[ONE]
assert all(a[1:]==(0,0) for p in (T,r25,S2,V2) for a in p)
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
data={'field':'F5[alpha]/(alpha^3+alpha+1)','coefficient_order':'ascending t powers; each field element [1,alpha,alpha^2]',
      'A':A,'B':B,'lambda_A4_over_B5':lam,'quartic_T':T,'quintic_P_minus_lambda_t5':F,
      'bezout_S':S,'bezout_V':V,'bezout_identity':'S*T+V*(P-lambda*t^5)=1',
      't25_minus_t_mod_T':r25,'irreducibility_bezout_S':S2,'irreducibility_bezout_V':V2,
      'irreducibility_identity':'S2*T+V2*(t^25-t mod T)=1'}
(out/'certificate.json').write_text(json.dumps(data,indent=2)+'\n')
summary={'scope':'fixed-field polynomial divisor gate only; actual d=0 Cartier bridge remains separate',
         'threads':1,'fixed_field_bezout':'PASS','quartic_no_degree1_or2_factor':'PASS',
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n');print(json.dumps(summary))
