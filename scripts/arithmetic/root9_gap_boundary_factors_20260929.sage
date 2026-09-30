#!/usr/bin/env sage
"""Factor only the new retained projection boundaries, not the huge norms."""
import json,sys,time
from pathlib import Path
d=Path(sys.argv[1]);co=load(str(d.parent/'coordinates.sobj'));K=co['root'].parent();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
R=PolynomialRing(K,'Z');Z=R.gen()
def elt(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def row(v):return R([elt(int(c)) for c in v])
model=json.load(open(d/'model.json'));poles=prod(row(v) for v in model['poles'])
def strip(f):
 while True:
  g=f.gcd(poles)
  if g.degree()==0:return f.monic()
  f=f//g
factors=[];proof=[];start=time.time()
for i in range(3):
 o=json.load(open(d/('boundary_projection.%d.json'%i)));f=strip(row(o['norm_of_primitive_row'])*row(o['content']))
 ff=f.factor();print('BOUNDARY',i,'DEGREE',f.degree(),'FACTORS',[(p.degree(),e) for p,e in ff],time.time()-start,flush=True)
 proof.append((i,f,ff))
 for p,e in ff:
  p=p.monic()
  if p not in factors:factors.append(p)
save({'factors':factors,'boundary_factorizations':proof,'poles':poles},str(d/'projection_boundary_factors.sobj'))
def vv(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vv(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vv(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
(d/'projection_boundary_factors.json').write_text(json.dumps({'scope':'Entire retained boundary projection; no points discarded','factors':[[code(c) for c in p] for p in factors]},separators=(',',':'))+'\n')
print('COMPLETE',len(factors),sum(p.degree() for p in factors),flush=True)
