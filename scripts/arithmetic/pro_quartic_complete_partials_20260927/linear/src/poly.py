"""Dense univariate and cubic-curve arithmetic over the exact coded field K."""
import field as F

def trim(a):
    while a and not a[-1]:a.pop()
    return a

def add(a,b):
    c=a.copy()+[0]*max(0,len(b)-len(a))
    for i,v in enumerate(b):c[i]=F.add(c[i],v)
    return trim(c)
def neg(a):return [F.neg(v) for v in a]
def sub(a,b):return add(a,neg(b))
def scale(a,s):return trim([F.mul(v,s) for v in a])
def shift(a,n):return [0]*n+a if a else []
def mul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,u in enumerate(a):
        if not u:continue
        for j,v in enumerate(b):
            if v:c[i+j]=F.add(c[i+j],F.mul(u,v))
    return trim(c)
def powp(a,n):
    b=[1]
    while n:
        if n&1:b=mul(b,a)
        a=mul(a,a);n//=2
    return b
def frob(a,power=1):
    p=5**power;b=[0]*((len(a)-1)*p+1) if a else []
    for i,v in enumerate(a):b[i*p]=F.powk(v,p)
    return trim(b)
def divmodp(a,b):
    if not b:raise ZeroDivisionError
    r=a.copy();q=[0]*max(0,len(a)-len(b)+1);bi=F.inv(b[-1])
    while len(r)>=len(b):
        d=len(r)-len(b);v=F.mul(r[-1],bi);q[d]=v
        for i,u in enumerate(b):r[i+d]=F.sub(r[i+d],F.mul(v,u))
        trim(r)
    return trim(q),r
def rem(a,b):return divmodp(a,b)[1]
def exactdiv(a,b):
    q,r=divmodp(a,b);assert not r,(len(a),len(b),r)
    return q
def gcd(a,b):
    while b:a,b=b,rem(a,b)
    return scale(a,F.inv(a[-1])) if a else []
def evalp(a,x):
    r=0
    for v in reversed(a):r=F.add(F.mul(r,x),v)
    return r
def deriv(a):return trim([F.scale(a[i],i) for i in range(1,len(a))])
def coeff(a,i):return a[i] if 0<=i<len(a) else 0

P=[]
def set_curve(p):
    global P
    P=p

def zero():return [[],[],[]]
def monomial(i,j,c=1):
    a=zero();a[j]=[0]*i+[c];return a

def cadd(a,b):return [add(a[i],b[i]) for i in range(3)]
def csub(a,b):return [sub(a[i],b[i]) for i in range(3)]
def cscale(a,s):return [scale(v,s) for v in a]
def cmulpoly(a,p):return [mul(v,p) for v in a]
def cmul(a,b):
    out=zero()
    for i in range(3):
        for j in range(3):
            v=mul(a[i],b[j]);k=i+j
            if k>=3:v=mul(v,P);k-=3
            out[k]=add(out[k],v)
    return out
def cpow(a,n):
    b=monomial(0,0)
    while n:
        if n&1:b=cmul(b,a)
        a=cmul(a,a);n//=2
    return b

def crem_poly(a,p):return [rem(v,p) for v in a]
def cmod_y(a,n):return [rem(a[j],powp(P,max(0,(n-j+2)//3))) for j in range(3)]
def cexact_y(a,n):
    # Divide each monomial character by y^n, using y^3=P.
    out=zero()
    for j in range(3):
        jj=(j-n)%3; e=(n+jj-j)//3
        out[jj]=exactdiv(a[j],powp(P,e))
    return out

def norm(a):
    return sub(add(add(powp(a[0],3),mul(powp(a[1],3),P)),mul(powp(a[2],3),powp(P,2))),scale(mul(mul(mul(a[0],a[1]),a[2]),P),3))
def basis(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def pole(a):return max((3*i+10*j for j in range(3) for i,c in enumerate(a[j]) if c),default=-1)
