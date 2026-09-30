#!/usr/bin/env python3
"""Rebuild and verify the complete degree-nine nonexistence certificate.

Requirements: Python >=3.10, a C++17 compiler (g++ by default), GMP headers
and library. No network access or computer-algebra-system installation needed.
The archive is read-only during verification; builds use a temporary directory.
"""
from __future__ import annotations
import argparse
import ctypes
import ctypes.util
import hashlib
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
sys.dont_write_bytecode = True
sys.path.insert(0, str(ROOT/'src'))


def manifest_check():
    manifest = ROOT/'SHA256SUMS'
    if not manifest.is_file():
        raise RuntimeError('SHA256SUMS is missing')
    count = 0
    for row in manifest.read_text().splitlines():
        expected, relative = row.split('  ', 1)
        path = ROOT/relative
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
            raise RuntimeError('Manifest mismatch: '+relative)
        count += 1
    print(f'PASS SHA-256 manifest: {count} files', flush=True)


def run(command, label):
    print('\nRUN '+label, flush=True)
    process = subprocess.run(command, cwd=ROOT, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT, text=True)
    print(process.stdout, end='', flush=True)
    if process.returncode:
        raise RuntimeError(f'{label} failed with exit status {process.returncode}')


def same(actual, expected):
    if actual.read_bytes() != expected.read_bytes():
        raise RuntimeError('Rebuilt certificate differs: '+expected.name)
    print('PASS exact rebuilt certificate: '+expected.name, flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--manifest-only', action='store_true')
    parser.add_argument('--skip-manifest', action='store_true',
                        help='archive assembly only; all mathematical checks still run')
    args = parser.parse_args()
    started = time.monotonic()
    print('Degree-nine Cartier-line boundary: COMPLETE NEGATIVE DECISION', flush=True)
    print('Python:', platform.python_version(), platform.python_implementation(), flush=True)
    if not args.skip_manifest:
        manifest_check()
    if args.manifest_only:
        return
    compiler = os.environ.get('CXX', 'g++')
    run([compiler, '--version'], 'compiler version')
    try:
        library = ctypes.CDLL(ctypes.util.find_library('gmp'))
        print('GMP:', ctypes.c_char_p.in_dll(library, '__gmp_version').value.decode(), flush=True)
    except (OSError, ValueError, TypeError):
        print('GMP version introspection unavailable; compilation/linking remains required.', flush=True)
    # The historical stage has its own complete manifest and verifier. Its
    # historical "partial" status is superseded by the subsequent checks.
    run([sys.executable, str(ROOT/'prior_stage/verify.py')],
        'historical coefficient reduction and retained certificates')
    from cross_checks import normalized_input_bytes, run_checks
    data, *_ = normalized_input_bytes()
    if data != (ROOT/'inputs/norm_input.txt').read_bytes():
        raise RuntimeError('Norm input differs from the certified three-dimensional kernel')
    print('PASS exact normalized input reconstructed from all coefficient data', flush=True)
    with tempfile.TemporaryDirectory(prefix='degree9-cartier-verify-') as temp:
        build = Path(temp)
        names = ['build_norm', 'build_square_equations', 'build_resultants',
                 'build_bezout', 'build_exceptional']
        for name in names:
            run([compiler, '-O3', '-std=c++17', str(ROOT/'src'/f'{name}.cpp'),
                 '-lgmp', '-o', str(build/name)], 'compile '+name)
        jobs = [
            ('build_norm', [ROOT/'inputs/norm_input.txt', build/'norm_poly.txt', '115'], 'norm_poly.txt'),
            ('build_square_equations', [build/'norm_poly.txt', build/'square_equations.txt'], 'square_equations.txt'),
            ('build_resultants', [build/'square_equations.txt', build/'generic_resultants.txt'], 'generic_resultants.txt'),
            ('build_bezout', [build/'generic_resultants.txt', build/'bezout_generic.txt'], 'bezout_generic.txt'),
            ('build_exceptional', [build/'norm_poly.txt', build/'square_equations.txt',
                                   build/'exceptional_resultant.txt'], 'exceptional_resultant.txt')]
        for name, arguments, target in jobs:
            run([str(build/name), *map(str, arguments)], name)
            same(build/target, ROOT/'certificates'/target)
    summary = run_checks()
    print('PASS independent Python norm evaluations:', summary['independent_norm_points'], flush=True)
    print('PASS formal-degree-drop cases:', summary['formal_degree_drop_discriminants_checked'], flush=True)
    print('PASS exceptional Bezout identity and odd-degree branch', flush=True)
    print('PASS all four support choices by the verified coefficientwise Frobenius transfer', flush=True)
    print('RESULT: NO actual witness (2)-(3) exists in the stated degree-nine boundary.', flush=True)
    print('No geometric parameter or required condition remains undecided within this task.', flush=True)
    print(f'ALL MATHEMATICAL CHECKS PASSED ({time.monotonic()-started:.3f} seconds in this run).', flush=True)


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, AssertionError, RuntimeError) as error:
        print('VERIFICATION FAILED:', error, file=sys.stderr)
        raise SystemExit(1)
