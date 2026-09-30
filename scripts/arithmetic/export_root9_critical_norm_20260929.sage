#!/usr/bin/env sage
"""Export new critical-norm tails and certified fixed-resultant degree bounds."""
import json,sys
from pathlib import Path
d=Path(sys.argv[1]);src=load(str(d/'tails.sobj'));R=src['tails'][0].parent();H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def vv(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vv(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vv(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
rows=[];meta=[]
for n,p in enumerate(src['tails'],17):
 h=min(e[0] for e in p.dict());p=p//H**h
 rows.append([[int(i),int(j),code(c)] for (i,j),c in p.dict().items()])
 meta.append({'index':n,'H_removed':int(h),'H_degree':int(p.degree(H)),'q_degree':int(p.degree(q))})
obj={'scope':'Critical quadratic norm, not original degree140 residual. H is an original unit.','rows':rows,'metadata':meta}
obj['resultant_bounds']=[meta[0]['H_degree']*meta[i]['q_degree']+meta[i]['H_degree']*meta[0]['q_degree'] for i in [1,2]]
(d/'native_tails.json').write_text(json.dumps(obj,separators=(',',':'))+'\n');print(meta,obj['resultant_bounds'],flush=True)
