#!/usr/bin/env python3
"""Run every archived verification command; fail immediately on a nonzero exit."""
import argparse
import os
from pathlib import Path
import platform
import subprocess
import sys
ROOT=Path(__file__).resolve().parents[1]
COMMANDS=[
 ['src/verify_manifest.py'],
 ['src/check_claims.py'],
 ['prior/src/verify_manifest.py'],
 ['prior/src/arithmetic_checks.py'],
 ['prior/src/symbolic_checks.py'],
 ['prior/src/local_spectrum.py','--check','prior/evidence/local_spectrum.json'],
 ['prior/src/genus_checks.py'],
 ['prior/src/profile_checks.py','--check','prior/evidence/profile_summary.json'],
 ['src/new_symbolic_checks.py'],
 ['src/new_local_checks.py','--check','evidence/refined_local_spectrum.json'],
 ['src/new_profile_checks.py','--check','evidence/new_profile_summary.json']]
def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--skip-root-manifest',action='store_true',help='Build-time only, when writing logs before manifest creation.')
    args=ap.parse_args()
    import sympy
    print('Python',platform.python_version(),'SymPy',sympy.__version__,platform.system(),platform.machine(),flush=True)
    env=dict(os.environ,PYTHONDONTWRITEBYTECODE='1')
    commands=COMMANDS[1:] if args.skip_root_manifest else COMMANDS
    for command in commands:
        print('\n$ python '+' '.join(command),flush=True)
        subprocess.run([sys.executable]+command,cwd=ROOT,env=env,check=True)
    print('\nPASS: all',len(commands),'verification commands.',flush=True)
    print('No actual-curve search or geometric witness verification was run.',flush=True)
if __name__=='__main__': main()
