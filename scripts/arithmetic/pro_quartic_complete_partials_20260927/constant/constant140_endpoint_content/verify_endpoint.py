#!/usr/bin/env python3
"""Regenerate and independently verify the new endpoint-content certificates.

This proves the stated complete incidence exclusions, not the full square-locus
decision. The full verify.py also reconstructs both retained coefficient inputs.
"""
from pathlib import Path
import hashlib
import json
import os
import platform
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent


def sha(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(1 << 20), b''):
            h.update(block)
    return h.hexdigest()


def main() -> None:
    os.chdir(ROOT)
    cxx = shutil.which('c++') or shutil.which('g++')
    if not cxx:
        raise RuntimeError('A C++17 compiler is required.')
    build = ROOT / 'build/endpoint_check'
    build.mkdir(parents=True, exist_ok=True)
    (ROOT / 'regenerated').mkdir(exist_ok=True)
    steps = []

    def run(name: str, command: list[str]) -> None:
        start = time.monotonic()
        with (build / (name + '.log')).open('w') as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log,
                                    stderr=subprocess.STDOUT, text=True)
        steps.append({'name': name, 'command': command, 'returncode': result.returncode,
                      'seconds': round(time.monotonic() - start, 3)})
        if result.returncode:
            raise RuntimeError(f'{name} failed; see build/endpoint_check/{name}.log')
        print('PASS', name, flush=True)

    expected = json.loads((ROOT / 'inputs/expected.json').read_text())
    wanted = {'E_records.tsv', 'ratio_source.json'}
    for row in expected['files'].values():
        filename = row['regenerated_filename']
        if filename in wanted:
            if sha(ROOT / 'inputs' / filename) != row['sha256']:
                raise RuntimeError('Source-provenance hash mismatch: ' + filename)
            wanted.remove(filename)
    if wanted:
        raise RuntimeError('Missing source-provenance hashes: ' + ', '.join(sorted(wanted)))

    run('export_ratio', [sys.executable, 'content/export_ratio.py'])
    run('universal_endpoint_identities', [sys.executable, 'content/check_local_identities.py'])
    for name in ['double_content', 'high_content', 'critical_incidence', 'check_certificates']:
        run('compile_' + name,
            [cxx, '-O3', '-std=c++17', '-Wall', '-Wextra',
             'content/' + name + '.cpp', '-o', 'build/endpoint_check/' + name])
    run('six_global_incidence_algebras', ['build/endpoint_check/double_content'])
    run('all_higher_content_candidates', ['build/endpoint_check/high_content'])
    run('small_common_critical_incidence', ['build/endpoint_check/critical_incidence'])
    run('independent_stored_certificate_replay',
        ['build/endpoint_check/check_certificates', 'certificates/endpoint_content'])

    checked = {}
    rows = json.loads((ROOT / 'inputs/endpoint_expected.json').read_text())['files']
    for name, row in rows.items():
        if sha(ROOT / row['regenerated_path']) != row['sha256']:
            raise RuntimeError('Regenerated certificate mismatch: ' + name)
        if 'stored_path' in row and sha(ROOT / row['stored_path']) != row['sha256']:
            raise RuntimeError('Stored certificate mismatch: ' + name)
        checked[name] = row['sha256']
    import sympy
    report = {
        'status': 'PASS', 'global_square_locus': 'UNRESOLVED',
        'scope': ('Complete exclusions on six degree-15 marked endpoint incidence algebras, '
                  '12 linear and three quadratic scale factor algebras with unit C71; '
                  'exact nilpotent-sensitive local identities and three-equation '
                  'common-critical presentation. The 64 additional substitution fixtures '
                  'are bounded implementation checks only.'),
        'python': platform.python_version(), 'sympy': sympy.__version__,
        'compiler': subprocess.check_output([cxx, '--version'], text=True).splitlines()[0],
        'steps': steps, 'exact_hash_count': len(checked), 'exact_hashes': checked,
    }
    (build / 'summary.json').write_text(json.dumps(report, indent=2) + '\n')
    print(f'ENDPOINT VERIFICATION PASS: {len(checked)} exact regenerated-output hashes; '
          'GLOBAL SQUARE LOCUS UNRESOLVED.', flush=True)


if __name__ == '__main__':
    try:
        main()
    except Exception as exc:
        print('ENDPOINT VERIFICATION FAILED:', exc, file=sys.stderr)
        sys.exit(1)
