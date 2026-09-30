#!/usr/bin/env sage
"""Exact two-sheet content projection; no finite-field search."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--projection-only',action='store_true');args=p.parse_args();d=Path(args.directory);out=d/'pair_content';out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'));R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
Q=PolynomialRing(K,'Z');z=Q.gen();U=PolynomialRing(Q,'H');h=U.gen();phi=R.hom([h,U(z)],U);f=phi(J);g=phi(R.hom([H,dec(11)*Z],R)(J));st=time.time()
print('INPUT',f.degree(),g.degree(),flush=True)
res=f.resultant(g);save(res,str(out/'resultant.sobj'));print('RESULTANT',res.degree(),'SECONDS',time.time()-st,flush=True)
fac=res.factor();save(fac,str(out/'projection_factors.sobj'));print('FACTORS',[(int(f.degree()),int(e)) for f,e in fac],flush=True)
if args.projection_only:raise SystemExit(0)
summary=[]
for ff,e in fac:
 if ff==z:continue
 E=Q.quotient(ff,'zz');V=PolynomialRing(E,'H');hv=V.gen();f1=V([E(c) for c in f]);g1=V([E(c) for c in g]);gg=f1.gcd(g1)
 summary.append({'degree':int(ff.degree()),'multiplicity':int(e),'fibre_gcd_degree':int(gg.degree())});save({'projection':ff,'gcd':gg},str(out/('fibre_'+str(len(summary))+'.sobj')))
 print('FIBRE',summary[-1],flush=True)
(out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
