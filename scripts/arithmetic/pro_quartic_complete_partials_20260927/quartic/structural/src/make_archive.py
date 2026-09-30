#!/usr/bin/env python3
"""Write the payload manifest and stream a self-contained ZIP archive."""
from __future__ import annotations
import argparse,hashlib,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]

def paths():
 return sorted(p for p in ROOT.rglob('*') if p.is_file()
               and not any(part in {'build','__pycache__','.git'} for part in p.relative_to(ROOT).parts)
               and p.suffix not in {'.pyc','.zip'}
               and p.name!='SHA256SUMS')

def manifest():
 ps=paths();lines=[]
 for p in ps:
  h=hashlib.sha256()
  with p.open('rb') as f:
   for block in iter(lambda:f.read(1<<20),b''):h.update(block)
  lines.append(h.hexdigest()+'  '+p.relative_to(ROOT).as_posix())
 (ROOT/'SHA256SUMS').write_text('\n'.join(lines)+'\n')
 return ps+[ROOT/'SHA256SUMS']

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--output',type=Path,required=True)
 args=parser.parse_args();out=args.output.resolve()
 if out.is_relative_to(ROOT):raise ValueError('Archive output must be outside the source directory')
 out.parent.mkdir(parents=True,exist_ok=True);ps=manifest()
 with zipfile.ZipFile(out,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
  for p in sorted(ps):z.write(p,p.relative_to(ROOT).as_posix())
 print(str(out), 'files',len(ps),'bytes',out.stat().st_size)
if __name__=='__main__':main()
