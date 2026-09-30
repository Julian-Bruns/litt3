#!/usr/bin/env python3
"""Rebuild the continuation and regenerate its 51 exact evidence files.

This checks the 1,470 distinguished-ratio exclusions and the computational
ingredients of the uniform 60-scale bound. It does NOT decide the full square
locus. Each of the 30 finite-algebra computations is an independent restartable
chunk. Baseline verification is provided separately by verify.py.
"""
from __future__ import annotations
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import subprocess
import sys
import time
from verify import sha256, check_manifest, atomic_json

ROOTS=[9,14,2514,7367,20130,104315,139659,154113,281660,364472]
ZETAS=[1,11,18]
TOOLS=['newton_edge','exceptional_ratios','exceptional_scales',
       'validate_finite_algebra','diagnose_structure']

def main() -> int:
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--workdir',required=True,type=Path)
    ap.add_argument('--jobs',type=int,default=1)
    ap.add_argument('--resume',action='store_true')
    ap.add_argument('--skip-manifest',action='store_true',help='Maintainer option before sealing the archive')
    args=ap.parse_args()
    archive=Path(__file__).resolve().parent
    work=args.workdir.resolve()
    if work==archive or work.is_relative_to(archive):ap.error('--workdir must be outside the archive')
    if args.jobs<1:ap.error('--jobs must be positive')
    build,gen,logs,stamps=[work/n for n in ['build','generated','logs','stamps']]
    for p in [build,gen,logs,stamps]:p.mkdir(parents=True,exist_ok=True)
    summary={'status':'running','scope':__doc__.strip(),'started_utc':dt.datetime.now(dt.timezone.utc).isoformat(),
             'archive':str(archive),'workdir':str(work),'steps':[]}
    started=time.perf_counter()
    env=os.environ.copy();env['PYTHONOPTIMIZE']='0'
    cxx=shlex.split(env.get('CXX','g++'))
    def save():atomic_json(work/'verification_summary.json',summary)
    try:
        if not args.skip_manifest:
            summary['manifest_files_checked']=check_manifest(archive)
            print('PASS full archive manifest',flush=True)
        else:summary['manifest_files_checked']=None
        import sympy
        summary['versions']={'python':sys.version,'sympy':sympy.__version__,
            'compiler':subprocess.check_output(cxx+['--version'],text=True).splitlines()[0],
            'platform':platform.platform()}
        sources=sorted((archive/'src').glob('*'))+sorted((archive/'continuation/src').glob('*'))+[Path(__file__),archive/'verify.py']
        source_hash=hashlib.sha256(''.join(f'{p.relative_to(archive)}:{sha256(p)}\n' for p in sources if p.is_file()).encode()).hexdigest()
        summary['source_sha256']=source_hash
        def run(name,command,outputs):
            expected={n:sha256(archive/'continuation/data'/n) for n in outputs}
            stamp=stamps/(name+'.json')
            if args.resume and stamp.exists():
                s=json.loads(stamp.read_text())
                if s.get('source_sha256')==source_hash and s.get('outputs')==expected and all((gen/n).is_file() and sha256(gen/n)==h for n,h in expected.items()):
                    return {'name':name,'status':'cached-verified','outputs':expected}
            st=time.perf_counter();log=logs/(name+'.log')
            with log.open('w') as f:
                f.write('$ '+shlex.join(command)+'\n');f.flush()
                p=subprocess.run(command,cwd=archive,env=env,stdout=f,stderr=subprocess.STDOUT)
            rec={'name':name,'command':command,'returncode':p.returncode,'elapsed_seconds':round(time.perf_counter()-st,6),'log':str(log),'outputs':expected}
            if p.returncode:raise RuntimeError(f'{name} failed with return code {p.returncode}: {log}')
            for n,h in expected.items():
                if not (gen/n).is_file() or sha256(gen/n)!=h:raise RuntimeError(f'{name}: regenerated evidence mismatch: {n}')
            rec['status']='passed';atomic_json(stamp,{'source_sha256':source_hash,'outputs':expected})
            print(f'PASS {name}: {len(outputs)} evidence files matched',flush=True)
            return rec
        for tool in TOOLS:
            command=cxx+['-O2','-std=c++17','-UNDEBUG',str(archive/'continuation/src'/f'{tool}.cpp'),'-o',str(build/tool)]
            # Always rebuild binaries: a stamp for a generator never substitutes for source compilation.
            st=time.perf_counter();log=logs/(f'build_{tool}.log')
            with log.open('w') as f:
                f.write('$ '+shlex.join(command)+'\n');f.flush()
                p=subprocess.run(command,cwd=archive,env=env,stdout=f,stderr=subprocess.STDOUT)
            if p.returncode:raise RuntimeError(f'Compilation failed: {log}')
            summary['steps'].append({'name':f'build_{tool}','status':'passed','command':command,'returncode':0,'elapsed_seconds':round(time.perf_counter()-st,6),'log':str(log)})
            print(f'PASS build {tool}',flush=True)
        tasks=[('universal_edge',[sys.executable,str(archive/'continuation/src/universal_edge.py'),str(gen/'universal_edge.json')],['universal_edge.json']),
               ('newton_edge',[str(build/'newton_edge'),str(gen)],[f'edge_{r}.json' for r in ROOTS]),
               ('exceptional_ratios',[str(build/'exceptional_ratios'),str(gen)],[f'ratios_{r}.json' for r in ROOTS]),
               ('validate_finite_algebra',[str(build/'validate_finite_algebra')],[]),
               ('diagnose_structure',[str(build/'diagnose_structure')],[])]
        for name,cmd,outs in tasks:
            summary['steps'].append(run(name,cmd,outs));save()
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futures=[]
            for case in range(30):
                r,z=ROOTS[case//3],ZETAS[case%3]
                name=f'scales_{case:02d}'
                futures.append(pool.submit(run,name,[str(build/'exceptional_scales'),str(gen),str(case),str(case+1)],[f'scales_{r}_{z}.json']))
            for future in as_completed(futures):summary['steps'].append(future.result());save()
        expected_files=[f'edge_{r}.json' for r in ROOTS]+[f'ratios_{r}.json' for r in ROOTS]+[f'scales_{r}_{z}.json' for r in ROOTS for z in ZETAS]+['universal_edge.json']
        assert len(expected_files)==51
        for n in expected_files:assert sha256(gen/n)==sha256(archive/'continuation/data'/n)
        summary.update(status='passed',data_files_verified=51,geometric_ratio_points_excluded=1470,
            uniform_scale_bound=60,original_square_decision='unresolved')
        print('PASS: all 51 continuation evidence files regenerated and matched; original square decision unresolved.',flush=True)
    except Exception as exc:
        summary.update(status='failed',error=str(exc));print(str(exc),file=sys.stderr)
    finally:
        summary['finished_utc']=dt.datetime.now(dt.timezone.utc).isoformat()
        summary['elapsed_seconds']=round(time.perf_counter()-started,6);save()
    return 0 if summary['status']=='passed' else 1
if __name__=='__main__':raise SystemExit(main())
