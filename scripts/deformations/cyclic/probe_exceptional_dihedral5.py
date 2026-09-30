#!/usr/bin/env python3
"""Probe the complete four-direction exceptional D10 fourth-obstruction map.

The finite sample may reconstruct a candidate quadratic, but does not itself
prove a polynomial degree bound or emptiness of the entire geometric locus.
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


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--model',required=True)
    ap.add_argument('--output',required=True)
    ap.add_argument('--jobs',type=int,default=2)
    ap.add_argument('--precision',type=int,default=3500)
    ap.add_argument('--field-basis',action='store_true',help='Separate ordinary and fifth-power linear coefficients.')
    args=ap.parse_args()
    assert 1<=args.jobs<=2
    root=Path(__file__).resolve().parents[3]
    output=Path(args.output).resolve();output.mkdir(parents=True,exist_ok=True)
    source=root/'scripts/deformations/cyclic/exceptional_dihedral5_w4.py'
    sources={str(p.relative_to(root)):sha(p) for p in
             [source,source.with_name('neutral5_witt_algebra.py'),
              source.with_name('neutral5_gmp_convolution.py')]}
    samples={}
    zero=lambda:[[0,0,0,0] for _ in range(4)]
    for i in range(4):
        for a in [1,4]:
            v=zero();v[i][0]=a;samples[f'e{i}_{a}']=v
    for i in range(4):
        for j in range(i+1,4):
            v=zero();v[i][0]=v[j][0]=1;samples[f'e{i}_e{j}']=v
    samples['field_check_1']=[[0,1,0,0],[1,0,1,0],[3,0,0,1],[4,2,1,3]]
    samples['field_check_2']=[[3,2,1,0],[0,0,1,1],[1,4,0,2],[2,1,3,4]]
    if args.field_basis:
        samples={}
        for i in range(4):
            for a in [1,4]:
                v=zero();v[i][1]=a;samples[f'e{i}_tau_{a}']=v
    model=str(Path(args.model).resolve())
    start=time.monotonic();rows=[]
    def run(label,parameters):
        out=output/label;out.mkdir(exist_ok=True)
        fingerprint=dict(model_sha256=sha(model),sources=sources,
                         parameters=parameters,precision=args.precision)
        receipt=out/'receipt.json'
        if receipt.exists():
            old=json.loads(receipt.read_text())
            if old.get('status')=='PASS' and old.get('fingerprint')==fingerprint:
                assert all(sha(out/n)==v for n,v in old['outputs'].items())
                return old
        env=dict(os.environ,DIHEDRAL5_MODEL=model,DIHEDRAL5_PARAMETERS=json.dumps(parameters),
                 NEUTRAL5_RUN_DIR=str(out),OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1')
        for key in ['NEUTRAL5_FIRST_ONLY','NEUTRAL5_FIELD_POWER',
                    'NEUTRAL5_PRIMITIVE_VARIANT','NEUTRAL5_KERNEL_VARIANT']:
            env.pop(key,None)
        t=time.monotonic()
        with (out/'run.log').open('w') as log:
            result=subprocess.run([sys.executable,str(source),'--precision',str(args.precision)],
                                  cwd=root,env=env,stdout=log,stderr=subprocess.STDOUT)
        row=dict(label=label,fingerprint=fingerprint,status='FAILED',
                 returncode=result.returncode,seconds=time.monotonic()-t)
        if result.returncode==0:
            data=json.loads((out/'genus6_fourth_result.json').read_text())
            assert data['status'].startswith('PASS complete') and data['parameters']==parameters
            row.update(status='PASS',c4=data['c4'],
                       outputs={p.name:sha(p) for p in out.glob('genus6_*.json')})
        else:
            row['last_lines']=(out/'run.log').read_text().splitlines()[-10:]
        receipt.write_text(json.dumps(row,indent=2)+'\n')
        return row
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures=[pool.submit(run,label,values) for label,values in samples.items()]
        for future in as_completed(futures):
            row=future.result();rows.append(row)
            print(json.dumps({k:row[k] for k in ['label','status','seconds','c4'] if k in row}),flush=True)
            (output/'summary.json').write_text(json.dumps(dict(
                status='RUNNING',rows=rows,expected=len(samples)),indent=2)+'\n')
    status='PASS' if all(r['status']=='PASS' for r in rows) else 'FAILED'
    (output/'summary.json').write_text(json.dumps(dict(
        status=status,rows=sorted(rows,key=lambda r:r['label']),expected=len(samples),
        seconds=time.monotonic()-start,
        scope='Actual evaluations only; candidate interpolation needs separate support proof.'),indent=2)+'\n')
    if status!='PASS':raise SystemExit(1)


if __name__=='__main__':main()
