#!/usr/bin/env python3
"""Verify every entry in the package SHA-256 manifest (standard library only)."""
from pathlib import Path
import hashlib

root=Path(__file__).resolve().parents[1]
manifest=root/'SHA256SUMS'
count=0
for line in manifest.read_text().splitlines():
    if not line:continue
    expected,name=line.split('  ',1)
    path=root/name
    if not path.is_file():raise SystemExit('MISSING: '+name)
    actual=hashlib.sha256(path.read_bytes()).hexdigest()
    if actual!=expected:raise SystemExit('HASH MISMATCH: '+name)
    count+=1
print(f'PASS: SHA-256 verified for all {count} manifest entries.')
print('The manifest intentionally excludes itself; runtime cache files are not payload.')
