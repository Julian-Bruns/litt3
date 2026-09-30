#!/usr/bin/env python3
"""Check SHA256SUMS.txt and the complete archive file set; standard library only."""
from __future__ import annotations

import hashlib
import re
import sys
from pathlib import Path, PurePosixPath

sys.dont_write_bytecode = True
ROOT = Path(__file__).resolve().parents[1]
MANIFEST = "SHA256SUMS.txt"


def main() -> int:
    expected: dict[str, str] = {}
    for line_number, line in enumerate((ROOT / MANIFEST).read_text(encoding="utf-8").splitlines(), 1):
        match = re.fullmatch(r"([0-9a-f]{64})  (.+)", line)
        if match is None:
            raise ValueError(f"Malformed manifest line {line_number}")
        digest, name = match.groups()
        relative = PurePosixPath(name)
        if relative.is_absolute() or ".." in relative.parts or "\\" in name or name == MANIFEST:
            raise ValueError(f"Unsafe or self-referential manifest path: {name}")
        if name in expected:
            raise ValueError(f"Duplicate manifest path: {name}")
        expected[name] = digest

    actual: set[str] = set()
    for path in ROOT.rglob("*"):
        if path.is_symlink():
            raise ValueError(f"Unexpected symbolic link: {path}")
        if path.is_file():
            relative_name = path.relative_to(ROOT).as_posix()
            if relative_name != MANIFEST:
                actual.add(relative_name)
    if actual != set(expected):
        raise ValueError(
            f"File set mismatch. Missing: {sorted(set(expected)-actual)}; "
            f"unlisted: {sorted(actual-set(expected))}"
        )
    for name, wanted in sorted(expected.items()):
        got = hashlib.sha256((ROOT / name).read_bytes()).hexdigest()
        if got != wanted:
            raise ValueError(f"SHA-256 mismatch: {name}")
    print(f"PASS SHA-256 manifest: all {len(expected)} files match; no unlisted files.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError) as exc:
        print(f"FAIL manifest: {exc}", file=sys.stderr)
        raise SystemExit(1) from exc
