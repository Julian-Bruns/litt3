#!/usr/bin/env python3
"""Streaming archive creation and SHA-256 verification, standard library only."""
from __future__ import annotations
import argparse
import hashlib
from pathlib import Path
import shutil
import sys
import zipfile

ROOT=Path(__file__).resolve().parents[1]
MANIFEST=ROOT/'SHA256SUMS'
CHUNK=1024*1024

def files(include_manifest: bool=False):
    for path in sorted(ROOT.rglob('*')):
        if not path.is_file():continue
        rel=path.relative_to(ROOT)
        if '__pycache__' in rel.parts or path.suffix in {'.pyc','.zip'}:continue
        if path==MANIFEST and not include_manifest:continue
        yield path

def digest(path: Path) -> str:
    h=hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(CHUNK),b''):h.update(block)
    return h.hexdigest()

def write_manifest():
    lines=[f'{digest(path)}  {path.relative_to(ROOT).as_posix()}' for path in files()]
    MANIFEST.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    return len(lines)

def check():
    if not MANIFEST.is_file():raise FileNotFoundError('SHA256SUMS is missing')
    recorded={}
    for line in MANIFEST.read_text(encoding='utf-8').splitlines():
        expected,name=line.split('  ',1)
        path=ROOT/name
        if not path.resolve().is_relative_to(ROOT.resolve()):raise ValueError('Unsafe manifest path')
        if name in recorded:raise ValueError('Duplicate manifest entry: '+name)
        if not path.is_file():raise FileNotFoundError(name)
        actual=digest(path)
        if actual!=expected:raise ValueError('SHA-256 mismatch: '+name)
        recorded[name]=expected
    actual_names={path.relative_to(ROOT).as_posix() for path in files()}
    if actual_names!=set(recorded):raise ValueError('Manifest file set does not equal distributed file set')
    print(f'PASS: SHA-256 manifest verified for all {len(recorded)} distributed files.')

def build(target: Path):
    target=target.resolve()
    if target.is_relative_to(ROOT.resolve()):raise ValueError('Write the ZIP outside the source directory')
    target.parent.mkdir(parents=True,exist_ok=True)
    count=write_manifest();check()
    with zipfile.ZipFile(target,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as zf:
        for path in files(include_manifest=True):
            name=(Path(ROOT.name)/path.relative_to(ROOT)).as_posix()
            info=zipfile.ZipInfo.from_file(path,arcname=name)
            info.compress_type=zipfile.ZIP_DEFLATED
            with path.open('rb') as src,zf.open(info,'w',force_zip64=True) as dst:
                shutil.copyfileobj(src,dst,CHUNK)
    with zipfile.ZipFile(target) as zf:
        bad=zf.testzip()
        if bad is not None:raise ValueError('ZIP CRC failure: '+bad)
    print(f'PASS: ZIP CRC verified; {count+1} files, {target.stat().st_size} bytes.')
    print('ARCHIVE:',target)
    print('ARCHIVE SHA-256:',digest(target))

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    sub=parser.add_subparsers(dest='action',required=True)
    sub.add_parser('check',help='Verify the existing file manifest')
    p=sub.add_parser('build',help='Refresh the manifest and build a ZIP');p.add_argument('target',type=Path)
    args=parser.parse_args()
    if args.action=='check':check()
    else:build(args.target)

if __name__=='__main__':
    try:main()
    except (OSError,ValueError) as exc:
        print('FAIL:',exc,file=sys.stderr);sys.exit(1)
