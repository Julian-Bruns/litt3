#!/usr/bin/env python3
"""Run the actual neutral D10 family with bounded independent worker processes.

Each case retains a full producer log and exact outputs. A failed assertion
is a failed case, never an exclusion. Existing completed cases are accepted
only when their input/source/precision fingerprint matches this run.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time


def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--models',required=True)
    ap.add_argument('--output',required=True)
    ap.add_argument('--jobs',type=int,default=2)
    ap.add_argument('--precision',type=int,default=3500)
    ap.add_argument('--frobenius-variant',type=int,choices=[0,1],default=0)
    ap.add_argument('--cases',nargs='*')
    args=ap.parse_args()
    assert 1<=args.jobs<=4
    root=Path(__file__).resolve().parents[3]
    out=Path(args.output).resolve();out.mkdir(parents=True,exist_ok=True)
    sources={str(p.relative_to(root)):sha(p) for p in
             [root/'scripts/deformations/cyclic/compute_dihedral5_w4.py',root/'scripts/deformations/cyclic/neutral5_witt_algebra.py',
              root/'scripts/deformations/cyclic/neutral5_gmp_convolution.py']}
    models=[p for p in sorted(Path(args.models).resolve().glob('pair_*.json'))
            if json.loads(p.read_text())['neutral'] and
            (not args.cases or p.stem in args.cases)]
    assert models
    start=time.monotonic(); completed=[]

    def work(model):
        label=model.stem;case=out/label;case.mkdir(exist_ok=True)
        fp=dict(model_sha256=sha(model),sources=sources,precision=args.precision,
                frobenius_variant=args.frobenius_variant)
        receipt=case/'worker_receipt.json'
        if receipt.exists():
            old=json.loads(receipt.read_text())
            if old.get('fingerprint')==fp and old.get('status')=='PASS':
                assert all(sha(case/n)==h for n,h in old['output_hashes'].items())
                return old
        env=dict(os.environ,DIHEDRAL5_MODEL=str(model),NEUTRAL5_RUN_DIR=str(case),
                 OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1',VECLIB_MAXIMUM_THREADS='1')
        for key in ['NEUTRAL5_FIRST_ONLY','NEUTRAL5_FIELD_POWER','NEUTRAL5_PRIMITIVE_VARIANT','NEUTRAL5_KERNEL_VARIANT']:
            env.pop(key,None)
        clock=time.monotonic()
        with (case/'run.log').open('w') as log:
            run=subprocess.run([sys.executable,str(root/'scripts/deformations/cyclic/compute_dihedral5_w4.py'),
                                '--precision',str(args.precision),
                                '--frobenius-variant',str(args.frobenius_variant)],
                               cwd=root,env=env,stdout=log,stderr=subprocess.STDOUT)
        result=dict(label=label,fingerprint=fp,seconds=time.monotonic()-clock,
                    returncode=run.returncode,status='FAILED')
        if run.returncode==0:
            r=json.loads((case/'genus6_fourth_result.json').read_text())
            assert r['status'].startswith('PASS complete')
            assert r['model_label']==label and r['rho4_precision']>=100
            result.update(status='PASS',c4=r['c4'],rho4_precision=r['rho4_precision'],
                          nonzero=any(r['c4']),
                          output_hashes={p.name:sha(p) for p in case.glob('genus6_*.json')})
        else:
            result['last_lines']=(case/'run.log').read_text().splitlines()[-8:]
        receipt.write_text(json.dumps(result,indent=2)+'\n')
        return result

    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures={pool.submit(work,p):p for p in models}
        for future in as_completed(futures):
            result=future.result();completed.append(result)
            print(json.dumps({k:result[k] for k in ['label','status','seconds','c4','nonzero'] if k in result}),flush=True)
            (out/'summary.json').write_text(json.dumps(dict(
                status='RUNNING',completed=sorted(completed,key=lambda r:r['label']),
                expected=len(models),seconds=time.monotonic()-start),indent=2)+'\n')
    status='PASS' if all(r['status']=='PASS' for r in completed) else 'FAILED_CASES'
    summary=dict(status=status,expected=len(models),completed=sorted(completed,key=lambda r:r['label']),
                 seconds=time.monotonic()-start,scope='Computed one actual compatible W3 per original neutral cover; parameter independence is a separate proof.')
    (out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(status,len(completed),'cases',round(summary['seconds'],2),'seconds',flush=True)
    if status!='PASS':raise SystemExit(1)


if __name__=='__main__':main()
