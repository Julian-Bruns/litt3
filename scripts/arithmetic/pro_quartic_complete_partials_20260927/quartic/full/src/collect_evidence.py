#!/usr/bin/env python3
"""Collect complete local executions; reject incomplete coverage or differing survivors."""
from pathlib import Path
import json,gzip,hashlib
ROOT=Path(__file__).resolve().parents[2]
KEYS=['pairs','first_projection_zero','Z_zero','norm_boundary','generic_Z_zero','T_zero','eq3_zero','eq4_zero']
def read_run(name):
 log=[json.loads(t)for t in (ROOT/f'build/{name}_summary.jsonl').read_text().splitlines()if t]
 assert log[-1]['kind']=='completed' and log[-1]['start']==0 and log[-1]['stop']==9776
 rows=sorted((r for r in log if r.get('kind')=='full_scan_h_summary'),key=lambda r:r['h_index'])
 assert [r['h_index']for r in rows]==list(range(9776))
 assert all(r['pairs']==812*(r['h_index']+1)for r in rows)
 candidates=sorted((json.loads(t)for t in (ROOT/f'build/{name}_candidates.jsonl').read_text().splitlines()if t),key=lambda r:(r['h_index'],r['q_index'],r['orbit']))
 assert len(candidates)==sum(r['generic_Z_zero']for r in rows)==6
 assert not sum(r['T_zero']for r in rows)
 prep=next(r for r in log if r.get('kind')=='prepared')
 result={k:sum(r[k]for r in rows)for k in KEYS}
 result.update({'status':'COMPLETE','scope':[0,9776],'h_rows':9776,'first_projection':prep.get('first_projection',0),'threads':prep['threads'],'seconds':log[-1]['seconds']})
 for r in rows:r.pop('seconds',None)
 return result,rows,candidates
primary,rows,candidates=read_run('final');initial,rows0,candidates0=read_run('full')
assert candidates==candidates0
for r,s in zip(rows,rows0):assert {k:v for k,v in r.items()if k!='first_projection_zero'}=={k:v for k,v in s.items()if k!='first_projection_zero'}
E=ROOT/'full/evidence';E.mkdir(exist_ok=True)
with (E/'scan_rows.jsonl.gz').open('wb')as raw:
 with gzip.GzipFile(fileobj=raw,mode='wb',mtime=0,filename='')as gz:
  for r in rows:gz.write((json.dumps(r,sort_keys=True,separators=(',',':'))+'\n').encode())
(E/'generic_survivors.jsonl').write_text(''.join(json.dumps(r,sort_keys=True,separators=(',',':'))+'\n'for r in candidates))
b=[json.loads(t)for t in (ROOT/'build/boundary_fresh_summary.jsonl').read_text().splitlines()if t][-1]
assert b['kind']=='summary' and b['start']==0 and b['stop']==9776 and b['tested']==9740288 and b['linear_consistent']==5 and not b['rank4_quadric_pass'] and not b['consistent_lower_rank']
(E/'boundary_summary.json').write_text(json.dumps(b,indent=2,sort_keys=True)+'\n')
(E/'boundary_survivors.jsonl').write_text((ROOT/'build/boundary_fresh_candidates.jsonl').read_text())
info={'decision':'EMPTY','status':'COMPLETE','primary':primary,'different_projection_complete_crosscheck':initial,'all_h_row_counts_except_first_projection_equal':True,'exact_survivor_lists_equal':True,'canonical_rows_sha256':hashlib.sha256(''.join(json.dumps(r,sort_keys=True,separators=(',',':'))+'\n'for r in rows).encode()).hexdigest()}
(E/'scan_summary.json').write_text(json.dumps(info,indent=2,sort_keys=True)+'\n')
# Keep only evidence-bearing startup/footer excerpts; the complete mathematical row sequence is compressed separately.
lines=[]
for name in ['full','final','boundary_fresh','portable']:
 log=[json.loads(t)for t in (ROOT/f'build/{name}_summary.jsonl').read_text().splitlines()if t]
 selected=[r for r in log if r.get('kind')not in {'full_scan_h_summary'} and r.get('stage')!='progress']
 if name=='portable':selected=log
 lines+=['RUN '+name]+[json.dumps(r,sort_keys=True)for r in selected]
(E/'execution_excerpts.log').write_text('\n'.join(lines)+'\n')
print(json.dumps(info,indent=2,sort_keys=True))
