"""Recover all global coefficients from the 133 certified algebra-valued fibres.
The degree bound is a theorem; the matrix inversion is exact over K.
Output ordering: [u-degree, tau-degree, x-degree, q-degree].
"""
import json,gzip,struct,hashlib,ctypes as ct,time,subprocess,sys
from exact import ROOT,power,lib as ff,rref
from extension import E,Poly,init
N=133;M=7*141*9
P=ct.POINTER(ct.c_int)

def library():
    path=ROOT/'src/libinterpolation.so'
    if not path.exists():
        subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/interpolation.cpp'),'-o',str(path)],check=True)
    lib=ct.CDLL(str(path));lib.ff_init()
    lib.ff_matmul_batch.argtypes=[P,P,P,ct.c_int,ct.c_int,ct.c_int]
    lib.ff_evaluate_rows.argtypes=[P,ct.c_int,ct.c_int,ct.c_int,P]
    return lib


def run():
    start=time.time();lib=library();rows=[];inputs=[]
    summary=json.loads((ROOT/'evidence/global_samples.json').read_text())
    assert summary['interpolation_points']==list(range(N)) and summary['u_degree_bound']==132
    for i,s in enumerate(summary['samples']):
        raw=gzip.open(ROOT/'work/global_samples'/f'{i}.bin.gz','rb').read()
        assert hashlib.sha256(raw).hexdigest()==s['digest']
        assert len(raw)==M*4
        inputs.extend(struct.unpack('<%dI'%M,raw))
        rows.append([power(i,j) for j in range(N)]+[int(i==j) for j in range(N)])
    rr,piv=rref(rows,N)
    assert piv==list(range(N))
    assert all(rr[i][:N]==[int(i==j) for j in range(N)] for i in range(N))
    inverse=[v for row in rr for v in row[N:]]
    A=(ct.c_int*(N*N))(*inverse);B=(ct.c_int*(N*M))(*inputs);out=(ct.c_int*(N*M))()
    lib.ff_matmul_batch(A,B,out,N,N,M)
    V=(ct.c_int*(N*N))(*[power(i,j) for i in range(N) for j in range(N)])
    check=(ct.c_int*(N*M))();lib.ff_matmul_batch(V,out,check,N,N,M)
    assert list(check)==inputs
    maxu=max((i for i in range(N) if any(out[i*M:(i+1)*M])),default=-1)
    nonzero=sum(bool(v) for v in out)
    for i in range(N):
        for j in range(M):
            if out[i*M+j]:assert 2*i+j%9<=264
    raw=struct.pack('<%dI'%len(out),*out)
    target=ROOT/'evidence/global_residual.bin.gz'
    target.write_bytes(gzip.compress(raw,compresslevel=9,mtime=0))
    byscale=[]
    for a in range(7):
        d=-1
        for i in range(N):
            if any(out[i*M+a*141*9:i*M+(a+1)*141*9]):d=i
        byscale.append(d)
    result={'coefficient_field':'K, exact alpha-basis codes',
            'ring':'K[u,q]/(critical_monic), polynomial in tau,x',
            'shape':[N,7,141,9],'ordering':['u_degree','tau_degree','x_degree','q_degree'],
            'byte_order':'little-endian uint32','identity':'R_tilde=q^83*d(q)^36*Rcal_r(u/q,q,tau/(q^3*d(q)),x)',
            'proved_u_degree_bound':132,'observed_u_degree':maxu,
            'observed_u_degrees_by_scale':byscale,'nonzero_coefficients':nonzero,
            'all_133_fibres_recover_exactly':True,'raw_sha256':hashlib.sha256(raw).hexdigest(),
            'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/global_residual.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2),flush=True)

if __name__=='__main__':run()
