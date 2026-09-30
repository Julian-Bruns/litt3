#!/usr/bin/env python3
"""Run ten-root fixed-q proofs. This is not a varying-q square decision."""
import argparse,concurrent.futures,json,subprocess,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ROOTS=[9,14,2514,7367,20130,104315,139659,154113,281660,364472]
def main():
 p=argparse.ArgumentParser();p.add_argument('--jobs',type=int,default=4);p.add_argument('--roots',type=int,nargs='+',default=ROOTS);p.add_argument('--base',type=Path,default=ROOT/'next');p.add_argument('--threads',type=int,default=1);a=p.parse_args();a.base=a.base.resolve()
 a.base.mkdir(parents=True,exist_ok=True)
 def work(r):
  dr=a.base/f'r{r}';dr.mkdir(exist_ok=True);logdir=a.base/'evidence';logdir.mkdir(exist_ok=True)
  commands=[['fibre_equations',str(r),str(dr),str(a.threads)],['fibre_resultants',str(dr),'73',str(a.threads)],['res_strip',str(r),str(dr),'73'],['fibre_gcd',str(dr)],['gcd_analyze',str(r),str(dr)],['quotient_fibre',str(dr)]]
  checks=[]
  for cmd in commands:
   path=logdir/f'{cmd[0]}_r{r}.log'
   with path.open('w') as f:
    t=time.monotonic();out=subprocess.run([str(ROOT/'build'/cmd[0]),*cmd[1:]],cwd=ROOT,stdout=f,stderr=subprocess.STDOUT);dt=time.monotonic()-t
   checks.append({'command':cmd,'exit_code':out.returncode,'seconds':dt})
   (dr/'run_status.json').write_text(json.dumps({'root':r,'checks':checks},indent=2)+'\n')
   print(r,cmd[0],out.returncode,f'{dt:.2f}s',flush=True)
   if out.returncode:raise RuntimeError(f'Root {r} stage {cmd[0]} failed. See {path}')
  result=json.loads((dr/'quotient_summary.json').read_text())
  if not result['all_geometric_H_mu_candidates_excluded']:raise RuntimeError(f'Root {r}: candidates survived')
  return {'root':r,'q':64426,'all_H_mu_excluded':True,'scope':'one fixed q fibre','checks':checks}
 with concurrent.futures.ThreadPoolExecutor(max_workers=a.jobs) as pool:
  results=list(pool.map(work,a.roots))
 (a.base/'fibres_summary.json').write_text(json.dumps({'scope':'fixed q=64426, arbitrary geometric H and mu; NOT the varying-q schemes','results':results},indent=2)+'\n')
 print('ALL_REQUESTED_FIBRES_EXCLUDED',flush=True)
if __name__=='__main__':main()
