#!/usr/bin/env python3
"""Regenerate the SHA-256 manifest for this archive; standard library only."""
from pathlib import Path
import hashlib

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / 'MANIFEST.sha256'

def included(path: Path) -> bool:
    return path.is_file() and path != TARGET and '__pycache__' not in path.parts

if __name__ == '__main__':
    paths = sorted((p for p in ROOT.rglob('*') if included(p)),
                   key=lambda p: p.relative_to(ROOT).as_posix())
    lines = [hashlib.sha256(p.read_bytes()).hexdigest() + '  ' +
             p.relative_to(ROOT).as_posix() for p in paths]
    TARGET.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print(f'WROTE MANIFEST.sha256: {len(paths)} files; manifest excludes itself')
