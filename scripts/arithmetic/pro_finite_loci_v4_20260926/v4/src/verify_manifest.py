#!/usr/bin/env python3
"""Verify all files listed in the archive's SHA256SUMS, without external tools."""
from __future__ import annotations
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1024*1024), b''):
            h.update(block)
    return h.hexdigest()


def main() -> None:
    count = 0
    for line in (ROOT/'SHA256SUMS').read_text().splitlines():
        expected, relative = line.split('  ', 1)
        path = (ROOT/relative).resolve()
        if ROOT not in path.parents:
            raise ValueError('unsafe manifest path: '+relative)
        if digest(path) != expected:
            raise ValueError('SHA-256 mismatch: '+relative)
        count += 1
    print(f'PASS: {count} SHA-256 file hashes')

if __name__ == '__main__':
    main()
