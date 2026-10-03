#!/usr/bin/env python3
"""Eight new selected-pair orbit cases, sequential one-core hard45s each."""
import json,os,subprocess,time
from pathlib import Path
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
out=folder/'compact_source_pair_batch.json';results=[];started=time.monotonic()
env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
for case in range(9):
 if case==6:
  d=json.loads((folder/'compact_second_source_support.json').read_text())
  assert d['complete'] and d['gcd_degree']==0
  results.append({'case':6,'existing_prototype':True,'gcd_degree':0});continue
 first=folder/('compact_source_pair_%02d_first.json'%case);second=folder/('compact_source_pair_%02d_second.json'%case)
 if second.exists() and json.loads(second.read_text()).get('complete'):
  d=json.loads(second.read_text());results.append({'case':case,'existing_complete':True,'gcd_degree':d['gcd_degree']});continue
 began=time.monotonic()
 for script,target in [('oct02_m9_uniform_compact_norm_symbolic.sage',first),('oct02_m9_uniform_compact_second_support.sage',second)]:
  if target.exists() and json.loads(target.read_text()).get('complete'):continue
  subprocess.run(['sage','scripts/'+script,'--case',str(case)],check=True,timeout=max(.1,45-(time.monotonic()-began)),env=env)
 d=json.loads(second.read_text());assert d['complete']
 results.append({'case':case,'gcd_degree':d['gcd_degree'],'seconds':time.monotonic()-began})
 out.write_text(json.dumps({'scope':'Nine exact selected-pair orbits. A unit gcd excludes an ordinary one-c-single/other-two-c-double branch with at most two selected c-zero points in distinct fibers. Boundaries remain separate.','complete':len(results)==9,'records':results,'seconds':time.monotonic()-started},indent=2)+'\n')
 print('CASE',case,'gcd',d['gcd_degree'],'seconds',time.monotonic()-began,flush=True)
out.write_text(json.dumps({'scope':'Nine selected-pair orbits, ordinary pole3 support exclusion only.','complete':True,'records':results,'seconds':time.monotonic()-started},indent=2)+'\n')
