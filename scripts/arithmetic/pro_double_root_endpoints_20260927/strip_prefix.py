"""Remove exact common q,d,u factors of the first four global square tails.
Only units of the original open set are removed. Division is performed in
K[u,q]/g, with no specialization and no inversion of a new polynomial.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib
from exact import ROOT,sub,mul,inv,DATA
N=1375;NW=64;D=9
libpath=ROOT/'src/libglobaldivision.so'
if not libpath.exists():subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(libpath)],check=True)
lib=ct.CDLL(str(libpath));lib.ff_init();IP=ct.POINTER(ct.c_int)
lib.div_q_linear.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP]
src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
gbuf=(ct.c_int*30)(*gs)
raw=gzip.open(ROOT/'evidence/global_prefix.bin.gz','rb').read();arr=struct.unpack('<%dI'%(len(raw)//4),raw)
droot=mul(sub(0,DATA['d'][0]),inv(DATA['d'][1]));rows=[];start=time.time()
for hi in range(4):
 flat=[arr[((i*4+hi)*NW+j)*D+k] for i in range(N) for j in range(NW) for k in range(D)]
 A=(ct.c_int*len(flat))(*flat);B=(ct.c_int*len(flat))();row={'tail':71+hi,'powers':{}}
 for name,r in [('q',0),('d_monic',droot)]:
  count=0
  while True:
   status=lib.div_q_linear(A,N,NW,gbuf,r,B)
   if status:break
   A,B=B,A;count+=1
   if count%50==0:print('STRIP',hi+71,name,count,flush=True)
   assert count<2000
  assert status>0,status
  row['powers'][name]=count
  row[name+'_next_division_nonzero_remainder_at_sigma']=status-1
  print('STRIP DONE',hi+71,name,count,flush=True)
 du=max((i for i in range(N) if any(A[i*NW*D:(i+1)*NW*D])),default=-1)
 lo=min((i for i in range(N) if any(A[i*NW*D:(i+1)*NW*D])),default=N)
 vals=list(A[lo*NW*D:(du+1)*NW*D]);n=du+1-lo
 row['powers']['u']=lo;row['u_degree']=n-1;row['nonzero_coefficients']=sum(bool(v) for v in vals);row['shape']=[n,NW,D]
 raw=struct.pack('<%dI'%len(vals),*vals);row['sha256']=hashlib.sha256(raw).hexdigest()
 (ROOT/'work/auxiliary').mkdir(parents=True,exist_ok=True)
 (ROOT/'work/auxiliary'/f'primitive_tail_{71+hi}.bin.gz').write_bytes(gzip.compress(raw,mtime=0,compresslevel=9))
 rows.append(row);print(json.dumps(row),flush=True)
(ROOT/'evidence/primitive_tails.json').write_text(json.dumps({'equation':'C#_n=q^p*(q-droot)^k*u^l*E_n','droot':droot,'rows':rows,'seconds':round(time.time()-start,3)},indent=2)+'\n')
