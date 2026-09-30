#!/usr/bin/env python3
"""Regenerate and compare certificates in a temporary, isolated working copy.
Does not modify the archive's frozen evidence. Exits nonzero on any mismatch.
"""
from pathlib import Path
import subprocess,sys,tempfile,shutil,json,hashlib,time
ROOT=Path(__file__).resolve().parents[1]

def main():
 start=time.time()
 commands=[
  [sys.executable,'src/reconstruct.py'],
  [sys.executable,'src/symbolic.py'],
  [sys.executable,'src/normalize.py'],
  ['g++','-O3','-std=c++17','src/boundary.cpp','-o','build/boundary'],
  ['build/boundary','{ROOT}'],
  [sys.executable,'src/verify_boundary.py'],
  [sys.executable,'src/residual.py'],
  [sys.executable,'src/check_field.py'],
  [sys.executable,'src/check_original.py'],
 ]
 files=['affine_basis.json','chart_laurent.json','normalized_sources.json','normalized_sources.dat','infinity_boundary.json','resultant_point_checks.json','residual_checks.json','reconstruction_checks.json','field_certificate.json','original_equations_checks.json']
 with tempfile.TemporaryDirectory(prefix='constant140_verify_') as tmp:
  dst=Path(tmp)/'constant140';dst.mkdir();shutil.copytree(ROOT/'src',dst/'src',ignore=shutil.ignore_patterns('__pycache__'));(dst/'evidence').mkdir();(dst/'build').mkdir()
  for cmd in commands:
   cmd=[str(dst) if a=='{ROOT}' else a for a in cmd]
   shown=' '.join(a.replace(str(dst),'<verification-root>') for a in cmd)
   print('RUN',shown,flush=True)
   proc=subprocess.run(cmd,cwd=dst,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
   if proc.returncode:
    print(proc.stdout);raise RuntimeError(f'command failed: {shown}')
   print('PASS',shown,flush=True)
  for f in files:
   expected=(ROOT/'evidence'/f).read_bytes();got=(dst/'evidence'/f).read_bytes()
   if expected!=got:raise RuntimeError(f'certificate mismatch: {f}')
   print('MATCH',f,hashlib.sha256(got).hexdigest(),flush=True)
  old=json.loads((ROOT/'evidence/boundary_independent_checks.json').read_text());new=json.loads((dst/'evidence/boundary_independent_checks.json').read_text());old.pop('seconds',None);new.pop('seconds',None)
  assert old==new
 print('ALL CHECKS PASSED; no global square-locus decision is asserted.',flush=True)
 print('elapsed_seconds',round(time.time()-start,3))

if __name__=='__main__':
 try:main()
 except Exception as e:
  print('VERIFICATION FAILED:',e,file=sys.stderr);sys.exit(1)
