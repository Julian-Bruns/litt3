#!/usr/bin/env python3
"""Verify every archived payload file against SHA256SUMS.txt."""
from pathlib import Path
import hashlib

root=Path(__file__).resolve().parent.parent
count=0
for line in (root/'SHA256SUMS.txt').read_text().splitlines():
    digest,name=line.split('  ',1)
    relative=Path(name)
    assert not relative.is_absolute() and '..' not in relative.parts
    path=root/relative
    check=hashlib.sha256()
    with path.open('rb') as source:
        for chunk in iter(lambda:source.read(1<<20),b''):check.update(chunk)
    assert check.hexdigest()==digest, name
    count+=1
print('PASS:',count,'payload files match SHA256SUMS.txt (the manifest itself is necessarily excluded).')
