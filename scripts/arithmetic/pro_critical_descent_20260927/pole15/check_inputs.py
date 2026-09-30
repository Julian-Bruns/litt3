#!/usr/bin/env python3
"""Small exact checks of the supplied curve data, using F25 codes literally."""
import json
from pathlib import Path

def add(x,y): return (x%5+y%5)%5 + 5*((x//5+y//5)%5)
def neg(x): return (-x%5)%5 + 5*((-(x//5))%5)
def mul(x,y):
    a,b,c,d=x%5,x//5,y%5,y//5
    return (a*c+3*b*d)%5 + 5*((a*d+b*c+b*d)%5)
def power(x,n):
    z=1
    while n:
        if n&1: z=mul(z,x)
        x=mul(x,x);n>>=1
    return z
def trim(a):
    a=list(a)
    while a and not a[-1]: a.pop()
    return a
def ps(a,b):
    return trim([add(a[i] if i<len(a) else 0,neg(b[i] if i<len(b) else 0))
                 for i in range(max(len(a),len(b)))])
def pm(a,b):
    z=[0]*max(0,len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):z[i+j]=add(z[i+j],mul(x,y))
    return trim(z)
def pr(a,b):
    a,b=trim(a),trim(b)
    if not b:raise ZeroDivisionError
    while len(a)>=len(b):
        c=mul(a[-1],power(b[-1],23)); j=len(a)-len(b)
        for i,x in enumerate(b):a[i+j]=add(a[i+j],neg(mul(c,x)))
        a=trim(a)
    return a
def pp(a,n,f):
    z=[1]
    while n:
        if n&1:z=pr(pm(z,a),f)
        a=pr(pm(a,a),f);n>>=1
    return z
def pg(a,b):
    while b:a,b=b,pr(a,b)
    return [mul(x,power(a[-1],23)) for x in a] if a else []
def pd(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def verify():
    data=json.loads((Path(__file__).resolve().parents[1]/'inputs.json').read_text())
    P,A,Q=data['P_ascending'],data['A_ascending'],data['Q_ascending']
    assert mul(5,5)==8 # beta^2=3+beta
    assert all(power(i,24)==1 for i in range(1,25))
    assert pd(Q)==pm(P,pm(A,A))
    assert pg(A,pd(A))==[1] and pg(A,P)==[1] and pg(P,pd(P))==[1]
    Am=[mul(c,power(A[-1],23)) for c in A]
    assert Am==data['A_monic_ascending']
    x=[0,1]
    assert pp(x,25**4,Am)==x and pg(ps(pp(x,25**2,Am),x),Am)==[1]
    basis=[(a,b) for b in range(3) for a in range(6) if 3*a+10*b<=15]
    assert basis==[(0,0),(1,0),(2,0),(3,0),(4,0),(5,0),(0,1),(1,1)]
    return {'F25_arithmetic':'passed','Q_prime_equals_P_A_squared':True,
            'P_squarefree':True,'A_squarefree_and_coprime_to_P':True,
            'A_irreducible_over_F25':True,'L15O_monomials':basis,
            'not_checked_here':['automorphism group','supplied field-recognition reductions',
                                 'c_alpha, b0_alpha and W_alpha arithmetic rows']}
if __name__=='__main__': print(json.dumps(verify(),indent=2))
