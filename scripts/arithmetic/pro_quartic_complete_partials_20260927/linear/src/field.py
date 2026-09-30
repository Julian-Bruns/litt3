"""Exact F25 and K=F25[a]/(a^4+[7]a^3+[6]a^2+[2]a+[5]).
Codes are precisely the problem's codes. No floating point arithmetic.
"""
from functools import lru_cache
import json, os
F25_ADD = [[(a%5+b%5)%5 + 5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
F25_NEG = [(-a%5)%5 + 5*((- (a//5))%5) for a in range(25)]
def f25mul(a,b):
    x,y=a%5,a//5; u,v=b%5,b//5
    return (x*u+3*y*v)%5+5*((x*v+y*u+y*v)%5)
F25_MUL=[[f25mul(a,b) for b in range(25)] for a in range(25)]
MOD=[5,2,6,7]
ORDER=390625

def add(a,b):
    c=0; place=1
    for _ in range(4):
        c+=place*F25_ADD[a%25][b%25]
        a//=25; b//=25; place*=25
    return c

def neg(a):
    c=0; place=1
    for _ in range(4):
        c+=place*F25_NEG[a%25]; a//=25; place*=25
    return c

def sub(a,b):return add(a,neg(b))

def rawmul(a,b):
    aa=[];bb=[]
    for _ in range(4):
        aa.append(a%25); bb.append(b%25); a//=25;b//=25
    cc=[0]*7
    for i in range(4):
        for j in range(4):
            cc[i+j]=F25_ADD[cc[i+j]][F25_MUL[aa[i]][bb[j]]]
    for i in range(6,3,-1):
        v=cc[i]
        for j in range(4):
            cc[i-4+j]=F25_ADD[cc[i-4+j]][F25_NEG[F25_MUL[v][MOD[j]]]]
    return sum(cc[i]*25**i for i in range(4))

def rawpow(a,n):
    b=1
    while n:
        if n&1:b=rawmul(b,a)
        a=rawmul(a,a); n//=2
    return b

LOG=None;EXP=None;GEN=None

def init():
    global LOG,EXP,GEN
    if LOG is not None:return
    # 390624=2^5*3*13*313.
    for g in range(25,ORDER):
        if all(rawpow(g,(ORDER-1)//p)!=1 for p in (2,3,13,313)):
            GEN=g;break
    LOG=[-1]*ORDER; EXP=[0]*(ORDER-1)
    a=1
    for i in range(ORDER-1):
        assert LOG[a]==-1
        LOG[a]=i;EXP[i]=a;a=rawmul(a,GEN)
    assert a==1

def mul(a,b):
    if not a or not b:return 0
    if a==1:return b
    if b==1:return a
    return EXP[(LOG[a]+LOG[b])%(ORDER-1)]

def inv(a):
    if not a:raise ZeroDivisionError
    return EXP[(-LOG[a])%(ORDER-1)]

def div(a,b):return mul(a,inv(b))
def powk(a,n):
    if n==0:return 1
    if not a:
        if n<0:raise ZeroDivisionError
        return 0
    return EXP[(LOG[a]*n)%(ORDER-1)]

def scale(a,n):return mul(a,n%5)
def code(digits):return sum(c*25**i for i,c in enumerate(digits))

if __name__=='__main__':
    import time
    t=time.time();init()
    print(json.dumps({'field_order':ORDER,'primitive_generator_code':GEN,'table_seconds':round(time.time()-t,3),'101_cubed':powk(101,3)},indent=2))

# Two-limb addition speeds up exact polynomial and matrix arithmetic.
_ADD625 = [0]*(625*625)
for _a in range(625):
    for _b in range(625):
        _ADD625[_a*625+_b] = F25_ADD[_a%25][_b%25] + 25*F25_ADD[_a//25][_b//25]
_NEG625 = [F25_NEG[a%25]+25*F25_NEG[a//25] for a in range(625)]
def add(a,b):
    return _ADD625[(a%625)*625+b%625] + 625*_ADD625[(a//625)*625+b//625]
def neg(a):return _NEG625[a%625]+625*_NEG625[a//625]
def sub(a,b):return add(a,neg(b))
