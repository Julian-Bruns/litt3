#!/usr/bin/env python3
"""Verify retained exact results. No network access or external CAS is used.
--mode full recomputes every one of the 97,656 parameter evaluations.
--mode certificates does NOT recompute that complete evaluation table.
The output concerns the partial results only, not the full question's decision.
"""
import argparse,array,hashlib,json,os,pathlib,shlex,shutil,subprocess,sys,tempfile,time
BASE=pathlib.Path(__file__).resolve().parent

def manifest_check():
 p=BASE/'SHA256SUMS'
 if not p.exists():raise FileNotFoundError('SHA256SUMS has not been created yet')
 entries=0
 for line in p.read_text().splitlines():
  dig,name=line.split('  ',1);q=BASE/name
  assert q.is_file(),name
  assert hashlib.sha256(q.read_bytes()).hexdigest()==dig,('hash mismatch',name)
  entries+=1
 print(f'MANIFEST VERIFIED: {entries} files.')

def main():
 ap=argparse.ArgumentParser(description=__doc__)
 ap.add_argument('--mode',choices=['full','certificates'],default='full')
 ap.add_argument('--manifest',action='store_true',help='check SHA-256 inventory only')
 ap.add_argument('--workdir',type=pathlib.Path,help='new directory to keep generated verification workspace')
 ap.add_argument('--log',type=pathlib.Path,help='write the complete execution transcript')
 ap.add_argument('--threads',type=int,default=4)
 args=ap.parse_args()
 if args.manifest:manifest_check();return
 if args.threads<1:raise ValueError('threads must be positive')
 if not shutil.which('g++'):raise RuntimeError('g++ supporting C++17 is required')
 import numpy
 expected={}
 for folder in ['data','certificates']:
  for p in (BASE/folder).glob('*'):
   if p.suffix in ['.json','.txt'] and '_rechecked' not in p.name and not p.name.startswith(('test_','parametric_benchmark','big_check')):
    expected[str(p.relative_to(BASE))]=p.read_bytes()
 if args.workdir:
  work=args.workdir.resolve();work.mkdir(parents=True,exist_ok=False);tmp=None
 else:
  tmp=tempfile.TemporaryDirectory(prefix='degree140_verify_');work=pathlib.Path(tmp.name)
 for folder in ['src','data','certificates','logs']:(work/folder).mkdir()
 for p in (BASE/'src').iterdir():
  if p.is_file() and p.suffix in ['.py','.cpp','.hpp']:shutil.copy2(p,work/'src'/p.name)
 for name,contents in expected.items():(work/name).write_bytes(contents)
 log=None
 if args.log:
  args.log.parent.mkdir(parents=True,exist_ok=True);log=args.log.open('w')
 def say(s):
  print(s,flush=True)
  if log:log.write(s+'\n');log.flush()
 env=os.environ.copy();env['OMP_NUM_THREADS']=str(args.threads);env['PYTHONHASHSEED']='0'
 def run(cmd):
  say('$ '+shlex.join(map(str,cmd)));start=time.monotonic()
  p=subprocess.Popen(list(map(str,cmd)),cwd=work,env=env,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
  for line in p.stdout:say(line.rstrip('\n'))
  code=p.wait();say(f'[exit={code}; elapsed_seconds={time.monotonic()-start:.3f}]')
  if code:raise RuntimeError(f'Failed command, exit {code}: {cmd}')
 def py(name,*args):run([sys.executable,work/'src'/name,*args])
 def compare(name):
  actual=(work/name).read_bytes();saved=expected[name]
  if name.endswith('.json'):assert json.loads(actual)==json.loads(saved),('data mismatch',name)
  else:assert actual==saved,('data mismatch',name)
  say('Exact retained-data comparison passed: '+name)
 try:
  say('Degree-140 partial-results verification; mode='+args.mode)
  say('Python='+sys.version.split()[0]+'; NumPy='+numpy.__version__)
  say('Workspace='+str(work));say('No claim of a global square-locus decision is made.')
  for exe in ['make_field','residual','parametric_eval','verify_big','interpolate']:
   opts=['g++','-O3','-std=c++17']
   if exe=='parametric_eval':opts+=['-fopenmp']
   run(opts+[work/'src'/f'{exe}.cpp','-o',work/'src'/exe])
  run([work/'src/make_field',work/'data'])
  py('reconstruct.py');compare('data/spaces.json')
  py('verify_spaces_original.py')
  py('series.py');compare('data/boundary_series.json')
  py('charts.py');compare('data/charts.json')
  py('exceptional.py');compare('data/exceptional.json')
  py('verify_symbolic_resultant.py')
  py('run_slices.py');compare('data/slices.json')
  for i in range(11):
   for name in [f'data/slice_{i:02d}.txt',f'data/slice_{i:02d}_residual.json',f'certificates/slice_{i:02d}_bezout.json']:compare(name)
  for sign in [0,1]:
   name=f'exceptional_param_3_{sign}'
   py('prepare_parametric.py',3,sign)
   compare(f'data/{name}_metadata.json');compare(f'data/{name}.txt')
   run([work/'src/residual',work/'data',work/'data'/f'{name}.txt',work/'data'/f'{name}.json'])
   compare(f'data/{name}.json')
   py('extract_parametric.py',name);compare(f'data/{name}_coeffs.txt')
  py('generic_boundary.py');compare('data/generic_boundary.json')
  py('verify_tail_values.py')
  for sign in [0,1]:
   if args.mode=='full':
    prefix=work/'data'/f'parametric_values_3_{sign}'
    run([work/'src/parametric_eval',work/'data',work/'data'/f'exceptional_param_3_{sign}_coeffs.txt',48828,prefix])
    aa=array.array('i');aa.frombytes(prefix.with_suffix('.bin').read_bytes())
    assert aa.itemsize==4
    vv=json.loads(expected[f'data/parametric_values_3_{sign}.json'])
    assert vv['N']==48828 and vv['omega']==384425
    assert aa.tolist()==vv['pair_major_values'],'complete resultant evaluation table mismatch'
    compare(f'data/parametric_values_3_{sign}_meta.json')
    say('ALL 48,828 PARAMETER VALUES AND ALL THREE RESULTANTS RECOMPUTED AND MATCHED: branch '+str(sign))
   else:say('NOT RECOMPUTED IN THIS MODE: the complete 48,828-point resultant table, branch '+str(sign))
   py('check_big.py',3,sign)
   py('close_exceptional.py',3,sign)
   compare(f'certificates/exceptional_closure_3_{sign}.json')
   for j in range(3):
    for name in [f'data/exceptional_3_{sign}_finite_{j}.txt',f'data/exceptional_3_{sign}_finite_{j}_residual.json',f'certificates/exceptional_3_{sign}_finite_{j}_bezout.json']:compare(name)
  say('PASS: all requested checks for mode '+args.mode+' passed.')
  say('VERIFIED SCOPE: all coefficient charts; six exceptional components for v=x-2514; eleven specified scaling lines.')
  say('OPEN: the remaining nonzero-pivot square loci and 54 other exceptional components. No square witness.')
 finally:
  if log:log.close()
  if tmp:tmp.cleanup()
if __name__=='__main__':main()
