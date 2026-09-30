"""All 141 coefficients against the separate actual global residual, followed
by an independent formal-root recurrence for both exclusion tails.
"""
import ctypes as ct,json,gzip,struct,hashlib,time,sys
from exact import *
from endpoint_geometry import ENDPOINTS,DEST
from fast_arithmetic import library

def run(x,label):
 tic=time.time();c=json.loads(gzip.open(DEST/f'certificate_{x}_{label}.json.gz','rb').read());M=c['modulus'];d=len(M)-1
 def buf(v,n):return (ct.c_int*n)(*(v+[0]*(n-len(v))))
 raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read();a=struct.unpack('<%dI'%(len(raw)//4),raw)
 norm=(ct.c_int*(141*d))();IP=ct.POINTER(ct.c_int)
 if label=='quartic':
  l=library('finite_norm_image');l.finite_image_residual_values.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP,IP]
  status=l.finite_image_residual_values(buf(list(a),len(a)),133,buf(M,d+1),d,buf(c['q'],d),buf(c['u'],d),buf(c['nu'],d),norm)
 else:
  l=library();l.finite_residual_values.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP]
  status=l.finite_residual_values(buf(list(a),len(a)),133,buf(M,d+1),d,buf(c['u'],d),buf(c['nu'],d),norm)
 assert status==0,status
 digest=hashlib.sha256(struct.pack('<%dI'%len(norm),*norm)).hexdigest();assert digest==c['actual_norm_sha256']
 l2=library('endpoint_tail_recurrence');l2.endpoint_root_recurrence.argtypes=[IP,IP,ct.c_int,IP]
 out=(ct.c_int*(2*d))();status=l2.endpoint_root_recurrence(norm,buf(M,d+1),d,out);assert status==0,status
 tt=[trim(list(out[i*d:(i+1)*d])) for i in range(2)];assert tt==c['tails_71_72']
 rec={'x_code':x,'label':label,'status':'passed','dimension':d,'actual_coefficients_compared':141,
   'actual_norm_sha256':digest,'norm_path':'separate q^4*Rtilde global array, all 141 x coefficients',
   'tail_path':'coefficient recurrence 2*b_n=A_n-sum_(i=1)^(n-1)b_i*b_(n-i)',
   'tails_compared':[71,72],'seconds':round(time.time()-tic,3)}
 (ROOT/'logs'/f'endpoint_residual_{x}_{label}.json').write_text(json.dumps(rec,indent=2)+'\n')
 print('INDEPENDENT FULL RESIDUAL AND ROOT RECURRENCE',x,label,d,'seconds',rec['seconds'],flush=True)
 return rec
if __name__=='__main__':
 if len(sys.argv)>1:run(int(sys.argv[1]),sys.argv[2])
 else:
  for x in ENDPOINTS:
   for label in ['0','4','quartic']:run(x,label)
