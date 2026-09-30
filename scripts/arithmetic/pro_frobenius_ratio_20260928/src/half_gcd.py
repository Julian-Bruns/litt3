"""Exact half-GCD acceleration with independently checkable Bezout outputs.
This module uses only the archive's K-polynomial arithmetic. Its outputs can
be verified using multiplication and division, independently of half-GCD.
"""
from ff import Poly,inv
I=(Poly(1),Poly(),Poly(),Poly(1))

def apply(M,a,b):return M[0]*a+M[1]*b,M[2]*a+M[3]*b

def multiply(A,B):
    a,b,c,d=A;e,f,g,h=B
    return (a*e+b*g,a*f+b*h,c*e+d*g,c*f+d*h)

def step(q,M):
    a,b,c,d=M
    return (c,d,a-q*c,b-q*d)

def hgcd(a,b):
    n=a.degree();m=(n+1)//2
    if not b or b.degree()<m:return I
    if n<32:
        M=I
        while b and b.degree()>=m:
            q,r=divmod(a,b);a,b=b,r;M=step(q,M)
        return M
    R=hgcd(Poly(a.a[m:]),Poly(b.a[m:]));c,d=apply(R,a,b)
    if not d or d.degree()<m:return R
    q,e=divmod(c,d);R=step(q,R)
    if not e or e.degree()<m:return R
    k=2*m-d.degree()
    assert k>=0
    S=hgcd(Poly(d.a[k:]),Poly(e.a[k:]))
    return multiply(S,R)

def xgcd(a,b,retain=True):
    a,b=Poly(a),Poly(b);aa,bb=a,b;M=I
    if a.degree()<b.degree():a,b=b,a;M=step(Poly(),M)
    while b:
        if a.degree()>64 and b.degree()<a.degree():
            R=hgcd(a,b);a,b=apply(R,a,b)
            if retain:M=multiply(R,M)
        if not b:break
        q,r=divmod(a,b);a,b=b,r
        if retain:M=step(q,M)
    if not a:return a,Poly(),Poly()
    il=inv(a[a.degree()]);g=a*il
    return (g,M[0]*il,M[1]*il) if retain else (g,None,None)

def gcd(a,b):return xgcd(a,b,False)[0]

def install():
    og=Poly.gcd;ox=Poly.xgcd
    Poly.gcd=lambda a,b:gcd(a,b) if max(len(a),len(Poly(b)))>256 else og(a,b)
    Poly.xgcd=lambda a,b:xgcd(a,b) if max(len(a),len(Poly(b)))>256 else ox(a,b)
