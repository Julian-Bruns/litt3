#!/usr/bin/env python3
"""Sequential one-core exact critical-norm exclusions at new x-root types."""
import argparse,json,os,subprocess,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--roots',default='211895,211959');args=ap.parse_args()
scripts=Path(__file__).parent;env=os.environ.copy()
for key in ('OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS'):
    env[key]='1'
start=time.time();summary=[]
for root in map(int,args.roots.split(',')):
    stages=[
        ('setup','concentrated_d0_critical_norm.sage',['--symbolic','--setup-only'],f'concentrated_d0_critical_setup_{root}.sobj'),
        ('interpolation','concentrated_d0_critical_interpolation.sage',['--interpolate-only'],f'concentrated_d0_critical_interpolated_{root}.sobj'),
        ('fast_norm','concentrated_d0_critical_fast_norm.sage',[],f'concentrated_d0_critical_norm_{root}_symbolic.sobj'),
        ('square_tails','concentrated_d0_norm_square_tails.sage',[],f'concentrated_d0_norm_square_tails_{root}.json'),
    ]
    for stage,script,extra,artifact in stages:
        if (args.work/'data'/artifact).exists():
            print('EXISTS',root,stage,flush=True);continue
        logfile=args.work/'data'/f'concentrated_d0_{stage}_{root}.log'
        command=['/usr/local/bin/sage','-python',str(scripts/script),'--work',str(args.work),'--root',str(root)]+extra
        print('START',root,stage,'SECONDS',time.time()-start,flush=True)
        with logfile.open('w') as output:subprocess.run(command,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        assert (args.work/'data'/artifact).exists()
        print('COMPLETE',root,stage,'SECONDS',time.time()-start,flush=True)
    result=json.loads((args.work/'data'/f'concentrated_d0_norm_square_tails_{root}.json').read_text())
    assert result['completed_exclusion'];summary.append(result)
(args.work/'data'/'concentrated_d0_pipeline_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
print('ALL_NEW_ROOTS_EXCLUDED','SECONDS',time.time()-start,flush=True)
