"""Combined replay for the critical-discriminant / complete-square continuation.
No external CAS or service is used. The default preserves the inherited
1375-sample digest replay; --full-prefix requests fresh sample regeneration.
"""
from pathlib import Path
import subprocess,sys,time,json
ROOT=Path(__file__).resolve().parent.parent
old=[sys.executable,'src/verify_global_tail_continuation.py']
if '--full-prefix' in sys.argv:old.append('--full-prefix')
commands=[old,
 [sys.executable,'src/normalize_full_jets.py','--verify'],
 [sys.executable,'src/verify_critical_identity.py'],
 [sys.executable,'src/critical_model.py','--verify'],
 [sys.executable,'src/critical_nonsplit.py','--verify'],
 [sys.executable,'src/critical_certificate.py','--verify'],
 [sys.executable,'src/test_cartier_square.py'],
 [sys.executable,'src/verify_full_square_model.py','1','132'],
 [sys.executable,'src/audit_critical_evidence.py']]
start=time.time();out=[]
for cmd in commands:
 t=time.time();print('\n$',' '.join(cmd),flush=True)
 subprocess.run(cmd,cwd=ROOT,check=True)
 out.append({'command':' '.join(cmd),'status':'passed','seconds':round(time.time()-t,3)})
result={'status':'passed','python':sys.version,
 'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],
 'commands':out,'seconds':round(time.time()-start,3),
 'full_prefix_fresh_regeneration':'--full-prefix' in sys.argv,
 'actual_critical_source_algebras_freshly_reconstructed':38,
 'actual_full_scale_reference_algebras':[1,132],
 'global_square_locus_decision':'unresolved',
 'new_global_certificate':'critical quadratic discriminant nonsquare, not residual-square exclusion'}
(ROOT/'logs/critical_continuation_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print('ALL CRITICAL CONTINUATION CHECKS PASSED',json.dumps(result),flush=True)
