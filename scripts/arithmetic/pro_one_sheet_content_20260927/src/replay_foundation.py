"""Fresh reconstruction from source only, followed by exact archive comparisons.
This checks foundational data and both boundary families, not new global tails.
"""
from pathlib import Path
import argparse,hashlib,json,shutil,subprocess,sys,time
ROOT=Path(__file__).resolve().parents[1]
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  while b:=f.read(1<<20):h.update(b)
 return h.hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--workdir',required=True);a=ap.parse_args();w=Path(a.workdir).resolve();assert not w.exists(),'Use a fresh directory'
 w.mkdir(parents=True);shutil.copytree(ROOT/'src',w/'src',ignore=shutil.ignore_patterns('__pycache__'))
 for d in ['data','evidence','build','logs']:(w/d).mkdir()
 commands=[]
 for script in ['replay.py','replay_continuation.py']:
  cmd=[sys.executable,'src/'+script];t=time.monotonic();log=w/(script+'.log');print('RUN',script,flush=True)
  with log.open('w') as f:p=subprocess.run(cmd,cwd=w,stdout=f,stderr=subprocess.STDOUT)
  rec={'command':cmd,'exit_code':p.returncode,'elapsed_seconds':round(time.monotonic()-t,3),'log_excerpt':'\n'.join(log.read_text().splitlines()[-6:])};commands.append(rec)
  assert p.returncode==0,rec;print('PASS',script,rec['elapsed_seconds'],flush=True)
 comparisons=[]
 for folder in ['data','evidence']:
  for p in sorted((w/folder).rglob('*')):
   rel=p.relative_to(w);original=ROOT/rel
   if p.is_file() and original.is_file():
    h=sha(p);assert h==sha(original),f'Exact reconstruction mismatch: {rel}'
    comparisons.append({'file':rel.as_posix(),'sha256':h,'status':'byte_identity_PASS'})
 assert any(r['file']=='data/Ehat.txt' for r in comparisons)
 record={'status':'PASS','scope':'Fresh source-only reconstruction, both boundaries and every generated foundational file also present in the archive. Does not replay global branch tails.','commands':commands,'compared_file_count':len(comparisons),'comparisons':comparisons}
 (ROOT/'evidence/fresh_foundation_replay.json').write_text(json.dumps(record,indent=2)+'\n');print('FOUNDATION_REPLAY=PASS files=',len(comparisons),flush=True)
if __name__=='__main__':main()
