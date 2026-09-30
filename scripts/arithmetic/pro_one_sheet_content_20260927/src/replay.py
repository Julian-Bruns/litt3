"""Rebuild all distributed exact evidence. Generated intermediates are restartable."""
from pathlib import Path
import subprocess,sys,json,hashlib
ROOT=Path(__file__).resolve().parents[1]
(ROOT/'build').mkdir(exist_ok=True)
LOG=ROOT/'build'/'replay_logs';LOG.mkdir(exist_ok=True)
def run(args,name):
 print('RUN',' '.join(map(str,args)),flush=True)
 with open(LOG/name,'w') as f:subprocess.run(list(map(str,args)),cwd=ROOT,stdout=f,stderr=subprocess.STDOUT,check=True)
for name in ['reconstruct','normalize','endpoints','monic_chart','model_input','boundary_input']:
 run([sys.executable,'src/'+name+'.py'],name+'.log')
for name in ['build_model','build_fixed','boundary_tails','audit_resultant']:
 run(['g++','-O3','-std=c++17','src/'+name+'.cpp','-o','build/'+name],'compile_'+name+'.log')
run(['build/audit_resultant'],'audit_resultant.log')
run(['build/build_model','data/model_input.txt','data/Ehat.txt'],'compact_model.log')
run(['build/build_fixed','data/Ehat.txt','data/B1_factor_jobs.txt','data'],'fixed_models.log')
run(['build/boundary_tails','data/B1_factor_jobs.txt','data','evidence'],'boundary_tails.log')
run([sys.executable,'src/verify_boundary.py'],'verify_boundary.log')
print('PASS: all reconstruction, tail-recursion and independent Bezout checks completed.',flush=True)
