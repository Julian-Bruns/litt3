"""Exact F_25 and polynomial arithmetic, Python standard library only.
Field code a+5*b denotes a+b*beta, beta^2=beta+3.
Polynomial lists are ascending, canonical zero is [].
"""
ADD = [[(a%5+b%5)%5+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
NEG = [(-a%5)%5+5*((-(a//5))%5) for a in range(25)]
MUL = [[((a%5)*(b%5)+3*(a//5)*(b//5))%5+5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
INV = [0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]
def add(a,b): return ADD[a][b]
def neg(a): return NEG[a]
def sub(a,b): return ADD[a][NEG[b]]
def mul(a,b): return MUL[a][b]
def inv(a):
    if not a: raise ZeroDivisionError('zero in F25')
    return INV[a]
def power(a,n):
    if n<0: return power(inv(a),-n)
    r=1
    while n:
        if n&1: r=mul(r,a)
        a=mul(a,a); n//=2
    return r
def trim(a):
    a=list(a)
    while a and a[-1]==0: a.pop()
    return a
def padd(a,b):
    c=list(a)+[0]*max(0,len(b)-len(a))
    for i,v in enumerate(b): c[i]=add(c[i],v)
    return trim(c)
def pneg(a): return [neg(v) for v in a]
def psub(a,b): return padd(a,pneg(b))
def pscale(a,c): return trim([mul(v,c) for v in a])
def pmul(a,b):
    if not a or not b: return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b):
                if y: c[i+j]=add(c[i+j],mul(x,y))
    return trim(c)
def pdivmod(a,b):
    a=trim(a); b=trim(b)
    if not b: raise ZeroDivisionError('zero polynomial')
    q=[0]*max(0,len(a)-len(b)+1); z=inv(b[-1])
    while a and len(a)>=len(b):
        k=len(a)-len(b); c=mul(a[-1],z); q[k]=c
        for j,v in enumerate(b): a[j+k]=sub(a[j+k],mul(c,v))
        a=trim(a)
    return trim(q),a
def pmod(a,m): return pdivmod(a,m)[1]
def pexact(a,b):
    q,r=pdivmod(a,b)
    if r: raise ArithmeticError('nonexact division')
    return q
def pmonic(a):
    a=trim(a)
    return pscale(a,inv(a[-1])) if a else []
def pgcd(a,b):
    while b: a,b=b,pmod(a,b)
    return pmonic(a)
def ppow(a,n,m=None):
    r=[1]
    if m: a=pmod(a,m)
    while n:
        if n&1:
            r=pmul(r,a)
            if m: r=pmod(r,m)
        a=pmul(a,a)
        if m: a=pmod(a,m)
        n//=2
    return r
def pinv(a,m):
    r0,r1=m,pmod(a,m); s0,s1=[],[1]
    while r1:
        q,r=pdivmod(r0,r1)
        r0,r1=r1,r; s0,s1=s1,psub(s0,pmul(q,s1))
    if len(r0)!=1: raise ZeroDivisionError('nonunit in quotient')
    return pmod(pscale(s0,inv(r0[0])),m)
def pder(a): return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def peval(a,x):
    r=0
    for v in reversed(a): r=add(mul(r,x),v)
    return r
def rank(matrix):
    a=[list(r) for r in matrix]
    if not a: return 0
    r=0
    for j in range(len(a[0])):
        q=next((q for q in range(r,len(a)) if a[q][j]),None)
        if q is None: continue
        a[r],a[q]=a[q],a[r]; z=inv(a[r][j]); a[r]=[mul(x,z) for x in a[r]]
        for q in range(len(a)):
            if q!=r and a[q][j]:
                c=a[q][j]; a[q]=[sub(x,mul(c,y)) for x,y in zip(a[q],a[r])]
        r+=1
        if r==len(a): break
    return r
