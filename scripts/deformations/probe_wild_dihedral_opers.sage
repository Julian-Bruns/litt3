#!/usr/bin/env sage
"""Bounded exploratory nilpotent-oper calculation on an actual D5 curve.

Z: y^2=((w^5-w)^2-a)((w^5-w)^2-b), genus nine.
The three invariant projective potentials are parameterized in t=w^5-w.
This only computes the invariant nilpotency scheme. It does not assert
effectivity, indigenous ordinariness, or a common-cover counterexample.
"""
import argparse, json, time
from pathlib import Path
ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--a',type=int,default=2)
ap.add_argument('--b',type=int,default=3)
ap.add_argument('--output',type=Path)
args=ap.parse_args(); started=time.monotonic()
k=GF(5)
P=PolynomialRing(k,names=('A','B','C','t'),order='degrevlex')
A,B,C,t=P.gens(); f=(t*t-k(args.a))*(t*t-k(args.b)); fp=f.derivative(t)
assert args.a%5 and args.b%5 and (args.a-args.b)%5

# (n,p,q) denotes (p+q*y)/f^n, y^2=f.
def add(x,y):
    n=max(x[0],y[0]);return (n,x[1]*f**(n-x[0])+y[1]*f**(n-y[0]),x[2]*f**(n-x[0])+y[2]*f**(n-y[0]))
def scale(a,x):return (x[0],a*x[1],a*x[2])
def mul(x,y):return (x[0]+y[0],x[1]*y[1]+f*x[2]*y[2],x[1]*y[2]+x[2]*y[1])
def deriv(x):
    n,p,q=x
    return (n+1,f*p.derivative(t)-n*fp*p,f*q.derivative(t)+(k(3)-n)*fp*q)

r=(2,2*fp**2-f.derivative(t,2)*f+(A+B*t*t)*f,C*t*f)
dr=deriv(r);d2r=deriv(dr);d3r=deriv(d2r);d4r=deriv(d3r)
a=add(d3r,scale(4,mul(r,dr)))
b=add(scale(3,d2r),mul(r,r))
c=add(add(d4r,scale(4,mul(dr,dr))),add(scale(2,mul(r,d2r)),mul(mul(r,r),r)))
nil=add(mul(a,a),mul(b,c))
R=PolynomialRing(k,names=('A','B','C'),order='degrevlex')
AA,BB,CC=R.gens()
def coefficients(p):
    out={}
    for e,v in p.dict().items():
        out[e[3]]=out.get(e[3],R.zero())+v*AA**e[0]*BB**e[1]*CC**e[2]
    return list(out.values())
eq=sorted(set(coefficients(nil[1])+coefficients(nil[2])),key=str)
eq=[e for e in eq if e]
I=R.ideal(eq);gb=I.groebner_basis()
print('a,b',args.a,args.b,'equations',len(eq),'seconds',time.monotonic()-started,flush=True)
print('dimension',I.dimension(),'basis',gb,flush=True)
receipt={'a':args.a,'b':args.b,'nilpotency_equations':[str(e) for e in eq],
 'groebner_basis':[str(e) for e in gb],'dimension':int(I.dimension()),
 'scope':'Invariant nilpotency scheme only; no actual BT1 or endpoint ordinariness claim.'}
if I.dimension()==0:
    receipt['quotient_dimension']=int(I.vector_space_dimension())
    points=I.variety(k)
    receipt['rational_points']=[{str(x):int(p[x]) for x in R.gens()} for p in points]
    receipt['points_dormant']=[]
    for point in points:
        vals={A:P(point[AA]),B:P(point[BB]),C:P(point[CC])}
        dormant=all(not pol.subs(vals) for x in (a,b,c) for pol in x[1:])
        receipt['points_dormant'].append(bool(dormant))
    print('quotient dimension',receipt['quotient_dimension'],'F5 points',receipt['rational_points'],
          'dormant',receipt['points_dormant'],flush=True)
receipt['seconds']=time.monotonic()-started
if args.output:
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
