#!/usr/bin/env sage
"""All fibres where the endpoint-content curve loses H degree."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('source_data');args=p.parse_args();d=Path(args.directory);out=d/'leading_boundary';out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'));R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def vec(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'Z');z=Q.gen();lc=Q(J.coefficient({H:12}));roots=lc.roots(multiplicities=False);assert all(f.degree()==1 for f,e in lc.factor())
U=PolynomialRing(K,'H');h=U.gen();src=json.loads((Path(args.source_data)/'inputs.json').read_text());rows={k:Q(list(map(dec,src[k]))) for k in ['a0','b','c','e','d']};summary=[]
for z0 in roots:
 if not z0:continue
 q0=co['P_root']/z0**3;phi=R.hom([h,U(z0)],U);f=phi(J);assert f and f.degree()<12
 bd=out/str(code(z0));bd.mkdir(exist_ok=True);blocks=[];removed=[]
 for g,mult in f.factor():
  u=q0*h;N=rows['a0'](q0)*u**3+rows['b'](q0)*u**2+rows['c'](q0)*u+rows['e'](q0)
  if not u%g:removed.append({'degree':int(g.degree()),'reason':'u=0'});continue
  if not N%g:removed.append({'degree':int(g.degree()),'reason':'F6=0'});continue
  blocks.append({'degree':int(g.degree()),'modulus':[code(c) for c in g.monic()],'coordinates':{'3':[code(c) for c in u%g],'q':[code(q0)]}})
 obj={'scope':'Whole H fibre of endpoint content at a root of its H-leading coefficient. Original-unit removals listed; multiplicities do not alter emptiness.','Z':code(z0),'q':code(q0),'length_reduced':sum(b['degree'] for b in blocks),'blocks':blocks,'excluded_blocks':removed}
 (bd/'finite_incidence.json').write_text(json.dumps(obj,separators=(',',':'))+'\n');summary.append({'directory':str(bd),'Z':code(z0),'q':code(q0),'H_degree':int(f.degree()),'retained_degrees':[r['degree'] for r in blocks],'removed':removed})
 print('FIBRE',summary[-1],flush=True)
(out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
