"""Exact F_(5^8), represented as F25[a]/(a^4+[7]a^3+[6]a^2+2a+[5])."""
import ff25 as f
MOD=[5,2,6,7,1]
ZERO=(0,0,0,0); ONE=(1,0,0,0); GEN=(0,1,0,0)
def const(c):return (c,0,0,0)
def add(x,y):return tuple(f.add(a,b) for a,b in zip(x,y))
def neg(x):return tuple(f.neg(a) for a in x)
def sub(x,y):return add(x,neg(y))
def mul(x,y):
    a=f.pdivmod(f.pmul(x,y),MOD)[1]
    return tuple((a+[0]*4)[:4])
def power(x,n):
    if n<0:return power(inv(x),-n)
    r=ONE
    while n:
        if n&1:r=mul(r,x)
        x=mul(x,x); n//=2
    return r
def inv(x):
    if x==ZERO:raise ZeroDivisionError
    return power(x,390623)
def div(x,y):return mul(x,inv(y))
def evaluate(a,x):
    r=ZERO
    for c in reversed(a):r=add(mul(r,x),const(c))
    return r
def code(x):return sum(c*25**i for i,c in enumerate(x))
