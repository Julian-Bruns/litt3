"""Exact F25 arithmetic: code a+5b means a+b*iota, iota^2=iota+3."""
def add(x,y): return ((x%5+y%5)%5)+5*((x//5+y//5)%5)
def neg(x): return (-x%5)+5*((- (x//5))%5)
def sub(x,y): return add(x,neg(y))
def mul(x,y):
    a,b=x%5,x//5; c,d=y%5,y//5
    return (a*c+3*b*d)%5+5*((a*d+b*c+b*d)%5)
def power(x,n):
    if n<0: return power(inv(x),-n)
    r=1
    while n:
        if n&1: r=mul(r,x)
        x=mul(x,x); n//=2
    return r
def inv(x):
    if not x: raise ZeroDivisionError
    return power(x,23)
def div(x,y): return mul(x,inv(y))
def trim(a):
    a=list(a)
    while len(a)>1 and a[-1]==0: a.pop()
    return a or [0]
def padd(a,b): return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pneg(a): return [neg(x) for x in a]
def psub(a,b): return padd(a,pneg(b))
def pscale(a,s): return trim([mul(x,s) for x in a])
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]=add(r[i+j],mul(x,y))
    return trim(r)
def ppow(a,n):
    r=[1]
    while n:
        if n&1:r=pmul(r,a)
        a=pmul(a,a); n//=2
    return r
def pder(a): return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def pdivmod(a,b):
    a,b=trim(a),trim(b)
    if b==[0]:raise ZeroDivisionError
    q=[0]*max(1,len(a)-len(b)+1)
    while a!=[0] and len(a)>=len(b):
        d=len(a)-len(b); c=div(a[-1],b[-1]); q[d]=c
        a=psub(a,[0]*d+pscale(b,c))
    return trim(q),a
def pgcd(a,b):
    while trim(b)!=[0]:a,b=b,pdivmod(a,b)[1]
    return pscale(a,inv(a[-1]))
def peval(a,x):
    r=0
    for c in reversed(a):r=add(mul(r,x),c)
    return r
def pshift(a,x):
    r=[0]
    for c in reversed(a): r=padd(pmul(r,[x,1]),[c])
    return r
def pmodpower(a,n,m):
    r=[1]; a=pdivmod(a,m)[1]
    while n:
        if n&1:r=pdivmod(pmul(r,a),m)[1]
        a=pdivmod(pmul(a,a),m)[1];n//=2
    return r
def pxgcd(a,b):
    """Return g,s,t with g monic and s*a+t*b=g."""
    r0,r1=trim(a),trim(b);s0,s1=[1],[0];t0,t1=[0],[1]
    while r1!=[0]:
        q,r=pdivmod(r0,r1)
        r0,r1=r1,r;s0,s1=s1,psub(s0,pmul(q,s1));t0,t1=t1,psub(t0,pmul(q,t1))
    scale=inv(r0[-1])
    return pscale(r0,scale),pscale(s0,scale),pscale(t0,scale)
