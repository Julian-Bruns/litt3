#!/usr/bin/env python3
"""Verify exact partial results and the preserved prior archive, not existence."""
import argparse
import hashlib
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parent
sys.dont_write_bytecode=True
sys.path.insert(0,str(ROOT/'src'))

def manifest():
    path=ROOT/'MANIFEST.sha256'
    if not path.is_file():raise RuntimeError('missing MANIFEST.sha256')
    listed=set()
    for line in path.read_text().splitlines():
        digest,rel=line.split('  ',1)
        target=(ROOT/rel).resolve()
        if ROOT not in target.parents:raise RuntimeError('unsafe manifest path: '+rel)
        if hashlib.sha256(target.read_bytes()).hexdigest()!=digest:
            raise RuntimeError('SHA-256 mismatch: '+rel)
        listed.add(rel)
    actual={str(p.relative_to(ROOT))for p in ROOT.rglob('*')if p.is_file()
            and p!=path and '__pycache__' not in p.parts}
    if listed!=actual:raise RuntimeError('manifest coverage mismatch: '+str(listed^actual))
    print(f'PASS complete SHA-256 manifest: {len(listed)} files.',flush=True)

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--manifest-only',action='store_true')
    ap.add_argument('--skip-manifest',action='store_true',help='initial archive assembly only')
    ap.add_argument('--new-only',action='store_true',help='do not rerun preserved prior computations')
    args=ap.parse_args()
    if not args.skip_manifest:manifest()
    if args.manifest_only:return
    print('STATUS: PARTIAL. The actual geometric existence question remains UNRESOLVED.',flush=True)
    print('Python:',sys.version.replace('\n',' '),flush=True)
    print('Platform:',platform.platform(),flush=True)
    from formal_checks import run as formal
    from local_checks import run as local
    formal();local(ROOT)
    sys.stdout.flush()
    with tempfile.TemporaryDirectory(prefix='k4_local_data_')as tmp:
        data=Path(tmp)/'local_certificates.json'
        subprocess.run([sys.executable,'-B',str(ROOT/'src/local_checks.py'),
                        '--write-data',str(data)],check=True)
        assert data.read_bytes()==(ROOT/'data/local_certificates.json').read_bytes()
    print('PASS exact local-certificate regeneration, byte for byte.',flush=True)
    if not args.new_only:
        print('Running preserved prior verifier, including its own manifest.',flush=True)
        env=dict(os.environ,PYTHONDONTWRITEBYTECODE='1')
        subprocess.run([sys.executable,'-B',str(ROOT/'prior/verify.py')],cwd=ROOT/'prior',
                       env=env,check=True)
    print('PASS ALL REQUESTED CHECKS. No geometric witness or full nonexistence certificate is claimed.',flush=True)

if __name__=='__main__':
    try:main()
    except Exception as exc:
        print('VERIFICATION FAILED:',exc,file=sys.stderr)
        raise
