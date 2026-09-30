#!/usr/bin/env python3
"""Continue the saved exact endpoint curves; keep every projected boundary.

The native binaries are built from the correspondingly named sources in
scripts/arithmetic. This driver only orchestrates mathematical operations
whose inputs and outputs are retained separately.
"""
import concurrent.futures,json,os,subprocess,sys,time
from pathlib import Path
base=Path('../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content')
env=dict(os.environ,OMP_NUM_THREADS='3')
def run_endpoint(i):
 d=base/str(i)/'homogeneous_0_compact';curve=d.parent/'content_curve_native.json'
 def execute(name,args,output=None):
  if output and (d/output).exists():
   print(i,name,'retained',flush=True);return
  start=time.time()
  with (d/(name+'.log')).open('w') as log:
   p=subprocess.run([str(x) for x in args],stdout=log,stderr=subprocess.STDOUT,env=env)
  print(i,name,'exit',p.returncode,'seconds',round(time.time()-start,2),flush=True)
  if p.returncode:raise RuntimeError((i,name,p.returncode))
 execute('export_curve',['/usr/local/bin/sage','scripts/arithmetic/export_root9_endpoint_curve_20260929.sage',d.parent])
 t=json.load(open(d/'sparse.tails.json'))
 (d/'sparse_for_content.json').write_text(json.dumps({'indices':[71,72,73],'rows':t['tails']},separators=(',',':'))+'\n')
 execute('norm_tail_content',[base/'gap_content',d/'model.json',d/'sparse_for_content.json',d/'norm_tail_content'],'norm_tail_content.73.json')
 execute('boundaries',[base/'projection_boundaries',d/'model.json',d/'fourier.residual.json',d/'boundary'],'boundary.2.json')
 execute('boundary_projection',[base/'gap_projection',curve,d/'boundary_projection',d/'boundary.0.json',d/'boundary.1.json',d/'boundary.2.json'],'boundary_projection.2.json')
 execute('boundary_factors',['/usr/local/bin/sage','scripts/arithmetic/root9_gap_boundary_factors_20260929.sage',d],'projection_boundary_factors.json')
 execute('norm_hermite',[base/'hermite_projection',curve,d/'norm_tail_content.71.json',d/'norm_tail_content.72.json',d/'norm_projection'],'norm_projection.72.json')
 execute('norm_support',[base/'projection_support',d/'model.json',d,'norm_projection','71','72'],'norm_projection.boundary_split.json')
 execute('norm_boundary_fibres',[base/'gap_boundary_fibres',curve,d,'norm_tail_content','71','72','norm'],'norm.boundary_fibre_results.json')
 result=json.load(open(d/'norm.boundary_fibre_results.json'))
 split=json.load(open(d/'norm_projection.boundary_split.json'))
 assert result['all_excluded'] and len(split['outside_part'])==1
 print('ACTUAL_CONTENT_ENDPOINT_COMPLETE',i,flush=True)
with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
 for result in pool.map(run_endpoint,map(int,sys.argv[1:] or [0,2])):pass
