"""Verify the complete global four-tail array by degree, hashes and all 1375
complete quotient-algebra evaluations, without a shipped sample cache.
This compares against digests from executed square-circuit evaluations.
Use prefix_samples.py --fresh and interpolate_prefix.py --verify for a fresh
re-execution of every square-circuit sample.
"""
import json,gzip,struct,hashlib,ctypes as ct,time
from exact import ROOT,power
from interpolate_prefix import lib,IP,matmul,shiftmat,B,NB,N,M,W,NT
start=time.time();meta=json.loads((ROOT/'evidence/global_prefix.json').read_text())
raw=gzip.open(ROOT/'evidence/global_prefix.bin.gz','rb').read();assert hashlib.sha256(raw).hexdigest()==meta['raw_sha256']
flat=struct.unpack('<%dI'%(len(raw)//4),raw);assert len(flat)==N*M;assert all(0<=a<390625 for a in flat)
a=(ct.c_int*len(flat))(*flat);rad=(ct.c_int*len(flat))();P=meta['subspace_polynomial']
lib.ff_radix_decompose(a,(ct.c_int*len(P))(*P),NB,B,M,rad)
G=matmul([power(z,i) for z in meta['quotient_interpolation_nodes'] for i in range(NB)],rad,NB,NB,B*M)
Vmat=[power(c,j) for c in range(B) for j in range(B)]
samples=json.loads((ROOT/'evidence/prefix_samples.json').read_text());assert samples['sample_count']==N
for j,c in enumerate(meta['coset_offsets']):
 V=matmul(shiftmat(c),G[j*B*M:(j+1)*B*M],B,B,M);vals=matmul(Vmat,V,B,B,M)
 for v in range(B):
  rr=struct.pack('<%dI'%M,*vals[v*M:(v+1)*M]);record=samples['samples'][j*B+v]
  assert record['u_code']==j*B+v and hashlib.sha256(rr).hexdigest()==record['sha256']
 print('GLOBAL PREFIX DIGEST BLOCK',j,'passed',flush=True)
wm=json.loads((ROOT/'evidence/normalized_jets.json').read_text())['tail_weight_bounds']
observed=[]
for h in range(NT):
 du=-1;nz=0;maxwt=-1;ds=-1
 for i in range(N):
  for s in range(W):
   for q in range(9):
    x=flat[(i*M+h*W*9+s*9)+q]
    if x:
     assert 2*i+q<=wm[str(71+h)][s];du=max(du,i);ds=max(ds,s);nz+=1;maxwt=max(maxwt,2*i+q)
 r={'tail':71+h,'u_degree':du,'max_weight':maxwt,'nonzero_K_coefficients':nz}
 assert r==meta['observed'][h];observed.append(dict(r,scale_degree=ds))
res={'status':'passed','all_complete_algebra_digests_checked':N,'observed':observed,'seconds':round(time.time()-start,3),'scope':'degree-bounded global coefficient verification against executed sample digests, not independent source regeneration'}
(ROOT/'logs/prefix_global_checks.json').write_text(json.dumps(res,indent=2)+'\n');print(json.dumps(res),flush=True)
