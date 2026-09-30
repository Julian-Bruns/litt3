#!/usr/bin/env python3
"""Rebuild the manifest and stream this source tree into one ZIP."""
from pathlib import Path
from hashlib import sha256
import zipfile, shutil, sys

def main():
    root=Path(__file__).resolve().parents[1]
    out=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else root.parent/'pole15_cubic_descent.zip'
    if root in out.parents: raise ValueError('Write the ZIP outside the source directory')
    files=sorted(p for p in root.rglob('*') if p.is_file() and p.name!='SHA256SUMS'
                 and '__pycache__' not in p.parts and p.suffix!='.pyc')
    lines=[]
    for p in files:
        digest=sha256()
        with p.open('rb') as f:
            for block in iter(lambda:f.read(1024*1024),b''):digest.update(block)
        lines.append(f'{digest.hexdigest()}  {p.relative_to(root).as_posix()}')
    (root/'SHA256SUMS').write_text('\n'.join(lines)+'\n')
    files.append(root/'SHA256SUMS')
    temporary=out.with_suffix('.zip.tmp')
    with zipfile.ZipFile(temporary,'w',zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
        for p in files:
            info=zipfile.ZipInfo(f'{root.name}/{p.relative_to(root).as_posix()}')
            info.date_time=(2026,9,27,0,0,0);info.compress_type=zipfile.ZIP_DEFLATED
            info.external_attr=0o644<<16
            with p.open('rb') as source,z.open(info,'w',force_zip64=True) as target:
                shutil.copyfileobj(source,target,length=1024*1024)
    temporary.replace(out)
    with zipfile.ZipFile(out) as z:assert z.testzip() is None
    print(f'Created {out.name}; files={len(files)}; bytes={out.stat().st_size}')
if __name__=='__main__':main()
