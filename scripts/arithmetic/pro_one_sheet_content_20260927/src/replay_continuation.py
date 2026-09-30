"""Replay the completed continuation certificates; no global-locus claim."""
from pathlib import Path
import subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
LOG=ROOT/'build'/'continuation_replay_logs';LOG.mkdir(parents=True,exist_ok=True)
def run(args,name):
    print('RUN',' '.join(map(str,args)),flush=True)
    with (LOG/name).open('w') as f:subprocess.run(list(map(str,args)),cwd=ROOT,stdout=f,stderr=subprocess.STDOUT,check=True)
for name in ['integral_chart','J_input','function_input','finite_input','degree_drop']:
    run([sys.executable,'src/'+name+'.py'],name+'.log')
run(['g++','-O3','-std=c++17','src/J_tails.cpp','-o','build/J_tails'],'compile_J_tails.log')
for r in [145049,211895,211959]:
    run(['build/J_tails',f'data/J_input_{r}.txt','data/Ehat.txt',f'evidence/J_tails_{r}.txt'],f'J_tails_{r}.log')
run([sys.executable,'src/verify_J.py'],'verify_J.log')
print('PASS: integral chart identities and all twelve complete J-boundary exclusions.',flush=True)
