"""Read-only full verification: baseline and all essential continuation data."""
from __future__ import annotations
import argparse,json,shutil,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from verify_all import canonical


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--skip-manifest',action='store_true',help='Maintainer mode before packaging')
    args=p.parse_args()
    if sys.flags.optimize: raise RuntimeError('Do not use python -O')
    cmd=[sys.executable,'-B','src/verify_all.py']
    if args.skip_manifest:cmd.append('--skip-manifest')
    subprocess.run(cmd,cwd=ROOT,check=True)
    stages=[
      ('continuation/src/check_frobenius.py',
       ['continuation/data/global_minor_circuit.json','continuation/evidence/frobenius_checks.json']),
      ('continuation/src/check_differential.py',
       ['continuation/data/differential_minor_circuits.json','continuation/evidence/differential_checks.json']),
      ('continuation/src/check_tangents.py',['continuation/evidence/tangent_checks.json']),
      ('continuation/src/check_middle_span.py',['continuation/evidence/middle_span.json']),
      ('continuation/explore_scale.py',['continuation/explore_scale.json']),
    ]
    count=0
    with tempfile.TemporaryDirectory(prefix='r9-continuation-verify-') as tmp:
        work=Path(tmp)/'archive'
        shutil.copytree(ROOT,work,ignore=shutil.ignore_patterns('__pycache__'))
        for script,files in stages:
            print('Running',script,flush=True)
            result=subprocess.run([sys.executable,'-B',script],cwd=work,capture_output=True,text=True)
            if result.returncode:raise RuntimeError(result.stdout+'\n'+result.stderr)
            # Logs are concise; the exploratory script has intentionally more
            # local output, so print its summary only.
            if 'explore_scale' not in script:print(result.stdout,end='',flush=True)
            for f in files:
                a=canonical(json.loads((ROOT/f).read_text()))
                b=canonical(json.loads((work/f).read_text()))
                if a!=b:raise RuntimeError('Reproduction mismatch: '+f)
            count+=len(files)
            print(script+': PASS ('+str(len(files))+' essential JSON files)',flush=True)
        print('Continuation essential JSON reproduction: PASS ('+str(count)+' files)',flush=True)
    print('Full verification PASS (12 baseline + 7 continuation essential JSON files).',flush=True)
    print('Requested moving-ratio square decision: UNRESOLVED.',flush=True)

if __name__=='__main__':main()
