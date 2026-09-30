#!/usr/bin/env python3
"""Verify all archived payload files against SHA256SUMS; standard library only."""
from __future__ import annotations
import hashlib
import re
import sys
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / 'SHA256SUMS'


def payload_paths() -> dict[str, Path]:
    result = {}
    for path in ROOT.rglob('*'):
        if not path.is_file():
            continue
        relative = path.relative_to(ROOT)
        if relative.as_posix() == 'SHA256SUMS' or '__pycache__' in relative.parts:
            continue
        result[relative.as_posix()] = path
    return result


def main() -> None:
    expected: dict[str, str] = {}
    for number, line in enumerate(MANIFEST.read_text(encoding='utf-8').splitlines(), 1):
        match = re.fullmatch(r'([0-9a-f]{64})  (.+)', line)
        if not match:
            raise ValueError(f'Invalid manifest line {number}')
        digest, name = match.groups()
        path = PurePosixPath(name)
        if path.is_absolute() or '..' in path.parts or name == 'SHA256SUMS':
            raise ValueError(f'Unsafe or self-referential manifest path: {name}')
        if name in expected:
            raise ValueError(f'Duplicate manifest path: {name}')
        expected[name] = digest
    actual = payload_paths()
    if set(expected) != set(actual):
        missing = sorted(set(expected) - set(actual))
        unexpected = sorted(set(actual) - set(expected))
        raise ValueError(f'Payload mismatch: missing={missing}, unexpected={unexpected}')
    for name, digest in expected.items():
        hasher = hashlib.sha256()
        with actual[name].open('rb') as source:
            for block in iter(lambda: source.read(1024 * 1024), b''):
                hasher.update(block)
        if hasher.hexdigest() != digest:
            raise ValueError(f'SHA-256 mismatch: {name}')
    print(f'PASS: SHA-256 verified for {len(expected)} payload files; '
          'no missing or unexpected payload files.')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print(f'FAIL: {error}', file=sys.stderr)
        raise SystemExit(1)
