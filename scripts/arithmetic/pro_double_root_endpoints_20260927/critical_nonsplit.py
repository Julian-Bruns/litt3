"""Global necessary square obstruction for Delta in L_32.
If Delta=(A(x)+B(x)V)^2 with pole(A+B V)<=16, then
Delta_1^2-4*Delta_0*Delta_2=0 coefficientwise. This script tests that
coefficient incidence over the entire critical ratio curve, not a field census.
"""
import ctypes as ct,gzip,struct,json,hashlib,subprocess,sys,time
from exact import *
from extension import E,Poly,init
from critical_model import sample,interpolate
from interpolate_global import library
N=15;NX=15;D=9

def run(verify=False):
 start=time.time();src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
 for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
 values=[];sample_records=[]
 for u0 in range(N):
  mod,de,_=sample(u0,False)
  hh=de.c[1]*de.c[1]-4*de.c[0]*de.c[2]
  assert hh.degree()<=14
  flat=[a for i in range(NX) for a in hh[i].a];values.extend(flat)
  sample_records.append(hashlib.sha256(struct.pack('<%dI'%len(flat),*flat)).hexdigest())
 data=interpolate(values,N,NX*D)
 assert all(2*iu+jq<=28 for iu in range(N) for ix in range(NX) for jq in range(D) if data[(iu*NX+ix)*D+jq])
 # Strip only exact common original-open unit factors, retaining quotient identities.
 dl=ct.CDLL(str(ROOT/'src/libglobaldivision.so'));dl.ff_init();IP=ct.POINTER(ct.c_int)
 dl.div_q_linear.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP]
 A=(ct.c_int*len(data))(*data);B=(ct.c_int*len(data))();gbuf=(ct.c_int*30)(*gs)
 strip={};dr=neg(div(DATA['d'][0],DATA['d'][1]))
 for name,r0 in [('q',0),('d_monic',dr)]:
  cnt=0
  while True:
   status=dl.div_q_linear(A,N,NX,gbuf,r0,B)
   if status:break
   A,B=B,A;cnt+=1
  assert status>0,status
  strip[name]=cnt
 lo=min(i for i in range(N) if any(A[i*NX*D:(i+1)*NX*D]));strip['u']=lo
 primitive=list(A[lo*NX*D:])+[0]*(lo*NX*D)
 wp=max(2*i+j for i in range(N) for x in range(NX) for j in range(D) if primitive[(i*NX+x)*D+j])
 bound=(9*wp)//2
 print('CRITICAL square obstruction common units',strip,'primitive weight',wp,'norm degree bound',bound,flush=True)
 # Norm coefficients are univariate polynomials of this proved degree bound.
 lp=ROOT/'src/libcriticalnorms.so'
 if not lp.exists():subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/critical_norms.cpp'),'-o',str(lp)],check=True)
 lib=ct.CDLL(str(lp));lib.ff_init();lib.norm9.argtypes=[IP,IP];lib.norm9.restype=ct.c_int
 ev=library();inp=(ct.c_int*len(primitive))(*primitive);out=(ct.c_int*(NX*D))();nvals=[]
 for u0 in range(bound+1):
  mod=[0]*10
  for iq,iu,a in src['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
  assert mod[-1]==1
  mb=(ct.c_int*10)(*mod)
  ev.ff_evaluate_rows(inp,N,NX*D,u0,out)
  for ix in range(NX):nvals.append(lib.norm9(mb,(ct.c_int*D)(*out[ix*D:(ix+1)*D])))
 normsdata=interpolate(nvals,bound+1,NX)
 norms=[trim([normsdata[i*NX+j] for i in range(bound+1)]) for j in range(NX)]
 G=[];bez=[[] for _ in range(NX)]
 for j,f in enumerate(norms):
  if not f:continue
  if not G:G=pc(f,inv(f[-1]));bez[j]=[inv(f[-1])]
  else:
   G,aa,bb=pxgcd(G,f);bez=[pm(p,aa) for p in bez];bez[j]=pa(bez[j],bb)
  print('Norm gcd through x coefficient',j,'degree',len(G)-1,flush=True)
  if G==[1]:break
 assert sum_polys([pm(a,b) for a,b in zip(bez,norms)])==G
 meta={'status':'global_norm_obstruction_computed','raw_square_obstruction_sample_digests':sample_records,'raw_shape':[N,NX,D],
  'raw_coefficients':data,'stripped_original_open_factors':strip,'primitive_shape':[N,NX,D],'primitive_coefficients':primitive,
  'primitive_weight':wp,'norm_degree_bound':bound,'norms_by_x_coefficient':norms,'norm_gcd':G,'bezout':bez}
 p=ROOT/'evidence/critical_nonsplit.json.gz';raw=json.dumps(meta,separators=(',',':')).encode()
 if verify:assert gzip.open(p,'rb').read()==raw
 else:p.write_bytes(gzip.compress(raw,mtime=0,compresslevel=9))
 print('NORM GCD',G,'seconds',round(time.time()-start,3),flush=True)
 return meta

def sum_polys(xs):
 p=[]
 for x in xs:p=pa(p,x)
 return p
if __name__=='__main__':run('--verify' in sys.argv)
