#!/usr/bin/env python3
"""Independent shifted-field, explicit-resultant check of all retained roots.

No resultant, factorization or root finder is used here. The producer uses
an absolute degree14 field and Sage's resultant/root routines.
"""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path);ap.add_argument('certificates',nargs='+',type=Path)
    args=ap.parse_args();start=time.monotonic()
    S=PolynomialRing(GF(5),'w');w=S.gen()
    absolute=S([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]);p=absolute(w-1)
    assert p.is_irreducible();K=GF(5**14,'w',modulus=p);z=K.gen()-1;assert z**29==1 and z!=1
    dec=lambda row:sum((K(c)*z**j for j,c in enumerate(row)),K.zero())
    b=dec([1,1,0,0,4,3,3,1,1,3,1,2,1,1]);assert b**2==b+3
    code=lambda n:K(n%5)+K(n//5)*b
    assert sum((code(c)*z**j for j,c in enumerate([4,22,7,20,21,7,24,1])),K.zero())==0
    q=5**7;kap=K(code(17));b0=K(code(8));bb=b0**q
    P=PolynomialRing(K,'N');N=P.gen();R=PolynomialRing(K,'e');e=R.gen()
    bar=lambda f:P([c**q for c in f.list()])
    def gcd(f,g):
        while g:f,g=g,f%g
        return f/f.leading_coefficient()
    def mp(x,n,f):
        r=f.parent().one();x%=f
        while n:
            if n&1:r=r*x%f
            n//=2
            if n:x=x*x%f
        return r
    orbit=set();count=candidates=0;receipts=[]
    for path in args.certificates:
        data=json.loads(path.read_text());assert data['status']=='COMPLETE'
        a=data['phase'];assert a in [0,1,2,4,8]
        this={a*pow(25,i,29)%29 for i in range(7)};assert not orbit&this;orbit|=this
        ps=lambda r:1+(z**a)**r
        u,v,U,V=ps(8),kap*ps(5),b0*ps(17),bb*ps(4)
        seen=set();nc=0
        for row in data['cases']:
            ci,di=row['second_phases'];assert 0<=ci<=di<29 and (ci,di) not in seen;seen.add((ci,di))
            qs=lambda r:(z**ci)**r+(z**di)**r
            w,zz,W,Z=kap*qs(5),qs(8),b0*qs(17),bb*qs(4)
            D=u-zz**q;F0=w-v**q
            if not D:assert F0
            else:
                ep=F0/D;assert not ep or ep**(q+1)!=1
            assert not row['norm_one'] and 'exception' not in row
            aa=D**5;be=(1-N)**4*(W**q-U);ga=(1-N)**4*(N*Z**q-V)-w**5+N**5*v**(q*5)
            if not aa:res=ga*bar(ga)-N*be*bar(be)
            else:
                A=bar(ga)*be;B0=bar(be)*N*be+bar(ga)*ga-aa*(aa**q)*N**5;C=bar(be)*N*ga
                DD=A**5*be**2;JJ=2*A**5*be*ga-aa*B0**5*be;HH=A**5*ga**2-aa*B0**5*ga+aa**2*C**5
                res=(A*HH-C*DD)**2-(A*JJ-B0*DD)*(B0*HH-C*JJ)
            assert res and res.degree()==row['resultant_degree']
            g=P(gcd(res,mp(N,q,res)-N));assert g==P([dec(c) for c in row['norm_gcd_coefficients']])
            roots=[dec(c) for c in row['norms']];assert len(set(roots))==len(roots)
            prod=P.one()
            for nv in roots:assert nv**q==nv;prod*=N-nv
            assert prod==g and g.degree()==row['norm_gcd_degree']
            row_count=0
            for nv in roots:
                if nv in [0,1]:continue
                f=R(aa)*e**5+R(be(nv))*e+R(ga(nv));assert f
                if f.degree()==0:continue
                h=R(gcd(f,mp(e,q+1,f)-nv));prod=R.one()
                witnesses=[w0 for w0 in row['candidates'] if dec(w0['norm'])==nv]
                for wit in witnesses:
                    ep=dec(wit['epsilon']);assert ep and ep**(q+1)==nv;prod*=e-ep
                    yb=(w-ep*D-nv*v**q)/(1-nv);yy=yb**q;xx=zz-ep*v+ep*yy
                    assert ep*(u-xx**q)==w-yb and ep*(v-yy)==zz-xx
                    r0=ep*xx**625-yb**5-ep*U-V;r1=xx**(q*625)-ep*yy**5-W-ep*Z
                    assert [not bool(r0),not bool(r1)]==wit['fourth_zero'] and (r0 or r1)
                    row_count+=1
                assert prod==h
            assert row_count==len(row['candidates']) and not row['survivors'];nc+=row_count;count+=1
        assert seen==set(itertools.combinations_with_replacement(range(29),2)) and not data['survivors']
        candidates+=nc;receipts.append(dict(file=path.name,cases=len(seen),complete_candidates=nc))
        print('PASS phase',a,'all435 pairs; candidates',nc,flush=True)
    assert orbit==set(range(29)) and count==2175 and candidates==2118
    out=dict(status='PASS_ALL_TWO_BLOCK_TRACE_PAIRS_EXCLUDED',cases=count,candidates=candidates,receipts=receipts,field_modulus=[int(c) for c in p.list()],seconds=time.monotonic()-start)
    args.output.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out),flush=True)

if __name__=='__main__':main()
