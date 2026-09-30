#!/usr/bin/env python3
"""Create the self-contained archive, hashing files and streaming ZIP writes."""
from pathlib import Path
import hashlib,zipfile,sys
ROOT=Path(__file__).resolve().parents[2]
OUT=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT.parent/'oriented_quartic_four_trace_continued.zip'
def keep(p):
 rel=p.relative_to(ROOT)
 return p.is_file() and not any(s in {'build','__pycache__','.git'} for s in rel.parts) and p.name not in {'SHA256SUMS','canonical_endpoints.jsonl'} and p.suffix not in {'.zip','.pyc'}
files=sorted((p for p in ROOT.rglob('*') if keep(p)),key=lambda p:str(p.relative_to(ROOT)))
with (ROOT/'SHA256SUMS').open('w') as f:
 for p in files:
  h=hashlib.sha256()
  with p.open('rb') as g:
   for b in iter(lambda:g.read(1024*1024),b''):h.update(b)
  f.write(h.hexdigest()+'  '+str(p.relative_to(ROOT))+'\n')
files.append(ROOT/'SHA256SUMS')
with zipfile.ZipFile(OUT,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
 for p in files:z.write(p,p.relative_to(ROOT))
print(OUT,OUT.stat().st_size)
