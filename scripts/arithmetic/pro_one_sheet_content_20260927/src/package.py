"""Create one streamed, hashed, self-contained ZIP; omit regenerable intermediates."""
from pathlib import Path
import hashlib,zipfile,sys
ROOT=Path(__file__).resolve().parents[1]
OUTPUT=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT.parent/'one_sheet_content_result.zip'
def selected(p):
 r=p.relative_to(ROOT)
 return p.is_file() and not any(k in ('build','__pycache__') for k in r.parts) and not p.name.startswith('R_q') and p.name!='SHA256SUMS' and p.suffix not in ('.zip','.pyc')
files=sorted(p for p in ROOT.rglob('*') if selected(p))
def digest(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  while b:=f.read(1024*1024):h.update(b)
 return h.hexdigest()
(ROOT/'SHA256SUMS').write_text(''.join(digest(p)+'  '+p.relative_to(ROOT).as_posix()+'\n' for p in files))
with zipfile.ZipFile(OUTPUT,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
 for p in files+[ROOT/'SHA256SUMS']:
  z.write(p,arcname='one_sheet_content/'+p.relative_to(ROOT).as_posix(),compress_type=zipfile.ZIP_STORED if p.suffix=='.gz' else zipfile.ZIP_DEFLATED)
print(f'{OUTPUT}: {len(files)+1} files, {OUTPUT.stat().st_size} bytes, sha256={digest(OUTPUT)}')
