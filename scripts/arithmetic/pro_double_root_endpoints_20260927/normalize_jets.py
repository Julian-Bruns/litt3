"""Exact polynomial jets after invertible parameter-dependent variable changes.
A#(T,sigma) = (q^84*d^33*u^12)^-1 A(q^2*d^3*u^3*T,sigma/(q^2*d^3*u)).
All negative powers are divided exactly in K[u,q]/g, not at sampled points.
"""
import ctypes as ct,json,gzip,struct,subprocess,time,hashlib,sys
from exact import ROOT,add,sub,mul,inv,power,DATA
N=133;NX=141;D=9;NS=75;NOUT=768
libpath=ROOT/'src/libglobaldivision.so'
subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(libpath)],check=True)
lib=ct.CDLL(str(libpath));lib.ff_init();IP=ct.POINTER(ct.c_int)
lib.normalize_jet.argtypes=[IP,ct.c_int,IP,ct.c_int,ct.c_int,ct.c_int,ct.c_int,ct.c_int,IP,ct.c_int]
src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
for iq,iu,a in src['critical_monic']:gs[iq*3+iu]=a
gbuf=(ct.c_int*30)(*gs)
a=struct.unpack('<%dI'%(N*7*NX*D),gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read())
droot=mul(sub(0,DATA['d'][0]),inv(DATA['d'][1]));B=(ct.c_int*(NOUT*D))()
weights=[];jets=[];maxu=0
for ni in range(NS):
 row=[];rr=[]
 for ti in range(7):
  flat=[a[((i*7+ti)*NX+140-ni)*D+k] for i in range(N) for k in range(D)]
  A=(ct.c_int*len(flat))(*flat)
  pq,pd,pu=2*ni-84-2*ti,3*ni-33-3*ti,3*ni-12-ti
  nn=lib.normalize_jet(A,N,gbuf,droot,DATA['d'][1],pq,pd,pu,B,NOUT)
  assert nn>=0,(ni,ti,nn,pq,pd,pu)
  vals=list(B[:nn*9]);maxu=max(maxu,nn-1)
  wt=max((2*i+j for i in range(nn) for j in range(9) if vals[9*i+j]),default=-1)
  row.append(wt);rr.append(vals)
 weights.append(row);jets.append(rr)
 if ni<16 or ni%10==0:print('JET',ni,'weights by sigma degree',row,flush=True)
# A product may only reduce weight on monic g-reduction. Therefore max-plus
# convolution supplies rigorous bounds for the complete square circuit.
def sm(a,b,N):
 out=[[-1]*107 for _ in range(N)]
 for n,row in enumerate(a):
  for m,s in enumerate(b[:N-n]):
   for i,w in enumerate(row):
    if w<0:continue
    for j,v in enumerate(s[:107-i]):
     if v>=0:out[n+m][i+j]=max(out[n+m][i+j],w+v)
 return out
def frob(a,k,N):
 out=[[-1]*107 for _ in range(N)];p=5**k
 for n,row in enumerate(a):
  if p*n>=N:break
  for i,w in enumerate(row):
   if i*p<107 and w>=0:out[p*n][p*i]=p*w
 return out
w2=sm(weights,weights,NS);w3=sm(w2,weights,NS)
cs=sm(sm(w3,frob(w2,1,NS),NS),frob(w2,2,NS),NS)
print('TAIL WEIGHT/ U DEGREE BOUNDS',[(n,max(cs[n]),max(cs[n])//2) for n in [71,72,73,74]],flush=True)
meta={'series_length':NS,'normalization':'A#=(q^84*d^33*u^12)^-1*A(q^2*d^3*u^3*T,sigma/(q^2*d^3*u))','coefficient_weights':weights,'max_u_degree':maxu,'tail_weight_bounds':{str(n):cs[n] for n in [71,72,73,74]},'tail_u_degree_bounds':{str(n):max(cs[n])//2 for n in [71,72,73,74]},'all_jet_divisions_exact':True}
# Store compact variable-length coefficient lists, not padded large arrays.
raw=json.dumps(jets,separators=(',',':')).encode();meta['jets_raw_sha256']=hashlib.sha256(raw).hexdigest()
if '--verify' in sys.argv:
 assert gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read()==raw
 assert json.loads((ROOT/'evidence/normalized_jets.json').read_text())==meta
 print('ALL NORMALIZED JETS AND BOUNDS REGENERATED EXACTLY',flush=True)
else:
 (ROOT/'evidence/normalized_jets.json.gz').write_bytes(gzip.compress(raw,compresslevel=9,mtime=0))
 (ROOT/'evidence/normalized_jets.json').write_text(json.dumps(meta,indent=2)+'\n')
print('MAX U DEGREE',maxu,flush=True)
