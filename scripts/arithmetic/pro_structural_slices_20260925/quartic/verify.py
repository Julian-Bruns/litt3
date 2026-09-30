#!/usr/bin/env python3
"""Verify all retained certificates and regenerate exact data, entirely offline.

Usage:
    python3 verify.py                 # manifest + full exact verification
    python3 verify.py --manifest-only # file-integrity check only
    python3 verify.py --checks-only   # full mathematics; skip manifest for archive builds

No files in the archive are changed. Compilers and generators run in a temporary
copy. Python assertions and C++ assertions must remain enabled.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import shutil
import subprocess
import sys
import tempfile
import time

sys.dont_write_bytecode = True
ROOT = Path(__file__).resolve().parent
DATA_FILES = [
    'field.json', 'signature.json', 'signature_polys.txt',
    'signature_resultant.txt', 'signature_clean.json', 'signature_clean.txt',
    'signature_partner.txt', 'signature_partner.txt.bezout',
    'scalar_subfield_certificate.txt', 'boundary_certificates.json',
]


def manifest_check() -> None:
    manifest = ROOT / 'MANIFEST.sha256'
    if not manifest.is_file():
        raise RuntimeError('MANIFEST.sha256 is missing; --checks-only is for archive builds.')
    seen = set()
    for number, line in enumerate(manifest.read_text().splitlines(), 1):
        if not line:
            continue
        if len(line) < 67 or line[64:66] != '  ':
            raise RuntimeError(f'Malformed manifest line {number}')
        expected, name = line[:64], line[66:]
        rel = Path(name)
        if rel.is_absolute() or '..' in rel.parts or name in seen:
            raise RuntimeError(f'Unsafe or duplicate manifest path: {name}')
        seen.add(name)
        file = ROOT / rel
        if not file.is_file() or file.is_symlink():
            raise RuntimeError(f'Missing file, or disallowed symlink: {name}')
        actual = hashlib.sha256(file.read_bytes()).hexdigest()
        if actual != expected:
            raise RuntimeError(f'SHA-256 mismatch: {name}')
    actual_files = {
        p.relative_to(ROOT).as_posix()
        for p in ROOT.rglob('*')
        if p.is_file() and p.name != 'MANIFEST.sha256'
        and '__pycache__' not in p.parts
    }
    if actual_files != seen:
        raise RuntimeError(f'Manifest coverage differs: {sorted(actual_files ^ seen)}')
    print(f'SHA-256 manifest: PASS ({len(seen)} files)', flush=True)


def run(command: list[str], cwd: Path) -> None:
    print('\n$ ' + shlex.join(command), flush=True)
    env = dict(os.environ, PYTHONDONTWRITEBYTECODE='1')
    subprocess.run(command, cwd=cwd, env=env, check=True)


def data_equal(left: Path, right: Path) -> bool:
    if left.suffix == '.json':
        return json.loads(left.read_text()) == json.loads(right.read_text())
    # Polynomial record files have whitespace-independent integer syntax.
    return [int(x) for x in left.read_text().split()] == [int(x) for x in right.read_text().split()]


def full_check() -> None:
    compiler = shlex.split(os.environ.get('CXX', 'g++'))
    if not compiler or shutil.which(compiler[0]) is None:
        raise RuntimeError('A C++17 compiler is required. Install g++ or set CXX.')
    print('Python:', platform.python_version(), flush=True)
    run(compiler + ['--version'], ROOT)
    with tempfile.TemporaryDirectory(prefix='galois-quartic-verification-') as tmp:
        work = Path(tmp)
        shutil.copytree(ROOT / 'src', work / 'src', ignore=shutil.ignore_patterns('__pycache__', '*.pyc'))
        shutil.copytree(ROOT / 'data', work / 'data')
        bins = work / 'bin'
        bins.mkdir()
        for name in ['check_certificates', 'resultant', 'quotient', 'scalar_subfield']:
            run(compiler + ['-O3', '-std=c++17', '-Wall', '-Wextra', '-UNDEBUG',
                            str(work / 'src' / (name + '.cpp')), '-o', str(bins / name)], work)
        print('\nDIRECT VERIFICATION OF RETAINED CERTIFICATES', flush=True)
        run([str(bins / 'check_certificates'), str(work / 'data')], work)
        run([sys.executable, str(work / 'src' / 'check_jets.py')], work)

        print('\nREGENERATION FROM P, A AND FIELD CONVENTIONS', flush=True)
        for name in DATA_FILES:
            (work / 'data' / name).unlink()
        run([sys.executable, str(work / 'src' / 'signature.py')], work)
        run([str(bins / 'resultant'), str(work / 'data/signature_polys.txt'),
             str(work / 'data/signature_resultant.txt')], work)
        run([sys.executable, str(work / 'src' / 'clean_resultant.py')], work)
        run([str(bins / 'quotient'), str(work / 'data/signature_polys.txt'),
             str(work / 'data/signature_clean.txt'), str(work / 'data/signature_partner.txt')], work)
        run([str(bins / 'scalar_subfield'), str(work / 'data/signature_partner.txt'),
             str(work / 'data/scalar_subfield_certificate.txt')], work)
        run([sys.executable, str(work / 'src' / 'boundary.py')], work)
        run([sys.executable, str(work / 'src' / 'check_jets.py')], work)
        run([str(bins / 'check_certificates'), str(work / 'data')], work)
        for name in DATA_FILES:
            if not data_equal(ROOT / 'data' / name, work / 'data' / name):
                raise RuntimeError(f'Regenerated data mismatch: {name}')
            print('Exact data comparison: PASS', name, flush=True)
    print('\nALL EXACT ALGEBRA CHECKS: PASS', flush=True)
    print('Scope: the certified finite invariants and cyclic exclusion in REPORT.md.', flush=True)
    print('This does not decide the remaining V4 existence problem.', flush=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--manifest-only', action='store_true')
    group.add_argument('--checks-only', action='store_true')
    args = parser.parse_args()
    if not __debug__:
        parser.error('Do not use Python -O: the certificate scripts use assertions.')
    start = time.monotonic()
    try:
        if not args.checks_only:
            manifest_check()
        else:
            print('Manifest skipped explicitly (--checks-only).', flush=True)
        if not args.manifest_only:
            full_check()
        print(f'VERIFICATION SUCCESS; elapsed {time.monotonic()-start:.2f} seconds', flush=True)
        return 0
    except (OSError, ValueError, RuntimeError, subprocess.CalledProcessError) as exc:
        print('VERIFICATION FAILED:', exc, file=sys.stderr, flush=True)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
