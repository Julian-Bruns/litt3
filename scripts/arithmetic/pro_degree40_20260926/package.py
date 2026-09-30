#!/usr/bin/env python3
"""Regenerate SHA256SUMS and stream a self-contained, compressed ZIP archive."""
import argparse
import hashlib
from pathlib import Path
import shutil
import zipfile

ROOT=Path(__file__).resolve().parents[1]

def files():
 return sorted(p for p in ROOT.rglob('*') if p.is_file()
               and '__pycache__' not in p.parts and p.suffix not in {'.pyc','.zip'}
               and p.name!='SHA256SUMS')

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('destination',type=Path)
 args=parser.parse_args()
 payload=files();lines=[]
 for p in payload:
  h=hashlib.sha256()
  with p.open('rb') as f:
   while chunk:=f.read(1024*1024):h.update(chunk)
  lines.append(h.hexdigest()+'  '+p.relative_to(ROOT).as_posix())
 manifest=ROOT/'SHA256SUMS';manifest.write_text('\n'.join(lines)+'\n')
 args.destination.parent.mkdir(parents=True,exist_ok=True)
 with zipfile.ZipFile(args.destination,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
  for p in sorted(payload+[manifest]):
   arc=(Path(ROOT.name)/p.relative_to(ROOT)).as_posix()
   with p.open('rb') as source,z.open(arc,'w',force_zip64=True) as dest:
    shutil.copyfileobj(source,dest,length=1024*1024)
 with zipfile.ZipFile(args.destination) as z:
  bad=z.testzip()
  if bad:raise AssertionError('ZIP CRC failure: '+bad)
 print('WROTE:',args.destination)
 print('PAYLOAD FILES:',len(payload)+1)
 print('SIZE BYTES:',args.destination.stat().st_size)
 print('ZIP CRC CHECK: PASSED')

if __name__=='__main__':main()
