#!/usr/bin/env sage
"""Geometric candidate projection from exact critical-norm resultants.

The resultants alone are only necessary. Retain all factors and actual
leading-degree boundaries; test the entire H-fibre with all eight tails.
"""
import json,sys,time
from pathlib import Path
d=Path(sys.argv[1]);start=time.time();src=load(str(d/'tails.sobj'))
R=src['tails'][0].parent();H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def elt(c):
 z=K(0)
 for i in range(4):
  digit=c%25;c//=25;z+=(digit%5+(digit//5)*beta)*a**i
 return z
U=PolynomialRing(K,'z');z=U.gen();raw=json.load(open(d/'resultants.json'))
polys=[U([elt(c) for c in row['coefficients']]) for row in raw['rows']]
g=polys[0].gcd(polys[1]);print('GCD_DEGREE',g.degree(),'seconds',time.time()-start,flush=True)
fac=g.factor();print('PROJECTION_FACTORS',[(f.degree(),int(e)) for f,e in fac],flush=True)
save({'polys':polys,'gcd':g,'factors':fac},str(d/'resultant_projection.sobj'))
receipts=[]
for idx,(f,e) in enumerate(fac):
 print('BEGIN_FIBRE',idx,'degree',f.degree(),flush=True)
 if f.degree()==1:L=K;qq=-f[0]/f[1]
 else:L=K.extension(f,'qq');qq=L.gen()
 LH=PolynomialRing(L,'hh');hh=LH.gen();gg=LH(0)
 for t in src['tails']:
  p=LH(0)
  for (i,j),c in t.dict().items():p+=L(c)*hh**i*qq**j
  gg=gg.gcd(p)
  if gg.degree()==0:break
 # H=0 is an original excluded unit. Do not remove any other factor.
 while gg and gg[0]==0:gg=gg//hh
 rec={'index':idx,'q_degree':int(f.degree()),'projection_multiplicity':int(e),'fibre_H_degree':int(gg.degree()),'q_zero':bool(qq==0)}
 receipts.append(rec);print('FIBRE',rec,flush=True)
 save({'base_factor':f,'field':L,'q':qq,'H_gcd':gg},str(d/('candidate_fibre_%02d.sobj'%idx)))
 (d/'projection_receipts.json').write_text(json.dumps(receipts,indent=2,default=int)+'\n')
print('DONE',time.time()-start,flush=True)
