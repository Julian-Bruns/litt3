"""Exact polynomial extension of every normalized residual coefficient.
Extends the inherited 75 jets to all 141. All negative-power divisions are
verified in the rank-nine ring; after n=48 every exponent is nonnegative.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib,sys
from exact import ROOT,sub,mul,inv,DATA
N=133;NX=141;D=9;NS=141;NOUT=1600
libpath=ROOT/'src/libglobaldivision.so'
if not libpath.exists():
 subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(libpath)],check=True)
lib=ct.CDLL(str(libpath));lib.ff_init();IP=ct.POINTER(ct.c_int)
lib.normalize_jet.argtypes=[IP,ct.c_int,IP,ct.c_int,ct.c_int,ct.c_int,ct.c_int,ct.c_int,IP,ct.c_int]
src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
gbuf=(ct.c_int*30)(*gs)
a=struct.unpack('<%dI'%(N*7*NX*D),gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read())
droot=mul(sub(0,DATA['d'][0]),inv(DATA['d'][1]));B=(ct.c_int*(NOUT*D))()
old=json.loads(gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read())
weights=[];jets=[];maxu=0;started=time.time()
for ni in range(NS):
 wr=[];jr=[]
 for ti in range(7):
  flat=[a[((i*7+ti)*NX+140-ni)*D+k] for i in range(N) for k in range(D)]
  A=(ct.c_int*len(flat))(*flat)
  pq,pd,pu=2*ni-84-2*ti,3*ni-33-3*ti,3*ni-12-ti
  if ni>=48:assert min(pq,pd,pu)>=0
  nn=lib.normalize_jet(A,N,gbuf,droot,DATA['d'][1],pq,pd,pu,B,NOUT)
  assert nn>=0,(ni,ti,nn)
  vals=list(B[:nn*9]);maxu=max(maxu,nn-1)
  if ni<75:assert vals==old[ni][ti]
  wr.append(max((2*i+j for i in range(nn) for j in range(9) if vals[9*i+j]),default=-1))
  jr.append(vals)
 weights.append(wr);jets.append(jr)
 if ni%25==0 or ni==140:print('FULL JET',ni,'weights',wr,flush=True)
raw=json.dumps(jets,separators=(',',':')).encode()
meta={'series_length':141,'shape_description':'[T degree][sigma degree][9*u degree+q degree]',
 'normalization':'Asharp=(q^84*d^33*u^12)^-1*Ahat(q^2*d^3*u^3*T,sigma/(q^2*d^3*u))',
 'coefficient_weights':weights,'max_u_degree':maxu,'all_divisions_exact':True,
 'from_T_degree_48_all_exponents_nonnegative':True,'prefix_75_matches_inherited':True,
 'jets_raw_sha256':hashlib.sha256(raw).hexdigest()}
path=ROOT/'evidence/normalized_full_jets.json.gz';mp=ROOT/'evidence/normalized_full_jets.json'
if '--verify' in sys.argv:
 assert gzip.open(path,'rb').read()==raw
 assert json.loads(mp.read_text())==meta
else:
 path.write_bytes(gzip.compress(raw,compresslevel=9,mtime=0));mp.write_text(json.dumps(meta,indent=2)+'\n')
print('ALL 987 NORMALIZED COEFFICIENTS POLYNOMIAL; max_u',maxu,'sha256',meta['jets_raw_sha256'],'seconds',round(time.time()-started,3),flush=True)
