#!/usr/bin/env python3
"""Small fixed-source endpoint tests for the new quotient jets, not a sweep."""
import argparse,json,sys
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES,Q_CODES
from cubic_extension import CubicExtension
from endpoint_jets import SOURCE_CHARACTERS
from infinity import InfinitySystem

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--lambda-start',type=int,default=1);args=ap.parse_args();data=args.work/'data'
    base=Field(args.work/'cache');bp=Poly(base);e=CubicExtension(base);p=Poly(e);C=Curve(e)
    inputs=json.loads((data/'critical_quadratic_fixed_input.json').read_text());aux=inputs['auxiliary_functions']
    points=json.loads((data/'shifted_concentrated_projection.json').read_text())['records']
    omega=int(base.exp[390624//3]);assert omega!=1 and base.power(omega,3)==1
    endpoints=[(r['root_K_code'],e.mul(r['y0_extension_code'],base.power(omega,j))) for r in points for j in range(3)]
    Z=bp.sub(B0_CODES,L0_CODES);family=json.loads((data/'adapted_family.json').read_text());t=family['t']
    def evaluate(function,x,y):return e.add(e.add(p.eval(function[0],x),e.mul(y,p.eval(function[1],x))),e.mul(e.power(y,2),p.eval(function[2],x)))
    records=[]
    def ordinary(D,v):
        matrix=[];forcing=[]
        for x,y in endpoints:
            dd=[evaluate(c,x,y) for c in D];cbase=e.div(bp.eval(Z,x),y);row=[]
            for ns in aux:
                n0,n1,n2=[evaluate(c,x,y) for c in ns]
                value=e.add(e.add(e.mul(dd[3],n2),e.mul(e.add(dd[2],e.mul(dd[3],cbase)),n1)),e.mul(e.add(e.add(dd[1],e.mul(dd[2],cbase)),e.mul(dd[3],e.power(cbase,2))),n0));row.append(e.neg(value))
            matrix.append(row);forcing.append([e.mul(evaluate(v,x,y),base.power(x,j)) for j in range(5)])
        return matrix,forcing
    for old in inputs['records']:
        mat,forcing=ordinary(old['D'],old['v']);rank=len(e.rref(np.array(mat,dtype=np.uint64))[1])
        records.append({'name':old['name'],'scope':'nine ordinary endpoint quotient constraints at a retained fixed tuple','auxiliary_rank':rank,'matrix':mat,'forcing_m4_square_monomials':forcing})
    source_records=json.loads((data/'concentrated_source_ranks.json').read_text())['records'];system=InfinitySystem(base,family)
    root=points[0]['root_K_code'];y0=points[0]['y0_extension_code'];cut=4
    def shift(poly):
        out=[]
        for scalar in reversed(poly):out=p.add(p.mul(out,[root,1]),[scalar])[:cut]
        return out
    rhs=p.scale(shift(C.P),e.inv(bp.eval(C.P,root)));h=[1]
    for n in range(1,cut):
        hh=p.power(h,3);h.append(e.div(e.sub(rhs[n] if n<len(rhs) else 0,hh[n] if n<len(hh) else 0),3))
    yy=p.scale(h,y0);yi=[e.inv(y0)]
    for n in range(1,cut):
        hh=p.mul(yy,yi);yi.append(e.neg(e.div(hh[n] if n<len(hh) else 0,y0)))
    shifted_center=p.add(p.mul(shift(Z),yi),[0,e.div(bp.eval(bp.derivative(t),root),y0)])[:cut]
    def series(function):
        out=[]
        for char in range(3):out=p.add(out,p.mul(shift(function[char]),p.power(yy,char)))
        return out[:cut]
    for d,m in ((3,12),(10,6)):
        model=next(r for r in source_records if (r['root_K_code'],r['d'],r['m'])==(root,d,m))
        rows=np.array([[bp.eval(f,1) for f in row] for row in model['polynomial_matrix']],dtype=np.uint32)
        ker,_,_=base.kernel(rows);i=next(i for i,row in enumerate(ker) if row[0]);origin=base.mulv(ker[i],base.inv(int(ker[i,0])))
        for lam in range(args.lambda_start,args.lambda_start+24):
            zz=origin.copy()
            for j,row in enumerate(ker):
                if j!=i:
                    direction=base.addv(row,base.mulv(origin,base.neg(int(row[0]))))
                    zz=base.addv(zz,base.mulv(direction,lam+j))
            assert zz[0]==1
            assert not np.any(base.matmul(rows,zz[:,None]))
            source=[e.mul(int(c),e.power(y0,1-SOURCE_CHARACTERS[j])) for j,c in enumerate(zz)]
            v=C.zero()
            for scalar,(b,char) in zip(source[13:],monomials(10)):v=C.add(v,C.monomial(b,char,scalar))
            N=[C.zero() for _ in range(6)]
            for scalar,column in zip(source[:13],system.N):
                for j in range(6):N[j]=C.add(N[j],C.scale(column[j],scalar))
            N[0]=v;N[5]=C.add(N[5],C.mul(v,C.polyx(Q_CODES)));S,q=C.frame(N);D=[C.scale(S[j],j) for j in range(1,5)]
            if C.pole(v)==d and C.pole(S[4])==m and evaluate(D[3],root,y0):break
        else:raise AssertionError('No selected fixed tuple on required unit chart')
        ordinary_rows,ordinary_forcing=ordinary(D,v);matrix=[];forcing=[];tags=[]
        for ix,point in enumerate(endpoints):
            if point!=(root,y0):matrix.append(ordinary_rows[ix]);forcing.append(ordinary_forcing[ix]);tags.append(['ordinary',*point])
        ds=list(map(series,D));a,b,c=ds[3],ds[2],ds[1];center=shifted_center
        jet_columns=[]
        for ns in aux:
            n0,n1,n2=list(map(series,ns))
            q0=p.neg(p.add(p.add(p.mul(a,n2),p.mul(p.add(b,p.mul(a,center)),n1)),p.mul(p.add(p.add(c,p.mul(b,center)),p.mul(a,p.power(center,2))),n0)))
            q1=p.neg(p.add(p.mul(a,n1),p.mul(p.add(b,p.scale(p.mul(a,center),2)),n0)))
            q2=p.neg(p.mul(a,n0))
            jet_columns.append([q0[n] if n<len(q0) else 0 for n in range(4)]+[q1[n] if n<len(q1) else 0 for n in range(2)]+[q2[0] if q2 else 0])
        for ix in range(7):
            matrix.append([column[ix] for column in jet_columns]);forcing.append([])
            for j in range(5):
                vv=p.mul(series(v),p.power([root,1],j));forcing[-1].append(vv[ix] if ix<4 and ix<len(vv) else 0)
            tags.append(['concentrated',0 if ix<4 else 1 if ix<6 else 2,ix if ix<4 else ix-4 if ix<6 else 0])
        mat=np.array(matrix,dtype=np.uint64);rank=len(e.rref(mat)[1]);aug=len(e.rref(np.concatenate((mat,np.array(forcing,dtype=np.uint64)),axis=1))[1])
        records.append({'name':f'concentrated_d{d}_m{m}_root{root}_eta1','scope':'fixed concentrated coefficient tuple only, not uniform slopes/sources','lambda':lam,'homogeneous_source_kernel':ker.tolist(),'source_normalized':zz.tolist(),'source_original':source,'D_finite':D,'critical_cubic_leading_at_endpoint':evaluate(D[3],root,y0),'auxiliary_rank':rank,'augmented_rank':aug,'matrix':matrix,'forcing_m4_square_monomials':forcing,'row_tags':tags})
    suffix='' if args.lambda_start==1 else f'_lambda{args.lambda_start}'
    (data/f'critical_quadratic_endpoint_probe{suffix}.json').write_text(json.dumps({'scope':'four fixed tuple probes only','records':records},separators=(',',':'))+'\n')
    print([(r['name'],r['auxiliary_rank'],r.get('augmented_rank')) for r in records])
if __name__=='__main__':main()
