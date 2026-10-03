#!/usr/bin/env python3
"""Nine NEW pole4 marked-gap factor representatives; skip completed prototype."""
import json, os, subprocess, time, signal
from pathlib import Path

root=Path('/Users/julian/Documents/litt3')
folder=root.parent/'litt3-computation-data'/'oct02_m9_uniform'
output=folder/'pole4_gap_source_batch.json'
started=time.monotonic()
result={'scope':'Ten marked-root factors at omission0, completed factor6 prototype preserved. Arithmetic Frobenius25 and full geometric selected strata cover all omissions.','new_records':[],'preserved_prototype':str(folder/'pole4_gap_source_factor06_omit00.json')}
env=dict(os.environ,OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1')
def save():
 result['seconds']=time.monotonic()-started
 output.write_text(json.dumps(result,indent=2)+'\n')
for index in [0,1,2,3,4,5,7,8,9]:
 if time.monotonic()-started>145:result['stopped']='aggregate budget';save();break
 case=folder/('pole4_gap_source_factor%02d_omit00.json'%index)
 if case.exists() and json.loads(case.read_text()).get('complete'):
  result['stopped']='unexpected completed input; do not replay';save();break
 proc=subprocess.Popen(['sage',str(root/'scripts/oct02_m9_uniform_pole4_gap_source_prototype.sage'),'--factor-index',str(index),'--omission-index','0'],cwd=root,env=env,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,start_new_session=True)
 try:log=proc.communicate(timeout=min(35,180-(time.monotonic()-started)))[0]
 except subprocess.TimeoutExpired:
  os.killpg(proc.pid,signal.SIGTERM);log=proc.communicate()[0];result['stopped']='case or aggregate hard timeout'
 data=json.loads(case.read_text()) if case.exists() else {}
 record={'factor_index':index,'returncode':proc.returncode,'complete':data.get('complete',False),'all_inconsistent':data.get('all_inconsistent',False),'gap_zero_relative_pairs':data.get('gap_zero_relative_pairs'),'seconds':data.get('seconds'),'output':str(case),'log':log[-2000:]}
 result['new_records'].append(record);save();print(index,record['complete'],record['all_inconsistent'],record['seconds'],flush=True)
 if proc.returncode or not record['complete'] or not record['all_inconsistent']:
  result['stopped']='failure or consistent stratum; inspect before continuing';save();break
else:
 proto=json.loads((folder/'pole4_gap_source_factor06_omit00.json').read_text())
 result['complete']=True;result['all_inconsistent']=proto['all_inconsistent'] and all(r['all_inconsistent'] for r in result['new_records']);save()
