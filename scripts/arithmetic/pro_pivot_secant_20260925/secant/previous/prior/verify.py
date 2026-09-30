#!/usr/bin/env python3
"""Verify the archive's partial results; this does not decide the curve locus."""
import argparse
import hashlib
import os
import platform
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))

def check_manifest(required=True):
    path = ROOT/'MANIFEST.sha256'
    if not path.exists():
        if required:
            raise RuntimeError('MANIFEST.sha256 is missing.')
        return
    count = 0
    for line in path.read_text().splitlines():
        digest,rel = line.split('  ',1)
        target = (ROOT/rel).resolve()
        if ROOT not in target.parents:
            raise RuntimeError('Manifest path escapes archive: '+rel)
        actual = hashlib.sha256(target.read_bytes()).hexdigest()
        if actual != digest:
            raise RuntimeError('SHA-256 mismatch: '+rel)
        count += 1
    print(f'PASS SHA-256 manifest: {count} files (manifest excludes itself).',flush=True)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--manifest-only',action='store_true')
    ap.add_argument('--skip-manifest',action='store_true',
                    help='For the initial packaging run only; normal users should not need this.')
    args = ap.parse_args()
    if not args.skip_manifest:
        check_manifest()
    if args.manifest_only:
        return
    print('Verification scope: partial results, not a geometric existence decision.',flush=True)
    print('Python:',sys.version.replace('\n',' '),flush=True)
    print('Platform:',platform.platform(),flush=True)
    from algebra_checks import run
    run(ROOT)
    sys.stdout.flush()
    compiler = os.environ.get('CXX','g++')
    if not shutil.which(compiler):
        raise RuntimeError('A C++17 compiler is required; set CXX or install g++.')
    version = subprocess.check_output([compiler,'--version'],text=True).splitlines()[0]
    print('Compiler:',version,flush=True)
    with tempfile.TemporaryDirectory(prefix='klein_four_verify_') as temp:
        exe = Path(temp)/'fourier_checks'
        command = [compiler,'-O3','-std=c++17','-Wall','-Wextra','-pedantic',
                   str(ROOT/'src/fourier_checks.cpp'),'-o',str(exe)]
        print('Compiling exact Fourier checker with -O3 -std=c++17 -Wall -Wextra -pedantic.',flush=True)
        subprocess.run(command,check=True)
        subprocess.run([str(exe)],check=True)
        regenerated = Path(temp)/'affine_bezout.json'
        subprocess.run([sys.executable,str(ROOT/'src/make_affine_certificate.py'),
                        '--output',str(regenerated)],check=True)
        if regenerated.read_bytes() != (ROOT/'data/affine_bezout.json').read_bytes():
            raise RuntimeError('Regenerated affine certificate differs from retained exact data.')
        print('PASS byte-for-byte independent affine certificate regeneration.',flush=True)
    from profile_bounds import verify_bounds
    verify_bounds(ROOT/'data/profile_outer_bounds.csv')
    print('PASS ALL EXECUTED CHECKS. The non-affine geometric existence question remains OPEN.',flush=True)

if __name__ == '__main__':
    try:
        main()
    except Exception as exc:
        print('VERIFICATION FAILED:',exc,file=sys.stderr)
        raise
