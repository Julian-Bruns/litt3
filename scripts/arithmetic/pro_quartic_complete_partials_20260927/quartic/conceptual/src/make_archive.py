#!/usr/bin/env python3
"""Write a fresh SHA-256 manifest and one streaming, self-contained ZIP."""
from __future__ import annotations
import argparse, hashlib, shutil, zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
EXCLUDE_PARTS={'build','__pycache__','.git','.pytest_cache'}

def included(path:Path)->bool:
    rel=path.relative_to(ROOT)
    return (path.is_file() and not any(p in EXCLUDE_PARTS for p in rel.parts)
            and path.suffix not in {'.pyc','.pyo','.zip','.o','.so'}
            and not path.name.endswith('~'))

def digest(path:Path)->str:
    h=hashlib.sha256()
    with path.open('rb') as source:
        for data in iter(lambda:source.read(1024*1024),b''):h.update(data)
    return h.hexdigest()

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output',type=Path)
    args=parser.parse_args()
    output=args.output.resolve()
    if output==ROOT/'SHA256SUMS':raise ValueError('Invalid output path')
    files=sorted((p for p in ROOT.rglob('*') if included(p) and p.name!='SHA256SUMS'),
                 key=lambda p:p.relative_to(ROOT).as_posix())
    manifest=ROOT/'SHA256SUMS'
    manifest.write_text(''.join(digest(p)+'  '+p.relative_to(ROOT).as_posix()+'\n' for p in files))
    files.append(manifest)
    output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,
                         allowZip64=True) as archive:
        for path in sorted(files,key=lambda p:p.relative_to(ROOT).as_posix()):
            info=zipfile.ZipInfo(path.relative_to(ROOT).as_posix(),date_time=(2026,9,26,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            info.external_attr=(0o100644 << 16)
            with path.open('rb') as source,archive.open(info,'w',force_zip64=True) as target:
                shutil.copyfileobj(source,target,length=1024*1024)
    print(f'{output}: {len(files)} files, {output.stat().st_size} bytes, SHA256 {digest(output)}')

if __name__=='__main__':main()
