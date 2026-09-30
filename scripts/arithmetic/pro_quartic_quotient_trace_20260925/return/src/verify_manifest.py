from pathlib import Path
import hashlib,sys
root=Path(__file__).resolve().parents[1]
manifest=root/'SHA256SUMS'
if not manifest.exists():raise SystemExit('SHA256SUMS is missing')
listed=set();count=0
for line in manifest.read_text().splitlines():
 digest,name=line.split('  ',1);p=root/name
 if not p.is_file():raise SystemExit(f'MISSING {name}')
 if hashlib.sha256(p.read_bytes()).hexdigest()!=digest:raise SystemExit(f'HASH MISMATCH {name}')
 listed.add(name);count+=1
actual={str(p.relative_to(root)) for p in root.rglob('*') if p.is_file() and p.name!='SHA256SUMS' and '__pycache__' not in p.parts}
if listed!=actual:raise SystemExit(f'MANIFEST FILE SET MISMATCH: {listed ^ actual}')
print(f'PASS SHA-256 and file coverage for {count} files (manifest itself excluded).')
