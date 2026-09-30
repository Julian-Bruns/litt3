"""Clean replay of the continued global expansion and complete square circuit.

Uses a fresh temporary directory and compares against archived fingerprints.
The original proof replay is included. No global square-locus solver is run.
"""
from pathlib import Path
import tempfile, shutil, subprocess, sys, json, time, hashlib, os
ROOT=Path(__file__).resolve().parents[1]

def run():
 start=time.time()
 def cmd(args,cwd):
  print('$ '+' '.join(map(str,args)),flush=True)
  subprocess.run(list(map(str,args)),cwd=cwd,check=True)
 cmd([sys.executable,'src/verify_all.py'],ROOT)
 with tempfile.TemporaryDirectory(prefix='constant140-full-') as directory:
  tmp=Path(directory)
  for name in ['src','inputs','evidence']:
   shutil.copytree(ROOT/name,tmp/name,ignore=shutil.ignore_patterns('__pycache__','*.pyc'))
  (tmp/'build').mkdir()
  cmd(['g++','-O3','-std=c++17','src/expand.cpp','-o','build/expand'],tmp)
  cmd(['build/expand',str(tmp),'resultant-only'],tmp)
  cmd(['g++','-O3','-std=c++17','src/fast_expand.cpp','-lgmp','-lz','-o','build/fast_expand'],tmp)
  cmd(['build/fast_expand',str(tmp),'test'],tmp)
  cmd(['build/fast_expand',str(tmp)],tmp)
  # A second pass uses all four compressed restart chunks; no norm products
  # are recomputed. Its final fingerprint must be identical.
  fp1=hashlib.sha256((tmp/'build/Rcal.bin').read_bytes()).hexdigest()
  cmd(['build/fast_expand',str(tmp)],tmp)
  fp2=hashlib.sha256((tmp/'build/Rcal.bin').read_bytes()).hexdigest()
  assert fp1==fp2
  print('MATCH compressed-restart output '+fp1,flush=True)
  cmd(['g++','-O3','-std=c++17','src/evaluate_full.cpp','-o','build/evaluate_full'],tmp)
  print('$ build/evaluate_full ROOT inputs/full_validation_triples.txt > build/full_evaluations.txt',flush=True)
  with (tmp/'build/full_evaluations.txt').open('w') as f:
   subprocess.run([str(tmp/'build/evaluate_full'),str(tmp),'inputs/full_validation_triples.txt'],cwd=tmp,check=True,stdout=f)
  cmd([sys.executable,'src/verify_full.py'],tmp)
  cmd([sys.executable,'src/inspect_full.py'],tmp)
  cmd([sys.executable,'src/complete_square.py'],tmp)
  for name in ['full_expansion_checks.json','full_support_summary.json','complete_square_circuit.json','complete_square_checks.json']:
   expected=json.loads((ROOT/'evidence'/name).read_text())
   actual=json.loads((tmp/'evidence'/name).read_text())
   if isinstance(expected,dict):expected.pop('seconds',None)
   if isinstance(actual,dict):actual.pop('seconds',None)
   assert actual==expected,('certificate mismatch',name)
   print('MATCH '+name,flush=True)
  assert fp2=='436fae7b0bb93fb03e40e2b6c66507440569ebd591bdf988acc40b47593fecf2'
 print('ALL CONTINUATION CHECKS PASSED; geometric existence decision remains UNRESOLVED.',flush=True)
 print('elapsed_seconds',round(time.time()-start,3),flush=True)
if __name__=='__main__':run()
