#!/usr/bin/env python3
"""Verify SHA-256 and the exact distributed file set, including the prior manifest."""
from pathlib import Path
import hashlib
ROOT=Path(__file__).resolve().parents[1]
MANIFEST=ROOT/'MANIFEST.sha256'
seen=set()
for line in MANIFEST.read_text().splitlines():
    digest,name=line.split('  ',1)
    p=ROOT/name
    if name in seen or p.is_symlink() or not p.is_file() or ROOT not in p.resolve().parents:
        raise SystemExit('Invalid or duplicate manifest entry: '+name)
    seen.add(name)
    h=hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda:f.read(1024*1024),b''): h.update(block)
    if h.hexdigest()!=digest: raise SystemExit('SHA-256 mismatch: '+name)
actual={p.relative_to(ROOT).as_posix() for p in ROOT.rglob('*')
        if p.is_file() and '__pycache__' not in p.parts and p!=MANIFEST}
if actual!=seen: raise SystemExit('File set differs: '+str(actual.symmetric_difference(seen)))
print('PASS: root SHA-256 manifest and exact file set:',len(seen),'files.')
