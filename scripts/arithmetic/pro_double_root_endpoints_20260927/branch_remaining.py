"""Restartable, two-process construction or verification of all nine scale graphs.
No finite-field search is performed: each worker uses the entire displayed
finite quotient algebra, including every nilpotent in that algebra.
"""
import concurrent.futures,json,subprocess,sys,time
from exact import ROOT
ROOTS=[14,2514,7367,20130,364472,281660,154113,139659,104315]

def job(x,verify=False,graphs_only=False):
 base=ROOT/'work/branch_root'/f'x_{x}';base.mkdir(parents=True,exist_ok=True)
 commands=[]
 if not graphs_only:commands.append([sys.executable,'src/branch_geometry.py',str(x)])
 commands.append([sys.executable,'src/branch_graph_check.py',str(x)])
 with (base/'continuation.log').open('w') as out:
  for cmd in commands:
   if verify:cmd+=['--verify']
   out.write('$ '+' '.join(cmd)+'\n');out.flush()
   subprocess.run(cmd,cwd=ROOT,stdout=out,stderr=subprocess.STDOUT,check=True)
 return x
if __name__=='__main__':
 roots=[int(a) for a in sys.argv[1:] if not a.startswith('--')] or ROOTS
 started=time.time();results=[]
 with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
  futs={pool.submit(job,x,'--verify' in sys.argv,'--graphs-only' in sys.argv):x for x in roots}
  for fut in concurrent.futures.as_completed(futs):
   x=futs[fut]
   try:fut.result();status='verified' if '--verify' in sys.argv else 'constructed_and_checked'
   except Exception as err:status='failed';print('FAILED',x,repr(err),flush=True)
   results.append({'x_code':x,'status':status});print('BRANCH ROOT',x,status,flush=True)
 ledger={'results':sorted(results,key=lambda a:a['x_code']),'seconds':round(time.time()-started,3),
         'geometry_regenerated':not ('--graphs-only' in sys.argv)}
 (ROOT/'work/branch_root/remaining_checks.json').write_text(json.dumps(ledger,indent=2)+'\n')
 assert all(a['status']!='failed' for a in results)
