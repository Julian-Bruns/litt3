"""Run explicitly named branch generations with bounded parallelism."""
from concurrent.futures import ThreadPoolExecutor,as_completed
from pathlib import Path
import argparse,json,subprocess,sys,time
ROOT=Path(__file__).resolve().parents[1]
def main():
 ap=argparse.ArgumentParser();ap.add_argument('names',nargs='+');ap.add_argument('--workers',type=int,default=2);ap.add_argument('--threads',type=int,default=2);a=ap.parse_args()
 def run(name):
  cmd=[sys.executable,str(ROOT/'src/solve_branch.py'),name,'--threads',str(a.threads)];log=ROOT/'logs/current'/f'{name}.log';t=time.monotonic()
  print('START',name,flush=True)
  with log.open('w') as f:p=subprocess.run(cmd,cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
  r={'name':name,'command':cmd,'exit_code':p.returncode,'elapsed_seconds':round(time.monotonic()-t,3),'log':str(log.relative_to(ROOT))};print('END',name,r['exit_code'],r['elapsed_seconds'],flush=True);return r
 results=[]
 with ThreadPoolExecutor(max_workers=a.workers) as pool:
  for f in as_completed([pool.submit(run,n) for n in a.names]):
   results.append(f.result());(ROOT/'evidence/new_suite_execution.json').write_text(json.dumps(results,indent=2)+'\n')
 if any(r['exit_code'] for r in results):raise SystemExit(1)
if __name__=='__main__':main()
