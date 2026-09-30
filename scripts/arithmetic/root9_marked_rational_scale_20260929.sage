#!/usr/bin/env sage
"""Find a compact fraction for the marked-content scale on its curve."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--max-degree',type=int,default=10);args=p.parse_args();out=Path(args.directory)
d=load(str(out/'scale_curve_reduced.sobj'));J=d['J'];R=J.parent();u,q=R.gens();K=R.base_ring();Q=PolynomialRing(K,'q');qq=Q.gen();F=Q.fraction_field();U=PolynomialRing(F,'u');uu=U.gen();hh=R.hom([uu,U(qq)],U)
j=hh(J);aa=hh(d['a']);bb=hh(d['b']);raw=[]
for side,v in [(0,bb),(1,-aa)]:
 for i in range(6):raw.append((side,i,(v*uu**i)%j))
den=lcm([c.denominator() for _,_,v in raw for c in v]);pieces={}
for side,i,v in raw:
 w=v*den;rows={}
 for k,c in enumerate(w):
  assert c.denominator()==1
  for l,b in enumerate(c.numerator()):
   if b:rows[k,l]=b
 pieces[side,i]=rows
for n in range(args.max_degree+1):
 labels=[(s,i,k) for s in range(2) for i in range(min(5,n)+1) for k in range(n-i+1)]
 columns=[];keys=set()
 for side,i,k in labels:
  col={(m,l+k):c for (m,l),c in pieces[side,i].items()};columns.append(col);keys.update(col)
 keys=sorted(keys);index={v:i for i,v in enumerate(keys)}
 mat=matrix(K,len(keys),len(columns),{(index[key],i):v for i,col in enumerate(columns) for key,v in col.items()},sparse=True)
 ker=mat.right_kernel();print('SEARCH',n,'MATRIX',mat.dimensions(),'KERNEL',ker.dimension(),flush=True)
 if ker.dimension():
  for v in ker.basis():
   A=sum((c*u**i*q**k for c,(s,i,k) in zip(v,labels) if s==0),R.zero());B=sum((c*u**i*q**k for c,(s,i,k) in zip(v,labels) if s==1),R.zero())
   if not B:continue
   assert (hh(A)*bb-hh(B)*aa)%j==0
   if hh(B)%j==0:continue
   save({'numerator':A,'denominator':B,'J':J,'searched_degree':n},str(out/'compact_scale_fraction.sobj'))
   print('FOUND_DEGREES',[(f.degree(u),f.degree(q),len(f.dict())) for f in [A,B]],flush=True)
   print('FACTORS',[(g.degree(u),g.degree(q),int(e)) for f in [A,B] for g,e in f.factor()],flush=True)
   quit()
