"""Direct multiplication of the stored full-scale linear-row certificate.
Does not run row reduction or assume the degree-nine algebra is a field.
No geometric ratio beyond the inherited u=1 divisor is newly excluded.
"""
import gzip,json,struct,hashlib,time,sys
from exact import ROOT
from extension import E,Poly,init
from fibres_u import load_sample,fibre_modulus
from differential_square import linear_rows,LINEAR_INDICES
from differential_compressed import build,linear_matrix

def run(compressed=False,fresh=False):
    start=time.time();p=ROOT/'evidence/differential_fibre_1.json.gz'
    C=json.loads(gzip.open(p,'rb').read());u0=C['u_code']
    orig,mod,removed=fibre_modulus(u0)
    assert orig==mod==C['modulus'] and removed==C['removed_factors']==[]
    assert list(LINEAR_INDICES)==C['linear_indices']
    init(orig);raw=load_sample(u0,rebuild=fresh)
    assert hashlib.sha256(raw).hexdigest()==C['residual_raw_sha256']
    f=struct.unpack('<%dI'%(7*141*9),raw)
    A=[Poly([E(f[(s*141+140-m)*9:(s*141+141-m)*9]) for s in range(7)]) for m in range(141)]
    L=A[0][0];assert A[0].degree()==0;L.inv()
    cert=[Poly([E(z) for z in p]) for p in C['certificate']]
    assert len(cert)==112 and max(p.degree() for p in cert)==326
    rows=linear_rows(A)
    for j in range(71):
        assert sum((c*r[j] for c,r in zip(cert,rows)),Poly())==int(j==0),j
    compressed_checked=False;compressed_degrees=None
    if compressed:
        model=build(A);indices,M=linear_matrix(model)
        assert len(M)==56 and all(len(r)==15 for r in M)
        by_m=dict(zip(LINEAR_INDICES,cert))
        for j in range(15):
            assert sum((by_m[m]*row[j] for m,row in zip(indices,M)),Poly())==Poly(L**3 if j==0 else 0),('compressed certificate',j)
        compressed_degrees=[max(p.degree() for p in row) for row in M]
        assert max(compressed_degrees)<=24
        compressed_checked=True
    out={'status':'passed','certificate_file':p.relative_to(ROOT).as_posix(),
      'coefficient_algebra':'entire K[q]/g(q,1), length9; no factor discarded',
      'scale':'all tau coefficients; every geometric scale, including zero',
      'identity':'sum c_m(tau)*D_m=B0',
      'columns_checked':71,'certificate_degree_in_scale':326,
      'compressed56_by15_identity_checked':compressed_checked,
      'compressed_row_scale_degrees':compressed_degrees,
      'source_fibre_freshly_regenerated':fresh,
      'residual_raw_sha256':hashlib.sha256(raw).hexdigest(),
      'new_ratio_exclusions':0,'scope':'reference certificate on a previously excluded divisor',
      'global_square_locus':'unresolved','seconds':round(time.time()-start,3)}
    name='differential_certificate_checked'+('_compressed' if compressed else '')+('_fresh' if fresh else '')+'.json'
    (ROOT/'logs'/name).write_text(json.dumps(out,indent=2)+'\n')
    print('DIRECT DIFFERENTIAL CERTIFICATE CHECK PASSED',json.dumps(out),flush=True)
    return out
if __name__=='__main__':run('--compressed' in sys.argv,'--fresh' in sys.argv)
