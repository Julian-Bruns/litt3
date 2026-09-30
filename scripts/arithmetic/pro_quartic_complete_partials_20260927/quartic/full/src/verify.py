#!/usr/bin/env python3
"""Compact proof replay: hashes, universal identities, complete-run counters,
and every decisive survivor. It does not rerun the exhaustive scans by default.
"""
from pathlib import Path
import argparse,json,gzip,hashlib,subprocess,sys,platform,time
ROOT=Path(__file__).resolve().parents[2]
KEYS=['pairs','first_projection_zero','Z_zero','norm_boundary','generic_Z_zero','T_zero','eq3_zero','eq4_zero']
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--skip-manifest',action='store_true',help='For development before rebuilding the archive only.');p.add_argument('--inherited-compact',action='store_true');a=p.parse_args()
 build=ROOT/'build/full_verify';build.mkdir(parents=True,exist_ok=True);checks=[]
 if not a.skip_manifest:
  count=0
  for line in (ROOT/'SHA256SUMS').read_text().splitlines():
   digest,name=line.split('  ',1);h=hashlib.sha256()
   with (ROOT/name).open('rb')as f:
    for block in iter(lambda:f.read(1<<20),b''):h.update(block)
   assert h.hexdigest()==digest,name;count+=1
  checks.append({'check':'SHA-256 manifest','status':'PASS','files':count})
 summary=json.loads((ROOT/'full/evidence/scan_summary.json').read_text())
 assert summary['status']=='COMPLETE' and summary['decision']=='EMPTY'
 with gzip.open(ROOT/'full/evidence/scan_rows.jsonl.gz','rt')as f:rows=[json.loads(t)for t in f if t.strip()]
 assert len(rows)==9776 and [r['h_index']for r in rows]==list(range(9776))
 assert all(r['pairs']==812*(r['h_index']+1)for r in rows)
 raw=''.join(json.dumps(r,sort_keys=True,separators=(',',':'))+'\n'for r in rows).encode()
 assert hashlib.sha256(raw).hexdigest()==summary['canonical_rows_sha256']
 for k in KEYS:assert sum(r[k]for r in rows)==summary['primary'][k],k
 assert summary['primary']['pairs']==38805460512 and summary['primary']['generic_Z_zero']==6 and summary['primary']['T_zero']==0
 assert summary['all_h_row_counts_except_first_projection_equal'] and summary['exact_survivor_lists_equal']
 for k in KEYS:
  if k!='first_projection_zero':assert summary['primary'][k]==summary['different_projection_complete_crosscheck'][k]
 records=[json.loads(t)for t in (ROOT/'full/evidence/generic_survivors.jsonl').read_text().splitlines()if t]
 assert len(records)==6 and all(r['kind']=='generic_Z_candidate'for r in records)
 for row in rows:assert row['generic_Z_zero']==sum(r['h_index']==row['h_index']for r in records)
 b=json.loads((ROOT/'full/evidence/boundary_summary.json').read_text())
 assert (b['start'],b['stop'],b['tested'])==(0,9776,9740288)
 assert b['rank_counts']==[0,0,288144,1436,9450708]
 assert b['consistent_rank_counts']==[0,0,0,0,5] and b['linear_consistent']==5
 assert b['consistent_lower_rank']==0 and b['rank4_quadric_pass']==0
 checks.append({'check':'Retained complete-run coverage, sums and survivor accounting','status':'PASS','generic_pair_tests':38805460512,'boundary_pair_tests':9740288,'scope':'Completed run records; scans not rerun by this compact verifier'})
 for script,evidence in [('verify_factorization.py','factorization_verified.json'),('replay_survivors.py','survivor_replay.json')]:
  cmd=[sys.executable,'full/src/'+script];t=time.monotonic();run=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True)
  (build/(script+'.stdout')).write_text(run.stdout)
  if run.returncode:raise RuntimeError(run.stdout+run.stderr)
  actual=json.loads(run.stdout);expected=json.loads((ROOT/'full/evidence'/evidence).read_text());assert actual==expected,script
  checks.append({'command':cmd,'status':'PASS','exact_retained_record_match':True,'seconds':round(time.monotonic()-t,6)})
 if a.inherited_compact:
  cmd=[sys.executable,'structural/src/verify.py','--inherited-compact'];run=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True)
  (build/'historical_compact.stdout').write_text(run.stdout)
  if run.returncode:raise RuntimeError(run.stdout+run.stderr)
  checks.append({'command':cmd,'status':'PASS','scope':'Historical reusable results; not needed for complete decision'})
 result={'status':'PASS','decision':'EMPTY','mathematical_status':'COMPLETE','exhaustive_scans_rerun':False,'software':{'python':platform.python_version()},'checks':checks}
 (build/'verification.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n');print(json.dumps(result,indent=2,sort_keys=True))
if __name__=='__main__':main()
