#!/usr/bin/env sage
"""Export the original polynomial content curve, retaining its leading locus."""
import json,sys
from pathlib import Path
d=Path(sys.argv[1]);f=load(str(d/'content_gcd.sobj'));R=f.parent();H,Z=R.gens();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def vv(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vv(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vv(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
rows=[[code(f[i,j]) for j in range(f.degree(Z)+1)] for i in range(f.degree(H)+1)]
(d/'content_curve_native.json').write_text(json.dumps({'scope':'Original content curve; no new factor inverted','coefficients':rows},separators=(',',':'))+'\n')
print('EXPORTED',f.degree(H),f.degree(Z),flush=True)
