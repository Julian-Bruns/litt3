"""Combined inherited/new replay for the differential-square continuation.
The global square-locus decision remains open; no bounded checks are
promoted to a global exclusion. No external CAS/service is used.
"""
from pathlib import Path
import subprocess,sys,time,json
ROOT=Path(__file__).resolve().parent.parent
old=[sys.executable,'src/verify_critical_continuation.py']
if '--full-prefix' in sys.argv:old.append('--full-prefix')
commands=[old,
 [sys.executable,'src/test_differential_square.py'],
 [sys.executable,'src/test_differential_compressed.py'],
 [sys.executable,'src/verify_differential_model.py','1','132'],
 [sys.executable,'src/differential_fibre.py','1','--verify'],
 [sys.executable,'src/verify_differential_certificate.py','--compressed','--fresh'],
 [sys.executable,'src/audit_differential_model.py','--verify'],
 [sys.executable,'src/verify_norm_warning.py']]
start=time.time();records=[]
for cmd in commands:
    t=time.time();print('\n$',' '.join(cmd),flush=True)
    subprocess.run(cmd,cwd=ROOT,check=True)
    records.append({'command':' '.join(cmd),'status':'passed','seconds':round(time.time()-t,3)})
result={'status':'passed','python':sys.version,
    'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],
    'commands':records,'seconds':round(time.time()-start,3),
    'old_prefix_1375_samples_freshly_regenerated':'--full-prefix' in sys.argv,
    'actual_full_scale_reference_algebras':[1,132],
    'fresh_differential_source_algebras':[1],
    'differential_row_certificate_freshly_regenerated':True,
    'differential_row_certificate_checked_columns':71,
    'compressed_certificate_dimensions':[56,15],
    'new_ratio_exclusions':0,'total_inherited_ratio_exclusions':281,
    'global_square_locus_decision':'unresolved',
    'new_global_results':'exact112-linear+28-quadratic square presentation; exact14-auxiliary56-linear+28-quadratic compression; proved coefficient-degree bounds'}
(ROOT/'logs/differential_continuation_checks.json').write_text(json.dumps(result,indent=2)+'\n')
lines=['# Executed differential-continuation checks','',
       '**Status: all listed checks passed; global square-locus decision unresolved.**','',
       'Executed versions: '+result['python'].splitlines()[0]+'; '+result['compiler']+'.','',
       '| Command | Outcome | Seconds |','|---|---|---:|']
for r in records:lines.append('| `'+r['command']+'` | '+r['status']+' | '+str(r['seconds'])+' |')
lines+=['','The first command recursively replays the inherited verification suite.',
       'The old1375 prefix samples are digest-replayed by default, not freshly regenerated.',
       'Use `--full-prefix` to request that additional reconstruction.',
       'The u=1 differential certificate is freshly regenerated, then directly verified',
       'against a freshly rebuilt actual source fibre, with polynomial scale untouched.',
       'The full-square comparisons at u=1,<132> retain all141 residual coefficients',
       'and all seven scale coefficients. They are bounded implementation checks.',
       'The universal ideal equivalence is proved in REPORT24–25, not inferred from them.',
       'No global polynomial-row certificate or complete square witness is claimed.',
       'No new ratio point is counted: the verified u=1 fibre was already excluded.','']
(ROOT/'logs/DIFFERENTIAL_EXECUTED_CHECKS.md').write_text('\n'.join(lines))
print('ALL DIFFERENTIAL CONTINUATION CHECKS PASSED',json.dumps(result),flush=True)
