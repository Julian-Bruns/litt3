"""Exact Z-valuation of the actual first four global tails in the rank-nine ring.
Z=F/u is a unit on the original source open. No inverse denominator is localized.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib
from exact import ROOT,DATA
N=1375;NW=64;D=9
libpath=ROOT/'src/libglobaldivision.so'
subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(libpath)],check=True)
lib=ct.CDLL(str(libpath));lib.ff_init();IP=ct.POINTER(ct.c_int)
lib.div_ring_element.argtypes=[IP,ct.c_int,ct.c_int,IP,IP,ct.c_int,IP,ct.c_int,IP]
src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
gbuf=(ct.c_int*30)(*gs)
z=json.loads((ROOT/'evidence/inverse_z.json').read_text());ni=max(map(len,z['inverse_numerators_by_q_degree']));nums=[]
for p in z['inverse_numerators_by_q_degree']:nums.extend(p+[0]*(ni-len(p)))
nums += [0]*((9-len(z['inverse_numerators_by_q_degree']))*ni)
nbuf=(ct.c_int*len(nums))(*nums);dd=z['denominator_u_coefficients'];dbuf=(ct.c_int*len(dd))(*dd)
raw=gzip.open(ROOT/'evidence/global_prefix.bin.gz','rb').read();arr=struct.unpack('<%dI'%(len(raw)//4),raw)
rows=[];start=time.time()
for hi in range(4):
 flat=[arr[((i*4+hi)*NW+j)*D+k] for i in range(N) for j in range(NW) for k in range(D)]
 A=(ct.c_int*len(flat))(*flat);B=(ct.c_int*len(flat))();count=0
 while True:
  status=lib.div_ring_element(A,N,NW,gbuf,nbuf,ni,dbuf,len(dd),B)
  if status:break
  A,B=B,A;count+=1
  if count%5==0:print('Z DIV',71+hi,count,flush=True)
  assert count<500
 assert status>0,status
 du=max(i for i in range(N) if any(A[i*NW*D:(i+1)*NW*D]));vals=list(A[:(du+1)*NW*D]);raw=struct.pack('<%dI'%len(vals),*vals)
 row={'tail':71+hi,'Z_power':count,'u_degree_after':du,'shape':[du+1,NW,9],'nonzero_coefficients':sum(bool(v) for v in vals),'next_division_nonzero_remainder_at_sigma':status-1,'raw_sha256':hashlib.sha256(raw).hexdigest()}
 (ROOT/'work/auxiliary').mkdir(parents=True,exist_ok=True)
 (ROOT/'work/auxiliary'/f'z_primitive_tail_{71+hi}.bin.gz').write_bytes(gzip.compress(raw,mtime=0,compresslevel=9));rows.append(row);print(json.dumps(row),flush=True)
(ROOT/'evidence/z_primitive_tails.json').write_text(json.dumps({'identity':'C#_n=Z^power*E_n in K[u,q]/g','rows':rows,'seconds':round(time.time()-start,3)},indent=2)+'\n')
