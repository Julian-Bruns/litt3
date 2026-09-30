#!/usr/bin/env python3
"""Independent complete opposite-pair test in K+[beta,J], J^2=3beta.

Only four coordinates are used, rather than the producer's eight. Matrices
come from direct determinant evaluations. Includes the common-phase first
pair as an extra case; balanced first endpoints use the proved exclusion.
"""
import argparse
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def main(path,outpath):
    ref=json.loads(path.read_text());start=time.time()
    P=PolynomialRing(GF(5),'t');k=GF(5**7,'t',modulus=P([4,4,2,3,3,2,2,1]));t=k.gen()
    zero=(k(0),k(0));one=(k(1),k(0));beta=(k(0),k(1))
    add=lambda x,y:(x[0]+y[0],x[1]+y[1])
    neg=lambda x:(-x[0],-x[1])
    sub=lambda x,y:add(x,neg(y))
    scale=lambda x,c:(x[0]*c,x[1]*c)
    mul=lambda x,y:(x[0]*y[0]+3*x[1]*y[1],x[0]*y[1]+x[1]*y[0]+x[1]*y[1])
    bar=lambda x:(x[0]+x[1],-x[1])
    def inv(x):
        n=x[0]**2+x[0]*x[1]+2*x[1]**2
        assert n
        return scale(bar(x),1/n)
    def power(x,n):
        r=one
        while n:
            if n&1:r=mul(r,x)
            x=mul(x,x);n//=2
        return r
    code=lambda n:(k(n%5),k(n//5))
    zz=(zero,zero);oo=(one,zero);J=(zero,one);J2=code(15)
    la=lambda x,y:(add(x[0],y[0]),add(x[1],y[1]))
    ln=lambda x:(neg(x[0]),neg(x[1]))
    ls=lambda x,y:la(x,ln(y))
    lm=lambda x,y:(add(mul(x[0],y[0]),mul(J2,mul(x[1],y[1]))),add(mul(x[0],y[1]),mul(x[1],y[0])))
    def li(x):
        n=sub(mul(x[0],x[0]),mul(J2,mul(x[1],x[1])))
        ni=inv(n);return (mul(x[0],ni),neg(mul(x[1],ni)))
    lift=lambda x:(x,zero)
    coord=lambda x:vector(k,list(x[0])+list(x[1]))
    assert not k(3).is_square() and lm(J,J)==lift(J2)
    d=sum(k(c)*t**i for i,c in enumerate([1,2,4,1,3,0,1]))
    z=scale(add((t,k(0)),scale(sub(scale(beta,2),one),d)),k(1)/2)
    assert power(z,29)==one and z!=one and bar(z)==inv(z)
    zp=[power(z,i) for i in range(29)]
    eta=lift(code(22));ie=li(eta)
    # Exact canonical projections in the J basis.
    # c1=[20],e1=[8],f1=[12],g1=4 and c4=J,e4=[12]J,
    # f4=[17]J,g4=[7]J. These independently reconstruct the pair sums.
    coeff=[(20,1,5),(8,12,8),(12,17,17),(4,7,4)]
    pair_values={}
    for i in range(2):
        for phase in range(29):
            pair_values[i,phase]=[(scale(mul(code(a),zp[r*phase%29]),2),
                                  scale(mul(code(b),zp[r*phase%29]),2*(-1)**i)) for a,b,r in coeff]
    pairs=list(pair_values)
    second=list(itertools.combinations_with_replacement(pairs,2));assert len(second)==1711
    families=[(p,j) for p in range(2) for j in [1,2,4,8]]+[(0,0)]
    out=dict(status='RUNNING',families=[],total_cases=15399,completed=0,isolated_count=0,survivors=[])
    for parity,phase in families:
        cq,eq,uq,vq=[la(a,b) for a,b in zip(pair_values[0,0],pair_values[parity,phase])]
        nq=out['isolated_count'];linear_bad=0;actual=0
        for hp,hq in second:
            ch,eh,uh,vh=[la(a,b) for a,b in zip(pair_values[hp],pair_values[hq])]
            a,b,c,d=[lm(v,ie) for v in [eq,cq,ch,eh]]
            def determinant(v):
                x=(v[0],v[1]);y=(v[2],v[3])
                return ls(lm(ls(a,lift(bar(x))),ls(d,lift(x))),
                          lm(ls(b,lift(y)),ls(c,lift(bar(y)))))
            v0=vector(k,[0]*4);const=coord(determinant(v0));cols=[]
            for j in range(4):
                v=vector(k,list(v0));v[j]=1;cols.append(coord(determinant(v))-const)
            mat=matrix(k,3,4,lambda i,j:cols[j][i+1]);rhs=-const[1:]
            rank=mat.rank();out['completed']+=1
            if mat.augment(matrix(k,3,1,list(rhs))).rank()!=rank:
                linear_bad+=1;continue
            particular=mat.solve_right(rhs);basis=mat.right_kernel().basis()
            assert len(basis)==1,(parity,phase,hp,hq,rank)
            w=basis[0];z0=coord(determinant(particular));zp1=coord(determinant(particular+w));zm1=coord(determinant(particular-w))
            assert not any(z0[1:]) and not any(zp1[1:]) and not any(zm1[1:])
            qa=(zp1[0]+zm1[0])/2-z0[0];qb=(zp1[0]-zm1[0])/2;qc=z0[0]
            roots=[]
            if qa:
                disc=qb*qb-4*qa*qc
                if disc.is_square():
                    rr=disc.sqrt();roots=list({(-qb+rr)/(2*qa),(-qb-rr)/(2*qa)})
            elif qb:roots=[-qc/qb]
            else:assert qc
            for rr in roots:
                v=particular+rr*w;x=(v[0],v[1]);y=(v[2],v[3])
                aa,bb=ls(a,lift(bar(x))),ls(b,lift(y))
                cc,dd=ls(c,lift(bar(y))),ls(d,lift(x))
                if aa==zz and bb==zz:
                    assert cc!=zz or dd!=zz;continue
                ep=lm(cc,li(aa)) if aa!=zz else lm(dd,li(bb))
                if ep==zz or lm(ep,aa)!=cc or lm(ep,bb)!=dd:continue
                actual+=1;out['isolated_count']+=1
                r0=ls(la(lm(ep,uq),vq),lm(eta,ls(lm(ep,lift(power(x,625))),lift(power(bar(y),5)))))
                r1=ls(la(uh,lm(ep,vh)),lm(eta,ls(lift(power(bar(x),625)),lm(ep,lift(power(y,5))))))
                assert r0!=zz or r1!=zz,(parity,phase,hp,hq)
        family=dict(parity=parity,phase=phase,linear_inconsistent=linear_bad,isolated=actual)
        out['families'].append(family);out['elapsed']=time.time()-start
        outpath.write_text(json.dumps(out,indent=2)+'\n')
        print('PASS',parity,phase,'isolated',actual,'seconds',round(out['elapsed'],1),flush=True)
    assert out['completed']==15399
    assert sum(f['isolated'] for f in out['families'][:8])==ref['isolated_count']==13284
    assert out['survivors']==ref['survivors']==[] and ref['unresolved']==[]
    out.update(status='COMPLETE',elapsed=time.time()-start)
    outpath.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: every opposite-pair endpoint configuration is excluded; balanced first ends use the prior theorem.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('certificate',type=Path);p.add_argument('--output',type=Path,required=True)
    ar=p.parse_args();main(ar.certificate,ar.output)
