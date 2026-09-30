#!/usr/bin/env python3
"""Restartable exhaustive union-of-norm-boundaries scan, standard library only."""
from pathlib import Path
import subprocess, json, gzip, concurrent.futures, argparse, time
ROOT=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('--jobs',type=int,default=4);p.add_argument('--output',type=Path,default=ROOT/'build'/'boundary_full');p.add_argument('--timeout',type=int,default=600);args=p.parse_args();args.output.mkdir(parents=True,exist_ok=True)
intervals=[(s,min(s+500,9776)) for s in range(0,9776,500)]
def work(ab):
 a,b=ab;stem=args.output/f'{a:05d}_{b:05d}';meta=stem.with_suffix('.json');gz=stem.with_suffix('.jsonl.gz')
 if meta.exists() and gz.exists():
  j=json.loads(meta.read_text())
  if j.get('execution_status')=='COMPLETE':return j
 cmd=[str(ROOT/'build'/'boundary_scan'),str(a),str(b)];start=time.monotonic()
 try:
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=args.timeout,check=True)
  logs=[json.loads(s) for s in r.stderr.splitlines()];j=logs[-1]
  if j.get('kind')!='summary' or j['start']!=a or j['stop']!=b:raise ValueError('Incomplete chunk')
  j['execution_status']='COMPLETE';j['command']=['build/boundary_scan',str(a),str(b)]
  with gzip.GzipFile(filename=str(gz),mode='wb',mtime=0) as f:f.write(r.stdout.encode())
  stem.with_suffix('.log').write_text(r.stderr)
 except Exception as e:j={'start':a,'stop':b,'execution_status':'INCOMPLETE','error':repr(e)}
 j['wall_seconds']=round(time.monotonic()-start,3);meta.write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(j),flush=True);return j
with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as e:results=list(e.map(work,intervals))
results.sort(key=lambda j:j['start']);ok=all(j['execution_status']=='COMPLETE' for j in results)
summary={'execution_status':'COMPLETE' if ok else 'INCOMPLETE','chunks':results}
if ok:
 for k in ['tested','norm_c_only','norm_e_only','both_norms_equal','linear_consistent','rank4_quadric_pass','consistent_lower_rank']:
  summary[k]=sum(j[k] for j in results)
 for k in ['rank_counts','consistent_rank_counts']:summary[k]=[sum(j[k][i] for j in results) for i in range(5)]
 summary['representatives']=9776;summary['endpoint_count']=7938112
(args.output/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k!='chunks'}),flush=True)
if not ok:raise SystemExit(1)
