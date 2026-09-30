"""Regenerate a complete selected branch from Ehat, then compare every certificate.
This is NOT a bounded field-point search. All arithmetic is over K(v)[S]/F and
whole finite quotient algebras. Restart files are tied to exact input/source hashes.
"""
from pathlib import Path
import argparse,gzip,hashlib,json,os,shutil,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as i:
  while b:=i.read(1<<20):h.update(b)
 return h.hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('name');ap.add_argument('--workdir',required=True);ap.add_argument('--threads',type=int,default=2);ap.add_argument('--resume',action='store_true');a=ap.parse_args()
 desc=json.loads((ROOT/'data/branches'/a.name/'descriptor.json').read_text());r=desc['r'];branch=desc['branch'];w=Path(a.workdir).resolve()
 inputs=[ROOT/f'data/function_input_{r}.txt',ROOT/f'data/finite_input_{r}.txt',ROOT/'data/Ehat.txt']+sorted((ROOT/'src').glob('*.hpp'))+sorted((ROOT/'src').glob('*.cpp'))
 manifest={p.relative_to(ROOT).as_posix():sha(p) for p in inputs}
 if w.exists():
  assert a.resume,'Use a new work directory or --resume with unchanged inputs.'
  assert json.loads((w/'INPUT_SHA256.json').read_text())==manifest,'Input/source changed; use a fresh work directory.'
 else:w.mkdir(parents=True);(w/'INPUT_SHA256.json').write_text(json.dumps(manifest,indent=2)+'\n')
 env=dict(os.environ,OMP_NUM_THREADS=str(a.threads));commands=[]
 def run(args,name):
  args=list(map(str,args));marker=w/(name+'.done');commands.append(args)
  if marker.exists():print('RESUME completed',name,flush=True);return
  print('RUN',name,' '.join(args),flush=True)
  with (w/(name+'.log')).open('w') as f:subprocess.run(args,cwd=ROOT,env=env,check=True,stdout=f,stderr=subprocess.STDOUT)
  marker.write_text('PASS\n')
 engines={'generic_curve':'generic_curve','generic_tails':'generic_tails_homogeneous','generic_root':'generic_root_hybrid','generic_norm':'generic_norm_shared','norm_gcd':'norm_gcd','factor_support':'factor_support','finite_fibers':'finite_fibers_fast'}
 for binary,source in engines.items():run(['g++','-O3','-std=c++17','-DUSE_GMP_PACKING','-fopenmp',ROOT/'src'/f'{source}.cpp','-lgmp','-o',w/binary],'compile_'+binary)
 chart=ROOT/f'data/function_input_{r}.txt';fc=ROOT/f'data/finite_input_{r}.txt';E=ROOT/'data/Ehat.txt'
 run([w/'generic_curve',chart,E,w/'generic'],'coordinates_E')
 run([w/'generic_tails',chart,w/'generic_coordinates.txt',w/'generic_E.txt',w/'specialized',branch],'norm_series')
 run([w/'generic_root',chart,w/'specialized_U.txt',w/'root'],'square_tails')
 for n in (71,72):run([w/'generic_norm',chart,w/f'root_C{n}.txt',w/f'norm_C{n}'],'scalar'+str(n))
 run([w/'norm_gcd',w/'norm_C71_norm.txt',w/'norm_C72_norm.txt',w/'root_support.txt',w/'unit'],'scalar_gcd')
 rows=(w/'unit_bezout.txt').read_text().splitlines();assert len(rows)==5;(w/'compact_unit.txt').write_text('\n'.join(rows[2:])+'\n')
 run([w/'factor_support',w/'factors.txt',w/'root_support.txt'],'factor_support')
 nf=int((w/'factors.txt').read_text().splitlines()[0])
 for i in range(nf):run([w/'finite_fibers',fc,E,w/'factors.txt',w/'fiber',i,i+1,branch],f'fiber{i}')
 mapping={'C71':w/'root_C71.txt','C72':w/'root_C72.txt','certificate71':w/'norm_C71_certificate.txt','certificate72':w/'norm_C72_certificate.txt','chain71':w/'unit_strip0_chain.txt','chain72':w/'unit_strip1_chain.txt','unit':w/'compact_unit.txt','support':w/'root_support.txt','factors':w/'factors.txt'}
 checks=[]
 for k,p in mapping.items():
  expected=desc['files'][k]['uncompressed_sha256'];actual=sha(p);assert actual==expected,(k,actual,expected);checks.append({'item':k,'sha256':actual,'status':'byte_identity_PASS'})
 for i,m in enumerate(desc['files']['fibers']):
  p=w/f'fiber_f{i}_b{branch}.txt';actual=sha(p);assert actual==m['uncompressed_sha256'];checks.append({'item':f'fiber{i}','sha256':actual,'status':'byte_identity_PASS'})
 report={'status':'PASS','name':a.name,'commands':commands,'checks':checks,'scope':'fresh or hash-tied restarted full reconstruction of tails and all branch certificates'}
 (w/'replay_verification.json').write_text(json.dumps(report,indent=2)+'\n');print('FULL_BRANCH_REGENERATION_AND_COMPARISON=PASS',a.name,flush=True)
if __name__=='__main__':main()
