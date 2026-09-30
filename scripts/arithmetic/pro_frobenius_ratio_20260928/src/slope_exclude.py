"""Generate exact all-scale Bezout witnesses for complete slope boundary fibres.
Restartable by sign and factor. A solution of endpoint moments is never used.
"""
import argparse,json,time
from pathlib import Path
import ext
from ext import Element as E,EP
from ff import Poly
from residual import peval,RATIO,check_open,Tails
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]

def run(sign,only=None):
    name='plus' if sign==1 else 'minus'
    model=json.loads((ROOT/f'data/slope_{name}_model.json').read_text())
    dest=ROOT/'data/slope_certificates';dest.mkdir(exist_ok=True)
    summary=[]
    for i,coeffs in enumerate(model['factors']):
        if only is not None and only!=i:continue
        start=time.time();mod=Poly(coeffs)
        q=ext.context(mod)
        z=-peval(model['r0'],q)/peval(model['r1'],q)
        u=z/peval(RATIO['b'],q)
        V=check_open(q,u)
        s=V/(u**3*peval(RATIO['d'],q))
        assert s**3==model['s_cube']
        print(name,i,'degree',mod.degree(),flush=True)
        _,A=residual_jet(q,u,72)
        ts=Tails(A,max_n=72);t1,t2=ts.tail(71),ts.tail(72)
        g,U,W=t1.xgcd(t2)
        assert g==1,('first two tails do not suffice',name,i,g.serialize())
        assert U*t1+W*t2==1
        cert={'case':'slope_'+name,'sign':sign,'factor_index':i,'modulus':mod.tolist(),
            'u_formula':'-r0/(b*r1)','s_cube':model['s_cube'],
            'tail_indices':[71,72],'tail_degrees':[t1.degree(),t2.degree()],
            'mu_power':0,'bezout_coefficients':[U.serialize(),W.serialize()]}
        path=dest/f'slope_{name}_{i}.json';path.write_text(json.dumps(cert,separators=(',',':'))+'\n')
        summary.append({'sign':sign,'factor_index':i,'degree':mod.degree(),
            'certificate':str(path.relative_to(ROOT)),'tail_degrees':cert['tail_degrees'],
            'status':'excluded for every geometric scale','elapsed_seconds':round(time.time()-start,3)})
        print('  verified',summary[-1],flush=True)
    tag='' if only is None else f'_factor_{only}'
    (ROOT/f'checks/slope_{name}_exclusion{tag}.json').write_text(json.dumps({'blocks':summary,'status':'all listed blocks excluded'},indent=2)+'\n')
    return summary

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--sign',choices=['plus','minus']);ap.add_argument('--factor',type=int);a=ap.parse_args()
    for sign in ([1,4] if a.sign is None else [1 if a.sign=='plus' else 4]):run(sign,a.factor)
