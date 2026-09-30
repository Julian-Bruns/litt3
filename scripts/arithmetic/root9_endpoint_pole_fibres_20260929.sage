#!/usr/bin/env sage
"""Retain every geometric content-curve point over given parameter poles.

Each finite reduced fibre is flattened over the original coefficient
field by an exact power-basis calculation, including non-rational Z.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('source_data');p.add_argument('--model');args=p.parse_args();d=Path(args.directory);out=d/('pole_fibres' if args.model else 'leading_fibres');out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'));R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def vec0(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec0(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec0(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'Z');z=Q.gen();pol=Q(J.coefficient({H:12}))
if args.model:
 md=json.load(open(args.model));pol=prod(Q(list(map(dec,row))) for row in md['poles'])
factors=[f.monic() for f,e in pol.factor() if f!=z];src=json.loads((Path(args.source_data)/'inputs.json').read_text());rows={k:Q(list(map(dec,src[k]))) for k in ['a0','b','c','e','d']};summary=[]
for index,f in enumerate(factors):
 E=Q.quotient(f,'zz');zz=E.gen();V=PolynomialRing(E,'H');h=V.gen();phi=R.hom([h,V(zz)],V);g=phi(J);assert g
 if g.degree()==0:continue
 g=(g//g.gcd(g.derivative())).monic();qv=E(co['P_root'])/zz**3
 if not rows['d'](qv):continue
 uv=qv*h;N=rows['a0'](qv)*uv**3+rows['b'](qv)*uv**2+rows['c'](qv)*uv+rows['e'](qv);g=g//g.gcd(uv*N)
 if g.degree()==0:continue
 F=V.quotient(g,'hh');hh=F.gen();nz=f.degree();nh=g.degree();n=nz*nh
 def flatten(c):
  cp=F(c).lift();return vector(K,[E(cp[i]).lift()[j] for i in range(nh) for j in range(nz)])
 for cc in range(1,30):
  theta=hh+F(E(dec(cc))*zz);pw=[F.one()]
  for i in range(n):pw.append(pw[-1]*theta)
  B=matrix(K,[flatten(v) for v in pw[:n]]).transpose()
  if B.rank()==n:break
 else:raise RuntimeError('No separating power basis in tested short list')
 coeff=B.solve_right(flatten(pw[n]));elim=z**n-Q(list(coeff));assert elim.gcd(elim.derivative()).degree()==0
 zcoord=Q(list(B.solve_right(flatten(F(zz)))));qcoord=Q(list(B.solve_right(flatten(F(qv)))));ucoord=Q(list(B.solve_right(flatten(hh*F(qv)))))
 assert f(zcoord)%elim==0
 blocks=[]
 for ff,m in elim.factor():
  assert m==1
  blocks.append({'degree':int(ff.degree()),'modulus':[code(c) for c in ff.monic()],'coordinates':{'3':[code(c) for c in ucoord%ff],'q':[code(c) for c in qcoord%ff]}})
 bd=out/str(index);bd.mkdir(exist_ok=True);save({'Z_factor':f,'H_fibre':g,'power_basis':B,'theta_scalar':dec(cc),'eliminant':elim,'Z':zcoord,'q':qcoord,'u':ucoord},str(bd/'reconstruction.sobj'))
 obj={'scope':'Every reduced original-open point on the content curve above this parameter factor. Exact power basis retained.','Z_factor':[code(c) for c in f],'length_reduced':int(n),'blocks':blocks}
 (bd/'finite_incidence.json').write_text(json.dumps(obj,separators=(',',':'))+'\n');summary.append({'directory':str(bd),'Z_factor_degree':int(nz),'H_degree':int(nh),'retained_degrees':[r['degree'] for r in blocks]});print('FIBRE',summary[-1],flush=True)
(out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
