#!/usr/bin/env python3
"""Exact norm elimination for two complete four-root blocks at each end.

All geometric scales are retained: the old traces put epsilon in K0.
This script then decides the finite K0 moment equations, not curve existence.
"""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path)
    ap.add_argument('--phase',type=int,default=0);ap.add_argument('--limit',type=int)
    args=ap.parse_args();start=time.monotonic()
    F=GF(5);R=PolynomialRing(F,'z')
    K=GF(5**14,'z',modulus=R([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]));z=K.gen()
    beta=K([1,1,0,0,4,3,3,1,1,3,1,2,1,1]);assert beta**2==beta+3 and z**29==1
    c=lambda n:K(n%5)+(n//5)*beta
    q=5**7;kap=c(17);b=c(8);bb=b**5
    P=PolynomialRing(K,'N');N=P.gen();R=PolynomialRing(P,'E');E=R.gen()
    S=PolynomialRing(K,'e');e=S.gen()
    bar=lambda f:P([x**q for x in f.list()])
    enc=lambda a:[int(a.polynomial()[j]) for j in range(14)]
    powers=[z**i for i in range(29)]
    aa=powers[args.phase]; ps=lambda r:1+aa**r
    u,v,U,V=ps(8),kap*ps(5),b*ps(17),bb*ps(4)
    out=dict(status='RUNNING',phase=args.phase,cases=[],survivors=[],scope='two complete four-root blocks per endpoint; exact four traces')
    def save():
        out['seconds']=time.monotonic()-start;args.output.write_text(json.dumps(out,indent=2)+'\n')
    def mp(x,n,f):
        a=f.parent().one();x%=f
        while n:
            if n&1:a=a*x%f
            n//=2
            if n:x=x*x%f
        return a
    def residues(ep,xx,yy,w,zz,W,Z):
        return [ep*(u-xx**q)-w+yy**q,ep*(v-yy)-zz+xx,
                ep*xx**625-yy**(q*5)-ep*U-V,
                xx**(q*625)-ep*yy**5-W-ep*Z]
    for index,(ci,di) in enumerate(itertools.combinations_with_replacement(range(29),2)):
        if args.limit is not None and index>=args.limit:break
        cc,dd=powers[ci],powers[di];qs=lambda r:cc**r+dd**r
        w,zz,W,Z=kap*qs(5),qs(8),b*qs(17),bb*qs(4)
        D=u-zz**q;F0=w-v**q
        row=dict(second_phases=[ci,di],norm_one=[],candidates=[],survivors=[])
        if not D:
            assert F0
        else:
            ep=F0/D
            if ep and ep**(q+1)==1:
                # The first two traces leave y free. The fourth traces are
                # F5-linear in y; test the full14-dimensional K0, not samples.
                def rr(yy):
                    xx=zz-ep*v+ep*yy
                    return vector(F,[int(a.polynomial()[j]) for a in residues(ep,xx,yy,w,zz,W,Z)[2:] for j in range(14)])
                r0=rr(K.zero());cols=[rr(z**j)-r0 for j in range(14)]
                mat=matrix(F,cols).transpose();rank=int(mat.rank())
                consistent=mat.augment(matrix(F,28,1,list(-r0))).rank()==rank
                witness=None
                if consistent:
                    sol=mat.solve_right(-r0);yy=sum((K(sol[j])*z**j for j in range(14)),K.zero());xx=zz-ep*v+ep*yy
                    assert not any(residues(ep,xx,yy,w,zz,W,Z))
                    witness=dict(epsilon=enc(ep),X=enc(xx),Y=enc(yy),kernel_dimension=14-rank)
                    row['survivors'].append(witness)
                row['norm_one'].append(dict(epsilon=enc(ep),rank=rank,consistent=bool(consistent)))
        al=D**5;be=(1-N)**4*(W**q-U)
        ga=(1-N)**4*(N*Z**q-V)-w**5+N**5*v**(q*5)
        if not al:
            assert be
            res=ga*bar(ga)-N*be*bar(be)
        else:
            q2=bar(ga)*be;q1=bar(be)*N*be+bar(ga)*ga-al*(al**q)*N**5;q0=bar(be)*N*ga
            Q=q2*E**2+q1*E+q0
            T=q2**5*(be*E+ga)**2-al*q1**5*(be*E+ga)+al**2*q0**5
            res=Q.resultant(T)
        if not res:
            row['exception']='IDENTICALLY_ZERO_NORM_ELIMINANT'
        else:
            g=res.gcd(mp(N,q,res)-N).monic();row.update(resultant_degree=int(res.degree()),norm_gcd_degree=int(g.degree()))
            roots=g.roots(multiplicities=False) if g.degree()>0 else []
            row['norm_gcd_coefficients']=[enc(t) for t in g.list()]
            row['norms']=[enc(t) for t in roots]
            assert len(roots)==g.degree()
            for nv in roots:
                if nv in [0,1]:continue
                f=S(al)*e**5+S(be(nv))*e+S(ga(nv))
                if not f:
                    row['exception']='ZERO_SCALE_EQUATION';continue
                if f.degree()==0:continue
                h=f.gcd(mp(e,q+1,f)-nv).monic()
                scales=h.roots(multiplicities=False) if h.degree()>0 else []
                assert len(scales)==h.degree()
                for ep in scales:
                    assert ep and ep**(q+1)==nv
                    yb=(w-ep*D-nv*v**q)/(1-nv);yy=yb**q;xx=zz-ep*v+ep*yy
                    rs=residues(ep,xx,yy,w,zz,W,Z);assert not rs[0] and not rs[1]
                    row['candidates'].append(dict(norm=enc(nv),epsilon=enc(ep),fourth_zero=[not bool(r) for r in rs[2:]]))
                    if not any(rs):row['survivors'].append(dict(epsilon=enc(ep),X=enc(xx),Y=enc(yy)))
        if row['survivors']:out['survivors'].append(dict(second_phases=[ci,di],witnesses=row['survivors']))
        out['cases'].append(row)
        if index%10==0 or row.get('exception') or row['survivors']:
            save();print('phase',args.phase,'cases',index+1,'surviving_cases',len(out['survivors']),'seconds',round(time.monotonic()-start,2),flush=True)
    out['status']='COMPLETE' if len(out['cases'])==435 else 'BOUNDED_PREFIX';save()
    print(out['status'],'cases',len(out['cases']),'surviving_cases',len(out['survivors']),flush=True)

if __name__=='__main__':main()
