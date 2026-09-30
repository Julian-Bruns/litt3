#!/usr/bin/env python3
"""Replay the conceptual continuation's exact checks.

This verifies formulas and retained small examples, NOT the global
existence problem. Outputs go only to the regenerable build/ directory.
"""
from __future__ import annotations
import argparse, hashlib, json, platform, subprocess, sys, time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
BUILD=ROOT/'build'/'conceptual_verify'

def mathematical_record(value):
    if isinstance(value,dict):
        return {k:mathematical_record(v) for k,v in value.items()
                if k not in {'seconds','python','software','platform'}}
    if isinstance(value,list):return [mathematical_record(v) for v in value]
    return value

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--inherited-compact',action='store_true',
                        help='Also rerun the inherited compact suite (requires g++).')
    args=parser.parse_args()
    BUILD.mkdir(parents=True,exist_ok=True)
    checks=[]
    manifest=ROOT/'SHA256SUMS'
    if manifest.exists():
        count=0
        for line in manifest.read_text().splitlines():
            digest,path=line.split('  ',1)
            if hashlib.sha256((ROOT/path).read_bytes()).hexdigest()!=digest:
                raise RuntimeError('Manifest mismatch: '+path)
            count+=1
        checks.append({'command':'internal SHA256 manifest verification','status':'PASS','files':count})
        print('PASS manifest',count,'files',flush=True)
    cases=[('verify_conceptual.py','conceptual_checks.json'),
           ('verify_semilinear.py','semilinear_checks.json'),
           ('verify_relaxation.py','formal_relaxation_verified.json')]
    for script,record in cases:
        command=[sys.executable,'conceptual/src/'+script]
        start=time.monotonic()
        run=subprocess.run(command,cwd=ROOT,text=True,capture_output=True)
        (BUILD/(script+'.stdout')).write_text(run.stdout)
        if run.stderr:(BUILD/(script+'.stderr')).write_text(run.stderr)
        if run.returncode:
            sys.stderr.write(run.stdout+run.stderr)
            raise RuntimeError('Check failed: '+script)
        actual=json.loads(run.stdout)
        expected=json.loads((ROOT/'conceptual'/'evidence'/record).read_text())
        if mathematical_record(actual)!=mathematical_record(expected):
            raise RuntimeError('Retained mathematical record disagrees: '+record)
        checks.append({'command':command,'status':'PASS',
                       'retained_record':str(Path('conceptual/evidence')/record),
                       'mathematical_record_match':True,
                       'seconds':round(time.monotonic()-start,3)})
        print('PASS',script,'and exact retained-record comparison',flush=True)
    if args.inherited_compact:
        command=[sys.executable,'continuation/src/verify.py']
        start=time.monotonic()
        run=subprocess.run(command,cwd=ROOT,text=True,capture_output=True)
        (BUILD/'inherited_compact.stdout').write_text(run.stdout)
        if run.stderr:(BUILD/'inherited_compact.stderr').write_text(run.stderr)
        if run.returncode:
            sys.stderr.write(run.stdout+run.stderr)
            raise RuntimeError('Inherited compact suite failed')
        checks.append({'command':command,'status':'PASS',
                       'scope':'compact replay, not exhaustive scan regeneration',
                       'seconds':round(time.monotonic()-start,3)})
        print('PASS inherited compact replay (not full scans)',flush=True)
    summary={'status':'PASS','global_existence_decision':'UNRESOLVED',
             'scope':'theoretical-formula corroboration and retained small cases',
             'large_endpoint_search_executed_in_this_run':False,
             'software':{'python':platform.python_version(),'platform':platform.platform()},
             'checks':checks}
    (BUILD/'verification.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps({k:v for k,v in summary.items() if k!='checks'},indent=2))

if __name__=='__main__':main()
