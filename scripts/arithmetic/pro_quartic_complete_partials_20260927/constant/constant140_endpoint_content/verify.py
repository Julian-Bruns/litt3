#!/usr/bin/env python3
"""Replay the exact retained and new certificates, not a square-locus decision."""
from __future__ import annotations
import argparse
import hashlib
import json
import os
import platform
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
BUILD = ROOT / 'build'
REGEN = ROOT / 'regenerated'
LOGS = BUILD / 'logs'

def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--core-only', action='store_true',
                        help='Rebuild source and new results; omit replay of the retained degree-45 certificate.')
    args = parser.parse_args()
    os.chdir(ROOT)
    for p in (BUILD, REGEN, LOGS):
        p.mkdir(exist_ok=True)
    cxx = shutil.which('c++') or shutil.which('g++')
    if not cxx:
        raise RuntimeError('A C++17 compiler with OpenMP is required.')
    steps: list[dict] = []
    checked: dict[str, str] = {}

    def run(name: str, command: list[str]) -> None:
        start = time.monotonic()
        with (LOGS / (name + '.log')).open('w') as log:
            p = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT, text=True)
        steps.append({'name': name, 'command': command, 'returncode': p.returncode,
                      'seconds': round(time.monotonic() - start, 3)})
        if p.returncode:
            print((LOGS / (name + '.log')).read_text(), file=sys.stderr)
            raise RuntimeError(f'{name} failed; see build/logs/{name}.log')
        print('PASS', name, flush=True)

    def compile_one(name: str, source: str, omp: bool = False) -> None:
        command = [cxx, '-O3', '-std=c++17', '-Wall', '-Wextra']
        if omp:
            command.append('-fopenmp')
        run('compile_' + name, command + [source, '-o', 'build/' + name])

    def check_expected(name: str, path: str, expected: str) -> None:
        actual = sha256(ROOT / path)
        if actual != expected:
            raise RuntimeError(f'Exact hash mismatch: {name}: {actual} != {expected}')
        checked[name] = actual
        print('PASS exact_hash_' + name, flush=True)

    for exe, source in [('source', 'main.cpp'), ('symbolic', 'symbolic.cpp'),
                        ('compact', 'compact.cpp'), ('rationalized', 'rationalized.cpp')]:
        compile_one(exe, 'src/' + source)
    run('source_build', ['build/source', 'build', 'regenerated/source_affine.dat'])
    run('symbolic_chart', ['build/symbolic', 'regenerated/source_affine.dat', 'regenerated/chart_laurent.json'])
    run('bounded_source_checks', ['build/source', 'check', 'regenerated/source_affine.dat'])
    run('compact_reconstruction', ['build/compact', 'build', 'regenerated/source_affine.dat', 'regenerated/E_records.tsv'])
    run('global_changes', [sys.executable, 'src/check_global_changes.py', '--output', 'regenerated/ratio_source.json'])
    run('rationalized_model', ['build/rationalized', 'regenerated/E_records.tsv', 'regenerated/T_records.tsv', 'regenerated/source_affine.dat'])
    run('universal_polynomial_identities', [sys.executable, 'src/check_resultant_identity.py'])
    expected = json.loads((ROOT / 'inputs/expected.json').read_text())
    for key, row in expected['files'].items():
        check_expected(key, 'regenerated/' + row['regenerated_filename'], row['sha256'])
        stored = ROOT / 'inputs' / row['regenerated_filename']
        if stored.exists() and sha256(stored) != row['sha256']:
            raise RuntimeError('Stored input differs from exact reconstruction: ' + key)

    run('global_scale_frontier', [sys.executable, 'forward/check_scale_bound.py', 'regenerated/scale_bound.json'])
    compile_one('pole_certificate', 'forward/pole_certificate.cpp', True)
    compile_one('check_pade', 'forward/check_pade.cpp')
    compile_one('check_pole', 'forward/check_pole.cpp', True)
    run('global_pole_certificate', ['build/pole_certificate', 'regenerated/E_records.tsv', 'regenerated/pole_rank.dat'])
    run('stored_pole_bezout', ['build/pole_certificate', 'verify', 'certificates/pole_rank.dat'])
    run('direct_pole_check', ['build/check_pole', 'regenerated/E_records.tsv', 'certificates/pole_rank.dat'])
    run('pade_checks', ['build/check_pade', 'regenerated/E_records.tsv'])
    forward_expected = json.loads((ROOT / 'inputs/forward_expected.json').read_text())
    for key, row in forward_expected['files'].items():
        check_expected(key, row['regenerated_path'], row['sha256'])
    if sha256(ROOT / 'certificates/pole_rank.dat') != sha256(REGEN / 'pole_rank.dat'):
        raise RuntimeError('Stored pole certificate differs from regeneration.')

    if not args.core_only:
        run('degree47_identity', [sys.executable, 'strategy/check_degree47.py', 'regenerated/degree47_certificate.json'])
        run('leading_support', [sys.executable, 'strategy/check_support.py'])
        for exe in ['rank2_frontier', 'rank3_frontier', 'minor_elimination', 'rank_candidates',
                    'check_rank_candidates', 'check_leading_rows', 'check_rank3_rows']:
            compile_one(exe, 'strategy/' + exe + '.cpp', exe == 'minor_elimination')
        for rank in (2, 3):
            prefix = 'build/rank' + str(rank)
            run(f'rank{rank}_rows', [prefix + '_frontier', 'regenerated/E_records.tsv', prefix])
            run(f'rank{rank}_resultants', ['build/minor_elimination', prefix + '_minors.dat', prefix + '_resultant', '3'])
            run(f'rank{rank}_radical', ['build/rank_candidates', prefix])
            run(f'rank{rank}_quotient', ['build/check_rank_candidates', prefix + '_minors.dat',
                                       prefix + '_candidate_radical.dat', prefix + '_resultant_current_open_gcd.dat'])
        run('bounded_rank2_rows', ['build/check_leading_rows'])
        run('bounded_rank3_rows', ['build/check_rank3_rows'])
        retained_expected = json.loads((ROOT / 'inputs/retained_expected.json').read_text())
        for key, row in retained_expected['files'].items():
            check_expected(key, row['regenerated_path'], row['sha256'])

    for exe in ['check_discriminant', 'profile_discriminant', 'check_content', 'check_power', 'check_simple_content']:
        compile_one(exe, 'discriminant/' + exe + '.cpp', True)
    run('exact_discriminant_identities', ['build/check_discriminant', 'regenerated/E_records.tsv',
                                         'regenerated/discriminant'])
    profile_files = ['regenerated/discriminant/' + name + '_discriminant.dat'
                     for name in ['H1_q3', 'H5_q15625', 'H31_q48151']]
    run('exact_discriminant_squarefree_profiles', ['build/profile_discriminant'] + profile_files)
    run('bounded_content_fixtures', ['build/check_content'])
    run('exact_power_fixtures', ['build/check_power'])
    run('simple_content_fixture', ['build/check_simple_content'])
    disc_expected = json.loads((ROOT / 'inputs/discriminant_expected.json').read_text())
    for key, row in disc_expected['files'].items():
        check_expected(key, row['regenerated_path'], row['sha256'])
        if sha256(ROOT / row['stored_path']) != row['sha256']:
            raise RuntimeError('Stored discriminant output mismatch: ' + key)

    run('endpoint_ratio_export', [sys.executable, 'content/export_ratio.py'])
    run('universal_endpoint_identities', [sys.executable, 'content/check_local_identities.py'])
    for exe in ['double_content', 'high_content', 'critical_incidence', 'check_certificates']:
        compile_one('endpoint_' + exe, 'content/' + exe + '.cpp')
    run('six_global_endpoint_incidence_algebras', ['build/endpoint_double_content'])
    run('all_higher_content_scale_candidates', ['build/endpoint_high_content'])
    run('small_common_critical_incidence', ['build/endpoint_critical_incidence'])
    run('independent_endpoint_certificate_replay',
        ['build/endpoint_check_certificates', 'certificates/endpoint_content'])
    endpoint_expected = json.loads((ROOT / 'inputs/endpoint_expected.json').read_text())
    for key, row in endpoint_expected['files'].items():
        check_expected(key, row['regenerated_path'], row['sha256'])
        if 'stored_path' in row and sha256(ROOT / row['stored_path']) != row['sha256']:
            raise RuntimeError('Stored endpoint output mismatch: ' + key)

    import sympy
    summary = {
        'status': 'PASS', 'global_square_locus': 'UNRESOLVED',
        'mode': 'core-only' if args.core_only else 'full',
        'scope': ('Complete source reconstruction, global pole-rank certificate, written twelve-scale bound, '
                  'scheme-equivalent two-auxiliary square presentation with bounded implementation checks; new exact discriminant identities, profiles, content fixtures, power fixtures, and simple-content fixture; complete new endpoint higher-content exclusions, independent unit-certificate replay, universal local identities, and exact common-critical presentation' +
                  ('.' if args.core_only else ', and full retained degree-45 scale-algebra replay.')),
        'python': platform.python_version(), 'sympy': sympy.__version__,
        'compiler': subprocess.check_output([cxx, '--version'], text=True).splitlines()[0],
        'steps': steps, 'exact_regenerated_hashes': checked,
        'exact_regenerated_hash_count': len(checked),
    }
    (BUILD / 'verification_summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(f'VERIFICATION PASS: {len(checked)} exact regenerated-output hashes; GLOBAL SQUARE LOCUS UNRESOLVED.', flush=True)

if __name__ == '__main__':
    try:
        main()
    except Exception as exc:
        print('VERIFICATION FAILED:', exc, file=sys.stderr)
        sys.exit(1)
