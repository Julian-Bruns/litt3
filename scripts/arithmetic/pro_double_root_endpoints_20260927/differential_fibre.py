"""Executed method check on an INHERITED, already excluded whole u fibre.
No new ratio exclusion and no global square-locus decision is claimed.
All scale coefficients and the complete degree-nine coefficient algebra remain.
"""
import ctypes as ct,gzip,struct,json,subprocess,time,sys,hashlib
from exact import ROOT,DATA,add,mul,power
from fibres_u import load_sample,fibre_modulus
from extension import E,Poly,init
from differential_square import linear_rows

def run(u0=1,verify=False):
    path=ROOT/'src/libdifferential_trace.so'
    if not path.exists() or path.stat().st_mtime<(ROOT/'src/differential_module.cpp').stat().st_mtime:
        subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/differential_module.cpp'),'-o',str(path)],check=True)
    original,mod,removed=fibre_modulus(u0)
    if mod!=original:
        raise ValueError('This reference driver does not discard any primary factor.')
    init(mod);D=len(mod)-1
    raw=load_sample(u0);flat=struct.unpack('<%dI'%(7*141*9),raw)
    inp=[flat[(s*141+140-t)*9+j] for t in range(141) for s in range(7) for j in range(9)]
    lib=ct.CDLL(str(path));lib.ff_init();IP=ct.POINTER(ct.c_int)
    lib.ef_init((ct.c_int*len(mod))(*mod),len(mod))
    lib.differential_left_certificate.argtypes=[IP,ct.c_int,IP,ct.c_int,IP]
    out=(ct.c_int*(112*1024*D))();stats=(ct.c_int*4)();start=time.time()
    status=lib.differential_left_certificate((ct.c_int*len(inp))(*inp),7,out,1024,stats)
    if status!=0:
        raise RuntimeError(('reference module did not certify',status,list(stats)))
    cert=[]
    for k in range(112):
        p=Poly([E(list(out[(k*1024+i)*D:(k*1024+i+1)*D])) for i in range(1024)])
        cert.append(p)
    A=[Poly([E(inp[(t*7+s)*9:(t*7+s+1)*9]) for s in range(7)]) for t in range(141)]
    rows=linear_rows(A)
    for j in range(71):
        p=sum((cc*row[j] for cc,row in zip(cert,rows)),Poly())
        assert p==int(j==0),('reference certificate',j)
    rec={'status':'verified','u_code':u0,'modulus':mod,'removed_factors':removed,
      'source':'actual Rtilde, all 141 x coefficients, all seven tau coefficients',
      'scale':'tau is an unrestricted polynomial variable',
      'identity':'sum_m certificate_m(tau)*D_m=B_0 in (K[q]/g(q,u0))[tau,B_0,...,B_70]',
      'scope':'method check on an inherited excluded divisor, not a new ratio exclusion',
      'stats':dict(zip(['row_reductions','row_rank','sum_row_degrees','max_certificate_scale_degree'],list(stats))),
      'residual_raw_sha256':hashlib.sha256(raw).hexdigest(),
      'linear_indices':list(__import__('differential_square').LINEAR_INDICES),
      'certificate':[p.records() for p in cert]}
    dest=ROOT/'evidence'/f'differential_fibre_{u0}.json.gz'
    payload=json.dumps(rec,separators=(',',':')).encode()
    if verify:
        assert gzip.open(dest,'rb').read()==payload
    else:
        dest.write_bytes(gzip.compress(payload,compresslevel=9,mtime=0))
    log={k:v for k,v in rec.items() if k!='certificate'};log['seconds']=round(time.time()-start,3)
    (ROOT/'logs'/f'differential_fibre_{u0}.json').write_text(json.dumps(log,indent=2)+'\n')
    print('FULL-SCALE DIFFERENTIAL CERTIFICATE VERIFIED',json.dumps(log),flush=True)
    return rec
if __name__=='__main__':run(int(sys.argv[1]) if len(sys.argv)>1 and sys.argv[1].isdigit() else 1,'--verify' in sys.argv)
