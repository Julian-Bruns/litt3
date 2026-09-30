"""Independent literal Bezout and finite-algebra presentation checks.

The quartic presentation is checked by direct substitution of M, H, and u(q),
not by trusting Berlekamp--Massey or its moment data. Equality of dimensions
and z=nu+cq prove the whole-algebra isomorphism, including any nilpotents.
"""
import ctypes as ct,json,gzip,time
from exact import *
from endpoint_geometry import ENDPOINTS,DEST
from fast_arithmetic import library

def run():
 tic=time.time();lib=library('endpoint_tower');IP=ct.POINTER(ct.c_int)
 lib.endpoint_verify_presentation.argtypes=[IP,ct.c_int,IP,IP,IP,IP,ct.c_int,IP,ct.c_int,IP,ct.c_int]
 records=[]
 for x in ENDPOINTS:
  p=json.loads(gzip.open(DEST/f'primitive_{x}.json.gz','rb').read());N=p['modulus'];n=len(N)-1;M=p['base_modulus'];d=len(M)-1;H=p['scale_modulus'];e=len(H)-1
  assert n==p['dimension']==d*e==1584 and N[-1]==M[-1]==1 and H[-1]==[1]
  assert pgcd(N,pder(N))==[1]
  h=p['cauchy_numerator'];a,b=p['cauchy_bezout'];assert pa(pm(h,a),pm(N,b))==[1]
  assert not prem(ps(pm(p['q'],h),p['q_cauchy_numerator']),N)
  assert not prem(ps(pm(p['u'],h),p['u_cauchy_numerator']),N)
  assert not prem(ps(pa(p['nu'],pc(p['q'],p['auxiliary_shift_K_code'])),[0,1]),N)
  def buf(v,n):return (ct.c_int*n)(*(v+[0]*(n-len(v))))
  gs=[v for hh in H[:-1] for v in hh+[0]*(d-len(hh))]
  status=lib.endpoint_verify_presentation(buf(N,n+1),n,buf(p['q'],n),buf(p['u'],n),buf(p['nu'],n),buf(M,d+1),d,buf(gs,len(gs)),e,buf(p['base_u'],d),p['auxiliary_shift_K_code'])
  assert status==0,('direct tower presentation',x,status)
  for label in ['0','4','quartic']:
   c=json.loads(gzip.open(DEST/f'certificate_{x}_{label}.json.gz','rb').read());mod=c['modulus'];a,b=c['tails_71_72'];s,t,r=c['bezout_tail71_tail72_modulus']
   assert pa(pa(pm(s,a),pm(t,b)),pm(r,mod))==[1]
   assert pgcd(a,mod)==[1]
   if label=='quartic':
    assert mod==N and c['q']==p['q'] and c['u']==p['u'] and c['nu']==p['nu']
   records.append({'x_code':x,'label':label,'dimension':len(mod)-1,'tail71_is_unit':True})
   print('INDEPENDENT ENDPOINT BEZOUT',x,label,len(mod)-1,flush=True)
  print('DIRECT COMPLETE QUARTIC PRESENTATION VERIFIED',x,n,flush=True)
 obj={'status':'passed','literal_square_tail_identities':9,'literal_cauchy_identities':3,
   'direct_quartic_presentations':3,'certificates':records,
   'presentation_method':'direct polynomial substitution; surjectivity from z=nu+cq and equal dimensions',
   'bezout_product_method':'independent schoolbook K-polynomial multiplication',
   'global_square_decision':'unresolved','seconds':round(time.time()-tic,3)}
 (ROOT/'logs/endpoint_certificates_independent.json').write_text(json.dumps(obj,indent=2)+'\n')
 print('ALL ENDPOINT UNIT AND PRESENTATION CERTIFICATES VERIFIED',obj['seconds'],flush=True)
 return obj
if __name__=='__main__':run()
