"""Exact square-unit/scale normalization for the ratio-only eliminant.

Rstar(nu,x)=q^-48 Rtilde(q^2 nu,x). Every coefficient division is exact
in K[u,q]/g, without parameter localization in the returned polynomial.
The original allowed open has q!=0, so this preserves its entire square ideal.
The regenerated array is a cache, not an additional source dependency.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib,sys
from exact import ROOT,DATA,neg,div
N=133;NX=141;D=9
CACHE=ROOT/'work/ratio_eliminant';CACHE.mkdir(parents=True,exist_ok=True)
META=ROOT/'evidence/ratio_eliminant_normalization.json'

def library():
 p=ROOT/'src/libglobaldivision.so';s=ROOT/'src/global_division.cpp'
 if not p.exists() or p.stat().st_mtime<s.stat().st_mtime:
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(s),'-o',str(p)],check=True)
 lib=ct.CDLL(str(p));lib.ff_init();IP=ct.POINTER(ct.c_int)
 lib.div_q_linear.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP]
 return lib

def build(verify=False,valuations=True):
 start=time.time();lib=library();src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
 for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
 gs=(ct.c_int*30)(*gs)
 raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read();old=struct.unpack('<%dI'%(len(raw)//4),raw)
 result=[0]*len(old)
 for s in range(7):
  flat=[old[((iu*7+s)*NX+x)*D+j] for iu in range(N) for x in range(NX) for j in range(D)]
  a=(ct.c_int*len(flat))(*flat);b=(ct.c_int*len(flat))()
  for k in range(48-2*s):
   assert lib.div_q_linear(a,N,NX,gs,0,b)==0,(s,k)
   a,b=b,a
  for iu in range(N):
   for x in range(NX):
    for j in range(D):result[((iu*7+s)*NX+x)*D+j]=a[(iu*NX+x)*D+j]
 payload=struct.pack('<%dI'%len(result),*result)
 weights=[];vals=[];dr=neg(div(DATA['d'][0],DATA['d'][1]));p=(ct.c_int*(N*D))();o=(ct.c_int*(N*D))()
 for t in range(NX):
  ww=[];vv=[]
  for s in range(7):
   ar=[result[((iu*7+s)*NX+140-t)*D+j] for iu in range(N) for j in range(D)]
   ww.append(max((2*iu+j for iu in range(N) for j in range(D) if ar[iu*D+j]),default=-1))
   if not any(ar):vv.append(None);continue
   val={'u':min(iu for iu in range(N) if any(ar[iu*D:(iu+1)*D]))}
   if valuations:
    for name,r in [('q',0),('d_monic',dr)]:
     p=(ct.c_int*(N*D))(*ar);o=(ct.c_int*(N*D))();n=0
     while True:
      status=lib.div_q_linear(p,N,1,gs,r,o)
      if status:break
      p,o=o,p;n+=1
      assert n<500
     assert status>0
     val[name]=n
   vv.append(val)
  weights.append(ww);vals.append(vv)
 meta={'normalization':'Rstar(nu,x)=q^-48*Rtilde(q^2*nu,x)',
  'normalization_is_square_unit_on_original_open':True,'tau_equals':'q^2*nu',
  'shape':[N,7,NX,D],'axis_order':['u','nu','x','q'],'raw_sha256':hashlib.sha256(payload).hexdigest(),
  'all_987_coefficients_divided_exactly':True,'powers_divided_per_scale':[48-2*s for s in range(7)],
  'normal_u_degree':max(iu for iu in range(N) if any(result[iu*7*NX*D:(iu+1)*7*NX*D])),
  'max_parameter_weight':max(max(w) for w in weights),'weights_by_T_scale':weights,
  'unit_valuations_by_T_scale':vals,'monic_d_root':dr}
 if verify:assert json.loads(META.read_text())==meta
 else:META.write_text(json.dumps(meta,separators=(',',':'))+'\n')
 (CACHE/'residual.bin.gz').write_bytes(gzip.compress(payload,mtime=0,compresslevel=6))
 print('RATIO ELIMINANT NORMALIZATION: 987 exact divisions; weight',meta['max_parameter_weight'],'u degree',meta['normal_u_degree'],'seconds',round(time.time()-start,3),flush=True)
 return meta,result

def load():
 p=CACHE/'residual.bin.gz'
 if not p.exists():return build(True)
 meta=json.loads(META.read_text());raw=gzip.open(p,'rb').read();assert hashlib.sha256(raw).hexdigest()==meta['raw_sha256']
 return meta,struct.unpack('<%dI'%(len(raw)//4),raw)
if __name__=='__main__':build('--verify' in sys.argv)
