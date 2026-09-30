#!/usr/bin/env python3
"""Check archive integrity and run all exact mathematical verifiers."""
import argparse
import hashlib
from pathlib import Path
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--skip-manifest',action='store_true',help='development/regeneration only; mathematical checks still run')
 args=parser.parse_args()
 print('Python:',sys.version.replace('\n',' '),flush=True)
 if not args.skip_manifest:
  manifest=ROOT/'SHA256SUMS'
  count=0
  for line in manifest.read_text().splitlines():
   digest,name=line.split('  ',1)
   path=ROOT/name
   h=hashlib.sha256()
   with path.open('rb') as f:
    while chunk:=f.read(1024*1024):h.update(chunk)
   if h.hexdigest()!=digest:raise AssertionError('SHA256 mismatch: '+name)
   count+=1
  print(f'PASS: SHA-256 manifest ({count} files)',flush=True)
 else:
  print('Manifest check deliberately skipped for pre-packaging regeneration.',flush=True)
 for script in ['endpoint_probe.py','verify_independent.py','verify_arithmetic.py']:
  print('\nRUN:',sys.executable,'src/'+script,flush=True)
  subprocess.run([sys.executable,str(ROOT/'src'/script)],check=True,cwd=ROOT)
 print('\nALL MATHEMATICAL AND REQUESTED INTEGRITY CHECKS PASSED',flush=True)

if __name__=='__main__':main()
