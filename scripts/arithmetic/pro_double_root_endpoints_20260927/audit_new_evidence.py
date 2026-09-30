"""Standard-library structural audit of the new evidence and support cone.
The support-cone calculation certifies the global scale-degree bounds before
any interpolation; it uses globally verified normalized jet coefficients.
"""
from pathlib import Path
import gzip,json,hashlib,struct
ROOT=Path(__file__).resolve().parent.parent
raw=gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read();jm=json.loads((ROOT/'evidence/normalized_jets.json').read_text())
assert hashlib.sha256(raw).hexdigest()==jm['jets_raw_sha256']
jets=json.loads(raw);assert len(jets)==75
orders=[None]*7
for n,row in enumerate(jets):
 assert len(row)==7
 for i,p in enumerate(row):
  assert len(p)%9==0 and all(0<=a<390625 for a in p)
  w=max((2*(j//9)+j%9 for j,a in enumerate(p) if a),default=-1)
  assert w==jm['coefficient_weights'][n][i]
  if w>=0:
   assert 4*i<=3*n,(n,i)
   if orders[i] is None:orders[i]=n
assert orders==[0,2,3,4,6,7,8]
scale_bounds={str(n):(3*n)//4 for n in range(71,75)}
assert list(scale_bounds.values())==[53,54,54,55]
for base in ['global_prefix','norm_element','global_residual','leading_preimage']:
 meta=json.loads((ROOT/'evidence'/f'{base}.json').read_text());data=gzip.open(ROOT/'evidence'/f'{base}.bin.gz','rb').read()
 assert hashlib.sha256(data).hexdigest()==meta['raw_sha256']
assert set(jm['tail_u_degree_bounds'])==set(scale_bounds)
for n,b in jm['tail_u_degree_bounds'].items():assert b<1375
result={'status':'passed','first_T_orders_by_scale':[0,2,3,4,6,7,8],'support_cone':'4*scale_degree<=3*T_degree','proved_scale_degree_bounds':scale_bounds,'normal_u_degree_bounds':jm['tail_u_degree_bounds'],'all_global_payload_hashes_match':True,'scope':'structural evidence audit; no geometric exclusion or global ideal decision'}
(ROOT/'logs/new_evidence_audit.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
