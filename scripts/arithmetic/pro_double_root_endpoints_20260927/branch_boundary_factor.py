"""Expand the degree-19 branch factor which is a unit on the true square scheme.
The unit assertion uses the complete ten-branch exclusion proofs. This script
verifies the exact polynomial product and stores its full rank-nine form.
"""
from exact import ROOT
import rank9 as R
from branch_root import weight,ud
from branch_geometry import ROOTS
import gzip,json,time,sys,hashlib

def run(verify=False):
 tic=time.time();out=[R.one()];unit={'q':0,'d_monic':0,'u':0};factors=[]
 for x in ROOTS:
  d=json.loads(gzip.open(ROOT/'evidence/branch_root'/f'geometry_x_{x}.json.gz','rb').read())
  c=d['components']['components'][0];p=c['nu_coefficients'][:]
  while p and p[-1]==R.zero():p.pop()
  new=[R.zero() for _ in range(len(out)+len(p)-1)]
  for i,a in enumerate(out):
   for j,b in enumerate(p):new[i+j]=R.plus(new[i+j],R.times(a,b))
  out=new
  for k in unit:unit[k]+=c['stripped_common_units'][k]
  factors.append({'x_code':x,'nu_degree':len(p)-1})
  print('BRANCH FACTOR PRODUCT',x,'nu degree',len(out)-1,flush=True)
 assert len(out)==20 and out[-1]!=R.zero()
 data={'name':'Lambda','nu_degree':19,'factors':factors,'nu_coefficients':out,
       'coefficient_ring':'K[u,q]/g_monic','coefficient_order':'nu, q, u; ascending at every level',
       'identity':'product_(P(a)=0) Theta_0(a,tau=q^2*nu)=q^N*(q-droot)^M*u^J*Lambda',
       'stripped_common_unit_powers':unit,'parameter_weight_bound':564,
       'actual_parameter_weight':max(weight(p) for p in out),'actual_u_degree':max(ud(p) for p in out),
       'unit_on_complete_square_scheme':'proved by the ten complete branch exclusions, not by this product calculation alone'}
 assert data['actual_parameter_weight']<=564
 payload=json.dumps(data,separators=(',',':')).encode();dest=ROOT/'evidence/branch_root/boundary_factor.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('GLOBAL BRANCH FACTOR',data['nu_degree'],data['actual_u_degree'],data['actual_parameter_weight'],unit,
       'sha256',hashlib.sha256(payload).hexdigest(),'seconds',round(time.time()-tic,3),flush=True)
 return data
if __name__=='__main__':run('--verify' in sys.argv)
