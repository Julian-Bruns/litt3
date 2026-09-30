"""Exact K=F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
Integer storage is precisely the problem's base-25 code, NOT integers mod 5.
Only the Python standard library is required.
"""
import functools
N=390625
N1=N-1
ADD25=[[ (a%5+b%5)%5+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
NEG25=[(-a%5)%5+5*((-(a//5))%5) for a in range(25)]
MUL25=[[ ((a%5)*(b%5)+3*(a//5)*(b//5))%5+5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
A625=[ADD25[a%25][b%25]+25*ADD25[a//25][b//25] for a in range(625) for b in range(625)]
NEG625=[NEG25[a%25]+25*NEG25[a//25] for a in range(625)]
def add(a,b):return A625[(a%625)*625+b%625]+625*A625[(a//625)*625+b//625]
def neg(a):return NEG625[a%625]+625*NEG625[a//625]
def sub(a,b):return add(a,neg(b))
def mul_slow(a,b):
    aa=[a//25**i%25 for i in range(4)];bb=[b//25**i%25 for i in range(4)]
    cc=[0]*7
    for i in range(4):
        for j in range(4):cc[i+j]=ADD25[cc[i+j]][MUL25[aa[i]][bb[j]]]
    for i in range(6,3,-1):
        for j,m in enumerate([5,2,6,7]):cc[i-4+j]=ADD25[cc[i-4+j]][NEG25[MUL25[cc[i]][m]]]
    return sum(cc[i]*25**i for i in range(4))
def pow_slow(a,e):
    z=1
    while e:
        if e&1:z=mul_slow(z,a)
        a=mul_slow(a,a);e>>=1
    return z
# 390624 = 2^5 * 3 * 13 * 313.
PRIMITIVE=next(g for g in range(25,N) if all(pow_slow(g,N1//p)!=1 for p in [2,3,13,313]))
EXP=[0]*N1;LOG=[-1]*N
# Multiplication by a fixed element is F25-linear; precompute four tables.
GM=[[mul_slow(PRIMITIVE,a*25**i) for a in range(25)] for i in range(4)]
z=1
for i in range(N1):
    assert LOG[z]==-1
    LOG[z]=i;EXP[i]=z
    z=add(add(GM[0][z%25],GM[1][z//25%25]),add(GM[2][z//625%25],GM[3][z//15625]))
assert z==1 and all(j>=0 for j in LOG[1:])
def mul(a,b):return EXP[(LOG[a]+LOG[b])%N1] if a and b else 0
def inv(a):
    if not a:raise ZeroDivisionError
    return EXP[-LOG[a]%N1]
def div(a,b):return mul(a,inv(b))
def power(a,e):
    if not a:
        if e<0:raise ZeroDivisionError
        return int(e==0)
    return EXP[LOG[a]*e%N1]
class F:
    __slots__=('v',)
    def __init__(self,v=0):self.v=v.v if isinstance(v,F) else v%5
    @staticmethod
    def code(v):
        assert 0<=v<N
        a=F.__new__(F);a.v=v;return a
    def __add__(a,b):return F.code(add(a.v,b.v if isinstance(b,F) else b%5))
    __radd__=__add__
    def __neg__(a):return F.code(neg(a.v))
    def __sub__(a,b):return a+-b
    def __rsub__(a,b):return -a+b
    def __mul__(a,b):return F.code(mul(a.v,b.v if isinstance(b,F) else b%5))
    __rmul__=__mul__
    def __truediv__(a,b):return F.code(div(a.v,b.v if isinstance(b,F) else b%5))
    def __rtruediv__(a,b):return F(b)/a
    def __pow__(a,e):return F.code(power(a.v,e))
    def __bool__(a):return bool(a.v)
    def __eq__(a,b):return a.v==(b.v if isinstance(b,F) else b%5)
    def __hash__(a):return hash(a.v)
    def __repr__(a):return f'<{a.v}>'

# Polynomial functions act on ascending rows of integer K codes.
def trim(a):
    while a and not a[-1]:a.pop()
    return a

def pa(a,b):
    c=list(a)+[0]*max(0,len(b)-len(a))
    for i,v in enumerate(b):c[i]=add(c[i],v)
    return trim(c)
def pn(a):return [neg(v) for v in a]
def ps(a,b):return pa(a,pn(b))
def scale(a,c):return trim([mul(v,c) for v in a])
def pm(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,v in enumerate(a):
        if v:
            for j,w in enumerate(b):
                if w:c[i+j]=add(c[i+j],mul(v,w))
    return trim(c)
def pdm(a,b):
    if not b:raise ZeroDivisionError
    a=list(a);c=[0]*max(0,len(a)-len(b)+1);bi=inv(b[-1])
    while a and len(a)>=len(b):
        j=len(a)-len(b);v=mul(a[-1],bi);c[j]=v
        for i,w in enumerate(b):a[i+j]=sub(a[i+j],mul(v,w))
        trim(a)
    return trim(c),a
def ppow(a,n,mod=None):
    c=[1]
    while n:
        if n&1:
            c=pm(c,a)
            if mod:c=pdm(c,mod)[1]
        a=pm(a,a)
        if mod:a=pdm(a,mod)[1]
        n>>=1
    return c
def peval(a,x):
    z=0
    for v in reversed(a):z=add(mul(z,x),v)
    return z

def pgcd(a,b):
    while b:a,b=b,pdm(a,b)[1]
    return scale(a,inv(a[-1])) if a else []
def pxgcd(a,b):
    u,v,s,t=[1],[],[],[1]
    while b:
        q,r=pdm(a,b);a,b=b,r;u,s=s,ps(u,pm(q,s));v,t=t,ps(v,pm(q,t))
    z=inv(a[-1]);return scale(a,z),scale(u,z),scale(v,z)

def deriv(a):return trim([mul(a[i],i%5) for i in range(1,len(a))])

if __name__=='__main__':
    import random,json
    random.seed(140)
    assert mul_slow(5,5)==add(5,3)
    assert pow_slow(25,4)==neg(add(add(mul_slow(7,pow_slow(25,3)),mul_slow(6,pow_slow(25,2))),add(mul_slow(2,25),5)))
    for _ in range(1000):
        a=random.randrange(N);b=random.randrange(N)
        assert mul(a,b)==mul_slow(a,b)
        assert sub(add(a,b),b)==a
        assert power(a,N)==a
        if a:assert mul(a,inv(a))==1
    print(json.dumps({'K_size':N,'primitive_code':PRIMITIVE,'tested_pairs':1000,'status':'PASS'}))
