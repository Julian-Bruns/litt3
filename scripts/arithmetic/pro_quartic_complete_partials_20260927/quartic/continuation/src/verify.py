#!/usr/bin/env python3
"""Compact verification, or full regeneration of the stated continuation strata.
A PASS result is not a whole-chart mathematical existence decision.
Run from any directory; outputs stay under the extracted archive's build/.
"""
from pathlib import Path
import argparse,subprocess,sys,json,gzip,hashlib,time,platform
ROOT=Path(__file__).resolve().parents[2];BUILD=ROOT/'build';BUILD.mkdir(exist_ok=True)
p=argparse.ArgumentParser();p.add_argument('--full',action='store_true');p.add_argument('--jobs',type=int,default=4);a=p.parse_args();checks=[]
def run(cmd,stdout=None,stderr=None):
 begin=time.monotonic();r=subprocess.run(cmd,cwd=ROOT,capture_output=True,text=True)
 if stdout:(ROOT/stdout).write_text(r.stdout)
 if stderr:(ROOT/stderr).write_text(r.stderr)
 rec={'command':cmd,'status':'PASS' if r.returncode==0 else 'FAIL','seconds':round(time.monotonic()-begin,3)};checks.append(rec)
 if r.returncode:
  print(r.stdout);print(r.stderr,file=sys.stderr);raise RuntimeError(str(cmd))
 print('PASS',' '.join(cmd),flush=True);return r
manifest=ROOT/'SHA256SUMS'
if manifest.exists():
 n=0
 for line in manifest.read_text().splitlines():
  h,path=line.split('  ',1);got=hashlib.sha256((ROOT/path).read_bytes()).hexdigest();assert got==h,path;n+=1
 checks.append({'command':['internal SHA256 manifest verification'],'status':'PASS','files':n});print('PASS SHA256 manifest',n,flush=True)
run([sys.executable,'src/run_checks.py'])
run([sys.executable,'continuation/src/replay_boundary.py'])
for name in ['check_generic','check_circuit','boundary_scan','generic_scan']:
 run(['g++','-O3','-std=c++17','-Wall','-Wextra',f'continuation/src/{name}.cpp','-o',f'build/{name}'])
run(['build/check_generic'],'build/recheck_generic_samples.jsonl','build/recheck_generic_counts.json')
assert (BUILD/'recheck_generic_samples.jsonl').read_bytes()==(ROOT/'continuation/evidence/generic_formula_samples.jsonl').read_bytes()
assert json.loads((BUILD/'recheck_generic_counts.json').read_text())==json.loads((ROOT/'continuation/evidence/generic_formula_checks.json').read_text())
run([sys.executable,'continuation/src/replay_generic_formula.py'])
run([sys.executable,'continuation/src/build_circuit.py','--output','build/recheck_circuit'])
with gzip.open(BUILD/'recheck_circuit.json.gz','rt') as f:new=json.load(f)
with gzip.open(ROOT/'continuation/evidence/residual_circuit.json.gz','rt') as f:old=json.load(f)
assert new==old
run(['build/check_circuit','build/recheck_circuit.txt'],'build/recheck_circuit_samples.jsonl','build/recheck_circuit_counts.json')
assert (BUILD/'recheck_circuit_samples.jsonl').read_bytes()==(ROOT/'continuation/evidence/circuit_samples.jsonl').read_bytes()
assert json.loads((BUILD/'recheck_circuit_counts.json').read_text())==json.loads((ROOT/'continuation/evidence/circuit_checks.json').read_text())
run([sys.executable,'continuation/src/replay_circuit.py'])
if a.full:
 # Use fresh names for verification. Resume only unchanged source in these directories.
 run([sys.executable,'continuation/src/run_boundary.py','--jobs',str(a.jobs),'--output','build/full_verify_boundary'])
 old=json.loads((ROOT/'continuation/evidence/boundary_summary.json').read_text());new=json.loads((BUILD/'full_verify_boundary/summary.json').read_text())
 keys=['tested','norm_c_only','norm_e_only','both_norms_equal','rank_counts','consistent_rank_counts','linear_consistent','rank4_quadric_pass','consistent_lower_rank']
 assert new['execution_status']=='COMPLETE' and all(old[k]==new[k] for k in keys)
 assert len(old['chunks'])==len(new['chunks'])==20
 for x,y in zip(old['chunks'],new['chunks']):assert all(x[k]==y[k] for k in keys+['start','stop'])
 got=[]
 for f in sorted((BUILD/'full_verify_boundary').glob('*.jsonl.gz')):
  with gzip.open(f,'rt') as g:got += [json.loads(s) for s in g]
 with gzip.open(ROOT/'continuation/evidence/boundary_survivors.jsonl.gz','rt') as f:expected=[json.loads(s) for s in f]
 key=lambda r:(r['q_index'],r['H']);assert sorted(got,key=key)==sorted(expected,key=key)
 run([sys.executable,'continuation/src/run_generic.py','--jobs',str(a.jobs),'--mode','two-phase','--output','build/full_verify_two_phase'])
 old=json.loads((ROOT/'continuation/evidence/two_phase_summary.json').read_text());new=json.loads((BUILD/'full_verify_two_phase/summary.json').read_text())
 keys=['total','admissible','norm_boundary_skipped','generic_tested','Z_pass','T_pass','eq3_pass','eq4_pass']
 assert new['execution_status']=='COMPLETE' and all(old[k]==new[k] for k in keys)
 assert len(old['chunks'])==len(new['chunks'])==128
 for x,y in zip(old['chunks'],new['chunks']):assert all(x[k]==y[k] for k in keys+['q_index','Q'])
 for f in (BUILD/'full_verify_two_phase').glob('*.jsonl.gz'):
  with gzip.open(f,'rb') as g:assert g.read()==b''
 checks.append({'command':['compare regenerated mathematical counters and all survivor streams'],'status':'PASS'})
summary={'status':'PASS','mode':'full_stated_continuation_strata' if a.full else 'compact_replay_only','global_existence_decision':'UNRESOLVED','checks':checks,'software':{'python':platform.python_version(),'compiler':subprocess.run(['g++','--version'],capture_output=True,text=True).stdout.splitlines()[0],'platform':platform.platform()}}
(BUILD/'continuation_verification.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k!='checks'},indent=2))
