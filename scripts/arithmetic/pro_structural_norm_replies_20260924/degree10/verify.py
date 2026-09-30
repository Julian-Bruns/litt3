#!/usr/bin/env python3
"""Recompute all certificates and optionally verify the SHA-256 manifest."""
import argparse, hashlib, json, pathlib, platform, sys, time
if not __debug__:
 raise SystemExit('Run without -O or -OO: verification assertions must remain enabled.')
ROOT=pathlib.Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'source'))
import numpy as np
from certification import build_certificates

def main():
 parser=argparse.ArgumentParser();parser.add_argument('--manifest',action='store_true',help='also check every entry in MANIFEST.sha256');args=parser.parse_args()
 print('Python: '+platform.python_version(),flush=True);print('NumPy: '+np.__version__,flush=True)
 print('Platform: '+platform.platform(),flush=True)
 supplied=json.loads((ROOT/'inputs.json').read_text())
 from ff25 import P,A,Q,B0,L
 assert all(supplied[k]==v for k,v in [('P',P),('A',A),('Q',Q),('B0',B0),('L',L)])
 print('PASS: portable inputs match the arithmetic source',flush=True)
 data=build_certificates(log=lambda s:print(s,flush=True))
 for name,obj in data.items():
  path=ROOT/'certificates'/name
  assert json.loads(path.read_text(encoding='utf-8'))==obj, 'certificate differs: '+name
  print('MATCH: certificates/'+name,flush=True)
 if args.manifest:
  count=0
  for line in (ROOT/'MANIFEST.sha256').read_text().splitlines():
   digest,name=line.split('  ',1);p=ROOT/name
   assert p.is_file(), 'missing: '+name
   assert hashlib.sha256(p.read_bytes()).hexdigest()==digest, 'hash mismatch: '+name
   count+=1
  print('PASS: SHA-256 manifest (%d files)'%count,flush=True)
 print('ALL EXECUTED CHECKS PASSED',flush=True)
if __name__=='__main__':main()
