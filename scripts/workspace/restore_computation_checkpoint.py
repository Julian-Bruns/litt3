#!/usr/bin/env python3
"""Restore one original checkpoint from the checked local gzip inventory.

This only decompresses bytes. It does not unpickle or execute the checkpoint.
The default inventory lives beside the computation folders. Existing files
are checked and left in place; restoration never overwrites a file.
"""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import tempfile

DATA = Path(__file__).resolve().parents[3] / 'litt3-computation-data'


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024**2), b''):
            h.update(block)
    return h.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('checkpoint', help='Original path relative to the inventory directory')
    parser.add_argument('--inventory', type=Path,
                        default=DATA / 'checkpoint-storage-20260913.json')
    parser.add_argument('--verify-only', action='store_true')
    args = parser.parse_args()
    inventory = args.inventory.resolve()
    row = next(r for r in json.loads(inventory.read_text())['files']
               if r['path'] == args.checkpoint)
    root = inventory.parent
    paths = []
    for name in [row['path'], row['compressed_path']]:
        relative = Path(name)
        target = root / relative
        if relative.is_absolute() or '..' in relative.parts or '.git' in relative.parts:
            raise ValueError('Unsafe inventory path')
        if target.resolve() != target.absolute():
            raise ValueError('Symlink in inventory path')
        paths.append(target)
    target, compressed = paths
    assert compressed.stat().st_size == row['compressed_bytes']
    assert digest(compressed) == row['compressed_sha256']
    if target.exists():
        assert target.stat().st_size == row['bytes']
        assert digest(target) == row['sha256']
        print('PASS existing original checkpoint matches inventory')
        return
    staging = None
    try:
        output = None
        if not args.verify_only:
            output = tempfile.NamedTemporaryFile(prefix=target.name + '.', suffix='.restore-tmp',
                                                 dir=target.parent, delete=False)
            staging = Path(output.name)
        h = hashlib.sha256()
        size = 0
        try:
            with gzip.open(compressed, 'rb') as stream:
                for block in iter(lambda: stream.read(4 * 1024**2), b''):
                    h.update(block)
                    size += len(block)
                    if output is not None:
                        output.write(block)
        finally:
            if output is not None:
                output.close()
        assert size == row['bytes'] and h.hexdigest() == row['sha256']
        if staging is not None:
            os.link(staging, target)
        print('PASS original bytes verified' + ('' if args.verify_only else ' and restored'))
    finally:
        if staging is not None:
            staging.unlink(missing_ok=True)


if __name__ == '__main__':
    main()
