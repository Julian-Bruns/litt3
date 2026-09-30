"""Replay every claimed computational check from the included sources."""
from pathlib import Path
import subprocess,sys,time,platform,json
ROOT=Path(__file__).resolve().parent.parent
commands=[
 ['g++','-O3','-std=c++17','-fPIC','-shared','src/field.cpp','-o','src/libfield.so'],
 [sys.executable,'src/exact.py'],
 [sys.executable,'src/source.py'],
 [sys.executable,'src/cramer.py'],
 [sys.executable,'src/factor.py'],
 [sys.executable,'src/extension.py'],
 [sys.executable,'src/residual.py'],
 [sys.executable,'src/global_source.py'],
 [sys.executable,'src/boundaries.py','all','--verify'],
 [sys.executable,'src/boundary_geometry.py'],
 [sys.executable,'src/verify_certificates_python.py'],
 [sys.executable,'src/test_square_circuit.py'],
 [sys.executable,'src/test_global_scaling.py']
]
print('Python:',sys.version.replace('\n',' '),flush=True)
print(subprocess.check_output(['g++','--version'],text=True).splitlines()[0],flush=True)
start=time.time();out=[]
for cmd in commands:
 t=time.time();print('\n$',' '.join(cmd),flush=True)
 subprocess.run(cmd,cwd=ROOT,check=True)
 out.append({'command':' '.join(cmd),'status':'passed','seconds':round(time.time()-t,3)})
print('\nALL 13 COMMANDS PASSED; seconds',round(time.time()-start,3),flush=True)
(ROOT/'logs/executed_checks.json').write_text(json.dumps({'python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],'commands':out},indent=2)+'\n')
