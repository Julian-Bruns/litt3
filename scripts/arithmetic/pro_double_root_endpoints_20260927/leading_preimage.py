"""Compact coefficient-Frobenius factor of the highest scale coefficient.
The degree-64 polynomial V has parameter weight <=22, hence u-degree <=11.
Its coefficients' fifth powers give U, and [tau^6]R_tilde=t*v*U^2.
No specialization of scale and no extra ratio localization is used.
"""
import json,gzip,struct,hashlib,time,ctypes as ct,sys
from exact import ROOT,DATA,t as tc,power,mul,code,rref
from extension import E,Poly,init
from residual import Curve,bp_add,bp_pow,bp_scale,bp_mul
from interpolate_global import library
SRC=json.loads((ROOT/'evidence/global_source.json').read_text())

def src_at(u0):
    mod=[0]*10
    from exact import add
    for iq,iu,a in SRC['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
    init(mod);q=E([0,1]);u=E(u0)
    qp=[E(1)]
    for _ in range(7):qp.append(qp[-1]*q)
    up=[E(1),u,u*u];P=Poly(DATA['P']);Curve.Pbar=P*qp[2]
    G={}
    for n,terms in SRC['G_tilde'].items():
        parts=[{} for _ in range(3)]
        for iq,iu,ix,j,a in terms:
            z=E(a)*qp[iq]*up[iu];parts[j][ix]=parts[j].get(ix,E(0))+z
        G[int(n)]=Curve([Poly([p.get(i,E(0)) for i in range(max(p,default=-1)+1)]) for p in parts])
    return mod,q,G

def preimage(u0):
    start=time.time();mod,q,G=src_at(u0)
    # H(Z)=Norm(3*G2*Z^2-2*G3*Z+G4).
    hs=[G[4],3*G[3],3*G[2]]
    a,b,c=[[z.c[j] for z in hs] for j in range(3)]
    H=bp_add(bp_add(bp_pow(a,3),bp_scale(bp_pow(b,3),Curve.Pbar)),bp_scale(bp_pow(c,3),Curve.Pbar**2))
    H=bp_add(H,bp_scale(bp_mul(bp_mul(a,b),c),2*Curve.Pbar))
    twist=lambda a:Poly([power(v,5**7) for v in a])
    P0=twist(DATA['P']);Q0=twist(DATA['Q']);t0=twist(tc)
    v0=Poly([-E(power(DATA['r'],5**7)),1])
    rhs=Poly();Qj=Poly(1)
    for Hj in H:
        # x -> x^5 WITHOUT applying Frobenius to its coefficients.
        vals=[E(0)]*(5*Hj.degree()+1) if Hj else []
        for i,z in enumerate(Hj.coeffs()):vals[5*i]=z
        rhs=rhs+Poly(vals)*Qj;Qj=Qj*Q0
    V=(v0*rhs)/(P0**20*t0**8)
    assert V.degree()<=64
    gamma=mul(2,mul(power(code(DATA['epsilon']),15),power(DATA['Q'][-1],3)))
    expected=E(power(gamma,5**7))*(q**8)*(Poly(DATA['d']).eval(q)**3)
    assert V[64]==expected
    flat=[a for i in range(65) for a in V[i].a]
    print('LEADING PREIMAGE fibre',u0,'exact polynomial division and leading coefficient checked',round(time.time()-start,3),flush=True)
    return flat

def run(verify=False):
    start=time.time();lib=library();n=12;m=65*9;points=list(range(1,13))
    inputs=[]
    for u0 in points:inputs.extend(preimage(u0))
    rows=[[power(u0,j) for j in range(n)]+[int(i==j) for j in range(n)] for i,u0 in enumerate(points)]
    rr,piv=rref(rows,n);assert piv==list(range(n))
    a=(ct.c_int*(n*n))(*[v for r in rr for v in r[n:]])
    b=(ct.c_int*(n*m))(*inputs);out=(ct.c_int*(n*m))();lib.ff_matmul_batch(a,b,out,n,n,m)
    check=(ct.c_int*(n*m))();a=(ct.c_int*(n*n))(*[power(u0,j) for u0 in points for j in range(n)])
    lib.ff_matmul_batch(a,out,check,n,n,m);assert list(check)==inputs
    assert all(2*i+j%9<=22 for i in range(n) for j in range(m) if out[i*m+j])
    raw=struct.pack('<%dI'%len(out),*out)
    if verify:assert gzip.open(ROOT/'evidence/leading_preimage.bin.gz','rb').read()==raw
    else:(ROOT/'evidence/leading_preimage.bin.gz').write_bytes(gzip.compress(raw,compresslevel=9,mtime=0))
    meta={'shape':[12,65,9],'ordering':['u_degree','x_degree','q_degree'],
          'meaning':'V; coefficientwise Frobenius Phi(V)=U; R_tilde[tau^6]=t*v*U^2',
          'u_degree_bound':11,'parameter_weight_bound':22,
          'observed_u_degree':max(i for i in range(n) if any(out[i*m:(i+1)*m])),
          'nonzero_coefficients':sum(bool(v) for v in out),
          'raw_sha256':hashlib.sha256(raw).hexdigest(),'interpolation_points':points,
          'leading_coefficient':'(2*epsilon^15*[24]^3)^(5^7)*q^8*d(q)^3'}
    # Cross-check all 133 complete quotient-algebra fibres against the independently
    # reconstructed residual. The proof of the identity is in REPORT.md.
    rrraw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read()
    rrflat=struct.unpack('<%dI'%(len(rrraw)//4),rrraw)
    M=7*141*9
    r6=[]
    for i in range(133):r6.extend(rrflat[i*M+6*141*9:i*M+7*141*9])
    allV=(ct.c_int*(133*m))();mat=(ct.c_int*(133*n))(*[power(u0,j) for u0 in range(133) for j in range(n)])
    lib.ff_matmul_batch(mat,out,allV,133,n,m)
    allR=(ct.c_int*(133*141*9))();matR=(ct.c_int*(133*133))(*[power(u0,j) for u0 in range(133) for j in range(133)])
    lib.ff_matmul_batch(matR,(ct.c_int*len(r6))(*r6),allR,133,133,141*9)
    from exact import add
    for u0 in range(133):
        mod=[0]*10
        for iq,iu,a in SRC['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
        init(mod)
        U=Poly([E(allV[(u0*65+i)*9:(u0*65+i+1)*9])**5 for i in range(65)])
        R6=Poly([E(allR[(u0*141+i)*9:(u0*141+i+1)*9]) for i in range(141)])
        assert U*U*Poly(tc)*Poly([-E(DATA['r']),1])==R6,u0
    meta['checked_complete_algebra_fibres']=133;meta['seconds']=round(time.time()-start,3)
    if verify:
        old=json.loads((ROOT/'evidence/leading_preimage.json').read_text())
        for key in meta:
            if key!='seconds':assert meta[key]==old[key],key
    else:(ROOT/'evidence/leading_preimage.json').write_text(json.dumps(meta,indent=2)+'\n')
    print(json.dumps(meta,indent=2),flush=True)

if __name__=='__main__':run('--verify' in sys.argv)
