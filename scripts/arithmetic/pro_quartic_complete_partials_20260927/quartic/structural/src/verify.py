#!/usr/bin/env python3
"""Verify the new pencil proof, optionally followed by inherited compact replays."""
from __future__ import annotations
import argparse,hashlib,json,platform,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
BUILD=ROOT/'build'/'structural_verify'

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--inherited-compact',action='store_true')
 args=parser.parse_args();BUILD.mkdir(parents=True,exist_ok=True)
 checks=[];count=0
 for line in (ROOT/'SHA256SUMS').read_text().splitlines():
  digest,path=line.split('  ',1)
  if hashlib.sha256((ROOT/path).read_bytes()).hexdigest()!=digest:
   raise RuntimeError('Manifest mismatch: '+path)
  count+=1
 checks.append({'command':'internal SHA-256 manifest verification','status':'PASS','files':count})
 print('PASS manifest',count,'files',flush=True)
 command=[sys.executable,'structural/src/verify_pencils.py'];st=time.monotonic()
 run=subprocess.run(command,cwd=ROOT,text=True,capture_output=True)
 (BUILD/'pencils.stdout').write_text(run.stdout)
 if run.stderr:(BUILD/'pencils.stderr').write_text(run.stderr)
 if run.returncode:raise RuntimeError(run.stdout+run.stderr)
 actual=json.loads(run.stdout)
 expected=json.loads((ROOT/'structural/evidence/pencil_verification.json').read_text())
 if actual!=expected:raise RuntimeError('New retained verification record mismatch')
 checks.append({'command':command,'status':'PASS','exact_record_match':True,
                'seconds':round(time.monotonic()-st,3)})
 print('PASS all six polynomial identities, scheme classification, and rank obstruction',flush=True)
 if args.inherited_compact:
  command=[sys.executable,'conceptual/src/verify.py','--inherited-compact'];st=time.monotonic()
  run=subprocess.run(command,cwd=ROOT,text=True,capture_output=True)
  (BUILD/'inherited.stdout').write_text(run.stdout)
  if run.stderr:(BUILD/'inherited.stderr').write_text(run.stderr)
  if run.returncode:raise RuntimeError(run.stdout+run.stderr)
  checks.append({'command':command,'status':'PASS','scope':'inherited compact replays, not full scans',
                 'seconds':round(time.monotonic()-st,3)})
  print('PASS inherited conceptual and older compact replays (not full scans)',flush=True)
 summary={'status':'PASS','global_existence_decision':'UNRESOLVED',
          'new_scope':'both-single-root-type endpoint pairs excluded',
          'new_endpoint_search_executed':False,'checks':checks,
          'software':{'python':platform.python_version(),'platform':platform.platform()}}
 (BUILD/'verification.json').write_text(json.dumps(summary,indent=2)+'\n')
 print(json.dumps({k:v for k,v in summary.items() if k!='checks'},indent=2))
if __name__=='__main__':main()
