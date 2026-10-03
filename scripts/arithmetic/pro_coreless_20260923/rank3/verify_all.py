"""Regenerate and verify every computational claim in this bundle.

Run from any directory: python /path/to/rank3_progress_bundle/verify_all.py
Requires Python 3.10+ and NumPy. This performs exact finite-field arithmetic.
"""
from __future__ import annotations
import json
import platform
from pathlib import Path
import subprocess
import sys
import numpy as np

ROOT = Path(__file__).resolve().parent
CERT = ROOT / 'certificates'
LOG = ROOT / 'verification'
LOG.mkdir(exist_ok=True)
STEPS = ['verify_rank3_first_return.py', 'period_two.py',
         'new_progress.py', 'hom_test.py', 'export_portable.py']

def main() -> None:
    transcript = []
    results = []
    for name in STEPS:
        heading = '\n=== ' + name + ' ===\n'
        print(heading, end='', flush=True)
        transcript.append(heading)
        result = subprocess.run([sys.executable, str(CERT / name)], cwd=CERT,
                                capture_output=True, text=True, check=False)
        print(result.stdout, end='', flush=True)
        if result.stderr:
            print(result.stderr, end='', file=sys.stderr)
        transcript.extend([result.stdout, result.stderr])
        results.append({'script': name, 'returncode': result.returncode})
        if result.returncode:
            (LOG / 'verification_log.txt').write_text(''.join(transcript))
            raise SystemExit(result.returncode)
    summary = {'all_steps_passed': True, 'python': platform.python_version(),
               'numpy': np.__version__, 'steps': results,
               'unrestricted_existence_question_decided': False,
               'new_result': 'Geometric rank-ten locus nonempty; explicit stable nowhere-zero-lift candidate has Hom(F^2 R,K)=0.'}
    (LOG / 'verification_log.txt').write_text(''.join(transcript))
    (LOG / 'verification_summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    print('\nAll exact certificate checks passed.')

if __name__ == '__main__':
    main()
