#!/usr/bin/env sage-python
"""UNEXECUTED continuation code: construct the complete global localized ideal.

This file was syntax-checked with CPython, but SageMath was not installed in the
execution environment. No output of this file is used as evidence in this archive.
It does not restrict H,w,lambda to the finite coefficient field.

Commands (from the archive root):
  sage -python src/global_builder_sage.py --r 9 --stage residual
  sage -python src/global_builder_sage.py --r 9 --stage circuit
  sage -python src/global_builder_sage.py --r 9 --stage groebner
Repeat separately for every root listed in data/inputs.json.

The expensive stages are separated so a completed residual or ideal is reusable.
A raw Groebner output is NOT automatically promoted to a certified final verdict.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, save, load, lcm

ROOT = Path(__file__).resolve().parents[1]
DATA = json.loads((ROOT/'data'/'inputs.json').read_text())
MODEL = json.loads((ROOT/'data'/'field_model.json').read_text())
Fp = GF(5)
Zp = PolynomialRing(Fp, 'z')
K = GF(5**8, 'alpha', modulus=Zp(MODEL['absolute_modulus_ascending_F5']))
alpha = K.gen()
beta = sum((K(c)*alpha**i for i,c in enumerate(MODEL['beta_in_alpha_ascending_F5'])),K(0))
assert beta**2 == beta+3

def kc(n):
    n=int(n)
    if not 0 <= n < 390625:
        raise ValueError('Not a K code')
    out=K(0)
    for i in range(4):
        c=n%25;n//=25
        out+=(K(c%5)+K(c//5)*beta)*alpha**i
    return out

assert alpha**4+kc(7)*alpha**3+kc(6)*alpha**2+kc(2)*alpha+kc(5)==0
A=PolynomialRing(K,names=('H','w','lam'),order='degrevlex')
H,w,lam=A.gens()
F=A.fraction_field()
X=PolynomialRing(F,'x');x=X.gen()
P=X([kc(c) for c in DATA['P']])
A0=X([kc(c) for c in DATA['A']])
Q=X([kc(c) for c in DATA['Q']])
B0=X([kc(c) for c in DATA['B0']])
t,rem=A0.quo_rem(kc(13)*(x-alpha));assert rem==0
for rr in DATA['roots']:assert P(kc(rr))==0

def exactdiv(a,b):
    q,r=a.quo_rem(b)
    if r != 0:raise ArithmeticError('Nonexact polynomial division')
    return q

class Curve:
    def __init__(self,a=0):
        if isinstance(a,Curve):self.c=a.c
        elif isinstance(a,(tuple,list)) and len(a)==3:self.c=tuple(X(p) for p in a)
        else:self.c=(X(a),X(0),X(0))
    @staticmethod
    def mon(i,j,c=1):
        row=[X(0)]*3;row[j]=X(c)*x**i
        return Curve(row)
    def __add__(self,b):
        b=Curve(b);return Curve([a+c for a,c in zip(self.c,b.c)])
    __radd__=__add__
    def __neg__(self):return Curve([-a for a in self.c])
    def __sub__(self,b):return self+-Curve(b)
    def __rsub__(self,b):return Curve(b)+-self
    def __mul__(self,b):
        b=Curve(b);out=[X(0)]*3
        for i in range(3):
            for j in range(3):out[(i+j)%3]+=self.c[i]*b.c[j]*(P if i+j>=3 else 1)
        return Curve(out)
    __rmul__=__mul__
    def __pow__(self,n):
        if n<0:raise ValueError('Nonnegative curve powers only')
        a=self;b=Curve(1)
        while n:
            if n&1:b=b*a
            a=a*a;n//=2
        return b
    def divide_y(self,n):
        out=[X(0)]*3
        for j in range(3):
            e=max(0,(n-j+2)//3)
            out[j+3*e-n]=exactdiv(self.c[j],P**e)
        return Curve(out)
    def norm(self):
        a,b,c=self.c;return a**3+b**3*P+c**3*P**2-3*a*b*c*P

def source_coordinates():
    for n,d in enumerate((14,46,57,70)):
        for j in range(3):
            for i in range(max(-1,(d-10*j)//3)+1):yield n,i,j

def parse_sparse(rows,q=False):
    base=F(w)**3 if q else F(w)
    return sum((F(kc(c))*F(H)**h*base**e for h,e,c in rows),F(0))

def build_source(r):
    data=json.loads((ROOT/'data'/f'cramer_{r}.json').read_text())
    rows=data['source_numerators_H_w'];coords=list(source_coordinates())
    assert len(rows)==len(coords)==156
    den=F(w)**3-kc(data['pivot'])
    G=[Curve() for _ in range(4)]
    for (n,i,j),row in zip(coords,rows):G[n]+=Curve.mon(i,j,parse_sparse(row)/den)
    G[0]=G[0]*Curve.mon(0,2)
    assert G[0].divide_y(2).c[1][1]==F(H*w)
    assert G[2].c[0][19]==F(w)
    return G

def resultant_from_bar(G,r):
    g2=G[0].divide_y(2)
    g3=(G[1]-3*B0*G[0]).divide_y(3)
    g4=(G[2]-2*B0*G[1]+3*B0**2*G[0]).divide_y(4)
    g5=(G[3]-B0*G[2]+B0**2*G[1]-B0**3*G[0]).divide_y(5)
    Qb=Curve.mon(0,1)*exactdiv(Q-B0**5,P**2)
    a,b,c,d=3*g2,2*g3,g4,g5
    C=Curve(t**3);ell=Curve(F(lam)*(x-kc(r)))
    E=a*d-b*c;Delta=b**2+a*c
    T0=c**5-Qb*b**5+Qb**2*a**5;U0=2*Qb*a**5-b**5
    V0=(-d*b**5-2*c**2*b**4-3*a*b**2*c**3-2*a**2*c**4
        +Qb*(2*a**5*d-a**4*b*c+a**3*b**3))
    W0=a**2*d**2-a*b*c*d+2*b**2*c**2+b**3*d+a*c**3
    M0=U0*(2*a*E+b*Delta)-a**2*V0
    RZ=(ell**2*T0**2+ell*(T0*V0+C*(U0**2-2*a**5*T0))
        +a**3*(T0*W0+C*M0)+C**2*a**10)
    return exactdiv(RZ.norm(),t**15*(x-kc(r))**3)

def check_sample(R,r):
    stored=json.loads((ROOT/'evidence'/f'sample_{r}.json').read_text())
    for ell in range(7):
        lv=kc(ell)
        ev=A.hom([kc(stored['H']),kc(stored['w']),lv],K)
        for i in range(141):
            f=F(R[i]);actual=ev(f.numerator())/ev(f.denominator())
            expect=K(0)
            for j,row in enumerate(stored['R_lambda_rows']):
                if i<len(row):expect+=kc(row[i])*lv**j
            assert actual==expect,(r,i,ell,'sample mismatch')

def open_polynomial(r):
    dat=json.loads((ROOT/'data'/f'psi_{r}.json').read_text())
    theta=A(parse_sparse(dat['Theta_H_q'],q=True))
    return H*w*lam*theta*(w**3-kc(dat['q_r']))*(w**3-kc(dat['pivot']))

def supported_on_open(f,op):
    f=A(f)
    while f and f.total_degree()>0:
        g=f.gcd(op)
        if g.total_degree()==0:return False
        f=exactdiv(f,g)
    return bool(f)

def clear_denominators(R,op):
    den=A(1)
    for c in R.list():den=lcm(den,A(c.denominator()))
    assert supported_on_open(den,op)
    N=[A(F(R[i])*F(den)) for i in range(141)]
    # Remove only a common scalar factor certified invertible on the original open set.
    content=A(0)
    for c in N:content=content.gcd(c)
    if content.total_degree()>0:
        assert supported_on_open(content,op)
        N=[exactdiv(c,content) for c in N]
    assert supported_on_open(N[140],op)
    return N

def trunc_product(a,b,n):
    out=[A(0) for _ in range(n)]
    for i,u in enumerate(a[:n]):
        if u:
            for j,v in enumerate(b[:n-i]):
                if v:out[i+j]+=u*v
    return out

def full_circuit(N):
    ahat=list(reversed(N));aa=ahat[:125]
    a2=trunc_product(aa,aa,125);a3=trunc_product(aa,a2,125)
    f5=[A(0) for _ in range(125)];f25=f5[:]
    for j in range(25):f5[5*j]=a2[j]**5
    for j in range(5):f25[25*j]=a2[j]**25
    C=trunc_product(trunc_product(a3,f5,125),f25,125)
    B=C[:71];B2=trunc_product(B,B,141);L=N[140]
    eq=C[71:125]+[B2[j]-L**125*ahat[j] for j in range(125,141)]
    assert len(eq)==70
    return eq

def strip_open_factors(f,op):
    if not f:return f
    while True:
        g=f.gcd(op)
        if g.total_degree()==0:return f
        f=exactdiv(f,g)

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--r',type=int,required=True,choices=DATA['roots'])
    ap.add_argument('--stage',choices=['residual','circuit','groebner'],required=True)
    ap.add_argument('--output',default='generated')
    args=ap.parse_args();out=ROOT/args.output;out.mkdir(parents=True,exist_ok=True)
    stem=out/f'r{args.r}'
    if args.stage=='residual':
        G=build_source(args.r);R=resultant_from_bar(G,args.r)
        assert R.degree()==140
        dat=json.loads((ROOT/'data'/f'psi_{args.r}.json').read_text())
        theta=parse_sparse(dat['Theta_H_q'],q=True)
        f6=theta/(F(w)**3*(F(w)**3-kc(dat['pivot'])))
        eps=kc(DATA['epsilon_K_code'])
        assert R[140]==(3*(F(H)*F(w))**3*eps**8*f6)**3
        check_sample(R,args.r)
        save(R,str(stem)+'_residual.sobj')
        print('Symbolic residual constructed and sample self-checks passed. No square decision.')
    elif args.stage=='circuit':
        R=load(str(stem)+'_residual.sobj');op=open_polynomial(args.r)
        N=clear_denominators(R,op);eq=full_circuit(N)
        eq=[strip_open_factors(f,op) for f in eq]
        B=PolynomialRing(K,names=('H','w','lam','inv'),order='degrevlex')
        hh,ww,ll,iv=B.gens();emb=A.hom([hh,ww,ll],B)
        I=B.ideal([emb(f) for f in eq]+[iv*emb(op)-1])
        save(I,str(stem)+'_complete_ideal.sobj')
        print('All 70 equations and the exact open condition retained. Ideal saved; no decision.')
    else:
        I=load(str(stem)+'_complete_ideal.sobj')
        G=I.groebner_basis(algorithm='singular:std')
        save(G,str(stem)+'_groebner.sobj')
        print('RAW Groebner result, not used as a certificate by this archive:',G)
        print('Next: export and independently verify a lift of 1, or a nonzero finite quotient.')

if __name__=='__main__':main()
