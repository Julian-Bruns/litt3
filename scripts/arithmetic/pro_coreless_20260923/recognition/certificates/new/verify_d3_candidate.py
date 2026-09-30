#!/usr/bin/env python3
"""Exact verifier for a proposed d=3 global counterexample certificate.

No candidate is supplied by this package. The verifier is NOT an exclusion
certificate. The report proves that a passing input reconstructs an actual
smooth proper curve T and two everywhere-etale maps T -> X.

Usage:
    python verify_d3_candidate.py --self-test
    python verify_d3_candidate.py candidate.json

JSON schema (all polynomial rows ascending):
  field_modulus: monic irreducible polynomial over F_5, coefficients 0..4
  a: encoded element satisfying a^2=a+3 (the specified embedding of F_25)
  n: integer 6..32
  D,F,G,B1,B2,J: polynomial rows over this finite field
  alpha,m1,m2,c: nonzero field elements
Field elements use base-5 coefficient digits in the polynomial generator.
See report Section 'An exact polynomial decision problem for d=3'.
"""
from __future__ import annotations
import argparse
import json
from pathlib import Path


def trim(p):
    p = list(p)
    while p and p[-1] == 0:
        p.pop()
    return p


def p5div(a, b):
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError('zero divisor')
    q = [0]*max(0,len(a)-len(b)+1)
    inv = pow(b[-1],-1,5)
    while len(a)>=len(b):
        shift, c = len(a)-len(b), a[-1]*inv % 5
        q[shift] = c
        for j, v in enumerate(b):
            a[j+shift] = (a[j+shift]-c*v) % 5
        a = trim(a)
    return trim(q), a


def p5mul(a,b):
    if not a or not b:
        return []
    out=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            out[i+j]=(out[i+j]+x*y)%5
    return trim(out)


def p5gcd(a,b):
    while b:
        a,b=b,p5div(a,b)[1]
    return [(x*pow(a[-1],-1,5))%5 for x in a] if a else []


def p5sub(a,b):
    a=list(a)+[0]*max(0,len(b)-len(a))
    for i,x in enumerate(b):
        a[i]=(a[i]-x)%5
    return trim(a)


def p5powmod(a,n,f):
    out=[1]
    while n:
        if n&1:
            out=p5div(p5mul(out,a),f)[1]
        a=p5div(p5mul(a,a),f)[1]
        n>>=1
    return out


def prime_divisors(n):
    out=[]
    p=2
    while p*p<=n:
        if n%p==0:
            out.append(p)
            while n%p==0:
                n//=p
        p+=1
    if n>1:
        out.append(n)
    return out


class Field:
    def __init__(self,modulus):
        if not isinstance(modulus,list) or len(modulus)<2 or modulus[-1]!=1:
            raise ValueError('field_modulus must be monic of positive degree')
        if any(type(v) is not int or not 0<=v<5 for v in modulus):
            raise ValueError('modulus coefficients must be integers 0..4')
        self.modulus=modulus
        self.degree=len(modulus)-1
        self.order=5**self.degree
        x=p5div([0,1],modulus)[1]
        for prime in prime_divisors(self.degree):
            test=p5sub(p5powmod(x,5**(self.degree//prime),modulus),x)
            if p5gcd(modulus,test)!=[1]:
                raise ValueError('field modulus is reducible')
        if p5powmod(x,self.order,modulus)!=x:
            raise ValueError('field modulus fails Frobenius irreducibility test')

    def valid(self,a):
        return type(a) is int and 0<=a<self.order

    def digits(self,a):
        out=[]
        for _ in range(self.degree):
            out.append(a%5)
            a//=5
        return out

    @staticmethod
    def encode(v):
        out=0
        for a in reversed(v):
            out=5*out+a
        return out

    def add(self,a,b):
        return self.encode([(x+y)%5 for x,y in zip(self.digits(a),self.digits(b))])

    def neg(self,a):
        return self.encode([(-x)%5 for x in self.digits(a)])

    def mul(self,a,b):
        return self.encode(p5div(p5mul(self.digits(a),self.digits(b)),self.modulus)[1])

    def power(self,a,n):
        out=1
        while n:
            if n&1:
                out=self.mul(out,a)
            a=self.mul(a,a)
            n>>=1
        return out

    def inv(self,a):
        if not a:
            raise ZeroDivisionError('cannot invert zero')
        return self.power(a,self.order-2)


class Polynomials:
    def __init__(self,K):
        self.K=K

    def add(self,a,b):
        out=list(a)+[0]*max(0,len(b)-len(a))
        for i,v in enumerate(b):
            out[i]=self.K.add(out[i],v)
        return trim(out)

    def scale(self,a,c):
        return trim([self.K.mul(v,c) for v in a])

    def sub(self,a,b):
        return self.add(a,self.scale(b,4))

    def mul(self,a,b):
        if not a or not b:
            return []
        out=[0]*(len(a)+len(b)-1)
        for i,u in enumerate(a):
            for j,v in enumerate(b):
                out[i+j]=self.K.add(out[i+j],self.K.mul(u,v))
        return trim(out)

    def power(self,a,n):
        out=[1]
        while n:
            if n&1:
                out=self.mul(out,a)
            a=self.mul(a,a)
            n>>=1
        return out

    def div(self,a,b):
        a,b=trim(a),trim(b)
        if not b:
            raise ZeroDivisionError('zero polynomial divisor')
        out=[0]*max(0,len(a)-len(b)+1)
        inv=self.K.inv(b[-1])
        while len(a)>=len(b):
            shift=len(a)-len(b)
            c=self.K.mul(a[-1],inv)
            out[shift]=c
            a=self.sub(a,[0]*shift+self.scale(b,c))
        return trim(out),a

    def gcd(self,a,b):
        while b:
            a,b=b,self.div(a,b)[1]
        return self.scale(a,self.K.inv(a[-1])) if a else []

    def derivative(self,a):
        return trim([self.K.mul(i%5,a[i]) for i in range(1,len(a))])

    def homogeneous(self,row,F,D):
        degree=len(row)-1
        out=[]
        for j,c in enumerate(row):
            out=self.add(out,self.scale(self.mul(self.power(F,j),self.power(D,degree-j)),c))
        return out


def require(condition,message):
    if not condition:
        raise ValueError(message)


def verify(data):
    K=Field(data['field_modulus'])
    R=Polynomials(K)
    a=data['a']
    require(K.valid(a) and K.mul(a,a)==K.add(a,3),'invalid F_25 embedding')
    n=data['n']
    require(type(n) is int and 6<=n<=32,'n must be between 6 and 32')
    pol={}
    for key in ('D','F','G','B1','B2','J'):
        row=data[key]
        require(isinstance(row,list) and all(K.valid(v) for v in row),f'invalid row {key}')
        pol[key]=trim(row)
    constants={key:data[key] for key in ('alpha','m1','m2','c')}
    require(all(K.valid(v) and v for v in constants.values()),'constants must be nonzero')
    D,F,G,B1,B2,J=(pol[key] for key in ('D','F','G','B1','B2','J'))
    for name,degree in [('D',n-3),('F',n),('G',n),('B1',n-2),('B2',n-2),('J',7*n+6)]:
        require(len(pol[name])-1==degree,f'wrong degree of {name}')
    require(D[-1]==1,'D must be monic')
    require(not R.div([4]+[0]*28+[1],D)[1],'D does not divide s^29-1')
    for name in ('D','B1','B2','J'):
        require(R.gcd(pol[name],R.derivative(pol[name]))==[1],f'{name} is not squarefree')
    require(R.gcd(D,R.mul(F,G))==[1],'cancellation at a prescribed pole')
    require(R.gcd(R.mul(D,J),R.mul(B1,B2))==[1],'critical and branch factors overlap')
    require(R.gcd(D,J)==[1],'D and J overlap')
    require(D[0] and G[0] and J[0] and B1[0] and B2[0],'forbidden zero at s=0')
    embed=lambda c: K.add(c%5,K.mul(c//5,a))
    A=list(map(embed,[1,21,14,22,13]))
    P=list(map(embed,[11,22,18,5,19,20,15,16,9,22,1]))
    s=[0,1]
    s3D=[0,0,0]+D
    require(R.mul(s,R.homogeneous(A,G,s3D))==R.scale(R.homogeneous(A,F,D),constants['alpha']),
            'A identity fails')
    lhs=R.sub(R.mul(R.derivative(F),D),R.mul(F,R.derivative(D)))
    require(lhs==R.scale(R.power(B1,2),constants['m1']),'first derivative identity fails')
    lhs=R.sub(R.mul(R.mul(s,D),R.derivative(G)),R.mul(R.add(R.scale(D,3),R.mul(s,R.derivative(D))),G))
    require(lhs==R.scale(R.power(B2,2),constants['m2']),'second derivative identity fails')
    require(R.homogeneous(P,F,D)==R.mul(R.power(B1,3),J),'first P identity fails')
    require(R.homogeneous(P,G,s3D)==R.scale(R.mul(R.power(B2,3),J),constants['c']),
            'second P identity fails')
    return {
        'status':'candidate_verified',
        'n':n,
        'degree_z_on_T':3,
        'genus_T':8*n+1,
        'T_model':'w^3=D(s)^2*J(s), followed by smooth proper normalization',
        'h1':'x=F/D, y=B1*w/D^4',
        'h2':'x=G/(s^3*D), y=rho*B2*w/(s^10*D^4), rho^3=c',
        'etaleness':'proved by the reconstruction theorem in the report',
        'distinct_fields':'proved by the reconstruction theorem in the report',
        'corelessness':'follows from distinct fields and the supplied cored exclusion',
    }


def self_test():
    K=Field([2,4,1])
    require(K.mul(5,5)==K.add(5,3),'field relation')
    for a in range(25):
        for b in range(25):
            for c in range(25):
                require(K.mul(a,K.add(b,c))==K.add(K.mul(a,b),K.mul(a,c)),'distributivity')
        if a:
            require(K.mul(a,K.inv(a))==1,'inversion')
    R=Polynomials(K)
    for f in ([1,2,3],[5,7,1],[0,1]):
        for g in ([2,1],[1,5,1]):
            product=R.mul(f,g)
            quotient,remainder=R.div(product,g)
            require(quotient==f and not remainder,'polynomial division')
    try:
        Field([4,0,1]) # x^2-1 is reducible.
        raise RuntimeError('reducible modulus was accepted')
    except ValueError:
        pass
    print('finite_field_and_polynomial_self_tests=passed')
    print('scope=verifier_self_tests_only_no_global_candidate_supplied')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('candidate',nargs='?',type=Path)
    parser.add_argument('--self-test',action='store_true')
    args=parser.parse_args()
    if args.self_test:
        self_test()
    elif args.candidate:
        try:
            print(json.dumps(verify(json.loads(args.candidate.read_text())),indent=2))
        except (ValueError,KeyError,TypeError,ZeroDivisionError) as exc:
            raise SystemExit(f'Candidate rejected: {exc}')
    else:
        parser.error('supply --self-test or a candidate JSON file')


if __name__=='__main__':
    main()
