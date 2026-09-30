#!/usr/bin/env python3
"""Explicitly regenerate content hashes; this is not a mathematical verifier."""
from pathlib import Path
import hashlib

ROOT = Path(__file__).resolve().parent
TARGET = ROOT/'MANIFEST.sha256'
rows = []
for path in sorted(ROOT.rglob('*')):
    if path.is_file() and path != TARGET:
        relative = path.relative_to(ROOT).as_posix()
        rows.append(hashlib.sha256(path.read_bytes()).hexdigest()+'  '+relative)
TARGET.write_text('\n'.join(rows)+'\n', encoding='utf-8')
print(f'Wrote hashes for {len(rows)} files. This command does not verify mathematical claims.')
