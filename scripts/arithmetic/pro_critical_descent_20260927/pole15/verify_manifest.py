#!/usr/bin/env python3
from pathlib import Path
from hashlib import sha256

def main():
    root=Path(__file__).resolve().parents[1]
    entries=(root/'SHA256SUMS').read_text().splitlines()
    listed=set()
    for line in entries:
        expected,name=line.split('  ',1)
        p=root/name
        if p.resolve().parent!=root and root not in p.resolve().parents:
            raise ValueError('unsafe manifest path')
        digest=sha256()
        with p.open('rb') as f:
            for block in iter(lambda:f.read(1024*1024),b''):digest.update(block)
        assert digest.hexdigest()==expected,f'hash mismatch: {name}'
        listed.add(name)
    actual={p.relative_to(root).as_posix() for p in root.rglob('*')
            if p.is_file() and p.name!='SHA256SUMS' and '__pycache__' not in p.parts}
    assert actual==listed, f'file inventory differs: {actual ^ listed}'
    print(f'PASS SHA-256 hashes and inventory for {len(listed)} files')
if __name__=='__main__':main()
