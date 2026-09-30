#!/usr/bin/env python3
"""Restartable exhaustive independent-H scans on the selected Q stratum."""
from pathlib import Path
import subprocess,json,gzip,concurrent.futures,argparse,time
ROOT=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('--jobs',type=int,default=4);p.add_argument('--mode',choices=['two-label','two-phase'],default='two-phase');p.add_argument('--output',type=Path,default=ROOT/'build'/'generic_two_phase');p.add_argument('--timeout',type=int,default=180);a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
repfile=ROOT/'continuation/evidence/canonical_endpoints.jsonl'
if not repfile.exists():
 subprocess.run([str(ROOT/'build/boundary_scan'),'0','0',str(repfile)],check=True,capture_output=True,text=True)
reps=[json.loads(s) for s in repfile.read_text().splitlines()];assert len(reps)==9776
if a.mode=='two-phase':chosen=[r for r in reps if len({j for i,j in r['Q']})==2];assert len(chosen)==128
else:chosen=[r for r in reps if len(set(map(tuple,r['Q'])))==2];assert len(chosen)==24
def work(rep):
 qi=rep['index'];stem=a.output/f'{qi:05d}';meta=stem.with_suffix('.json');gz=stem.with_suffix('.jsonl.gz')
 if meta.exists() and gz.exists():
  j=json.loads(meta.read_text())
  if j.get('execution_status')=='COMPLETE':return j
 cmd=[str(ROOT/'build/generic_scan'),str(qi),str(qi+1),a.mode];begin=time.monotonic()
 try:
  r=subprocess.run(cmd,capture_output=True,text=True,timeout=a.timeout,check=True);logs=[json.loads(s) for s in r.stderr.splitlines()]
  assert len(logs)==2 and logs[-1]['kind']=='completed' and logs[0]['q_index']==qi and logs[0]['Q']==rep['Q']
  j=logs[0];assert j['admissible']==7938112 and j['total']==7940751
  assert j['generic_tested']+j['norm_boundary_skipped']==j['admissible']
  j['execution_status']='COMPLETE';j['command']=['build/generic_scan',str(qi),str(qi+1),a.mode]
  with gzip.GzipFile(filename=str(gz),mode='wb',mtime=0) as f:f.write(r.stdout.encode())
  stem.with_suffix('.log').write_text(r.stderr)
 except Exception as e:j={'q_index':qi,'execution_status':'INCOMPLETE','error':repr(e)}
 j['wall_seconds']=round(time.monotonic()-begin,3);meta.write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(j),flush=True);return j
with concurrent.futures.ThreadPoolExecutor(max_workers=a.jobs) as pool:results=list(pool.map(work,chosen))
results.sort(key=lambda j:j['q_index']);ok=all(j['execution_status']=='COMPLETE' for j in results)
s={'execution_status':'COMPLETE' if ok else 'INCOMPLETE','mode':a.mode,'Q_representatives':len(chosen),'chunks':results}
if ok:
 for k in ['total','admissible','norm_boundary_skipped','generic_tested','Z_pass','T_pass','eq3_pass','eq4_pass']:s[k]=sum(j[k] for j in results)
(a.output/'summary.json').write_text(json.dumps(s,indent=2)+'\n');print(json.dumps({k:v for k,v in s.items() if k!='chunks'}),flush=True)
if not ok:raise SystemExit(1)
