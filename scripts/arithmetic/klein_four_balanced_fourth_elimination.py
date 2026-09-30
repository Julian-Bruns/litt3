#!/usr/bin/env python3
"""Eliminate the norm for arbitrary balanced epsilon in F_(5^14).

Both fourth-order trace identities imply an affine Frobenius equation
for epsilon. Norm compatibility and its fifth power give two quadratics.
Their resultant is a necessary norm condition; every boundary is retained.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def main(path):
    start=time.time()
    p=PolynomialRing(GF(5),'z')
    K=GF(5**14,'z',modulus=p([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]))
    z=K.gen();beta=K([1,1,0,0,4,3,3,1,1,3,1,2,1,1])
    c=lambda n:K(n%5)+(n//5)*beta
    assert beta**2==beta+3 and z**29==1
    q=5**7;kap=c(17);b=c(8);bb=b**5;a=c(12)
    assert a==b*b and b*bb==4
    P=PolynomialRing(K,'N');N=P.gen();R=PolynomialRing(P,'E');E=R.gen()
    S=PolynomialRing(K,'e');e=S.gen()
    bar=lambda f:P([x**q for x in f.list()])
    encode=lambda x:list(map(int,x.polynomial().list()))
    out=dict(status='RUNNING',scope='Necessary old and both fourth traces, all balanced phases, arbitrary epsilon in F5^14',
             norm_field_exponent=q,cases=[])
    path.write_text(json.dumps(out,indent=2)+'\n')

    def modpower(x,n,f):
        ans=f.parent().one();x=x%f
        while n:
            if n&1:ans=(ans*x)%f
            n//=2
            if n:x=(x*x)%f
        return ans

    for phase in [0,1,2,4,8]:
        phi=z**phase;al=1-phi**18
        be=(1-N)**4*(bb*phi**12-b)
        ga=(1-N)**4*(b*N*phi**25-bb)+N**5*kap-kap**5*phi**25
        norm_one=[]
        if phase:
            ep=(kap*phi**5-kap**5)/(1-phi**(-8))
            if ep**(q+1)==1:norm_one.append(encode(ep))
        else:
            assert kap!=kap**5
        assert not norm_one
        if phase==0:
            resultant=ga*bar(ga)-N*be*bar(be)
            Q=R(be*E+ga);T=R.zero()
        else:
            q2=bar(ga)*be
            q1=bar(be)*N*be+bar(ga)*ga-al*(al**q)*N**5
            q0=bar(be)*N*ga
            Q=q2*E**2+q1*E+q0
            T=q2**5*(be*E+ga)**2-al*q1**5*(be*E+ga)+al**2*q0**5
            resultant=Q.resultant(T)
        row=dict(phase=phase,norm_one_candidates=norm_one,resultant_zero=not bool(resultant))
        if not resultant:
            out['cases'].append(row);path.write_text(json.dumps(out,indent=2)+'\n')
            print('phase',phase,'IDENTICALLY ZERO RESULTANT',flush=True);continue
        row['resultant_degree']=int(resultant.degree())
        g=resultant.gcd(modpower(N,q,resultant)-N).monic()
        row['field_norm_gcd_degree']=int(g.degree())
        row['field_norm_gcd_coefficients']=[encode(x) for x in g.list()]
        print('phase',phase,'raw resultant degree',resultant.degree(),'norm gcd degree',g.degree(),flush=True)
        roots=[];gopen=g
        for nv in [K.zero(),K.one()]:
            if not gopen(nv):
                roots.append(nv);gopen=gopen//(N-nv)
        if gopen.degree()>0:
            roots.extend(gopen.roots(multiplicities=False))
        assert len(roots)==g.degree()
        candidates=[];survivors=[]
        for nv in roots:
            if nv in [0,1]:continue
            f=S(al)*e**5+S(be(nv))*e+S(ga(nv))
            assert f
            f=f.monic()
            if f.degree()==0:continue
            h=f.gcd(modpower(e,q+1,f)-nv).monic()
            epsilons=h.roots(multiplicities=False) if h.degree()>0 else []
            assert len(epsilons)==h.degree()
            for ep in epsilons:
                assert ep and ep**(q+1)==nv
                yb=(kap*phi**5-ep*(1-phi**(-8))-nv*kap**5)/(1-nv)
                y=yb**q;x=phi**8-ep*kap+ep*y
                assert ep*(1-x**q)==kap*phi**5-yb
                assert ep*(kap-y)==phi**8-x
                r0=ep*a+4-b*(ep*x**625-yb**5)
                r1=a*phi**17+4*ep*phi**4-b*(x**(q*625)-ep*y**5)
                rec=dict(norm=encode(nv),epsilon=encode(ep),fourth_zero=[not bool(r0),not bool(r1)])
                candidates.append(rec)
                if not r0 and not r1:survivors.append(rec)
        row.update(norms=[encode(n) for n in roots],candidates=candidates,survivors=survivors,
                   elapsed=time.time()-start)
        out['cases'].append(row);path.write_text(json.dumps(out,indent=2)+'\n')
        print('phase',phase,'resultant',resultant.degree(),'norm gcd',g.degree(),'candidates',len(candidates),'survivors',len(survivors),'seconds',round(time.time()-start,2),flush=True)
    out.update(status='COMPLETE',elapsed=time.time()-start)
    path.write_text(json.dumps(out,indent=2)+'\n')


if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True)
    main(ap.parse_args().output)
