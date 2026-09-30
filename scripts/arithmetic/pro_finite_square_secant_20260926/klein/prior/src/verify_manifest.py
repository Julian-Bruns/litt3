"""Verify all distributed files against the included SHA-256 manifest."""
from pathlib import Path
import hashlib
root=Path(__file__).resolve().parents[1]
manifest=root/'MANIFEST.sha256'
rows=[]
for line in manifest.read_text().splitlines():
    digest,name=line.split('  ',1)
    path=root/name
    if not path.is_file(): raise SystemExit('MISSING: '+name)
    h=hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda:f.read(1024*1024),b''): h.update(chunk)
    if h.hexdigest()!=digest: raise SystemExit('HASH MISMATCH: '+name)
    rows.append(name)
files={str(p.relative_to(root)) for p in root.rglob('*') if p.is_file() and '__pycache__' not in p.parts and p.name!='MANIFEST.sha256'}
if files!=set(rows): raise SystemExit('Manifest file set differs: '+str(files.symmetric_difference(rows)))
print(f'PASS: SHA-256 manifest verified for {len(rows)} files.')
