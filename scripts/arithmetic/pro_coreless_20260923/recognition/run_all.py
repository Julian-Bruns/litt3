#!/usr/bin/env python3
"""Re-run all included certificate checks; no all-degree decision is claimed."""
from pathlib import Path
import json
import platform
import shutil
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parent
LOGS=ROOT/'certificates'/'logs'
ORIG=ROOT/'certificates'/'original'
NEW=ROOT/'certificates'/'new'


def run(command,stem):
    result=subprocess.run(command,cwd=ROOT,text=True,capture_output=True,check=False)
    (LOGS/f'{stem}.stdout').write_text(result.stdout)
    (LOGS/f'{stem}.stderr').write_text(result.stderr)
    if result.returncode:
        print(result.stdout,end='')
        print(result.stderr,end='',file=sys.stderr)
        raise SystemExit(f'FAILED: {stem}, return code {result.returncode}')
    print(f'PASS: {stem}')
    return result.stdout


def main():
    if not __debug__:
        raise SystemExit('Run without -O: Python assertions are part of these checks.')
    if not shutil.which('g++'):
        raise SystemExit('A C++17 compiler named g++ is required.')
    try:
        import sympy
    except ImportError:
        raise SystemExit('SymPy is required for the two symbolic checks.')
    LOGS.mkdir(parents=True,exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='cartier_checks_') as tmp:
        binary=Path(tmp)/'degree4'
        run(['g++','-O3','-std=c++17',str(ORIG/'cartier_degree4_certificate.cpp'),'-o',str(binary)],'degree4_compile')
        run([str(binary)],'degree4')
    run([sys.executable,str(ORIG/'cartier_degree5_identities.py')],'degree5')
    result=run([sys.executable,str(NEW/'verify_inputs.py')],'input_checks')
    json.loads(result) # Check that the machine-readable output is well formed.
    (LOGS/'input_checks.json').write_text(result)
    run([sys.executable,str(NEW/'verify_structural_identities.py')],'structural')
    run([sys.executable,str(NEW/'enumerate_pole_layouts.py')],'pole_layouts')
    run([sys.executable,str(NEW/'verify_d3_candidate.py'),'--self-test'],'candidate_verifier_selftest')
    compiler=subprocess.run(['g++','--version'],text=True,capture_output=True,check=True).stdout.splitlines()[0]
    info={
        'python':platform.python_version(),
        'sympy':sympy.__version__,
        'compiler':compiler,
        'all_included_checks_passed':True,
        'degree_four_geometric_candidates':720,
        'degree_four_matches':0,
        'degree_six_pole_layouts_up_to_rotation':126,
        'degree_six_pole_layouts_up_to_dihedral_action':70,
        'global_candidate_supplied':False,
        'unrestricted_decision':'not resolved by this package'
    }
    (LOGS/'run_summary.json').write_text(json.dumps(info,indent=2)+'\n')
    print('All included checks passed. No global candidate or all-degree exclusion is claimed.')


if __name__=='__main__':
    main()
