"""Read-only reproduction of all 23 essential JSON files, including prior work."""
from __future__ import annotations
import argparse
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'src'))
from verify_all import canonical


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--skip-manifest', action='store_true',
                        help='Maintainer mode before packaging only')
    args = parser.parse_args()
    if sys.flags.optimize:
        raise RuntimeError('Assertions must be enabled; do not use python -O.')
    previous = [sys.executable, '-B', 'continuation/src/verify_continuation.py']
    if args.skip_manifest:
        previous.append('--skip-manifest')
    subprocess.run(previous, cwd=ROOT, check=True)
    stages = [
        ('conceptual/src/check_universal.py',
         ['conceptual/evidence/universal_checks.json']),
        ('conceptual/src/check_concepts.py',
         ['conceptual/evidence/concept_checks.json',
          'conceptual/data/diagnostic_upstairs.json',
          'conceptual/data/ambient_example.json']),
    ]
    count = 0
    with tempfile.TemporaryDirectory(prefix='r9-conceptual-verify-') as tmp:
        work = Path(tmp) / 'archive'
        shutil.copytree(ROOT, work, ignore=shutil.ignore_patterns('__pycache__'))
        for script, outputs in stages:
            print('Running ' + script, flush=True)
            result = subprocess.run([sys.executable, '-B', script], cwd=work,
                                    capture_output=True, text=True)
            if result.returncode:
                raise RuntimeError(result.stdout + '\n' + result.stderr)
            for relative in outputs:
                expected = canonical(json.loads((ROOT / relative).read_text()))
                actual = canonical(json.loads((work / relative).read_text()))
                if expected != actual:
                    raise RuntimeError('Reproduction mismatch: ' + relative)
            count += len(outputs)
            print(script + ': PASS (' + str(len(outputs)) +
                  ' essential JSON files)', flush=True)
    print('Conceptual essential JSON reproduction: PASS (' + str(count) + ' files)', flush=True)
    print('Full verification PASS: 12 baseline + 7 continuation + 4 conceptual = 23.', flush=True)
    print('Theoretical component and normalization results are proved in conceptual/BASELINE_REPORT.md;', flush=True)
    print('they are not inferred from these diagnostic checks.', flush=True)
    print('Requested moving-ratio square decision: UNRESOLVED.', flush=True)


if __name__ == '__main__':
    main()
