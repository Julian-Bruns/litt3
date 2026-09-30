#!/usr/bin/env python3
"""Regenerate the manifest and stream a compact, self-contained research ZIP."""
from pathlib import Path
import argparse
import hashlib
import shutil
import zipfile

ROOT=Path(__file__).resolve().parents[1]
def files():
    return sorted(p for p in ROOT.rglob('*') if p.is_file()
                  and '__pycache__' not in p.parts
                  and p.suffix not in {'.pyc','.zip'}
                  and p.name!='SHA256SUMS')
def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    retained=files();lines=[]
    for path in retained:
        h=hashlib.sha256()
        with path.open('rb') as stream:
            for chunk in iter(lambda:stream.read(1024*1024),b''):h.update(chunk)
        lines.append(f'{h.hexdigest()}  {path.relative_to(ROOT).as_posix()}')
    manifest=ROOT/'SHA256SUMS'
    manifest.write_text('\n'.join(lines)+'\n')
    retained.append(manifest)
    output=args.output.resolve();output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,
                         allowZip64=True) as archive:
        for path in sorted(retained):
            name='mixed_phase_quintic/'+path.relative_to(ROOT).as_posix()
            info=zipfile.ZipInfo(name,date_time=(2026,9,27,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            info.external_attr=0o100644<<16
            with path.open('rb') as source,archive.open(info,'w',force_zip64=True) as target:
                shutil.copyfileobj(source,target,length=1024*1024)
    h=hashlib.sha256()
    with output.open('rb') as stream:
        for chunk in iter(lambda:stream.read(1024*1024),b''):h.update(chunk)
    print(f'ARCHIVE: {output}')
    print(f'FILES: {len(retained)}; BYTES: {output.stat().st_size}')
    print(f'SHA256: {h.hexdigest()}')
if __name__=='__main__':main()
