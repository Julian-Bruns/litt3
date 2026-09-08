#!/usr/bin/env python3
"""Fresh-process conversion pool for old exact direction checkpoints."""
import argparse,concurrent.futures,json,os,subprocess,time
from pathlib import Path
from atlas_native_tensor_input import sha

ap=argparse.ArgumentParser();ap.add_argument('--folder',type=Path,required=True)
ap.add_argument('--workers',type=int,default=10);ap.add_argument('--sage',default='sage');args=ap.parse_args()
assert 1<=args.workers<=10;folder=args.folder.resolve();start=time.monotonic()
assert (folder/'oper.sobj').exists()
assert all((folder/('direction_%02d.sobj'%i)).exists() for i in range(32))
def job(i):
    env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',SAGE_NUM_THREADS='1',MKL_NUM_THREADS='1')
    # Same owned process group as this wrapper: its controller can stop
    # every conversion without orphaning independent process sessions.
    log_folder=folder/'complete_native'/'packing_logs';log_folder.mkdir(parents=True,exist_ok=True)
    log=log_folder/('direction-%02d-%s.log'%(i,time.time_ns()))
    completed=subprocess.run([args.sage,str(Path(__file__).with_name('pack_legacy_native_direction.sage')),
        '--folder',str(folder),'--direction',str(i)],capture_output=True,text=True,env=env)
    log.write_text(completed.stdout+completed.stderr)
    if completed.returncode:
        raise RuntimeError('Legacy packing failed for direction%d; exact stderr saved in%s: %s'%
                           (i,log,completed.stderr[-1500:]))
    return json.loads(completed.stdout.strip().splitlines()[-1])
with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
    futures=[pool.submit(job,i) for i in range(32)]
    for future in concurrent.futures.as_completed(futures):print(json.dumps(future.result()),flush=True)
print(json.dumps(dict(all32_original_direction_native_bindings_verified=True,workers=args.workers,
    seconds=time.monotonic()-start)),flush=True)
