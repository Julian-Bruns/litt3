#!/usr/bin/env python3
"""Verify all delivered content hashes and the exact content-file inventory."""
from __future__ import annotations
import hashlib
from pathlib import Path

ROOT=Path(__file__).resolve().parent
EXCLUDED={'MANIFEST.sha256'}


def main() -> None:
    entries={}
    for line in (ROOT/'MANIFEST.sha256').read_text().splitlines():
        digest, rel=line.split('  ',1)
        path=ROOT/rel
        if len(digest)!=64 or Path(rel).is_absolute() or '..' in Path(rel).parts:
            raise ValueError(f'Invalid manifest entry: {line}')
        if rel in entries:
            raise ValueError(f'Duplicate manifest entry: {rel}')
        entries[rel]=digest
        actual=hashlib.sha256(path.read_bytes()).hexdigest()
        if actual!=digest:
            raise AssertionError(f'SHA-256 mismatch: {rel}')
        print('PASS:',rel)
    actual_files={str(p.relative_to(ROOT)) for p in ROOT.rglob('*') if p.is_file()}
    if actual_files-EXCLUDED != set(entries):
        raise AssertionError(f'Inventory mismatch: extra={actual_files-EXCLUDED-set(entries)}, missing={set(entries)-actual_files}')
    print(f'PASS: {len(entries)} content hashes and exact delivered-file inventory')
    print('Documented exclusion: MANIFEST.sha256 itself')


if __name__=='__main__':
    main()
