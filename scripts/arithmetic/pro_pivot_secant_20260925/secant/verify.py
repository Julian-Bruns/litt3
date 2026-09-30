#!/usr/bin/env python3
"""Verify certified partial results, NOT emptiness or an actual geometric model."""
import argparse
import csv
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
sys.dont_write_bytecode = True
sys.path.insert(0, str(ROOT/'src'))


def check_manifest():
    manifest = ROOT/'MANIFEST.sha256'
    if not manifest.is_file():
        raise RuntimeError('missing MANIFEST.sha256')
    listed = set()
    for line in manifest.read_text().splitlines():
        digest, relative = line.split('  ',1)
        target = (ROOT/relative).resolve()
        if ROOT not in target.parents:
            raise RuntimeError('unsafe manifest path: '+relative)
        if relative in listed:
            raise RuntimeError('duplicate manifest entry: '+relative)
        if hashlib.sha256(target.read_bytes()).hexdigest() != digest:
            raise RuntimeError('SHA-256 mismatch: '+relative)
        listed.add(relative)
    actual = {str(p.relative_to(ROOT)) for p in ROOT.rglob('*') if p.is_file()
              and p != manifest and '__pycache__' not in p.parts}
    if actual != listed:
        raise RuntimeError('manifest coverage mismatch: '+str(actual ^ listed))
    print(f'PASS complete SHA-256 manifest: {len(listed)} files.',flush=True)


def check_profile_comparison():
    def table(path):
        with path.open() as stream:
            return {int(r['n']):int(r['genus_outer_bound']) for r in csv.DictReader(stream)}
    old = table(ROOT/'previous/prior/data/profile_outer_bounds.csv')
    new = table(ROOT/'data/profile_outer_bounds.csv')
    changes = [{'n':n,'previous_genus_bound':old[n],'new_genus_bound':new[n]}
               for n in new if old[n] != new[n]]
    expected = {'scope':'Relaxed necessary integer profiles, not geometric realizability',
                'improved_degrees':changes}
    assert json.loads((ROOT/'data/profile_comparison.json').read_text()) == expected
    assert len(changes) == 19
    assert all(row['new_genus_bound'] == row['previous_genus_bound']-1 for row in changes)
    assert [row['n'] for row in changes] == list(range(15,52,2))
    print('PASS exact profile comparison: genus outer bounds improve by one at 19 odd degrees, 15 through 51.')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--manifest-only',action='store_true')
    parser.add_argument('--new-only',action='store_true',help='Do not replay preserved earlier verifiers.')
    parser.add_argument('--skip-manifest',action='store_true',help='Archive assembly only.')
    args = parser.parse_args()
    if not args.skip_manifest:
        check_manifest()
    if args.manifest_only:
        return
    print('STATUS: PARTIAL. The geometric existence question remains UNRESOLVED.',flush=True)
    print('Python:',sys.version.replace('\n',' '),flush=True)
    print('Platform:',platform.platform(),flush=True)
    from variational_checks import run as formal
    from secant_checks import run as local
    from profile_bounds_new import verify_bounds
    formal()
    local()
    verify_bounds(ROOT/'data/profile_outer_bounds.csv')
    check_profile_comparison()
    sys.stdout.flush()
    with tempfile.TemporaryDirectory(prefix='k4_secant_data_') as directory:
        regenerated = Path(directory)/'secant_certificates.json'
        subprocess.run([sys.executable,'-B',str(ROOT/'src/secant_checks.py'),
                        '--write-data',str(regenerated)],check=True)
        assert regenerated.read_bytes() == (ROOT/'data/secant_certificates.json').read_bytes()
    print('PASS independent-process secant-certificate regeneration, byte for byte.',flush=True)
    if not args.new_only:
        print('Replaying previous verifiers, their manifests, and the complete earlier Fourier checks.',flush=True)
        subprocess.run([sys.executable,'-B',str(ROOT/'previous/verify.py')],cwd=ROOT/'previous',
                       env=dict(os.environ,PYTHONDONTWRITEBYTECODE='1'),check=True)
    print('PASS ALL REQUESTED CHECKS. No geometric witness or full nonexistence certificate is claimed.',flush=True)

if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print('VERIFICATION FAILED:',error,file=sys.stderr)
        raise
