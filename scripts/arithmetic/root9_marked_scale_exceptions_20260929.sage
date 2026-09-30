#!/usr/bin/env sage
"""Complete base-point incidence of the marked-content scale equation."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)/'scale_exceptions';out.mkdir(exist_ok=True)
d=load(str(Path(args.directory)/'scale_curve_reduced.sobj'));R=d['J'].parent();u,q=R.gens();K=R.base_ring()
Q=PolynomialRing(K,'q');qq=Q.gen();U=PolynomialRing(Q,'u');uu=U.gen();hh=R.hom([uu,U(qq)],U)
j=hh(d['J']);aa=hh(d['a']);bb=hh(d['b']);st=time.time()
ra=j.resultant(aa);rb=j.resultant(bb);gg=ra.gcd(rb);save({'ra':ra,'rb':rb,'gcd':gg},str(out/'resultants.sobj'))
print('RESULTANT_DEGREES',ra.degree(),rb.degree(),'GCD',gg.degree(),'SECONDS',time.time()-st,flush=True)
B=PolynomialRing(K,('inv','u','q'),order='degrevlex');iv,bu,bq=B.gens();h=R.hom([bu,bq],B)
lc=j.leading_coefficient();factor=B(0)
for i,c in enumerate(lc):factor+=c*bq**i
g=B(0)
for i,c in enumerate(gg):g+=c*bq**i
fs=[h(d['J']),h(d['a']),h(d['b']),g,iv*bq*factor-1];I=B.ideal(fs);gb=I.groebner_basis();save({'polys':fs,'root':None},str(out/'source.sobj'));save(gb,str(out/'groebner.sobj'))
print('DIMENSION',I.dimension(),'LENGTH',I.vector_space_dimension(),flush=True)
if I.dimension()<0:
 cs=B.one().lift(fs);assert sum((f*c for f,c in zip(fs,cs)),B.zero())==1;save(cs,str(out/'unit.sobj'));print('NO_SCALE_BASE_POINTS',flush=True)
else:
 Lex=PolynomialRing(K,('inv','u','q'),order='lex');ll=I.transformed_basis('fglm',other_ring=Lex);save(ll,str(out/'lex.sobj'))
 print('LEX',[(str(f.lm()),len(f.dict())) for f in ll],flush=True)
