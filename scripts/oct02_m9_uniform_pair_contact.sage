#!/usr/bin/env sage
"""Bounded fixed pair-contact rank test; no critical or source parameters."""
import json,time
from pathlib import Path
from itertools import combinations
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
meta=json.loads((folder/'quotient_probe_q3_0_certified.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(meta['field_modulus']))
def unpack(v):return E(v)
beta=unpack(meta['beta_coordinates'])
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_quotient_probe.sage').read_text().split('records=[]')[0]
source=source.replace("E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()", "R=PolynomialRing(E,'x');x=R.gen()")
source=source.replace("beta=(x*x-x-3).roots(multiplicities=False)[0]", "assert beta*beta-beta-3==0")
exec(compile(source,'quotient_probe_prefix','exec'))
def coords(v):return [int(a) for a in v.polynomial().list()]
records=[]
for omitted in aroots:
 endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
 full=matrix(E,[row for pt in endpoints for row in allrows[pt].values()])
 empty=full.right_kernel_matrix();assert empty.nrows()==2
 for i,j in combinations(range(9),2):
  hit={endpoints[i],endpoints[j]}
  contact=matrix(E,[row for pt in endpoints for (h,t),row in allrows[pt].items() if pt not in hit or t<2-h])
  assert (contact*empty.transpose()).is_zero()
  rank=contact.rank()
  records.append({'omitted_A_root':coords(omitted),'relaxed_endpoints':[[coords(v) for v in endpoints[n]] for n in [i,j]],
                  'same_x_fiber':bool(endpoints[i][0]==endpoints[j][0]),'contact_rank':int(rank),
                  'dimension':int(50-rank),'equals_empty_stratum':bool(rank==48)})
  if time.time()-started>9:break
 print('omissions',len(set(tuple(r['omitted_A_root']) for r in records)),'pairs',len(records),'dimensions',sorted(set(r['dimension'] for r in records)),'seconds',time.time()-started,flush=True)
 if time.time()-started>9:break
out={'scope':'All two-endpoint weight-two relaxations, contact weight three elsewhere, fixed cubic quotient space with bounds22-j. No critical/source sweep.',
     'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],'records':records,
     'complete':len(records)==144,'seconds':time.time()-started,'sage_version':version()}
(folder/'pair_contact_ranks.json').write_text(json.dumps(out,indent=2)+'\n')
print('DONE',len(records),time.time()-started,'seconds')
