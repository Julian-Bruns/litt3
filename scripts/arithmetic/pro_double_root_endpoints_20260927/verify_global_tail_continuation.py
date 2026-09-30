"""Replay all inherited checks and the new global-tail/norm constructions."""
from pathlib import Path
import subprocess,sys,time,json
ROOT=Path(__file__).resolve().parent.parent
commands=[
 [sys.executable,'src/verify_continuation.py'],
 [sys.executable,'src/normalize_jets.py','--verify'],
 [sys.executable,'src/verify_prefix_expansion.py'],
 [sys.executable,'src/norm_element.py','--verify'],
 [sys.executable,'src/verify_new_models.py'],
]
if '--full-prefix' in sys.argv:
 commands += [[sys.executable,'src/prefix_samples.py','1375','--fresh'],[sys.executable,'src/interpolate_prefix.py','--verify']]
start=time.time();out=[]
for cmd in commands:
 t=time.time();print('\n$',' '.join(cmd),flush=True);subprocess.run(cmd,cwd=ROOT,check=True)
 out.append({'command':' '.join(cmd),'status':'passed','seconds':round(time.time()-t,3)})
result={'status':'passed','python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],'commands':out,'seconds':round(time.time()-start,3),'full_prefix_fresh_regeneration': '--full-prefix' in sys.argv}
(ROOT/'logs/global_tail_checks.json').write_text(json.dumps(result,indent=2)+'\n');print('ALL GLOBAL-TAIL CONTINUATION CHECKS PASSED',json.dumps(result),flush=True)
