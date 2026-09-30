"""Replay the original source checks and continuation certificates.
The default verifies the global array against archived source digests.
Pass --full-source to independently regenerate all 133 actual source fibres.
"""
from pathlib import Path
import subprocess,sys,time,json
ROOT=Path(__file__).resolve().parent.parent
commands=[
 [sys.executable,'src/verify_all.py'],
 [sys.executable,'src/verify_global_expansion.py'],
 [sys.executable,'src/fibres_u.py','all','--verify'],
 [sys.executable,'src/fibre_geometry.py','--verify'],
 [sys.executable,'src/verify_u_certificates_python.py'],
 [sys.executable,'src/leading_preimage.py','--verify'],
 [sys.executable,'src/test_no_homothetic_descent.py','--verify'],
]
if '--full-source' in sys.argv:
 commands.insert(2,[sys.executable,'src/reconstruct_global.py','133','--verify','--fresh'])
start=time.time();out=[]
print('Python:',sys.version.replace('\n',' '),flush=True)
print(subprocess.check_output(['g++','--version'],text=True).splitlines()[0],flush=True)
for cmd in commands:
 t=time.time();print('\n$',' '.join(cmd),flush=True)
 subprocess.run(cmd,cwd=ROOT,check=True)
 out.append({'command':' '.join(cmd),'status':'passed','seconds':round(time.time()-t,3)})
result={'python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],
        'commands':out,'source_reconstruction_scope':'all 133 fibres freshly rebuilt' if '--full-source' in sys.argv else 'global array checked against all 133 executed source-fibre digests; independent source reconstruction not repeated by this invocation',
        'seconds':round(time.time()-start,3)}
(ROOT/'logs/continuation_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print('\nALL CONTINUATION CHECKS PASSED',json.dumps(result),flush=True)
