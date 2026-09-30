"""Read-only reproduction of all 31 essential outputs and manifest coverage.

This verifies the evidence, not the unresolved original source decision.
"""
from __future__ import annotations
import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'src'))
from verify_all import canonical


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--skip-manifest', action='store_true',
                        help='Maintainer mode before intentional packaging only')
    args = parser.parse_args()
    if sys.flags.optimize:
        raise RuntimeError('Assertions must be enabled; do not use python -O.')
    command = [sys.executable, '-B', 'intersection/src/verify_intersection.py']
    if args.skip_manifest:
        command.append('--skip-manifest')
    subprocess.run(command, cwd=ROOT, check=True)
    stages = [
        ('global/src/check_infinity.py', ['global/data/infinity_factor.json']),
        ('global/src/check_countermodel.py', ['global/data/countermodel.json']),
    ]
    with tempfile.TemporaryDirectory(prefix='r9-global-verify-') as tmp:
        work = Path(tmp) / 'archive'
        shutil.copytree(ROOT, work, ignore=shutil.ignore_patterns('__pycache__'))
        for script, outputs in stages:
            print('Running ' + script, flush=True)
            result = subprocess.run([sys.executable, '-B', script], cwd=work,
                                    capture_output=True, text=True)
            if result.returncode:
                raise RuntimeError(result.stdout + '\n' + result.stderr)
            for path in outputs:
                expected = canonical(json.loads((ROOT / path).read_text()))
                actual = canonical(json.loads((work / path).read_text()))
                if expected != actual:
                    raise RuntimeError('Reproduction mismatch: ' + path)
            print(script + ': PASS (1 essential JSON file)', flush=True)
    print('Full verification PASS: 29 retained + 2 new = 31 essential outputs.', flush=True)
    print('New global infinity factor: exact and verified.', flush=True)
    print('Finite projection and length bound: proved in REPORT.md, not computed from samples.', flush=True)
    print('Comparison family: NOT the prescribed source.', flush=True)
    print('Requested moving-ratio square decision: UNRESOLVED.', flush=True)


if __name__ == '__main__':
    main()
