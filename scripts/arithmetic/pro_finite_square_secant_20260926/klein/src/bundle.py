#!/usr/bin/env python3
"""Write a complete SHA-256 manifest and stream a deterministic, compressed ZIP."""
import argparse
import hashlib
from pathlib import Path
import shutil
import zipfile
ROOT=Path(__file__).resolve().parents[1]

def digest(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda:f.read(1024*1024),b''): h.update(block)
    return h.hexdigest()

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('output',type=Path,nargs='?')
    ap.add_argument('--manifest-only',action='store_true')
    args=ap.parse_args()
    manifest=ROOT/'MANIFEST.sha256'
    files=sorted(p for p in ROOT.rglob('*') if p.is_file()
                 and '__pycache__' not in p.parts and p!=manifest)
    for p in files:
        if p.is_symlink(): raise ValueError('Refusing symlink: '+str(p))
    manifest.write_text(''.join(digest(p)+'  '+p.relative_to(ROOT).as_posix()+'\n' for p in files))
    if args.manifest_only:
        print('Wrote root manifest for',len(files),'files.'); return
    if not args.output: ap.error('Supply output ZIP, or --manifest-only.')
    output=args.output.resolve()
    if output==ROOT or ROOT in output.parents: ap.error('ZIP must be outside source directory.')
    output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
        for p in sorted(files+[manifest]):
            info=zipfile.ZipInfo(ROOT.name+'/'+p.relative_to(ROOT).as_posix(),(2026,9,26,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED; info._compresslevel=9
            info.external_attr=0o100644<<16
            with p.open('rb') as src,z.open(info,'w',force_zip64=True) as dst:
                shutil.copyfileobj(src,dst,length=1024*1024)
    with zipfile.ZipFile(output) as z: assert z.testzip() is None
    print('ZIP:',output,'Files:',len(files)+1,'Bytes:',output.stat().st_size)
    print('SHA-256:',digest(output))
if __name__=='__main__': main()
