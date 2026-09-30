"""Check the full global coefficient file against all 133 source-fibre digests.
This also checks its field codes, weight and degree bounds, and universal leading
coefficient. Use reconstruct_global.py --verify --fresh to regenerate every
source-fibre digest independently of the coefficient file.
"""
import gzip,struct,json,hashlib,ctypes as ct,time
from exact import ROOT,DATA,code,power,add,mul
from extension import E,Poly,init
from interpolate_global import library
start=time.time();meta=json.loads((ROOT/'evidence/global_residual.json').read_text())
raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read()
assert hashlib.sha256(raw).hexdigest()==meta['raw_sha256']
flat=struct.unpack('<%dI'%(len(raw)//4),raw);N=133;M=7*141*9
assert len(flat)==N*M and all(0<=v<390625 for v in flat)
assert sum(bool(v) for v in flat)==meta['nonzero_coefficients']
assert max(i for i in range(N) if any(flat[i*M:(i+1)*M]))==meta['observed_u_degree']==129
for i in range(N):
    assert all(2*i+j%9<=264 for j in range(M) if flat[i*M+j])
by=[]
for a in range(7):by.append(max(i for i in range(N) if any(flat[i*M+a*141*9:i*M+(a+1)*141*9])))
assert by==meta['observed_u_degrees_by_scale']
lib=library();mat=(ct.c_int*(N*N))(*[power(i,j) for i in range(N) for j in range(N)])
out=(ct.c_int*(N*M))();lib.ff_matmul_batch(mat,(ct.c_int*len(flat))(*flat),out,N,N,M)
samples=json.loads((ROOT/'evidence/global_samples.json').read_text())
assert samples['interpolation_points']==list(range(N))
src=json.loads((ROOT/'evidence/global_source.json').read_text())
for u0,s in enumerate(samples['samples']):
    row=out[u0*M:(u0+1)*M];rr=struct.pack('<%dI'%M,*row)
    assert hashlib.sha256(rr).hexdigest()==s['digest']
    mod=[0]*10
    for iq,iu,a in src['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
    assert mod==s['modulus'];init(mod);q=E([0,1]);u=E(u0)
    F=Poly(DATA['a0']).eval(q)*u**3+Poly(DATA['b']).eval(q)*u*u+Poly(DATA['c']).eval(q)*u+Poly(DATA['e']).eval(q)
    gamma=(E(3)*E(code(DATA['epsilon']))**8)**3
    expected=gamma*q**84*Poly(DATA['d']).eval(q)**33*u**9*F**3
    assert E(row[140*9:141*9])==expected
print('Global residual: 977302 exact nonzero coefficients; u-degree 129; all 133 source-fibre digests match; all leading coefficients and weight bounds agree. Seconds',round(time.time()-start,3),flush=True)
