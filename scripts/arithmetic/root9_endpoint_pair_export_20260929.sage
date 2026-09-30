#!/usr/bin/env sage
"""Export the exact two-sheet resultant and its complete factors."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();d=Path(args.directory);out=d/'pair_content'
co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'));R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def vec(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'Z');z=Q.gen();fac=load(str(out/'projection_factors.sobj'));res=load(str(out/'resultant.sobj'));assert fac.prod()==res
obj={'root':code(co['root']),'P_root':code(co['P_root']),'phase':11,'J':[[code(c) for c in Q(J.coefficient({H:i}))] for i in range(13)],'factors':[{'modulus':[code(c) for c in f.monic()],'multiplicity':int(e)} for f,e in fac if f!=z]}
(out/'projection.json').write_text(json.dumps(obj,separators=(',',':'),default=int)+'\n');print('EXPORTED',[(len(r['modulus'])-1,r['multiplicity']) for r in obj['factors']],flush=True)
