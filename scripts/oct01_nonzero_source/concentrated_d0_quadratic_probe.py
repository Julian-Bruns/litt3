#!/usr/bin/env python3
"""Fixed first-slope probe on the exact d0 concentrated rational source family."""
import argparse,json,sys
from math import comb
from itertools import combinations_with_replacement
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES,Q_CODES,inverse_mod
from cubic_extension import CubicExtension
from endpoint_jets import SOURCE_CHARACTERS
from infinity import InfinitySystem


def kernel(e,matrix):
    rr,piv=e.rref(matrix);free=[i for i in range(rr.shape[1]) if i not in piv]
    ker=np.zeros((len(free),rr.shape[1]),dtype=np.uint64)
    for row,col in enumerate(free):
        ker[row,col]=1
        for j,pivot in enumerate(piv):ker[row,pivot]=e.neg(int(rr[j,col]))
    assert not np.any(e.matmul(np.asarray(matrix,dtype=np.uint64),ker.T))
    return ker,piv


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    ap.add_argument('--root',type=int,default=145049);ap.add_argument('--eta',type=int,default=1)
    ap.add_argument('--points',type=int,default=45);args=ap.parse_args()
    base=Field(args.work/'cache');bp=Poly(base);e=CubicExtension(base);p=Poly(e);C=Curve(e)
    fam=json.loads((args.work/'data/adapted_family.json').read_text());t=fam['t'];z=bp.sub(B0_CODES,L0_CODES)
    source_family=json.loads((args.work/'data/concentrated_d0_source_family.json').read_text())
    record=next(r for r in source_family['records'] if r['root_K_code']==args.root)
    den=bp.eval(record['common_denominator'],args.eta);assert den
    normalized=[base.div(bp.eval(f,args.eta),den) for f in record['source_numerators']]
    assert normalized[0]==1 and normalized[4] and normalized[13]
    shifted=json.loads((args.work/'data/shifted_concentrated_projection.json').read_text())
    point=next(r for r in shifted['records'] if r['root_K_code']==args.root)
    y0=point['y0_extension_code']
    source=[e.mul(c,e.power(y0,1-SOURCE_CHARACTERS[i])) for i,c in enumerate(normalized)]
    system=InfinitySystem(base,fam);N=[C.zero() for _ in range(6)]
    for scalar,row in zip(source[:13],system.N):
        for j in range(6):N[j]=C.add(N[j],C.scale(row[j],scalar))
    v=C.const(source[13]);N[0]=v;N[5]=C.add(N[5],C.mul(v,C.polyx(Q_CODES)))
    S,q=C.frame(N);assert C.pole(v)==0 and C.pole(S[4])==12
    tau=C.power(C.polyx(t),3)
    F=[C.add(C.add(C.mul(v,C.power(q,2)),C.mul(q,S[0])),tau)]
    F.extend(C.mul(q,S[j]) for j in range(1,5));F.append(C.add(S[0],C.scale(C.mul(v,q),2)))
    F.extend(S[1:]);F.append(v);D=[C.scale(S[j],j) for j in range(1,5)]
    def pi(function,n):
        raw=C.mul(C.polyx(bp.power(z,n)),function);out=C.zero()
        for char,component in enumerate(raw):
            power,target=divmod(char-n,3)
            out[target]=p.mul(component,bp.power(C.P,power)) if power>=0 else p.divmod(component,bp.power(C.P,-power))[0]
        return out
    def numerator(a5,a4,rs):
        c3=C.add(pi(a4,1),rs[3]);c2=C.add(C.neg(C.add(C.scale(pi(c3,1),3),pi(a4,2))),rs[2])
        c1=C.add(C.neg(C.add(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3)),C.scale(pi(a4,3),4))),rs[1])
        c0=C.add(C.neg(C.add(C.add(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3)),pi(a4,4)),pi(a5,5))),rs[0])
        return [c0,c1,c2,c3,a4,a5]
    def jetrows(cs):
        out=[]
        for j in range(3):
            clear=C.zero()
            for hh in range(j,6):
                scalar=comb(hh,j)%5
                if scalar:
                    term=C.mul(C.polyx(bp.power(z,hh-j)),cs[hh])
                    term=C.mul(term,C.power(C.monomial(0,1),5-hh))
                    clear=C.add(clear,C.scale(term,scalar))
            modulus=bp.power(t,3-j)
            for component in clear:
                rem=p.mod(component,modulus);out.extend(rem+[0]*(len(modulus)-1-len(rem)))
        return out
    cut=7
    def shift(poly):
        out=[]
        for scalar in reversed(poly):out=p.add(p.mul(out,[args.root,1]),[scalar])[:cut]
        return out
    rhs=p.scale(shift(C.P),e.inv(bp.eval(C.P,args.root)));h=[1]
    for n in range(1,cut):
        power=p.power(h,3);h.append(e.div(e.sub(rhs[n] if n<len(rhs) else 0,power[n] if n<len(power) else 0),3))
    yy=p.scale(h,y0);yi=[e.inv(y0)]
    for n in range(1,cut):
        product=p.mul(yy,yi);yi.append(e.neg(e.div(product[n] if n<len(product) else 0,y0)))
    aa=p.mul(shift(z),yi)[:cut]
    slope=e.div(e.mul(bp.eval(bp.derivative(t),args.root),args.eta),y0)
    def series(function):
        out=[]
        for char in range(3):out=p.add(out,p.mul(shift(function[char]),p.power(yy,char)))
        return out[:cut]
    def extra(cs):
        vals=[series(c) for c in cs];short=[]
        for j in range(6):
            out=[]
            for hh in range(j,6):out=p.add(out,p.scale(p.mul(vals[hh],p.power(aa,hh-j)),comb(hh,j)%5))
            short.append(out[:cut])
        out=[]
        for j,n in point['row_tags']:
            coefficient=0
            for hh in range(j,6):
                ix=n-(hh-j)
                if 0<=ix<len(short[hh]):
                    coefficient=e.add(coefficient,e.mul(e.mul(comb(hh,j)%5,e.power(slope,hh-j)),short[hh][ix]))
            out.append(coefficient)
        return out
    columns=[]
    for b in range(3):
        m=C.monomial(b,0);columns.append(numerator(C.mul(v,m),C.mul(S[4],m),[C.zero() for _ in range(4)]))
    for b,char in monomials(10):columns.append(numerator(C.zero(),C.mul(v,C.monomial(b,char)),[C.zero() for _ in range(4)]))
    for j in range(4):
        for b,char in monomials(25-j):
            rs=[C.zero() for _ in range(4)];rs[j]=C.monomial(b,char)
            columns.append(numerator(C.zero(),C.zero(),rs))
    J=np.array([jetrows(cs)+extra(cs) for cs in columns],dtype=np.uint64).T
    ker,piv=kernel(e,J);U=[]
    for vector in ker:
        cs=[C.zero() for _ in range(6)]
        for scalar,col in zip(vector,columns):
            if scalar:
                for j in range(6):cs[j]=C.add(cs[j],C.scale(col[j],int(scalar)))
        U.append(cs)
    sym=list(combinations_with_replacement(range(len(U)),2))
    eta0=[C.monomial(b,char) for b,char in monomials(20)]
    eta1=[C.monomial(b,char) for b,char in monomials(32)]
    eta2=[C.monomial(b,char) for b,char in monomials(44)]
    eta10=[pi(C.mul(v,c),1) for c in eta0]
    eta20=[C.sub(C.scale(pi(C.mul(v,pi(C.mul(v,c),1)),1),2),pi(C.mul(C.power(v,2),c),2)) for c in eta0]
    eta21=[C.scale(pi(C.mul(v,c),1),2) for c in eta1]
    def evaluate(function,x,y):
        return e.add(e.add(p.eval(function[0],x),e.mul(y,p.eval(function[1],x))),e.mul(e.power(y,2),p.eval(function[2],x)))
    matrix=[];points=[]
    for x in range(1,200000):
        value=bp.eval(C.P,x)
        if not value or int(base.log[value])%3:continue
        y=int(base.exp[int(base.log[value])//3]);tf=bp.eval(t,x)
        if not tf:continue
        vf=source[13];ff=[evaluate(c,x,y) for c in F];dd=[evaluate(c,x,y) for c in D]
        fm=p.scale(ff,e.inv(vf));phi=[evaluate(q,x,y),0,0,0,0,1];fw=p.mul(phi,dd)
        if p.gcd(ff,fw)!=[1]:continue
        di=inverse_mod(p,dd,fm);g=p.mod(p.power(di,2),fm);traces=[]
        for n in range(13):
            out=p.mod(p.mul(g,fw),fm);traces.append(e.div(out[9] if len(out)>9 else 0,vf));g=p.mod([0]+g,fm)
        uu=np.array([[evaluate(c,x,y) for c in cs] for cs in U],dtype=np.uint64);grams=[]
        for j in range(3):
            hank=np.array([[traces[a+b+j] for b in range(6)] for a in range(6)],dtype=np.uint64)
            gram=e.matmul(e.matmul(uu,hank),uu.T)
            grams.append([e.mul(e.mul(int(gram[a,b]),1 if a==b else 2),e.power(vf,j)) for a,b in sym])
        erows=[
            [e.neg(evaluate(c,x,y)) for c in eta0]+[0]*(len(eta1)+len(eta2)),
            [e.neg(evaluate(c,x,y)) for c in eta10]+[e.neg(evaluate(c,x,y)) for c in eta1]+[0]*len(eta2),
            [e.neg(evaluate(c,x,y)) for c in eta20]+[e.neg(evaluate(c,x,y)) for c in eta21]+[e.neg(evaluate(c,x,y)) for c in eta2],
        ]
        matrix.extend([grams[j]+erows[j] for j in range(3)]);points.append([x,y])
        if len(points)==args.points:break
    assert len(points)==args.points
    matrix=np.array(matrix,dtype=np.uint64);rank=len(e.rref(matrix)[1]);erank=len(e.rref(matrix[:,len(sym):])[1])
    report={'scope':'fixed slope necessary quadratic probe on exact concentrated d0 source model, not all slopes',
            'root':args.root,'eta':args.eta,'source_original_coordinates':source,'slope_extension_code':slope,
            'numerator_dimension':len(U),'endpoint_rank':len(piv),'numerator_kernel':ker.tolist(),
            'quadratic_coordinates':len(sym),'eta_coordinates':72,'eta_rank':erank,'full_rank':rank,
            'projected_quadratic_rank':rank-erank,'matrix':matrix.tolist(),'points':points}
    (args.work/'data'/f'concentrated_d0_quadratic_root{args.root}_eta{args.eta}.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({key:report[key] for key in ('scope','root','eta','numerator_dimension','quadratic_coordinates','eta_rank','full_rank','projected_quadratic_rank')}))


if __name__=='__main__':main()
