#!/usr/bin/env sage
"""A new bounded probe of dLambda, never a family-wide exclusion.

Read the accepted root-nine source; inspect the divisor of its critical
scale differential at specified ratios.  No old certificate is replayed.
"""
import argparse, json, time
from pathlib import Path
p=argparse.ArgumentParser(); p.add_argument('source');p.add_argument('output')
p.add_argument('--h',type=int,default=30);p.add_argument('--w',type=int,default=25)
args=p.parse_args();out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
s=load(args.source);oldP=s['P'];R=oldP.base_ring().ring();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
    z=K.zero()
    for i in range(4):
        d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
    assert c==0
    return z
h0,w0=map(dec,(args.h,args.w))
L=FunctionField(K,'x');x=L.gen();RY=PolynomialRing(L,'yy');yy=RY.gen()
PP=sum((dec(c)*x**i for i,c in enumerate([11,22,18,5,19,20,15,16,9,22,1])),L.zero())
X=L.extension(yy**3-PP,'y');y=X.gen()
def coeff(c):
    return c.numerator()(h0,w0)/c.denominator()(h0,w0)
def row(p):return sum((X(coeff(c))*x**i for i,c in enumerate(p)),X.zero())
G=[sum((row(g[j])*y**j for j in range(3)),X.zero()) for g in s['source_G']]
B0=sum((dec(c)*x**i for i,c in enumerate([8,14,19,2,10,19,3,24,18,16])),L.zero())
Q=sum((dec(c)*x**i for i,c in enumerate([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])),L.zero())
A=sum((dec(c)*x**i for i,c in enumerate([1,21,14,22,13])),L.zero())
t=A/(dec(13)*(x-a));v=x-dec(9)
g2=G[0]/y**2
g3=(G[1]-3*B0*G[0])/y**3
g4=(G[2]-2*B0*G[1]+3*B0**2*G[0])/y**4
g5=(G[3]-B0*G[2]+B0**2*G[1]-B0**3*G[0])/y**5
QB=(Q-B0**5)/y**5
RW=PolynomialRing(X,'ww');ww=RW.gen();D=3*g2*ww**2+2*g3*ww+g4
C=X.extension(D.monic(),'W');W=C.gen()
phi=W**5+QB;ss=g2*W**3+g3*W**2+g4*W+g5
lam=-(phi*ss+t**3)/(v*phi**2)
dx=X.derivation();ssx=dx(g2)*W**3+dx(g3)*W**2+dx(g4)*W+dx(g5)
dl=(phi*dx(QB)*ss-phi**2*ssx-3*t**2*dx(X(t))*phi+2*t**3*dx(QB))/(v*phi**3)-lam*dx(X(v))/v
assert C.derivation()(lam)==dl
start=time.time();nd=dl.norm().norm();print('NORM_BUILT',time.time()-start,flush=True)
num=nd.numerator();den=nd.denominator()
def summary(poly):
    fac=poly.factor();return [{'degree':int(f.degree()),'multiplicity':int(m)} for f,m in fac]
record={'scope':'one exact ratio only; no geometric universal claim','h_code':int(args.h),'w_code':int(args.w),
        'numerator_degree':int(num.degree()),'denominator_degree':int(den.degree()),
        'numerator_factors':summary(num),'denominator_factors':summary(den),
        'direct_derivation_agrees':True}
save({'lambda':lam,'derivative':dl,'norm':nd},str(out/'functions.sobj'))
(out/'receipt.json').write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record),flush=True)
