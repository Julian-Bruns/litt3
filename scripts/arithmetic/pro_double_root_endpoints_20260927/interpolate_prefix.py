"""Exact additive-coset interpolation of global square-prefix polynomials.
1375 nodes = eleven cosets of the 125-element F5-subspace with codes 0..124.
Works in the common rank-nine q basis; no geometric point restriction is made.
"""
import ctypes as ct,json,gzip,struct,hashlib,time,sys,subprocess,math
from exact import ROOT,add,sub,neg,mul,inv,power,pa,pm,pp,peval,rref
from prefix_samples import CACHE,NT,W,NODES
N=NODES;B=125;NB=11;M=NT*W*9
LIB=ROOT/'src/libinterpolation.so'
if not LIB.exists() or LIB.stat().st_mtime < max((ROOT/'src/interpolation.cpp').stat().st_mtime,(ROOT/'src/field.cpp').stat().st_mtime):
 subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/interpolation.cpp'),'-o',str(LIB)],check=True)
lib=ct.CDLL(str(LIB));lib.ff_init();IP=ct.POINTER(ct.c_int)
lib.ff_matmul_batch.argtypes=[IP,IP,IP,ct.c_int,ct.c_int,ct.c_int]
lib.ff_radix_combine.argtypes=[IP,IP,ct.c_int,ct.c_int,ct.c_int,ct.c_int,IP]
lib.ff_radix_decompose.argtypes=[IP,IP,ct.c_int,ct.c_int,ct.c_int,IP]

def matinv(nodes):
 n=len(nodes);rr,pv=rref([[power(c,j) for j in range(n)]+[int(i==j) for j in range(n)] for i,c in enumerate(nodes)],n)
 assert pv==list(range(n));return [v for row in rr for v in row[n:]]

def matmul(a,b,n,k,m):
 A=(ct.c_int*len(a))(*a) if not isinstance(a,ct.Array) else a
 B0=(ct.c_int*len(b))(*b) if not isinstance(b,ct.Array) else b
 C=(ct.c_int*(n*m))();lib.ff_matmul_batch(A,B0,C,n,k,m);return C

def shiftmat(c):
 # Coefficient matrix for F(v) -> F(u+c), rows output u-degree.
 rows=[]
 for k in range(B):
  for j in range(B):
   rows.append(mul(math.comb(j,k)%5,power(c,j-k)) if j>=k else 0)
 return rows

def run():
 start=time.time();meta=json.loads((ROOT/'evidence/prefix_samples.json').read_text());assert meta['sample_count']==N
 Y=[]
 for row in meta['samples']:
  assert row['u_code']==len(Y)//M
  raw=gzip.open(CACHE/f"{row['u_code']}.bin.gz",'rb').read();assert hashlib.sha256(raw).hexdigest()==row['sha256'];Y.extend(struct.unpack('<%dI'%M,raw))
 vi=matinv(list(range(B)));vmat=[power(c,j) for c in range(B) for j in range(B)]
 P=[1]
 for c in range(B):P=pm(P,[neg(c),1])
 assert len(P)==B+1 and P[-1]==1
 assert all(not a or i in [1,5,25,125] for i,a in enumerate(P))
 offsets=[B*j for j in range(NB)];znodes=[peval(P,c) for c in offsets];assert len(set(znodes))==NB
 zi=matinv(znodes);G=[]
 for j,c in enumerate(offsets):
  V=matmul(vi,Y[j*B*M:(j+1)*B*M],B,B,M)
  coeff=matmul(shiftmat(neg(c)),V,B,B,M)
  G.extend(coeff)
  print('PREFIX INTERPOLATION BLOCK',j,'complete',flush=True)
 rad=matmul(zi,G,NB,NB,B*M)
 powers=[]
 for i in range(NB):powers.extend(pp(P,i)+[0]*(N-len(pp(P,i))))
 out=(ct.c_int*(N*M))();lib.ff_radix_combine(rad,(ct.c_int*len(powers))(*powers),NB,B,M,N,out)
 # Independent inverse radix transformation of the completed coefficient array.
 back=(ct.c_int*(N*M))();lib.ff_radix_decompose(out,(ct.c_int*len(P))(*P),NB,B,M,back)
 assert list(back)==list(rad)
 # Check every complete algebra-valued sample from the completed array.
 G2=matmul([power(z,i) for z in znodes for i in range(NB)],back,NB,NB,B*M)
 for j,c in enumerate(offsets):
  V=matmul(shiftmat(c),G2[j*B*M:(j+1)*B*M],B,B,M)
  vals=matmul(vmat,V,B,B,M)
  assert list(vals)==Y[j*B*M:(j+1)*B*M],j
  print('PREFIX GLOBAL REEVALUATION BLOCK',j,'matched',flush=True)
 weights=json.loads((ROOT/'evidence/normalized_jets.json').read_text())['tail_weight_bounds']
 observed=[]
 for h in range(NT):
  du=max((i for i in range(N) if any(out[(i*M+h*W*9):(i*M+(h+1)*W*9)])),default=-1)
  nz=0;maxwt=-1
  for i in range(N):
   for s in range(W):
    wt=weights[str(71+h)][s]
    for q in range(9):
     a=out[(i*M+h*W*9+s*9)+q]
     if a:
      assert 2*i+q<=wt,(h,i,s,q,wt);nz+=1;maxwt=max(maxwt,2*i+q)
  observed.append({'tail':71+h,'u_degree':du,'max_weight':maxwt,'nonzero_K_coefficients':nz})
 raw=struct.pack('<%dI'%len(out),*out)
 if '--verify' in sys.argv:assert gzip.open(ROOT/'evidence/global_prefix.bin.gz','rb').read()==raw
 else:(ROOT/'evidence/global_prefix.bin.gz').write_bytes(gzip.compress(raw,compresslevel=9,mtime=0))
 result={'shape':[N,NT,W,9],'order':['u','tail_minus_71','sigma','q'],'coefficient_type':'little-endian uint32 K codes','raw_sha256':hashlib.sha256(raw).hexdigest(),'observed':observed,'nodes':N,'all_samples_recover_exactly':True,'subspace_polynomial':P,'coset_offsets':offsets,'quotient_interpolation_nodes':znodes,'seconds':round(time.time()-start,3)}
 if '--verify' in sys.argv:
  old=json.loads((ROOT/'evidence/global_prefix.json').read_text())
  assert {k:v for k,v in old.items() if k!='seconds'}=={k:v for k,v in result.items() if k!='seconds'}
 else:(ROOT/'evidence/global_prefix.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps(result,indent=2),flush=True)
if __name__=='__main__':run()
