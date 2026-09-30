#!/usr/bin/env sage
"""Split the common-critical boundary into the ten actual cubic branches."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('incidence_directory');p.add_argument('output');args=p.parse_args()
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
polys=load(str(Path(args.incidence_directory)/'incidence.sobj'));B=polys[0].parent();K=B.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return K(c%5)+K(c//5)*beta
R=PolynomialRing(K,('inv','u','q'),order='degrevlex');iv,u,q=R.gens()
X=PolynomialRing(K,'x');x=X.gen();P=X(list(map(dec,[11,22,18,5,19,20,15,16,9,22,1])))
roots=P.roots(multiplicities=False);assert len(roots)==10
results=[]
for j,r in enumerate(roots):
 bd=out/str(j);bd.mkdir(exist_ok=True)
 hh=B.hom([iv,0,R(r),u,q],R);fs=[hh(f) for f in polys];fs=[f for f in fs if f]
 save({'root':r,'polys':fs},str(bd/'source.sobj'))
 I=R.ideal(fs);st=time.time();gb=I.groebner_basis();save(gb,str(bd/'groebner.sobj'))
 dim=I.dimension();length=int(I.vector_space_dimension()) if dim<=0 else None
 row={'index':j,'dimension':int(dim),'length':length,'seconds':time.time()-st}
 print('BRANCH',row,'ROOT',r,flush=True)
 if dim<0:
  coeff=R.one().lift(fs);assert sum((c*f for c,f in zip(coeff,fs)),R.zero())==1
  save({'root':r,'source':fs,'multipliers':coeff},str(bd/'unit_certificate.sobj'))
  row['unit_identity']='PASS'
 if dim==0:
  Lex=PolynomialRing(K,('inv','u','q'),order='lex');ll=I.transformed_basis('fglm',other_ring=Lex);save(ll,str(bd/'lex.sobj'))
  print('SHAPE',[(str(f.lm()),len(f.dict())) for f in ll],flush=True)
 results.append(row);(out/'summary.json').write_text(json.dumps(results,indent=2)+'\n')
