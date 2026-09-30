"""Exact ratio algebra for the two leading-critical-slope boundary divisors.
Uses z=b(q)*u; its quadratic relation is z^2+2*c*z+3*b*e=0.
These are complete geometric fibres s^3=+/-kappa, not rational-point scans.
"""
import json,time
from pathlib import Path
from ff import Poly,X,mul,div,neg,power
from residual import RATIO
from reconstruct import epsilon
from factor import factor_squarefree
ROOT=Path(__file__).resolve().parents[1]

def make_model(sign, save=True):
    assert sign in (1,4)
    start=time.time()
    a,b,c,e,d=[Poly(RATIO[k]) for k in ['a0','b','c','e','d']]
    const=mul(sign,div(power(24,6),mul(2,power(epsilon,6))))
    Z0,Z1=2*b*e,3*c
    def add(x,y):return (x[0]+y[0],x[1]+y[1])
    def scale(x,k):return (x[0]*k,x[1]*k)
    def prod(x,y):
        return (x[0]*y[0]+x[1]*y[1]*Z0,
                x[0]*y[1]+x[1]*y[0]+x[1]*y[1]*Z1)
    def pw(x,n):
        ans=(Poly(1),Poly())
        while n:
            if n&1:ans=prod(ans,x)
            n//=2
            if n:x=prod(x,x)
        return ans
    z=(Poly(),Poly(1))
    z2=pw(z,2)
    W=add(add(scale(z2,a),scale(z,4*b*b)),(2*c*b*b,Poly()))
    # s = W/(d*z^2), exactly on g=0 and b,u,d units.
    raw=add(pw(W,3),scale(pw(z,6),neg(const)*d**3))
    cont=raw[0].gcd(raw[1])
    r0,r1=[x//cont for x in raw]
    norm=r0*r0-2*c*r0*r1+3*b*e*r1*r1
    old=X*d*b*c*e*Poly(RATIO['C'])*(X-10149)*(X-64426)
    dd2=c*c-4*b*e
    dd3=b*b*c*c+a*c**3+b**3*e+3*a*a*e*e+3*a*b*c*e
    old=old*dd2*dd3
    # Removing content is safe ONLY if it is supported on known old units.
    k=cont
    while k.degree()>0:
        gg=k.gcd(old)
        assert gg.degree()>0,('uncontrolled content',gg.tolist())
        k=k//gg
    orig=norm
    while True:
        gg=norm.gcd(old)
        if gg.degree()==0:break
        norm=norm//gg
    norm=norm.monic()
    sf=norm//norm.gcd(norm.derivative())
    sf=sf.monic()
    common=sf.gcd(r1)
    print('slope sign',sign,'constant',const,'norm raw/allowed/sf deg',orig.degree(),norm.degree(),sf.degree(),'common r1 degree',common.degree(),flush=True)
    fs=factor_squarefree(sf)
    print('factors',[f.degree() for f in fs],flush=True)
    model={'sign':sign,'s_cube':const,'kappa':div(power(24,6),mul(2,power(epsilon,6))),
      'z_relation':'z^2+2*c*z+3*b*e=0; z=b*u',
      's_formula':'s=(a0*z^2+4*b^2*z+2*c*b^2)/(d*z^2)',
      'content':cont.tolist(),'r0':r0.tolist(),'r1':r1.tolist(),
      'norm_raw':orig.tolist(),'norm_allowed':norm.tolist(),'norm_squarefree':sf.tolist(),
      'old_q_units':old.tolist(),'r1_exception':common.tolist(),
      'factors':[f.tolist() for f in fs],
      'elapsed_seconds':round(time.time()-start,3)}
    if save:(ROOT/'data'/('slope_plus_model.json' if sign==1 else 'slope_minus_model.json')).write_text(json.dumps(model,indent=2)+'\n')
    return model

if __name__=='__main__':
    make_model(1);make_model(4)
