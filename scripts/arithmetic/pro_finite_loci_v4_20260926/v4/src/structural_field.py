"""Exact F_(5^7), F_(5^14), and F_(5^56) arithmetic for structural checks.

The only dependencies are the Python standard library. Integers encoding F_(5^7)
are ascending base-five coefficient vectors, NOT integers modulo 5^7.
F_(5^14) is F_(5^7)[beta]/(beta^2-beta-3), represented by pairs.
F_(5^56) is its quartic extension by monic A=(beta,2,1+beta,2+beta,1),
represented by eight coordinates in order 1,beta,alpha,beta*alpha,... .
"""
from __future__ import annotations
from functools import lru_cache

H=(4,4,2,3,3,2,2,1)
Q=5**7
K0=(0,0);K1=(1,0);BETA=(0,1)

@lru_cache(maxsize=100000)
def digits(a:int)->tuple[int,...]:
    if not 0<=a<Q: raise ValueError('noncanonical F_(5^7) element')
    r=[]
    for _ in range(7): r.append(a%5);a//=5
    return tuple(r)

def code(v)->int:
    if len(v)>7 or any(not 0<=x<5 for x in v):raise ValueError('invalid coefficient row')
    return sum(x*5**i for i,x in enumerate(v))

def add(a:int,b:int)->int:
    return code([(x+y)%5 for x,y in zip(digits(a),digits(b))])

def neg(a:int)->int:return code([(-x)%5 for x in digits(a)])
def sub(a:int,b:int)->int:return add(a,neg(b))

def mul(a:int,b:int)->int:
    if not a or not b:return 0
    if a<5:return code([(a*x)%5 for x in digits(b)])
    if b<5:return code([(b*x)%5 for x in digits(a)])
    v=[0]*13
    for i,x in enumerate(digits(a)):
        if x:
            for j,y in enumerate(digits(b)):
                v[i+j]+=x*y
    for i in range(12,6,-1):
        s=v[i]%5
        for j,h in enumerate(H[:7]):v[i-7+j]-=s*h
    return code([x%5 for x in v[:7]])

def power(a:int,n:int)->int:
    if n<0:return power(inv(a),-n)
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r

def inv(a:int)->int:
    if not a:raise ZeroDivisionError('zero field element')
    r=power(a,Q-2)
    if mul(a,r)!=1:raise ArithmeticError('field inverse failed')
    return r

def sqrt(a:int)->int|None:
    """Tonelli--Shanks; does not enumerate the field."""
    if not a:return 0
    if power(a,(Q-1)//2)!=1:return None
    n=Q-1;s=0
    while n%2==0:s+=1;n//=2
    z=2
    assert power(z,(Q-1)//2)==4
    c=power(z,n);x=power(a,(n+1)//2);t=power(a,n);m=s
    while t!=1:
        v=t;i=0
        while v!=1 and i<m:v=mul(v,v);i+=1
        if i==m:raise ArithmeticError('Tonelli--Shanks invariant failed')
        b=power(c,2**(m-i-1));x=mul(x,b);c=mul(b,b);t=mul(t,c);m=i
    assert mul(x,x)==a
    return x

def ka(a,b):return (add(a[0],b[0]),add(a[1],b[1]))
def kn(a):return (neg(a[0]),neg(a[1]))
def ks(a,b):return ka(a,kn(b))
def km(a,b):
    ac=mul(a[0],b[0]);bd=mul(a[1],b[1])
    return (add(ac,mul(3,bd)),add(add(mul(a[0],b[1]),mul(a[1],b[0])),bd))
def kc(a,s):return (mul(a[0],s),mul(a[1],s))
def kb(a):return (add(a[0],a[1]),neg(a[1]))
def ki(a):
    ab=kb(a);nn=km(a,ab);assert nn[1]==0
    return kc(ab,inv(nn[0]))
def kp(a,n):
    if n<0:return kp(ki(a),-n)
    r=K1
    while n:
        if n&1:r=km(r,a)
        a=km(a,a);n//=2
    return r

def old25(a:int):return (a%5,a//5)

THETA=5
D=code([1,2,4,1,3,0,1])
# zeta=(theta+(2 beta-1)d)/2.
ZETA=(mul(3,sub(THETA,D)),D)
ZPOW=[K1]
for _ in range(29):ZPOW.append(km(ZPOW[-1],ZETA))
assert ZPOW[29]==K1 and all(z!=K1 for z in ZPOW[1:29])
assert km(ZETA,kb(ZETA))==K1

F0=(0,)*8;F1=(1,)+(0,)*7
MONIC_A=[BETA,old25(2),old25(6),old25(7)]
def fa(a,b):return tuple(add(x,y) for x,y in zip(a,b))
def fn(a):return tuple(neg(x) for x in a)
def fs(a,b):return fa(a,fn(b))
def fc(a,s):return tuple(mul(x,s) for x in a)
def fk(a,s):
    r=[]
    for i in range(0,8,2):r.extend(km(a[i:i+2],s))
    return tuple(r)
def fm(a,b):
    p=[K0]*7
    for i in range(4):
        for j in range(4):p[i+j]=ka(p[i+j],km(a[2*i:2*i+2],b[2*j:2*j+2]))
    for i in range(6,3,-1):
        for j in range(4):p[i-4+j]=ks(p[i-4+j],km(p[i],MONIC_A[j]))
    return tuple(v for p0 in p[:4] for v in p0)
def fp(a,n):
    if n<0:raise ValueError('use fi for inverse')
    r=F1
    while n:
        if n&1:r=fm(r,a)
        a=fm(a,a);n//=2
    return r

def lift25row(row):
    r=[]
    for c in list(row)+[0]*(4-len(row)):r.extend(old25(c))
    return tuple(r)

@lru_cache(maxsize=1)
def sigma_columns():
    """25th power on K8 constants, extended by identity on K14."""
    out=[]
    for j in range(8):out.append(fp(tuple(int(i==j) for i in range(8)),25))
    return out

def sigma(a):
    r=F0
    for c,col in zip(a,sigma_columns()):r=fa(r,fc(col,c))
    return r

def fi(a):
    if a==F0:raise ZeroDivisionError('zero F_(5^56) element')
    s1=sigma(a);s2=sigma(s1);s3=sigma(s2)
    prod=fm(fm(s1,s2),s3);nn=fm(a,prod)
    assert nn[2:]==(0,)*6
    ans=fk(prod,ki(nn[:2]));assert fm(a,ans)==F1
    return ans

def gaussian(matrix,variables=4):
    """RREF with a retained row-operation certificate."""
    a=[list(r) for r in matrix];rows=len(a)
    transform=[[int(i==j) for j in range(rows)] for i in range(rows)]
    r=0;piv=[]
    for j in range(variables):
        p=next((i for i in range(r,rows) if a[i][j]),None)
        if p is None:continue
        a[p],a[r]=a[r],a[p];transform[p],transform[r]=transform[r],transform[p]
        v=inv(a[r][j]);a[r]=[mul(v,x) for x in a[r]];transform[r]=[mul(v,x) for x in transform[r]]
        for i in range(rows):
            if i==r:continue
            v=a[i][j]
            if not v:continue
            a[i]=[sub(x,mul(v,y)) for x,y in zip(a[i],a[r])]
            transform[i]=[sub(x,mul(v,y)) for x,y in zip(transform[i],transform[r])]
        piv.append(j);r+=1
    bad=next((i for i,row in enumerate(a) if not any(row[:variables]) and row[variables]),None)
    return a,piv,transform,bad

def decode_moments(x,y,mass:int):
    """Inverse Fourier transform, then all allowed weight-one -> weight-six lifts.

    x=M_2,y=M_6 are pairs in K14. This is exact reconstruction, not a search.
    """
    moments=[None]*29;moments[0]=(mass%5,0)
    for start,z in ((2,x),(6,y)):
        j=start
        for _ in range(14):
            if moments[j] is not None:raise ArithmeticError('Fourier orbits overlap')
            moments[j]=z;j=j*5%29;z=kp(z,5)
        assert j==start
    assert all(z is not None for z in moments)
    weights=[]
    for a in range(29):
        w=K0
        for j,z in enumerate(moments):w=ka(w,km(z,ZPOW[-j*a%29]))
        w=kc(w,4) # inverse of 29 in F5
        assert w[1]==0 and w[0]<5
        weights.append(w[0])
    ordinary=sum(weights);ones=weights.count(1);delta=mass-ordinary
    allowed=delta>=0 and delta%5==0 and delta//5<=ones
    return {'residue_weights':weights,'least_positive_mass':ordinary,
            'number_of_residue_one_nodes':ones,
            'required_weight_six_nodes':delta//5 if delta>=0 and delta%5==0 else None,
            'allowed_weight_lift_exists':allowed,
            'warning':'This checks only allowed total weights, not genus, inertia, local poles, or an actual curve.'}
