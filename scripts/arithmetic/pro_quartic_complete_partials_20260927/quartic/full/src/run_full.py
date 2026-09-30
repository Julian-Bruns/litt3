#!/usr/bin/env python3
"""Restartable exhaustive sieve, using bounded, compressed chunks.
Only a validated complete partition of [0,9776) is labeled globally complete.
"""
from pathlib import Path
import argparse,subprocess,sys,json,gzip,hashlib,time,os
ROOT=Path(__file__).resolve().parents[2]
KEYS=['pairs','first_projection_zero','Z_zero','norm_boundary','generic_Z_zero','T_zero','eq3_zero','eq4_zero']
def gzwrite(path,text):
 tmp=path.with_name(path.name+'.tmp')
 with tmp.open('wb')as raw:
  with gzip.GzipFile(fileobj=raw,mode='wb',mtime=0,filename='')as f:f.write(text.encode())
 tmp.replace(path)
def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--output',type=Path,default=ROOT/'build/full_regeneration')
 p.add_argument('--threads',type=int,default=4);p.add_argument('--projection',type=int,default=1,choices=range(14))
 p.add_argument('--chunk-size',type=int,default=256);p.add_argument('--start-h',type=int,default=0);p.add_argument('--stop-h',type=int,default=9776)
 p.add_argument('--portable',action='store_true');a=p.parse_args()
 if not 0<=a.start_h<=a.stop_h<=9776 or a.chunk_size<1 or a.threads<1:p.error('invalid interval/chunk/thread count')
 out=a.output.resolve();out.mkdir(parents=True,exist_ok=True);(ROOT/'build').mkdir(exist_ok=True)
 binary=ROOT/'build/full_scan_regenerate'
 command=['g++','-std=c++17','-O3','-march=native','-fopenmp']+(['-DPORTABLE_DOT']if a.portable else [])+['full/src/full_scan.cpp','-o',str(binary)]
 subprocess.run(command,cwd=ROOT,check=True)
 sources=['full/src/full_scan.cpp','full/src/factor_data.hpp','continuation/src/generic_kernel.hpp','continuation/src/pair_kernel.hpp','src/fast_field.hpp']
 signature=hashlib.sha256(b''.join((ROOT/f).read_bytes()for f in sources)+str((a.projection,a.portable)).encode()).hexdigest()
 chunks=[];candidate_paths=[];row_paths=[]
 for first in range(a.start_h,a.stop_h,a.chunk_size):
  last=min(first+a.chunk_size,a.stop_h);stem=out/f'{first:05d}_{last:05d}_p{a.projection}'
  meta=stem.with_suffix('.json');cand=stem.with_suffix('.candidates.jsonl.gz');rows=stem.with_suffix('.rows.jsonl.gz')
  candidate_paths.append(cand);row_paths.append(rows)
  saved=json.loads(meta.read_text())if meta.exists()else None
  if saved and saved.get('status')=='COMPLETE' and saved.get('source_signature')==signature and cand.exists()and rows.exists():
   with gzip.open(rows,'rt')as f:data=[json.loads(x)for x in f if x.strip()]
   if [r['h_index']for r in data]==list(range(first,last)):
    chunks.append(saved);print(json.dumps({'kind':'resumed','start':first,'stop':last}),flush=True);continue
  cmd=[str(binary),str(first),str(last),str(a.threads),'16',str(a.projection)];t=time.monotonic()
  run=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True)
  if run.returncode:
   (stem.with_suffix('.failed.stderr')).write_text(run.stderr);raise RuntimeError('Chunk failed; no completion marker written')
  log=[json.loads(x)for x in run.stderr.splitlines()if x.strip()]
  assert log[-1]['kind']=='completed' and log[-1]['start']==first and log[-1]['stop']==last
  data=sorted((r for r in log if r.get('kind')=='full_scan_h_summary'),key=lambda r:r['h_index'])
  assert [r['h_index']for r in data]==list(range(first,last))
  assert all(r['pairs']==812*(r['h_index']+1)for r in data)
  for r in data:r.pop('seconds',None)
  gzwrite(cand,run.stdout);gzwrite(rows,''.join(json.dumps(r,sort_keys=True,separators=(',',':'))+'\n'for r in data))
  record={'status':'COMPLETE','start':first,'stop':last,'source_signature':signature,'command':cmd,'seconds':round(time.monotonic()-t,6),**{k:sum(r[k]for r in data)for k in KEYS}}
  tmp=meta.with_suffix('.json.tmp');tmp.write_text(json.dumps(record,indent=2)+'\n');tmp.replace(meta);chunks.append(record)
  print(json.dumps(record,sort_keys=True),flush=True)
 global_complete=a.start_h==0 and a.stop_h==9776
 result={'status':'COMPLETE'if global_complete else 'BOUNDED_INTERVAL_COMPLETE','scope':[a.start_h,a.stop_h],'source_signature':signature,'chunks':len(chunks),**{k:sum(r[k]for r in chunks)for k in KEYS}}
 if global_complete:
  assert result['pairs']==38805460512
  expected=json.loads((ROOT/'full/evidence/scan_summary.json').read_text())['primary']
  for k in KEYS:
   if k!='first_projection_zero' or a.projection==expected['first_projection']:assert result[k]==expected[k],(k,result[k],expected[k])
  actual_candidates=[];actual_rows=[]
  for path in candidate_paths:
   with gzip.open(path,'rt')as f:actual_candidates.extend(json.loads(t)for t in f if t.strip())
  for path in row_paths:
   with gzip.open(path,'rt')as f:actual_rows.extend(json.loads(t)for t in f if t.strip())
  target_candidates=[json.loads(t)for t in (ROOT/'full/evidence/generic_survivors.jsonl').read_text().splitlines()if t]
  order=lambda r:(r['h_index'],r['q_index'],r['orbit'])
  assert sorted(actual_candidates,key=order)==sorted(target_candidates,key=order)
  with gzip.open(ROOT/'full/evidence/scan_rows.jsonl.gz','rt')as f:target_rows=[json.loads(t)for t in f if t.strip()]
  for actual,target in zip(actual_rows,target_rows):
   if a.projection!=expected['first_projection']:
    actual={k:v for k,v in actual.items()if k!='first_projection_zero'}
    target={k:v for k,v in target.items()if k!='first_projection_zero'}
   assert actual==target
  result['all_survivors_match']=True;result['all_h_rows_match']=True
 (out/'summary.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,sort_keys=True))
if __name__=='__main__':main()
