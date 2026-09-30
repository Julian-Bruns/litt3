"""Compute exact common q,d powers of each global scale coefficient.
No parameter localization beyond the original open is introduced.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib
from exact import ROOT,add,sub,mul,inv,power,DATA
N=133;NX=141;D=9
libpath=ROOT/'src/libglobaldivision.so'
if not libpath.exists():
 subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(libpath)],check=True)
lib=ct.CDLL(str(libpath));lib.ff_init()
IP=ct.POINTER(ct.c_int)
lib.div_q_linear.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP]
src=json.loads((ROOT/'evidence/global_source.json').read_text())
gs=[0]*30
for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
gbuf=(ct.c_int*30)(*gs)
raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read()
a=struct.unpack('<%dI'%(len(raw)//4),raw)
droot=mul(sub(0,DATA['d'][0]),inv(DATA['d'][1]))
res=[];outdata=[]
for ti in range(7):
 flat=[a[((i*7+ti)*NX+j)*D+k] for i in range(N) for j in range(NX) for k in range(D)]
 A=(ct.c_int*len(flat))(*flat);B=(ct.c_int*len(flat))()
 row={'tau_degree':ti,'powers':{},'division_failures':{}}
 for name,r in [('q',0),('d_monic',droot)]:
  count=0
  while True:
   status=lib.div_q_linear(A,N,NX,gbuf,r,B)
   if status:break
   A,B=B,A;count+=1
   if count>180:raise AssertionError('unexpected factor')
  assert status>0,status
  row['powers'][name]=count;row['division_failures'][name]={'x_degree':status-1,'next_division_has_nonzero_remainder':True}
 row['u_degree']=max((i for i in range(N) if any(A[i*NX*D:(i+1)*NX*D])),default=-1)
 row['nonzero_coefficients']=sum(bool(z) for z in A)
 b=struct.pack('<%dI'%len(A),*A)
 path=ROOT/'work/auxiliary'/f'stripped_scale_{ti}.bin.gz';path.parent.mkdir(parents=True,exist_ok=True)
 with gzip.open(path,'wb') as f:f.write(b)
 row['sha256']=hashlib.sha256(b).hexdigest();res.append(row)
 print(json.dumps(row),flush=True)
(ROOT/'evidence/stripped_global.json').write_text(json.dumps({'shape_per_scale':[N,NX,D],'d_monic_root':droot,'scale_coefficients':res},indent=2)+'\n')
