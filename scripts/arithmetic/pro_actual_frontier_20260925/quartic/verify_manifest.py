#!/usr/bin/env python3
"""Check SHA256SUMS; --write is a packaging/regeneration operation only."""
import argparse
import hashlib
from pathlib import Path

ROOT=Path(__file__).resolve().parent
MANIFEST=ROOT/'SHA256SUMS'

def included_files():
    return sorted(p for p in ROOT.rglob('*') if p.is_file()
                  and p!=MANIFEST and '__pycache__' not in p.parts
                  and p.suffix!='.pyc')

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write',action='store_true')
    args=parser.parse_args()
    if args.write:
        MANIFEST.write_text(''.join(f'{sha(p)}  {p.relative_to(ROOT).as_posix()}\n' for p in included_files()))
        print('Manifest written.')
    expected={}
    for line in MANIFEST.read_text().splitlines():
        digest,name=line.split('  ',1)
        if len(digest)!=64:raise ValueError('Malformed hash')
        p=ROOT/name
        if p.resolve().parent!=ROOT and ROOT not in p.resolve().parents:raise ValueError('Unsafe path')
        if name in expected:raise ValueError('Duplicate manifest path')
        expected[name]=digest
    actual={p.relative_to(ROOT).as_posix():p for p in included_files()}
    if set(actual)!=set(expected):
        raise RuntimeError(f'File-set mismatch: missing={set(expected)-set(actual)}, unexpected={set(actual)-set(expected)}')
    for name,digest in expected.items():
        if sha(actual[name])!=digest:raise RuntimeError(f'SHA-256 mismatch: {name}')
    print(f'MANIFEST CHECK PASSED: {len(expected)} files; SHA256SUMS excludes itself.')

if __name__=='__main__':main()
