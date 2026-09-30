"""Read-only manifest check and reproduction of all 29 essential JSON outputs.

This verifies exact evidence, not the unresolved source square-locus decision.
The geometric proofs are in REPORT.md and the retained predecessor reports.
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


def check_claim_paths() -> None:
    claims = json.loads((ROOT / 'claims.json').read_text())
    ids = [claim['id'] for claim in claims]
    if len(ids) != len(set(ids)):
        raise RuntimeError('Duplicate claim identifiers.')
    for claim in claims:
        for dependency in claim.get('dependencies', []):
            if dependency not in ids:
                raise RuntimeError('Unknown claim dependency: ' + dependency)
        for evidence in claim.get('evidence', []):
            path = evidence.split('#', 1)[0]
            if not (ROOT / path).is_file():
                raise RuntimeError('Missing claim evidence: ' + path)
    print('Claim-to-evidence paths and dependency identifiers: PASS (' + str(len(claims)) + ' claims)', flush=True)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--skip-manifest', action='store_true',
                        help='Maintainer mode before packaging only')
    args = parser.parse_args()
    if sys.flags.optimize:
        raise RuntimeError('Assertions must be enabled; do not use python -O.')
    previous = [sys.executable, '-B', 'conceptual/src/verify_conceptual.py']
    if args.skip_manifest:
        previous.append('--skip-manifest')
    subprocess.run(previous, cwd=ROOT, check=True)
    check_claim_paths()
    stages = [
        ('intersection/src/critical_cover.py',
         ['intersection/data/critical_nonsquare.json',
          'intersection/evidence/critical_checks.json']),
        ('intersection/src/check_geometry.py',
         ['intersection/data/ambient_geometry.json',
          'intersection/evidence/geometry_checks.json']),
        ('intersection/src/check_hessian.py',
         ['intersection/data/hessian_example.json',
          'intersection/evidence/hessian_checks.json']),
    ]
    count = 0
    with tempfile.TemporaryDirectory(prefix='r9-geometry-verify-') as tmp:
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
            print(script + ': PASS (' + str(len(outputs)) + ' essential JSON files)', flush=True)
    print('New geometry/certificate essential JSON reproduction: PASS (' + str(count) + ' files)', flush=True)
    print('Full verification PASS: 12 baseline + 7 continuation + 4 conceptual + 6 new = 29.', flush=True)
    print('Global critical discriminant: uniformly NONSQUARE on q*(q-<118020>) != 0.', flush=True)
    print('Geometric theorems: supplied proofs, not inferred from diagnostic checks.', flush=True)
    print('Requested moving-ratio residual-square decision: UNRESOLVED.', flush=True)


if __name__ == '__main__':
    main()
