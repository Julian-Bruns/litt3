"""Exact global residual in K[u,q]/(g), via bounded polynomial interpolation.
All quotient algebras K[q]/g(q,u0), including nonreduced ones, are retained.
No inverse depending on q or u is taken.
"""
import sys,time,json,gzip,struct,hashlib,os
from exact import ROOT,DATA,t as tc,add,mul,inv,sub,power
from extension import E,Poly,init
from residual import Curve,resultant_coefficients,bp_add,bp_pow,bp_scale,bp_mul
SRC=json.loads((ROOT/'evidence/global_source.json').read_text())
CACHE=ROOT/'work/global_samples'

def sample(u0):
    start=time.time()
    mod=[0]*10
    for iq,iu,a in SRC['critical_monic']:
        mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
    assert mod[-1]==1
    init(mod);q=E([0,1]);u=E(u0)
    qp=[E(1)]
    for _ in range(7):qp.append(qp[-1]*q)
    up=[E(1),u,u*u]
    P=Poly(DATA['P']);Q=Poly(DATA['Q']);t=Poly(tc);v=Poly([-E(DATA['r']),1])
    d=Poly(DATA['d']).eval(q)
    Curve.Pbar=P*qp[2]
    G={}
    for n,terms in SRC['G_tilde'].items():
        parts=[{} for _ in range(3)]
        for iq,iu,ix,j,a in terms:
            c=E(a)*qp[iq]*up[iu]
            parts[j][ix]=parts[j].get(ix,E(0))+c
        G[int(n)]=Curve([Poly([p.get(i,E(0)) for i in range(max(p,default=-1)+1)]) for p in parts])
    T=Curve([Poly(),(t**3)*(P**3)*qp[2]*d,Poly()])
    rc=resultant_coefficients(3*G[2],2*G[3],G[4],G[5],Curve(Q),T,v)
    a,b,c=[[z.c[j] for z in rc] for j in range(3)]
    norm=bp_add(bp_add(bp_pow(a,3),bp_scale(bp_pow(b,3),Curve.Pbar)),bp_scale(bp_pow(c,3),Curve.Pbar**2))
    norm=bp_add(norm,bp_scale(bp_mul(bp_mul(a,b),c),2*Curve.Pbar))
    den=(P**40)*(t**15)*(v**3)
    R=[p/den for p in norm]
    assert len(R)==7 and max(p.degree() for p in R)<=140
    flat=[a for p in R for i in range(141) for a in p[i].a]
    raw=struct.pack('<%dI'%len(flat),*flat)
    result={'u_code':u0,'modulus':mod,'shape':[7,141,9],
            'digest':hashlib.sha256(raw).hexdigest(),
            'degrees_x':[p.degree() for p in R],
            'seconds':round(time.time()-start,3)}
    CACHE.mkdir(parents=True,exist_ok=True)
    with gzip.open(CACHE/(str(u0)+'.bin.gz'),'wb') as f:f.write(raw)
    (CACHE/(str(u0)+'.json')).write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('GLOBAL SAMPLE',u0,'exact divisions and degree bound verified;',result['seconds'],'seconds',flush=True)
    return result

if __name__=='__main__':
    sample(int(sys.argv[1]) if len(sys.argv)>1 else 0)
