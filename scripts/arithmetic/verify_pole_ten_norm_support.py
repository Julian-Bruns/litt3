"""Independent standard-library replay of pole_ten_norm_support.sage.

Usage: python3 -B scripts/arithmetic/verify_pole_ten_norm_support.py CERT.json
This implementation uses flat base-25 integers for F25[alpha]/M, and
reconstructs every monic cube rather than trusting the claimed obstruction.
"""
import json
import sys

def a25(a,b):
    return (a%5+b%5)%5+5*((a//5+b//5)%5)
def n25(a):
    return (-a%5)+5*((-(a//5))%5)
def m25(a,b):
    a0,a1,b0,b1=a%5,a//5,b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def digits(a):
    out=[]
    for _ in range(4):
        out.append(a%25); a//=25
    assert not a
    return out
def code(a):
    return sum(c*25**i for i,c in enumerate(a))
def add(a,b): return code([a25(x,y) for x,y in zip(digits(a),digits(b))])
def neg(a): return code([n25(x) for x in digits(a)])
def sub(a,b): return add(a,neg(b))
MOD=(5,2,6,7,1)
def mul(a,b):
    c=[0]*7
    for i,x in enumerate(digits(a)):
        for j,y in enumerate(digits(b)):
            c[i+j]=a25(c[i+j],m25(x,y))
    for i in range(6,3,-1):
        for j in range(4):
            c[i-4+j]=a25(c[i-4+j],n25(m25(c[i],MOD[j])))
    return code(c[:4])
def power(a,n):
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r
def inv(a):
    assert a
    r=power(a,25**4-2)
    assert mul(a,r)==1
    return r
def trim(a):
    a=list(a)
    while a and not a[-1]:a.pop()
    return a
def padd(a,b):
    return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0)
                 for i in range(max(len(a),len(b)))])
def psub(a,b):return padd(a,[neg(x) for x in b])
def pmul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
    return trim(c)
def pcube(a):return pmul(pmul(a,a),a)
def peval(a,t):
    r=0
    for x in reversed(a):r=add(mul(r,t),x)
    return r
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
roots=[power(25,25**i) for i in range(4)]
assert len(set(roots))==4
assert all(peval(A,r)==0 and peval(P,r)!=0 for r in roots)
def verify(path):
    cert=json.load(open(path))
    assert cert['solutions']==[]
    assert len(cert['rows'])==cert['number_of_compositions']==286
    seen=set()
    for row in cert['rows']:
        weights=tuple(row['weights'])
        assert len(weights)==4 and sum(weights)==10 and min(weights)>=0
        assert weights not in seen
        seen.add(weights)
        S=[1]
        for r,m in zip(roots,weights):
            for _ in range(m):S=pmul(S,[neg(r),1])
        D=psub(S,P)
        assert len(D)==10 and row['degree']==9
        E=[mul(c,inv(D[-1])) for c in D]
        q=[0,0,0,1]
        for j in range(2,-1,-1):
            diff=psub(E,pcube(q))
            q[j]=mul(diff[6+j] if len(diff)>6+j else 0,2)
        residual=psub(E,pcube(q))
        assert residual
        assert [digits(c) for c in q]==row['monic_root']
        assert len(residual)-1==row['residual_degree']
        assert digits(residual[-1])==row['residual_coefficient']
        assert row['obstruction']=='nonzero_cube_residual'
    assert len(seen)==286
    print('PASS: all 286 geometric degree-ten support patterns fail the cube identity.')

if __name__=='__main__':
    verify(sys.argv[1])
