"""Read-only reproduction of all 36 essential outputs and manifest coverage.
This verifies the supplied evidence, not the unresolved square-locus decision.
"""
from __future__ import annotations
import argparse,json,shutil,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from verify_all import canonical

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--skip-manifest',action='store_true',help='Maintainer only, before packaging')
 args=parser.parse_args()
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 command=[sys.executable,'-B','global/src/verify_global.py']
 if args.skip_manifest:command.append('--skip-manifest')
 subprocess.run(command,cwd=ROOT,check=True)
 stages=[('check_critical_coordinates.py','critical_coordinates.json'),
         ('check_auxiliary_curves.py','auxiliary_curves.json'),
         ('check_chart_boundaries.py','chart_boundaries.json'),
         ('check_cubic_branch.py','cubic_branch.json'),
         ('check_cusp_scales.py','cusp_scales.json')]
 with tempfile.TemporaryDirectory(prefix='r9-resolution-verify-') as temp:
  work=Path(temp)/'archive';shutil.copytree(ROOT,work,ignore=shutil.ignore_patterns('__pycache__'))
  for script,output in stages:
   relative='resolution/src/'+script
   print('Running '+relative,flush=True)
   result=subprocess.run([sys.executable,'-B',relative],cwd=work,capture_output=True,text=True)
   if result.returncode:raise RuntimeError(result.stdout+'\n'+result.stderr)
   path='resolution/data/'+output
   if canonical(json.loads((ROOT/path).read_text()))!=canonical(json.loads((work/path).read_text())):
    raise RuntimeError('Reproduction mismatch: '+path)
   print(relative+': PASS (1 essential JSON output)',flush=True)
 print('Full verification PASS: 31 retained + 5 new = 36 essential outputs.',flush=True)
 print('Complete fourteen-ratio triple-root stratum: EMPTY for all geometric scales.',flush=True)
 print('No new full q fibre is excluded; the other ratios on those q values remain in scope.',flush=True)
 print('Auxiliary curve irreducibility tests and boundary algebras are NOT square witnesses.',flush=True)
 print('Requested moving-ratio square decision: UNRESOLVED.',flush=True)
if __name__=='__main__':main()
