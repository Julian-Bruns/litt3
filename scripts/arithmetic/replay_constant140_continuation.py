#!/usr/bin/env python3
"""Replay the received global residual computation, retaining restart artifacts.

This verifies expansion and square-circuit identities, not square-locus emptiness.
The original theorem-only replay is separate and need not be repeated here.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--work', type=Path, required=True)
    args = parser.parse_args()
    archive, work = args.archive.resolve(), args.work.resolve()
    assert work != archive and not work.is_relative_to(archive)
    work.mkdir(parents=True, exist_ok=True)
    for name in ('src', 'inputs', 'evidence'):
        shutil.copytree(archive / name, work / name, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('__pycache__', '*.pyc'))
    (work / 'build').mkdir(exist_ok=True)
    env = os.environ.copy()
    include = Path('/opt/homebrew/include')
    lib = Path('/opt/homebrew/lib')
    if include.is_dir():
        env['CPLUS_INCLUDE_PATH'] = str(include) + os.pathsep + env.get('CPLUS_INCLUDE_PATH', '')
    if lib.is_dir():
        env['LIBRARY_PATH'] = str(lib) + os.pathsep + env.get('LIBRARY_PATH', '')
    commands = [
        ['g++', '-O3', '-std=c++17', 'src/expand.cpp', '-o', 'build/expand'],
        ['build/expand', str(work), 'resultant-only'],
        ['g++', '-O3', '-std=c++17', 'src/fast_expand.cpp', '-lgmp', '-lz', '-o', 'build/fast_expand'],
        ['build/fast_expand', str(work), 'test'],
        ['build/fast_expand', str(work)],
        ['build/fast_expand', str(work)],
        ['g++', '-O3', '-std=c++17', 'src/evaluate_full.cpp', '-o', 'build/evaluate_full'],
        ['build/evaluate_full', str(work), 'inputs/full_validation_triples.txt'],
        [sys.executable, 'src/verify_full.py'],
        [sys.executable, 'src/inspect_full.py'],
        [sys.executable, 'src/complete_square.py'],
    ]
    summary = {'status': 'running', 'archive': str(archive), 'work': str(work),
               'scope': 'Exact full expansion and complete-square circuit, not a geometric decision.',
               'python': sys.version, 'steps': []}
    def save():
        (work / 'replay_summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    save()
    for i, command in enumerate(commands):
        start = time.monotonic()
        print('RUN', ' '.join(command), flush=True)
        log = work / ('build/full_evaluations.txt' if i == 7 else f'build/replay_{i:02}.log')
        with log.open('w') as output:
            result = subprocess.run(command, cwd=work, env=env, stdout=output, stderr=subprocess.STDOUT)
        summary['steps'].append({'command': command, 'returncode': result.returncode,
                                 'seconds': time.monotonic() - start, 'log': str(log)})
        if result.returncode:
            summary['status'] = 'failed'; save()
            raise RuntimeError(f'Failed: {command}; see {log}')
        save()
    digest = hashlib.sha256((work / 'build/Rcal.bin').read_bytes()).hexdigest()
    assert digest == '436fae7b0bb93fb03e40e2b6c66507440569ebd591bdf988acc40b47593fecf2'
    for name in ('full_expansion_checks.json', 'full_support_summary.json',
                 'complete_square_circuit.json', 'complete_square_checks.json'):
        actual = json.loads((work / 'evidence' / name).read_text())
        expected = json.loads((archive / 'evidence' / name).read_text())
        if isinstance(actual, dict): actual.pop('seconds', None)
        if isinstance(expected, dict): expected.pop('seconds', None)
        assert actual == expected, name
    summary.update(status='passed', residual_sha256=digest, frozen_certificates_matched=4)
    save()
    print('PASS full residual and circuit; geometric square decision remains open.', flush=True)


if __name__ == '__main__':
    main()
