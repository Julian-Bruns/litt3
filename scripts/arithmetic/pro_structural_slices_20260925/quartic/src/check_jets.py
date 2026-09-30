"""Independent truncated-series checks of the three boundary jet formulas.
All roots are handled at once in F25[X]/(A), /(P), or /(A').
No search over a bounded coefficient field is involved.
"""
from ff25 import *
import json,pathlib
ROOT=pathlib.Path(__file__).resolve().parents[1]
CERT=json.loads((ROOT/'data/boundary_certificates.json').read_text())
P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13];Ap=derivative(A)
N=4
class JetRing:
    def __init__(self,m):self.m=m
    def r(self,a):return mod(a,self.m)
    def prod(self,a,b):return self.r(mul(a,b))
    def plus(self,a,b):return add(a,b)
    def inv(self,a):return invmod(a,self.m)
    def const(self,a):return [self.r(a)]+[[] for _ in range(N-1)]
    def sadd(self,a,b):return [add(x,y) for x,y in zip(a,b)]
    def smul(self,a,b):
        c=[[] for _ in range(N)]
        for i in range(N):
            for j in range(N-i):c[i+j]=add(c[i+j],self.prod(a[i],b[j]))
        return c
    def spow(self,a,n):
        z=self.const([1])
        while n:
            if n&1:z=self.smul(z,a)
            a=self.smul(a,a);n>>=1
        return z
    def sinv(self,a):
        b=[self.inv(a[0])]+[[] for _ in range(N-1)]
        for n in range(1,N):
            w=[]
            for i in range(1,n+1):w=add(w,self.prod(a[i],b[n-i]))
            b[n]=neg(self.prod(b[0],w))
        return b
    def evaluate(self,p,x):
        z=self.const([])
        for c in reversed(p):z=self.sadd(self.smul(z,x),self.const([c]))
        return z
    def inverse_A(self,linear):
        x=self.const([0,1]);api=self.inv(self.r(Ap))
        for i in range(1,N):
            current=self.evaluate(A,x)[i]
            target=linear if i==1 else []
            x[i]=self.prod(sub(target,current),api)
        return x

def expect(key,value):
    assert value==CERT[key]['value_modulus'],(key,value,CERT[key]['value_modulus'])

# At a zero of A, use w=A(x) and expand G=A'(x)^3 P(x)^2.
J=JetRing(A);x=J.inverse_A([1]);G=J.smul(J.spow(J.evaluate(Ap,x),3),J.spow(J.evaluate(P,x),2))
gi=[J.prod(G[i],J.inv(G[0])) for i in range(N)]
expect('Aroot_g1',gi[1])
expect('Aroot_z2',J.prod(gi[2],J.inv(J.prod(gi[1],gi[1]))))
expect('Aroot_z3',J.prod(gi[3],J.inv(J.prod(J.prod(gi[1],gi[1]),gi[1]))))
print('A-root jets through cubic order: PASS')

# At a zero of P, use z=A(x)/A(alpha)-1 and expand H/z^2.
J=JetRing(P);x=J.inverse_A(J.r(A))
H=J.smul(J.smul(J.spow(J.evaluate(P,x),2),J.spow(J.evaluate(Ap,x),3)),J.sinv(J.spow(J.evaluate(A,x),3)))
assert not H[0] and not H[1]
expect('branch_P',J.prod(H[3],J.inv(H[2])))
print('P-root normalized H/z^2 linear jet: PASS')

# At a critical point of A, take dx/dz=(P(x)/P(alpha))^(2/3).
# Through order 3 the exponent 2/3 equals 4 in characteristic 5.
J=JetRing(Ap);x=J.const([0,1]);x[1]=[1];pi=J.const(J.inv(J.r(P)))
for i in range(2,N):
    rhs=J.spow(J.smul(J.evaluate(P,x),pi),4)
    x[i]=scale(rhs[i-1],INV[i%5])
ax=J.evaluate(A,x);assert not ax[1]
a2=J.prod(ax[2],J.inv(ax[0]));a3=J.prod(ax[3],J.inv(ax[0]))
expected=scale(J.prod(J.prod(a3,a3),J.inv(J.prod(J.prod(a2,a2),a2))),2)
expect('critical_Aprime',expected)
print('A-prime-root quadratic/cubic flat-coordinate jets: PASS')
