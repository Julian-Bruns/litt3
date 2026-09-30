#!/usr/bin/env sage
"""Entire common-critical incidence at each of the three t-endpoints."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('incidence_directory');p.add_argument('data');p.add_argument('output');args=p.parse_args()
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
polys=load(str(Path(args.incidence_directory)/'incidence.sobj'));B=polys[0].parent();K=B.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
 assert not c
 return z
R=PolynomialRing(K,('inv','z','u','q'),order='degrevlex');iv,z,u,q=R.gens()
X=PolynomialRing(K,'x');x=X.gen();A=X(list(map(dec,[1,21,14,22,13])))
t,rem=A.quo_rem(dec(13)*(x-a));assert not rem
roots=t.roots(multiplicities=False);assert len(roots)==3
src=json.loads((Path(args.data)/'scaled_source.json').read_text());D0=sum((dec(c)*q**i for i,c in enumerate(src['D0_q'])),R.zero())
results=[]
for j,r in enumerate(roots):
 bd=out/str(j);bd.mkdir(exist_ok=True)
 hh=B.hom([iv,z,R(r),u,q],R);fs=[hh(f) for f in polys[:-1]]+[iv*q*D0-1];fs=[f for f in fs if f]
 save({'root':r,'polys':fs},str(bd/'source.sobj'))
 I=R.ideal(fs);st=time.time();gb=I.groebner_basis();save(gb,str(bd/'groebner.sobj'))
 dim=I.dimension();length=int(I.vector_space_dimension()) if dim<=0 else None
 row={'index':j,'dimension':int(dim),'length':length,'seconds':time.time()-st}
 print('ENDPOINT',row,'ROOT',r,flush=True)
 if dim<0:
  coeff=R.one().lift(fs);assert sum((c*f for c,f in zip(coeff,fs)),R.zero())==1
  save({'root':r,'source':fs,'multipliers':coeff},str(bd/'unit_certificate.sobj'));row['unit_identity']='PASS'
 elif dim==0:
  Lex=PolynomialRing(K,('inv','z','u','q'),order='lex');ll=I.transformed_basis('fglm',other_ring=Lex);save(ll,str(bd/'lex.sobj'))
  print('SHAPE',[(str(f.lm()),len(f.dict())) for f in ll],flush=True)
 results.append(row);(out/'summary.json').write_text(json.dumps(results,indent=2)+'\n')
