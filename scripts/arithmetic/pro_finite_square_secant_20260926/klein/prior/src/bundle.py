#!/usr/bin/env python3
"""Regenerate the manifest and stream a deterministic ZIP outside the source root."""
from __future__ import annotations
import argparse
import hashlib
from pathlib import Path
import shutil
import zipfile


def digest(path: Path) -> str:
    h=hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(1024*1024),b''):
            h.update(block)
    return h.hexdigest()


def main() -> None:
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output',type=Path)
    args=parser.parse_args()
    root=Path(__file__).resolve().parents[1]
    output=args.output.resolve()
    if output==root or root in output.parents:
        parser.error('Output must be outside the source directory.')
    files=sorted(p for p in root.rglob('*') if p.is_file()
                 and '__pycache__' not in p.parts and p.name!='MANIFEST.sha256')
    for p in files:
        if p.is_symlink():
            raise ValueError('Refusing symlink: '+str(p))
    manifest=root/'MANIFEST.sha256'
    manifest.write_text(''.join(digest(p)+'  '+p.relative_to(root).as_posix()+'\n'
                                for p in files))
    output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,
                         compresslevel=9,allowZip64=True) as archive:
        for p in sorted(files+[manifest]):
            name=root.name+'/'+p.relative_to(root).as_posix()
            info=zipfile.ZipInfo(name,date_time=(2026,9,26,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            info.external_attr=0o100644<<16
            info._compresslevel=9
            with p.open('rb') as src,archive.open(info,'w',force_zip64=True) as dst:
                shutil.copyfileobj(src,dst,length=1024*1024)
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
    print('Wrote',output)
    print('ZIP files:',len(files)+1,'Manifest entries:',len(files))
    print('ZIP bytes:',output.stat().st_size)
    print('ZIP SHA-256:',digest(output))

if __name__=='__main__':
    main()
