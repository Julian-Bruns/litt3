#!/usr/bin/env python3
"""Eight NEW J111 orbit norms modulo uniform support, bounded onecore."""
import json,os,subprocess,time,signal
from pathlib import Path
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/'source_e_J111_batch.json';results=[];started=time.monotonic()
def expired(s,f):raise TimeoutError('J111 batch hard80s wall cap')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,80)
env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
for case in range(9):
 path=folder/('source_e_J111_case%02d_full.json'%case)
 if path.exists() and json.loads(path.read_text()).get('complete'):
  d=json.loads(path.read_text());assert d['gcd_degree']==0;results.append({'case':case,'stored_complete':True,'gcd_degree':0});continue
 began=time.monotonic();subprocess.run(['sage','scripts/oct02_m9_uniform_source_e_J111_norm.sage','--case',str(case),'--variant','full','--modulo-saved-gcd'],check=True,timeout=15,env=env)
 d=json.loads(path.read_text());assert d['complete'];results.append({'case':case,'gcd_degree':d['gcd_degree'],'seconds':time.monotonic()-began})
 output.write_text(json.dumps({'scope':'Nine selected J111 diagonalC3/Frobenius25 phase representatives. Necessary gap-only support and third source-e augmented minor norm; no common geometric marked root in any case.','complete':len(results)==9,'records':results,'seconds':time.monotonic()-started},indent=2)+'\n')
 print('J111case',case,'gcd',d['gcd_degree'],'seconds',time.monotonic()-began,flush=True)
output.write_text(json.dumps({'scope':'All nine J111 source-only ordinary pole3 phase representatives.','complete':True,'records':results,'seconds':time.monotonic()-started},indent=2)+'\n');signal.setitimer(signal.ITIMER_REAL,0)
