"""Portable exact F_25 arithmetic and ascending dense polynomial operations.
Encoding a+5*b means a+b*beta, beta^2=beta+3, 0<=a,b<5.
"""
from __future__ import annotations
ADD = [[((a%5+b%5)%5)+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
NEG = [((-a%5)%5)+5*((- (a//5))%5) for a in range(25)]
MUL = [[((a%5*(b%5)+3*(a//5)*(b//5))%5)+5*((a%5*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
INV=[0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]
def fpow(a:int,n:int)->int:
    if n<0:
        if not a: raise ZeroDivisionError
        a=INV[a];n=-n
    z=1
    while n:
        if n&1:z=MUL[z][a]
        a=MUL[a][a];n>>=1
    return z

def trim(a):
    a=list(a)
    while a and not a[-1]:a.pop()
    return a

def add(a,b):
    c=list(a)+[0]*max(0,len(b)-len(a))
    for i,v in enumerate(b):c[i]=ADD[c[i]][v]
    return trim(c)
def neg(a):return [NEG[v] for v in a]
def sub(a,b):return add(a,neg(b))
def scale(a,s):return trim([MUL[s][v] for v in a])
def mul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        if x:
            row=MUL[x]
            for j,y in enumerate(b):
                c[i+j]=ADD[c[i+j]][row[y]]
    return trim(c)
def powpoly(a,n):
    assert n>=0
    z=[1]
    while n:
        if n&1:z=mul(z,a)
        a=mul(a,a);n>>=1
    return z
def divmodpoly(a,b):
    if not b:raise ZeroDivisionError
    a=trim(a);b=trim(b)
    if len(a)<len(b):return [],a
    q=[0]*(len(a)-len(b)+1);ib=INV[b[-1]]
    while len(a)>=len(b):
        d=len(a)-len(b);s=MUL[a[-1]][ib];q[d]=s
        row=MUL[NEG[s]]
        for i,y in enumerate(b):a[i+d]=ADD[a[i+d]][row[y]]
        a=trim(a)
    return trim(q),a
def exactdiv(a,b):
    q,r=divmodpoly(a,b)
    assert not r, (a,b,r)
    return q
def mod(a,b):return divmodpoly(a,b)[1]
def monic(a):return scale(a,INV[a[-1]]) if a else []
def gcd(a,b):
    while b:a,b=b,mod(a,b)
    return monic(a)
def derivative(a):return trim([MUL[i%5][v] for i,v in enumerate(a) if i>0])
def evalpoly(a,x):
    z=0
    for y in reversed(a):z=ADD[MUL[z][x]][y]
    return z

def powmod(a,n,m):
    z=[1];a=mod(a,m)
    while n:
        if n&1:z=mod(mul(z,a),m)
        a=mod(mul(a,a),m);n>>=1
    return z

class Rat:
    def __init__(self,a,b=(1,)):
        if isinstance(a,int):a=[a]
        if isinstance(b,int):b=[b]
        a,b=trim(a),trim(b)
        if not b:raise ZeroDivisionError
        g=gcd(a,b)
        self.a=exactdiv(a,g);self.b=exactdiv(b,g)
        z=INV[self.b[-1]]
        self.a=scale(self.a,z);self.b=scale(self.b,z)
    def __add__(self,o):
        if not isinstance(o,Rat):o=Rat(o)
        return Rat(add(mul(self.a,o.b),mul(o.a,self.b)),mul(self.b,o.b))
    def __neg__(self):return Rat(neg(self.a),self.b)
    def __sub__(self,o):return self+-o if isinstance(o,Rat) else self+Rat(NEG[o])
    def __mul__(self,o):
        if not isinstance(o,Rat):o=Rat(o)
        return Rat(mul(self.a,o.a),mul(self.b,o.b))
    def __truediv__(self,o):
        if not isinstance(o,Rat):o=Rat(o)
        return Rat(mul(self.a,o.b),mul(self.b,o.a))
    def __pow__(self,n):
        if n<0:return Rat(self.b,self.a)**(-n)
        return Rat(powpoly(self.a,n),powpoly(self.b,n))
    def der(self):return Rat(sub(mul(derivative(self.a),self.b),mul(self.a,derivative(self.b))),mul(self.b,self.b))
    def __repr__(self):return f'Rat({self.a}, {self.b})'
    def __eq__(self,o):
        if not isinstance(o,Rat):o=Rat(o)
        return self.a==o.a and self.b==o.b
    def value(self,x):
        den=evalpoly(self.b,x)
        if not den:raise ZeroDivisionError
        return MUL[evalpoly(self.a,x)][INV[den]]

def invmod(a,m):
    r0,r1=m,mod(a,m);s0,s1=[],[1]
    while r1:
        q,r=divmodpoly(r0,r1)
        r0,r1=r1,r;s0,s1=s1,sub(s0,mul(q,s1))
    if len(r0)!=1:raise ZeroDivisionError(f'nonunit modulo polynomial, gcd degree {len(r0)-1}')
    return mod(scale(s0,INV[r0[0]]),m)

def ratmod(r,m):return mod(mul(r.a,invmod(r.b,m)),m)
def composemod(a,x,m):
    z=[]
    for c in reversed(a):z=mod(add(mul(z,x),[c]),m)
    return z

def minpoly_mod(r,m):
    d=len(m)-1;basis=[None]*d;comb=[None]*d;w=[1]
    for k in range(d+1):
        v=w+[0]*(d-len(w));c=[0]*k+[1]
        for i in range(d):
            if not v[i]:continue
            if basis[i] is None:
                s=INV[v[i]];basis[i]=[MUL[s][b] for b in v];comb[i]=scale(c,s)
                break
            s=v[i]
            v=[ADD[a][NEG[MUL[s][b]]] for a,b in zip(v,basis[i])]
            c=sub(c,scale(comb[i],s))
        else:return monic(c)
        w=mod(mul(w,r),m)
    raise AssertionError('minimal polynomial not found')
