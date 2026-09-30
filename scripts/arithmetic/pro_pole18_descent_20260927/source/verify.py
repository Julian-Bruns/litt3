#!/usr/bin/env python3
"""Exact checks for pole18_descent. Python >=3.10, standard library only.

This is not an enumeration of covers or scalars. The complete phase-multiset
check is separately executed by phase_sums.cpp. The theoretical implications
are proved in REPORT.md; these arithmetic checks corroborate their inputs.
"""
from pathlib import Path
import json, math, sys
ROOT=Path(__file__).resolve().parents[1]
DATA=json.loads((ROOT/'inputs/exact_data.json').read_text())

def trim(a):
    a=list(a)
    while len(a)>1 and a[-1]==0:a.pop()
    return a or [0]

class Field:
    def __init__(self,q):
        assert q in (5,25)
        self.q=q
    def add(self,a,b):
        if self.q==5:return (a+b)%5
        return ((a%5+b%5)%5)+5*((a//5+b//5)%5)
    def neg(self,a):
        if self.q==5:return -a%5
        return (-a%5)+5*(-(a//5)%5)
    def sub(self,a,b):return self.add(a,self.neg(b))
    def mul(self,a,b):
        if self.q==5:return a*b%5
        a0,a1=a%5,a//5;b0,b1=b%5,b//5
        return ((a0*b0+3*a1*b1)%5)+5*((a0*b1+a1*b0+a1*b1)%5)
    def pow(self,a,n):
        assert n>=0
        out=1
        while n:
            if n&1:out=self.mul(out,a)
            a=self.mul(a,a);n//=2
        return out
    def inv(self,a):
        assert a
        return self.pow(a,self.q-2)
    def padd(self,a,b):
        return trim([self.add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
    def pneg(self,a):return [self.neg(v) for v in a]
    def psub(self,a,b):return self.padd(a,self.pneg(b))
    def pmul(self,a,b):
        c=[0]*(len(a)+len(b)-1)
        for i,x in enumerate(a):
            for j,y in enumerate(b):c[i+j]=self.add(c[i+j],self.mul(x,y))
        return trim(c)
    def pscale(self,a,c):return trim([self.mul(x,c) for x in a])
    def pdiv(self,a,b):
        a=trim(a);b=trim(b);assert b!=[0]
        q=[0]*max(1,len(a)-len(b)+1)
        while a!=[0] and len(a)>=len(b):
            i=len(a)-len(b);c=self.mul(a[-1],self.inv(b[-1]));q[i]=c
            a=self.psub(a,[0]*i+self.pscale(b,c))
        return trim(q),a
    def pmod(self,a,b):return self.pdiv(a,b)[1]
    def ppow(self,a,n,mod=None):
        out=[1]
        while n:
            if n&1:
                out=self.pmul(out,a)
                if mod:out=self.pmod(out,mod)
            a=self.pmul(a,a)
            if mod:a=self.pmod(a,mod)
            n//=2
        return out
    def pgcd(self,a,b):
        while trim(b)!=[0]:a,b=b,self.pmod(a,b)
        return self.pscale(a,self.inv(a[-1]))
    def deriv(self,a):return trim([self.mul(i%5,a[i]) for i in range(1,len(a))])
    def peval(self,a,t):
        out=0
        for x in reversed(a):out=self.add(self.mul(out,t),x)
        return out
    def irreducible(self,f):
        n=len(trim(f))-1;x=[0,1]
        primes=[p for p in range(2,n+1) if n%p==0 and all(p%d for d in range(2,math.isqrt(p)+1))]
        if self.psub(self.ppow(x,self.q**n,f),x)!=[0]:return False
        return all(self.pgcd(f,self.psub(self.ppow(x,self.q**(n//p),f),x))==[1] for p in primes)

F=Field(5); E=Field(25)
assert E.mul(5,5)==8 # beta^2=3+beta
for a in range(1,25):assert E.mul(a,E.inv(a))==1
print('PASS F25 arithmetic and all 24 inverses')
P,A,Q=(DATA['ascending_polynomials'][s] for s in ('P','A','Q'))
assert E.deriv(Q)==E.pmul(P,E.ppow(A,2))
assert E.pgcd(P,E.deriv(P))==[1]
assert E.pgcd(A,E.deriv(A))==[1]
assert E.pgcd(P,A)==[1]
assert A[-1]==13
assert E.irreducible(A)
print('PASS Q\'=P*A^2; P and A squarefree; gcd(P,A)=1; A irreducible over F25')
f=DATA['phase_field']['monic_modulus_ascending']
assert F.irreducible(f)
assert F.ppow([0,1],29,f)==[1]
assert F.pmod([0,1],f)!=[1]
assert F.pmod([1]*29,f)==[0]
powers=[F.ppow([0,1],i,f) for i in range(29)]
assert len({tuple(p) for p in powers})==29
print('PASS phase modulus irreducible of degree 14; xi has exact order 29')
# Independent F25 model used by the complete pole-support rank calculation.
f25=DATA['phase_field_over_F25']['monic_modulus_ascending']
assert E.irreducible(f25)
assert E.ppow([0,1],29,f25)==[1]
beta_emb=DATA['phase_field_over_F25']['beta_embedding_ascending_F5']
assert F.psub(F.ppow(beta_emb,2,f),F.padd(beta_emb,[3]))==[0]
# Evaluate the F25 modulus in the F5 model, beta -> beta_emb and xi -> T.
f25_in_f5=[0]
for j,a in enumerate(f25):
    coeff=F.padd([a%5],F.pscale(beta_emb,a//5))
    f25_in_f5=F.padd(f25_in_f5,[0]*j+coeff)
assert F.pmod(f25_in_f5,f)==[0]
assert DATA['phase_field_over_F25']['orbit_exponents']==[pow(25,j,29) for j in range(7)]
print('PASS degree-seven F25 phase modulus, exact order, and cross-model embedding')
# b_alpha has degree four over F25, so all four b_alpha are distinct.
Aprime=E.deriv(A)
c_alpha=E.pmod(E.pscale(E.pmul(E.ppow(Aprime,3),E.ppow(P,2)),E.mul(3,E.inv(E.pow(A[-1],3)))),A)
b_alpha=E.ppow(c_alpha,pow(29,-1,25**4-1),A)
assert c_alpha==[7,8,4,3]
assert b_alpha==[21,19,20,22]
assert E.ppow(b_alpha,25**2,A)!=b_alpha
assert E.ppow(b_alpha,25**4,A)==b_alpha
print('PASS c_alpha and b_alpha reconstruction; b_alpha has four distinct 25-Frobenius conjugates')

compositions=[]
for a in range(7):
 for b in range(7-a):
  for c in range(7-a-b):
   d=6-a-b-c;m=(a,b,c,d);compositions.append(m)
   assert 0 in m or 1 in m
   g=math.gcd(*(abs(x-a) for x in m[1:]))
   assert g>0 and 6%g==0
assert len(compositions)==84
print('PASS all 84 norm compositions: absent root or singleton; difference gcd divides 6')
N=6*(5**8-1)
assert N==2343744 and (5**48-1)%N==0
assert math.gcd(8,14)==2 and math.gcd(29,5**8-1)==1
print('PASS scalar order 2343744 divides 5^48-1; phase/coefficient field intersection degree 2')
# Endpoint singular ODE: K*u_t=2b, K*L=4*2=3, numerator derivative=4*2-2=1.
assert (1-4*2)%5==3
assert ((4*2-2)*pow(3,-1,5))%5==2
# Common-point indicial coefficients for character orders 2,5,8.
assert (2-2*1)%5==0
assert all((5-2*r)%5 for r in (1,2))
assert [(8-2*r)%5 for r in (1,2,3,4)]==[1,4,2,0]
assert (57%29,57%5)==(28,2)
assert (8*18)%29==28 and (8*4)%5==2
print('PASS endpoint eigenvalue 2; order-five nonresonance; order-eight fourth-pole resonance; transport exponent 57')
# Endpoint character lemma: w^12=(1+h)^29, J=3(1+h)(w-1)/(1-3w).
w=[1,2,1]
assert F.ppow(w,12)[:3]==F.ppow([1,1],29)[:3]
numerator=F.pscale(F.pmul([1,1],F.psub(w,[1])),3)
denominator=F.psub([1],F.pscale(w,3))
j_series=[]
for i in range(3):
    coefficient=numerator[i] if i<len(numerator) else 0
    for a in range(1,min(i+1,len(denominator))):
        coefficient=F.sub(coefficient,F.mul(denominator[a],j_series[i-a]))
    j_series.append(F.mul(coefficient,F.inv(denominator[0])))
assert j_series==[0,2,2]
# Discrete composition/phase-partition classification; there are no unknown field coefficients here.
def partitions(n,least=1):
    if n==0:
        yield ()
    else:
        for a in range(least,n+1):
            for rest in partitions(n-a,a):yield (a,)+rest
import itertools
admissible=[];types=set()
for comp in compositions:
    positive=[m for m in comp if m]
    if len({m%5 for m in positive})!=1:continue
    for parts in itertools.product(*(list(partitions(m)) for m in positive)):
        rs=[r for part in parts for r in part]
        if len({r%5 for r in rs})!=1:continue
        assert len(set(positive))==1 and len(set(rs))==1
        m=positive[0];r=rs[0];d=m//r
        types.add((m,r,d));admissible.append((comp,parts))
        assert r%5!=0 and d in (1,2,3,6)
        assert (d*(d+1))%5!=0
        assert ((2*r)-2*(r-1))%5==2
assert len(admissible)==36
assert types=={(6,1,6),(6,2,3),(6,3,2),(6,6,1),(3,1,3),(3,3,1),(2,1,2),(2,2,1)}
assert [d*(d+1)%5 for d in (1,2,3,6)]==[2,1,2,2]
print('PASS endpoint character lemma: J=2h+2h^2/a+...; all 36 labelled integer patterns give d(d+1)!=0')

# Auxiliary rational pair U=N/(t-1)^4=V^5+t^2 W^5.
C=[4,1]; denom=F.ppow(C,4)
num=DATA['resonant_auxiliary_pair']['N_ascending_F5']
vnum=[0,4,2];wnum=[0,4]
assert F.pmul(num,C)==F.padd(F.ppow(vnum,5),[0,0]+F.ppow(wnum,5))
# Verify Euler ODE t U''-U'=0 via polynomial numerator arithmetic.
# U'=(N'D - ND')/D^2. This direct calculation avoids relying on its Frobenius split.
D=denom
up=F.psub(F.pmul(F.deriv(num),D),F.pmul(num,F.deriv(D)))
udd_num=F.psub(F.pmul(F.deriv(up),D),F.pscale(F.pmul(up,F.deriv(D)),2))
K_num=F.psub([0]+udd_num,F.pmul(up,D))
assert K_num==[0]
assert F.peval(num,1)==3
assert min(i for i,a in enumerate(num) if a)==5
assert len(num)-len(D)==5
# U(t)-t^57 U(1/t) has denominator (t-1)^4, numerator N(t)-t^61 N(1/t).
rev=[0]*62
for i,a in enumerate(num):rev[61-i]=a
quot,rem=F.pdiv(F.psub(num,rev),D)
assert rem==[0]
assert len(quot)-1==52
assert min(i for i,a in enumerate(quot) if a)==5
# Finite parts at c=1: V=h^-1+3+2h; W=-h^-1-1; v=t^(1/12), v(1)=1, v'(1)=3.
assert (4+3+3)%5==0
# Polar part: coefficient h^-4=3, coefficient h^-3=4, others zero.
# Obtain N(1+h) exactly and divide by h^4.
shift=[0]
for i,a in enumerate(num):shift=F.padd(shift,F.pscale(F.ppow([1,1],i),a))
assert shift[:4]==[3,4,0,0]
print('PASS nonzero auxiliary pair: Euler equation, fourth pole, finite part, zero/growth bounds, reciprocal polynomial identity')
print('Auxiliary reciprocal polynomial coefficients (ascending F5):',quot)
print('ALL PYTHON CHECKS PASSED. The geometric implication is proved in REPORT.md; no cover is being constructed.')
