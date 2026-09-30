#!/usr/bin/env sage
"""A new necessary test for A4 rather than full signed-cubic monodromy.

This is discovery until an exact ideal identity or a complete survivor
algebra is retained.  It concerns the critical quadratic, not the
original residual specialized at a scale.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--eliminate',action='store_true');a=p.parse_args();d=Path(a.directory);out=d/'norm_square';out.mkdir(exist_ok=True)
s=load(str(d/'descent'/'normalized.sobj'));d0,d1,d2=s['delta_normalized'];P=s['P'];X=P.parent();F=X.base_ring();R=F.ring();H,q=R.gens();K=R.base_ring();st=time.time()
rr=q**2*d0**3+q*P*d1**3+P**2*d2**3-3*q*P*d0*d1*d2
assert rr.degree()==32 and rr[32]==s['B']**3
den=lcm([v.denominator() for v in rr]);vals=[R(rr[32-i]*den) for i in range(25)]
S=PowerSeriesRing(R,'T',default_prec=25);T=S.gen();series=S(vals).add_bigoh(25)
# Coefficient Frobenius must accompany T -> T5.
sq=(series**2).add_bigoh(5);fr=S([0]*25)
for i in range(5):fr+=sq[i]**5*T**(5*i)
t13=(series**3*fr).add_bigoh(25)
rows=[]
for n in range(17,25):
 v=R(t13[n]);factors=[]
 for fac,e in den.factor():
  ee=0
  while v and not v%fac:v//=fac;ee+=1
  factors.append((str(fac),ee))
 if v:rows.append(v)
 print('TAIL',n,'DEG',v.degree(H),v.degree(q),'TERMS',len(v.dict()),'STRIPPED',factors,flush=True)
save({'norm':rr,'denominator':den,'tails':rows},str(out/'tails.sobj'));print('SOURCE_SECONDS',time.time()-st,flush=True)
if a.eliminate:
 B=PolynomialRing(K,('inv','H','q'),order='degrevlex');iv,hh,qq=B.gens();phi=R.hom([hh,qq],B);unit=q*H*prod(f for f,e in den.factor());polys=[phi(v) for v in rows]+[iv*phi(unit)-1];I=B.ideal(polys)
 gb=I.groebner_basis();save({'equations':polys,'groebner':gb},str(out/'elimination.sobj'));print('DIM',I.dimension(),'GB',[(str(v.lm()),len(v.dict())) for v in gb],flush=True)
 if I.dimension()<0:
  mul=list(B.one().lift(I));assert sum((u*v for u,v in zip(mul,polys)),B.zero())==1;save(mul,str(out/'unit_multipliers.sobj'));print('UNIT_IDENTITY',sum(len(v.dict()) for v in mul),flush=True)
