#!/usr/bin/env python3
"""Regenerate the SHA-256 manifest and stream a compact self-contained ZIP."""
from __future__ import annotations
import argparse
import shutil
import zipfile
from pathlib import Path
from verify_manifest import digest

ROOT = Path(__file__).resolve().parents[1]


def files() -> list[Path]:
    return sorted(p for p in ROOT.rglob('*') if p.is_file()
                  and '__pycache__' not in p.parts
                  and p.suffix not in ('.pyc','.zip')
                  and p.name != 'SHA256SUMS')


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,default=ROOT.parent/(ROOT.name+'.zip'))
    args = parser.parse_args()
    selected = files()
    manifest = ROOT/'SHA256SUMS'
    manifest.write_text(''.join(f'{digest(p)}  {p.relative_to(ROOT).as_posix()}\n' for p in selected))
    selected.append(manifest)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    temporary = args.output.with_suffix('.zip.tmp')
    with zipfile.ZipFile(temporary,'w',compression=zipfile.ZIP_DEFLATED,
                         compresslevel=9,allowZip64=True) as archive:
        for p in sorted(selected):
            info = zipfile.ZipInfo(ROOT.name+'/'+p.relative_to(ROOT).as_posix(),
                                   date_time=(2026,9,26,0,0,0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            with p.open('rb') as source, archive.open(info,'w',force_zip64=True) as dest:
                shutil.copyfileobj(source,dest,length=1024*1024)
    with zipfile.ZipFile(temporary) as archive:
        bad = archive.testzip()
        if bad:
            raise ValueError('ZIP validation failed: '+bad)
    temporary.replace(args.output)
    print(f'Created {args.output.name}: {len(selected)} files, {args.output.stat().st_size} bytes')
    print('SHA-256:',digest(args.output))

if __name__ == '__main__':
    main()
