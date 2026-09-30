"""Generate all evidence for a previously unresolved entire scale branch.
Restart markers are bound to exact source/input hashes. No field-point search.
"""
from pathlib import Path
import argparse,hashlib,json,os,subprocess,sys,time,fcntl
ROOT=Path(__file__).resolve().parents[1]
ENGINES={'generic_curve':'generic_curve','generic_tails':'generic_tails_homogeneous','generic_root':'generic_root_hybrid','generic_norm':'generic_norm_shared','norm_gcd':'norm_gcd','factor_support':'factor_support','finite_fibers':'finite_fibers_fast','verify_global':'verify_global'}
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  while b:=f.read(1<<20):h.update(b)
 return h.hexdigest()
def compile_engines():
 b=ROOT/'build/bin';b.mkdir(parents=True,exist_ok=True)
 for binary,source in ENGINES.items():
  print('COMPILE',binary,flush=True)
  subprocess.run(['g++','-O3','-std=c++17','-DUSE_GMP_PACKING','-fopenmp',str(ROOT/'src'/f'{source}.cpp'),'-lgmp','-o',str(b/binary)],check=True)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('name',nargs='?');ap.add_argument('--threads',type=int,default=2);ap.add_argument('--compile',action='store_true');ap.add_argument('--workdir');a=ap.parse_args()
 if a.compile:compile_engines()
 if not a.name:return
 r,s=a.name.split('_');r=int(r);branch=['small','large0','large1','large2'].index(s);assert r in [145049,211895,211959]
 w=Path(a.workdir).resolve() if a.workdir else ROOT/'build/new_branches'/a.name;w.mkdir(parents=True,exist_ok=True)
 lock=(w/'run.lock').open('w');fcntl.flock(lock,fcntl.LOCK_EX)
 deps=[ROOT/f'data/function_input_{r}.txt',ROOT/f'data/finite_input_{r}.txt',ROOT/'data/Ehat.txt']+sorted((ROOT/'src').glob('*.hpp'))+sorted((ROOT/'src').glob('*.cpp'))
 hashes={p.relative_to(ROOT).as_posix():sha(p) for p in deps};stamp=w/'INPUT_SHA256.json'
 if stamp.exists():assert json.loads(stamp.read_text())==hashes,'Input/source changed; use a new work directory'
 else:stamp.write_text(json.dumps(hashes,indent=2)+'\n')
 env=dict(os.environ,OMP_NUM_THREADS=str(a.threads));records=[]
 def run(cmd,label):
  cmd=list(map(str,cmd));marker=w/(label+'.done.json');log=w/(label+'.log')
  if marker.exists():
   rec=json.loads(marker.read_text());assert rec['command']==cmd;records.append(rec);print('RESUME',label,flush=True);return
  print('RUN',a.name,label,flush=True);t=time.monotonic()
  # Serialize the packed high-precision root products: two such stages can
  # exceed a container's 4 GiB cgroup limit, even when host memory is larger.
  # This lock changes scheduling only, never arithmetic or certificates.
  memory_lock=None
  if label=='square_tails':
   memory_lock=(ROOT/'build/root_memory.lock').open('w')
   fcntl.flock(memory_lock,fcntl.LOCK_EX)
  try:
   with log.open('w') as f:p=subprocess.run(cmd,cwd=ROOT,env=env,stdout=f,stderr=subprocess.STDOUT)
  finally:
   if memory_lock is not None:memory_lock.close()
  rec={'command':cmd,'exit_code':p.returncode,'status':'PASS' if p.returncode==0 else 'FAIL','elapsed_seconds':round(time.monotonic()-t,3),'log_sha256':sha(log),'log_excerpt':'\n'.join(log.read_text().splitlines()[-8:])}
  records.append(rec)
  if p.returncode:print(rec['log_excerpt'],flush=True);raise RuntimeError(f'{label} failed')
  marker.write_text(json.dumps(rec,indent=2)+'\n');print('PASS',label,rec['elapsed_seconds'],flush=True)
 bins=ROOT/'build/bin';chart=ROOT/f'data/function_input_{r}.txt';fc=ROOT/f'data/finite_input_{r}.txt';E=ROOT/'data/Ehat.txt'
 shared=ROOT/'build/coordinates'/str(r);shared.mkdir(parents=True,exist_ok=True)
 if not (shared/'complete.json').exists():
  run([bins/'generic_curve',chart,E,shared/'generic'],'coordinates_E');(shared/'complete.json').write_text(json.dumps(hashes))
 else:assert json.loads((shared/'complete.json').read_text())==hashes
 run([bins/'generic_tails',chart,shared/'generic_coordinates.txt',shared/'generic_E.txt',w/'specialized',branch],'norm_series')
 run([bins/'generic_root',chart,w/'specialized_U.txt',w/'root'],'square_tails')
 for n in (71,72):run([bins/'generic_norm',chart,w/f'root_C{n}.txt',w/f'norm_C{n}'],f'scalar{n}')
 run([bins/'norm_gcd',w/'norm_C71_norm.txt',w/'norm_C72_norm.txt',w/'root_support.txt',w/'unit'],'scalar_gcd')
 assert (w/'unit_gcd.txt').read_text().split()==['1','1'],'Nonconstant scalar gcd: further work required'
 rows=(w/'unit_bezout.txt').read_text().splitlines();assert len(rows)==5;(w/'compact_unit.txt').write_text('\n'.join(rows[2:])+'\n')
 run([bins/'factor_support',w/'factors.txt',w/'root_support.txt'],'factor_support');nf=int((w/'factors.txt').read_text().splitlines()[0])
 for i in range(nf):run([bins/'finite_fibers',fc,E,w/'factors.txt',w/'fiber',i,i+1,branch],f'fiber{i}')
 run([sys.executable,ROOT/'src/collect_branch.py',r,branch,'--tail-prefix',w/'root','--cert-prefix',w/'norm','--chain-prefix',w/'unit','--unit',w/'compact_unit.txt','--factors',w/'factors.txt','--fiber-prefix',w/'fiber'],'collect')
 run([sys.executable,ROOT/'src/verify_branch.py',a.name],'independent_verify')
 out={'name':a.name,'status':'PASS','records':records,'inputs':hashes,'scope':'Full branch generation from Ehat, exact global identities, and every exceptional fibre; no bounded field-point search.'}
 (ROOT/'evidence'/f'generation_{a.name}.json').write_text(json.dumps(out,indent=2)+'\n');print('COMPLETE_BRANCH',a.name,'PASS',flush=True)
if __name__=='__main__':main()
