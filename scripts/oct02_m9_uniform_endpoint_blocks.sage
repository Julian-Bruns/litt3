#!/usr/bin/env sage
"""Check the additional third endpoint block on already certified kernels.

This reconstructs endpoint jets only. It does not rerun quotient kernels,
itinerary enumeration, or any full-rank sweep.
"""
import json,time
from pathlib import Path
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=[json.loads((folder/('quotient_probe_q3_%s_certified.json'%i)).read_text()) for i in range(2)]
first=data[0]
Q=PolynomialRing(GF(5),'t')
E=GF(5**24,'e',modulus=Q(first['field_modulus']))
def unpack(v):return E(v)
beta=unpack(first['beta_coordinates'])
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_quotient_probe.sage').read_text().split('records=[]')[0]
source=source.replace("E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()", "R=PolynomialRing(E,'x');x=R.gen()")
source=source.replace("beta=(x*x-x-3).roots(multiplicities=False)[0]", "assert beta*beta-beta-3==0")
exec(compile(source,'quotient_probe_prefix','exec'))
def coords(v):return [int(a) for a in v.polynomial().list()]
checks=[]
for run in data:
 for index,record in enumerate(run['records']):
  cert=record['certificate']
  endpoints=[tuple(unpack(v) for v in pt) for pt in cert['selected_endpoints']]
  kernel=matrix(E,[[unpack(v) for v in row] for row in cert['base_kernel']])
  assert kernel.nrows()==3
  blocks=[]
  for endpoint_index in range(9):
   pt=endpoints[endpoint_index]
   block=matrix(E,[allrows[pt][j,2-j] for j in range(3)])*kernel.transpose()
   det=block.det()
   blocks.append(coords(det))
  checks.append({'c_fiber':run['c_fiber'],'record_index':index,'endpoint_block_minors':blocks})
all_nonzero=all(v for check in checks for v in check['endpoint_block_minors'])
out={'scope':'Additional one-endpoint contact rank on every selected endpoint, using existing exact base kernels; all 72 records, no kernel replay.',
     'field_modulus':first['field_modulus'],'records_checked':len(checks),'all_blocks_nonzero':all_nonzero,
     'checks':checks,'seconds':time.time()-started,'sage_version':version()}
(folder/'endpoint_blocks_q3.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS' if all_nonzero else 'PARTIAL',len(checks),'records,',sum(bool(v) for check in checks for v in check['endpoint_block_minors']),'nonzero blocks;',time.time()-started,'seconds')
