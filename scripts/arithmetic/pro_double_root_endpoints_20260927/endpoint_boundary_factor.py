"""Expanded global endpoint product Omega=Res_x(t,Rstar).

This is an exact polynomial in the original fraction-free ratio algebra and
nu. Its being a unit on the square scheme follows from the complete endpoint
incidence exclusions, not from inspecting its coefficients.
"""
import gzip,json,hashlib,time,sys
from exact import *
import rank9 as R
from branch_root import weight,ud
from endpoint_geometry import ENDPOINTS,DEST
from endpoint_incidence import coefficient_jets

def scale_product(a,b):
 r=[R.zero() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):r[i+j]=R.plus(r[i+j],R.times(x,y))
 return r

def run(verify=False):
 tic=time.time();prod=[R.one()];factors=[];tt=[1]
 for x in ENDPOINTS:
  tt=pm(tt,[neg(x),1]);raw=coefficient_jets(x)
  vals=[[trim([raw[(i*9+s)*9+j] for i in range(133)]) for j in range(9)] for s in range(4)]
  assert vals[-1]!=R.zero();factors.append({'x_code':x,'nu_coefficients':vals});prod=scale_product(prod,vals)
 assert tt==t and len(prod)==10 and prod[-1]!=R.zero()
 out={'identity':'Omega=product_(t(a)=0) Rstar(nu,a)=Res_x;(3,140)(t,Rstar)',
      'combined_identity':'Res_x(P*t,Rstar)=q^98*(q-<118020>)^84*Lambda^3*Omega',
      'nu_degree':9,'q_basis_rank':9,'coefficient_convention':'nine ascending K[u] lists, indexed by q exponent',
      'nu_coefficients':prod,'factors':factors,
      'weight_bound':max(weight(v) for v in prod),'normal_u_degree':max(ud(v) for v in prod),
      'nonzero_coefficient_count':sum(bool(z) for v in prod for c in v for z in c),
      'unit_status':'proved only together with complete endpoint incidence and nilpotent-lifting certificates'}
 payload=json.dumps(out,separators=(',',':')).encode();dest=DEST/'boundary_factor.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('EXPANDED OMEGA',out['nu_degree'],'scale degree;',out['normal_u_degree'],'u degree;',out['weight_bound'],'weight;',out['nonzero_coefficient_count'],'coefficients; seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':run('--verify' in sys.argv)
