#!/usr/bin/env python3
"""Exact whole-curve tests for the three other rational square-norm scales.

No branch is labelled excluded before all retained projection fibres close.
This driver preserves checkpoints and does not duplicate the completed
actual-scale graph (branch0).
"""
import concurrent.futures,json,os,subprocess,sys,time
from pathlib import Path
base=Path('../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content')
source=Path('../litt3-computation-data/companion140_reply_20260928/companion140')
env=dict(os.environ,OMP_NUM_THREADS='2')
def run_branch(pair):
 i,j=pair;d=base/str(i)/('homogeneous_'+str(j));d.mkdir(exist_ok=True)
 curve=d.parent/'content_curve_native.json';tag=f'{i}:{j}'
 def execute(name,args,output=None):
  if output and (d/output).exists():
   try:json.load(open(d/output))
   except Exception:pass
   else:print(tag,name,'retained',flush=True);return
  start=time.time()
  with (d/(name+'.log')).open('w') as log:
   p=subprocess.run([str(x) for x in args],stdout=log,stderr=subprocess.STDOUT,env=env)
  print(tag,name,'exit',p.returncode,'seconds',round(time.time()-start,2),flush=True)
  if p.returncode:raise RuntimeError((tag,name,p.returncode))
 execute('export',['/usr/local/bin/sage','scripts/arithmetic/root9_endpoint_homogeneous_scales_20260929.sage',d.parent,'--branch',j],'model.json')
 execute('fourier_residual',[base/'function_field_fourier',source,d/'model.json',d/'fourier','fft-residual',d.parent/'source_cache.json'],'fourier.residual.json')
 execute('sparse',[base/'sparse_tails',d/'model.json',d/'fourier.residual.json',d/'sparse'],'sparse.tails.json')
 t=json.load(open(d/'sparse.tails.json'))
 (d/'sparse_for_content.json').write_text(json.dumps({'indices':[71,72,73],'rows':t['tails']},separators=(',',':'))+'\n')
 execute('norm_tail_content',[base/'gap_content_fast',d/'model.json',d/'sparse_for_content.json',d/'norm_tail_content'],'norm_tail_content.73.json')
 execute('boundaries',[base/'projection_boundaries',d/'model.json',d/'fourier.residual.json',d/'boundary'],'boundary.2.json')
 execute('boundary_projection',[base/'gap_projection',curve,d/'boundary_projection',d/'boundary.0.json',d/'boundary.1.json',d/'boundary.2.json'],'boundary_projection.2.json')
 execute('boundary_factors',['/usr/local/bin/sage','scripts/arithmetic/root9_gap_boundary_factors_20260929.sage',d],'projection_boundary_factors.json')
 jr=json.load(open(curve))['coefficients'];dj=max(len(r)-1 for r in jr);m=len(jr)-1;bounds=[]
 for k in [71,72]:
  row=json.load(open(d/('norm_tail_content.%d.json'%k)))['coefficients'];bounds.append(m*max(len(r)-1 for r in row)+(len(row)-1)*dj)
 engine='hermite_projection' if max(bounds)<3*390624 else 'multijet_projection'
 print(tag,'projection bounds',bounds,'engine',engine,flush=True)
 execute('norm_hermite',[base/engine,curve,d/'norm_tail_content.71.json',d/'norm_tail_content.72.json',d/'norm_projection'],'norm_projection.72.json')
 execute('norm_support',[base/'projection_support',d/'model.json',d,'norm_projection','71','72'],'norm_projection.boundary_split.json')
 execute('norm_boundary_fibres',[base/'gap_boundary_fibres',curve,d,'norm_tail_content','71','72','norm'],'norm.boundary_fibre_results.json')
 result=json.load(open(d/'norm.boundary_fibre_results.json'));split=json.load(open(d/'norm_projection.boundary_split.json'))
 closed=result['all_excluded'] and len(split['outside_part'])==1
 (d/'decision.json').write_text(json.dumps({'endpoint':i,'branch':j,'excluded':closed,'outside_projection_degree':len(split['outside_part'])-1,'all_boundary_fibres_excluded':result['all_excluded'],'scope':'Entire indicated rational-scale graph; all original opens and retained fibres included'},indent=2)+'\n')
 print('SQUARE_CONTENT_BRANCH_RESULT',tag,closed,flush=True)
pairs=[tuple(map(int,a.split(':'))) for a in sys.argv[1:]] or [(i,j) for i in range(3) for j in range(1,4)]
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
 for result in pool.map(run_branch,pairs):pass
