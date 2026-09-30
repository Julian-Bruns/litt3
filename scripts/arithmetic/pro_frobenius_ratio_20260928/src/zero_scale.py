"""Global zero-scale computation on the ordinary-double-root ratio curve.
The outcome is recorded only after exact norm Bezout and unit checks.
This does not decide the nonzero-scale square problem.
"""
import json,time
from pathlib import Path
import numpy as np
from global_curve import QC,ssquare,smul
from half_gcd import install
install()
from ff import Poly,X
from residual import RATIO
ROOT=Path(__file__).resolve().parents[1]


from global_units import known_q_units

def strip(p,old):
    parts=[]
    g=p.gcd(old)
    while g.degree()>0:
        p=p//g;parts.append(g)
        if p.degree()<=0:break
        g=p.gcd(g*g)
    return p,parts

def compute():
    start=time.time();g=np.load(ROOT/'data/global_residual.npz')['coefficients']
    content=Poly(json.loads((ROOT/'data/global_contents.json').read_text())['contents'][0])
    old=known_q_units();rem,_=strip(content,old);assert rem.degree()==0
    aa=[QC(g[0,n,0],g[1,n,0])//content for n in range(74)]
    print('ZERO_SCALE_INPUT',max(a.a.degree() for a in aa),max(a.b.degree() for a in aa),flush=True)
    a2=ssquare(aa,74);print('ZERO_SCALE_SQUARE',round(time.time()-start,3),flush=True)
    a3=smul(aa,a2,74);print('ZERO_SCALE_CUBE',round(time.time()-start,3),flush=True)
    p5=[x.frob() for x in a2[:15]];p25=[x.frob(2) for x in a2[:3]]
    cert={'status':'computation in progress','global_scale_multiplier':'b^72*q^83*d^36','removed_input_content':content.tolist(),'tails':{}}
    norms=[]
    for n in (71,72,73):
        val=QC()
        for j in range(n//25+1):
            inner=QC()
            for i in range((n-25*j)//5+1):inner=inner+a3[n-25*j-5*i]*p5[i]
            val=val+inner*p25[j]
        print('ZERO_SCALE_RAW_TAIL',n,val.degrees(),round(time.time()-start,3),flush=True)
        np.savez_compressed(ROOT/f'scratch/zero_scale_raw_{n}.npz',a=val.a.a,b=val.b.a)
        ct=val.content();print('ZERO_SCALE_CONTENT',n,ct.degree(),round(time.time()-start,3),flush=True)
        rem,_=strip(ct,old);print('ZERO_SCALE_CONTENT_STRIPPED',n,rem.degree(),round(time.time()-start,3),flush=True)
        # Preserve any uncontrolled content; it is not silently inverted.
        allowed_ct=ct//rem;prim=val//allowed_ct
        norm=prim.norm();allowed_norm,norm_parts=strip(norm,old)
        allowed_norm=allowed_norm.monic();norms.append(allowed_norm)
        cert['tails'][str(n)]={'primitive_pair':prim.serialize(),'removed_content':allowed_ct.tolist(),
          'uncontrolled_content':rem.tolist(),'allowed_norm':allowed_norm.tolist()}
        print('ZERO_SCALE_PRIMITIVE_TAIL',n,prim.degrees(),'allowed norm',allowed_norm.degree(),'uncontrolled content',rem.degree(),round(time.time()-start,3),flush=True)
        (ROOT/'data/zero_scale_certificate.json').write_text(json.dumps(cert,separators=(',',':'))+'\n')
        if len(norms)>=2:
            gg,xx,yy=norms[0].xgcd(norms[1]);print('ZERO_SCALE_NORM_GCD',gg.degree(),round(time.time()-start,3),flush=True)
            if gg.degree()==0:
                assert xx*norms[0]+yy*norms[1]==1
                cert['status']='global zero-scale square locus excluded on old proved open'
                cert['bezout']={'indices':[71,72],'U':xx.tolist(),'V':yy.tolist()}
                break
    cert['seconds']=round(time.time()-start,3)
    (ROOT/'data/zero_scale_certificate.json').write_text(json.dumps(cert,separators=(',',':'))+'\n')
    print('ZERO_SCALE_SUMMARY',cert['status'],cert['seconds'],flush=True)

if __name__=='__main__':compute()
