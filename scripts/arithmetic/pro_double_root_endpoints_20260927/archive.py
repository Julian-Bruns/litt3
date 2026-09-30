"""Write a SHA-256 manifest and stream a self-contained ZIP.
Regenerable binaries, caches and work directories are not archived.
"""
from pathlib import Path
import hashlib,zipfile,sys
ROOT=Path(__file__).resolve().parent.parent
TARGET=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else ROOT.parent/'double_root_square_continued.zip'
def included(p):
 r=p.relative_to(ROOT)
 return p.is_file() and not any(s in {'__pycache__','work','tmp'} for s in r.parts) and p.suffix not in {'.so','.pyc','.zip'} and p.name!='SHA256SUMS'
files=sorted(p for p in ROOT.rglob('*') if included(p))
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
 return h.hexdigest()
(ROOT/'SHA256SUMS').write_text(''.join(f'{sha(p)}  {p.relative_to(ROOT).as_posix()}\n' for p in files))
files.append(ROOT/'SHA256SUMS')
with zipfile.ZipFile(TARGET,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
 for p in sorted(files):z.write(p,p.relative_to(ROOT).as_posix())
print(f'{TARGET}: {len(files)} files, {TARGET.stat().st_size} bytes')
