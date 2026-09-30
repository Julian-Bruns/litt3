#!/usr/bin/env python3
"""Main verification entry point. Default needs only Python's standard library."""
from pathlib import Path
import argparse
import hashlib
import subprocess
import sys
ROOT=Path(__file__).resolve().parent

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--tensor',action='store_true',help='also rebuild and verify the full exact tensor (requires NumPy and Numba)')
    args=p.parse_args()
    manifest=ROOT/'SHA256SUMS'
    if manifest.exists():
        lines=manifest.read_text().splitlines()
        for line in lines:
            digest,name=line.split('  ',1)
            actual=hashlib.sha256((ROOT/name).read_bytes()).hexdigest()
            if actual!=digest:
                raise RuntimeError('SHA-256 mismatch: '+name)
        print('PASS SHA-256 manifest:',len(lines),'files',flush=True)
    else:
        print('NOTE manifest not yet created (archive assembly run)',flush=True)
    subprocess.run([sys.executable,str(ROOT/'src'/'verify_independent.py')],check=True,cwd=ROOT)
    if args.tensor:
        subprocess.run([sys.executable,str(ROOT/'src'/'verify_tensor.py')],check=True,cwd=ROOT)
    print('ALL REQUESTED CHECKS PASSED',flush=True)

if __name__=='__main__':
    main()
