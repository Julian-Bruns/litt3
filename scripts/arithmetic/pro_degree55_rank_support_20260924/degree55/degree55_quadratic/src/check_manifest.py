#!/usr/bin/env python3
"""Verify hashes and exact regular-file inventory of the extracted archive."""
import hashlib
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
manifest = root / "SHA256SUMS"
expected = {}
try:
    for line in manifest.read_text().splitlines():
        digest, rel = line.split("  ", 1)
        if len(digest) != 64 or any(c not in "0123456789abcdef" for c in digest):
            raise ValueError("invalid SHA-256 row")
        target = root / rel
        if target.resolve().is_relative_to(root.resolve()) is False:
            raise ValueError("manifest path escapes archive")
        if rel in expected:
            raise ValueError("duplicate manifest path")
        expected[rel] = digest
    actual = {str(p.relative_to(root)) for p in root.rglob("*")
              if p.is_file() and p != manifest and "__pycache__" not in p.parts}
    if actual != set(expected):
        raise ValueError(f"inventory mismatch; missing={set(expected)-actual}, "
                         f"unlisted={actual-set(expected)}")
    for rel, digest in sorted(expected.items()):
        observed = hashlib.sha256((root/rel).read_bytes()).hexdigest()
        if observed != digest:
            raise ValueError(f"hash mismatch: {rel}")
    print(f"PASS: SHA-256 hashes and inventory for all {len(expected)} delivered files")
except (OSError, ValueError) as exc:
    print(f"FAIL: {exc}", file=sys.stderr)
    sys.exit(1)
