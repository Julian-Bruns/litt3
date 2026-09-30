"""Reproduce retained evidence and preparation, not a completed global decision."""
from __future__ import annotations
import argparse,json,shutil,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from verify_all import canonical

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--skip-manifest',action='store_true',help='Maintainer use before packaging only')
    a=p.parse_args()
    if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
    cmd=[sys.executable,'-B','resolution/src/verify_resolution.py']
    if a.skip_manifest:cmd.append('--skip-manifest')
    subprocess.run(cmd,cwd=ROOT,check=True)
    with tempfile.TemporaryDirectory(prefix='r9-decision-attempt-') as tmp:
        work=Path(tmp)/'archive'
        shutil.copytree(ROOT,work,ignore=shutil.ignore_patterns('__pycache__'))
        for script,out in [('prepare_global.py','preparation.json'),('check_global_model.py','model_diagnostics.json')]:
            run=subprocess.run([sys.executable,'-B','decision/src/'+script],cwd=work,capture_output=True,text=True)
            if run.returncode:raise RuntimeError(run.stdout+'\n'+run.stderr)
            rel='decision/data/'+out
            if canonical(json.loads((ROOT/rel).read_text()))!=canonical(json.loads((work/rel).read_text())):
                raise RuntimeError('Mismatch: '+rel)
            print('decision/src/'+script+': PASS (preparation/diagnostics only)',flush=True)
        rel='decision/global_incidence.sing'
        if (ROOT/rel).read_bytes()!=(work/rel).read_bytes():raise RuntimeError('Generated prototype differs')
    print('Reproduction PASS: 36 retained + 2 preparation/diagnostic JSON outputs.',flush=True)
    print('Singular text regenerated identically; Singular code remains UNEXECUTED and UNVERIFIED.',flush=True)
    print('No new source exclusion, exact source square, or global unit certificate.',flush=True)
    print('Requested complete moving-ratio decision: UNRESOLVED.',flush=True)
if __name__=='__main__':main()
