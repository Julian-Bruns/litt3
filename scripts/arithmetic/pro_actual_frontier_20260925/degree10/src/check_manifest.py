#!/usr/bin/env python3
"""Check SHA256SUMS and detect omitted/unexpected distributed files."""
from __future__ import annotations
import hashlib
import pathlib
import sys


def main() -> None:
    root = pathlib.Path(__file__).resolve().parents[1]
    expected = {}
    for line in (root/'SHA256SUMS').read_text().splitlines():
        digest, name = line.split('  ', 1)
        path = pathlib.PurePosixPath(name)
        if path.is_absolute() or '..' in path.parts or name in expected:
            raise ValueError(f'Unsafe or repeated path: {name}')
        expected[name] = digest
    actual = {p.relative_to(root).as_posix() for p in root.rglob('*')
              if p.is_file() and p.name != 'SHA256SUMS'
              and '__pycache__' not in p.parts and '.venv' not in p.parts}
    if actual != set(expected):
        raise AssertionError(f'File-set mismatch: missing {sorted(set(expected)-actual)}; unexpected {sorted(actual-set(expected))}')
    for name, digest in expected.items():
        found = hashlib.sha256((root/name).read_bytes()).hexdigest()
        if found != digest:
            raise AssertionError(f'SHA-256 mismatch: {name}')
    print(f'PASS SHA-256 manifest: {len(expected)} files. Manifest itself excluded by definition.')


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, AssertionError) as error:
        print(f'MANIFEST CHECK FAILED: {error}', file=sys.stderr)
        sys.exit(1)
