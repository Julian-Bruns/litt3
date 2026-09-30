#!/usr/bin/env sage
"""Complete B=0,C1=0 incidence at an endpoint, before square equations."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();d=Path(args.directory);out=d/'B_boundary';out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));R=co['source_denominator'].parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def vec(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
B=load(str(d/'translated_1_T0.sobj'));C=load(str(d/'translated_2_T1.sobj'))
T=PolynomialRing(K,('inv','H','Z'),order='degrevlex');iv,hh,zz=T.gens();phi=R.hom([hh,zz],T);polys=[phi(B),phi(C),iv*zz*phi(co['source_denominator'])-1];I=T.ideal(polys)
st=time.time();gb=I.groebner_basis();save({'polynomials':polys,'groebner':gb},str(out/'source.sobj'));print('DIM',I.dimension(),'LENGTH',I.vector_space_dimension(),'SECONDS',time.time()-st,flush=True)
assert I.dimension()==0
L=PolynomialRing(K,('inv','H','Z'),order='lex');lex=I.transformed_basis('fglm',other_ring=L);save(lex,str(out/'lex.sobj'))
print('SHAPE',[(str(f.lm()),len(f.dict())) for f in lex],flush=True)
Q=PolynomialRing(K,'Z');z=Q.gen();fq=None;hc=None
for f in lex:
 if f.lm()==L.gen(1):
  v=L.gen(1)-f;hc=Q([v.coefficient({L.gen(2):i}) for i in range(v.degree(L.gen(2))+1)])
 elif all(not mon[0] and not mon[1] for mon in f.dict()):fq=Q([f.coefficient({L.gen(2):i}) for i in range(f.degree(L.gen(2))+1)])
assert fq is not None and hc is not None and fq.gcd(fq.derivative()).degree()==0
blocks=[]
for ff,e in fq.factor():
 assert e==1
 qp=co['P_root']*power_mod(z,-3,ff)%ff;up=hc*qp%ff
 for f in [B,C]:
  ans=Q.zero()
  for (i,j),c in f.dict().items():ans=(ans+c*power_mod(hc,i,ff)*power_mod(z,j,ff))%ff
  assert not ans
 blocks.append({'degree':int(ff.degree()),'modulus':[code(c) for c in ff],'coordinates':{'3':[code(c) for c in up],'q':[code(c) for c in qp]}})
(out/'finite_incidence.json').write_text(json.dumps({'scope':'Complete endpoint B=C1=0 incidence; generator is Z, actual q and u retained explicitly.','length':int(fq.degree()),'blocks':blocks},separators=(',',':'))+'\n')
print('EXPORTED',[(r['degree']) for r in blocks],flush=True)
