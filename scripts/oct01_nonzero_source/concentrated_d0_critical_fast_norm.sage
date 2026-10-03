#!/usr/bin/env sage
"""Exact subfield descent and Kronecker expansion of the critical norm."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from field_descent import descend
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();start=time.time();data=args.work/'data'
source=load(str(data/f'concentrated_d0_critical_interpolated_{args.root}.sobj'))
original_E=source['E'];alpha=source['alpha'];beta=source['beta'];rho=source['rho']
def decode(code):
    n=int(code);out=original_E.zero()
    for j in range(3):
        b=n%390625;n//=390625;s=original_E.zero()
        for i in range(4):
            c=b%25;b//=25;s+=(original_E(c%5)+original_E(c//5)*beta)*alpha**i
        out+=s*rho**j
    return out
point=next(r for r in json.loads((data/'shifted_concentrated_projection.json').read_text())['records'] if r['root_K_code']==args.root)
y0=decode(point['y0_extension_code']);components=[f*y0**j for j,f in enumerate(source['C_hat'])]
Pc=source['P']/y0**3
items=[];labels=[]
for index,f in enumerate(components+[Pc]):
    for tag,c in f.dict().items():labels.append((index,tag));items.append(c)
K,converted,descent=descend(items,original_E,alpha)
R=PolynomialRing(K,('x','eta'),order='degrevlex');x,eta=R.gens()
groups=[{} for _ in range(4)]
for (index,tag),c in zip(labels,converted):groups[index][tag]=c
c0,c1,c2,P=[R(g) for g in groups]
max_x=max(3*c0.degree(x),P.degree(x)+3*c1.degree(x),2*P.degree(x)+3*c2.degree(x),
          P.degree(x)+c0.degree(x)+c1.degree(x)+c2.degree(x))
width=int(max_x)+1;U=PolynomialRing(K,'h',implementation='NTL');h=U.gen()
def kr(f):return U({int(dx)+width*int(de):c for (dx,de),c in f.dict().items()})
u0,u1,u2,pp=[kr(f) for f in (c0,c1,c2,P)]
print('DESCENT_SECONDS',time.time()-start,'KRONECKER_WIDTH',width,flush=True)
nk=u0**3+pp*u1**3+pp**2*u2**3-3*pp*u0*u1*u2
print('KRONECKER_NORM_SECONDS',time.time()-start,'DEGREE',nk.degree(),flush=True)
nc=R({(int(i)%width,int(i)//width):c for i,c in enumerate(nk) if c})
# Projection on x-degree is bounded by width-1 in every norm term, so
# no exponent carries can occur. This proves the Kronecker decoding exact.
alphaK=K.gen();betaK=-(alphaK**4+2*alphaK**3+alphaK**2+2*alphaK)/(alphaK**3+alphaK**2+1)
root_value=sum((K((args.root//25**i)%25%5)+K(((args.root//25**i)%25)//5)*betaK)*alphaK**i for i in range(4))
remaining,r=nc.quo_rem((x-root_value)**20);assert not r
source.update(norm_C_hat=nc,reduced_norm_C_hat=remaining,norm_field_descended=True,
              norm_field=K,norm_descent=descent,norm_kronecker_width=width,
              norm_twisted_curve_polynomial=P,norm_descended_C_components=[c0,c1,c2])
save(source,str(data/f'concentrated_d0_critical_norm_{args.root}_symbolic.sobj'))
print('COMPLETE_SECONDS',time.time()-start,'NORM_X_DEGREE',nc.degree(x),
      'REDUCED_NORM_X_DEGREE',remaining.degree(x),'NORM_ETA_DEGREE',nc.degree(eta),flush=True)
