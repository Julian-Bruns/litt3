#!/usr/bin/env python3
"""Exact first-slope polynomial model for the stronger concentrated jets."""
import argparse,json,sys
from math import comb
from pathlib import Path
import numpy as np

ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,B0_CODES,L0_CODES
from cubic_extension import CubicExtension
from endpoint_jets import ENDPOINT_ROOTS


def determinant(p,matrix):
    a=[[list(f) for f in row] for row in matrix]
    n=len(a);previous=[1];sign=1
    for j in range(n-1):
        rows=[i for i in range(j,n) if a[i][j]]
        if not rows:return []
        i=rows[0]
        if i!=j:a[j],a[i]=a[i],a[j];sign=p.k.neg(sign)
        pivot=a[j][j]
        for i in range(j+1,n):
            for hh in range(j+1,n):
                numerator=p.sub(p.mul(a[i][hh],pivot),p.mul(a[i][j],a[j][hh]))
                a[i][hh]=p.exactdiv(numerator,previous)
            a[i][j]=[]
        previous=pivot
    return p.scale(a[-1][-1],sign)


def extended_gcd(p,a,b):
    r0,r1=list(a),list(b);s0,s1=[1],[];t0,t1=[],[1]
    while r1:
        q,r=p.divmod(r0,r1)
        r0,r1=r1,r;s0,s1=s1,p.sub(s0,p.mul(q,s1));t0,t1=t1,p.sub(t0,p.mul(q,t1))
    factor=p.k.inv(r0[-1])
    return p.scale(r0,factor),p.scale(s0,factor),p.scale(t0,factor)


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--work',type=Path,required=True)
    ap.add_argument('--sheet',type=int,choices=(0,1,2),default=0)
    args=ap.parse_args()
    k=Field(args.work/'cache');p=Poly(k);C=Curve(k);e=CubicExtension(k);ep=Poly(e)
    data=json.loads((args.work/'data/lower_numerator_product_space.json').read_text())
    U=data['numerator_coefficients'];z=p.sub(B0_CODES,L0_CODES)
    results=[]
    for root in ENDPOINT_ROOTS:
        cut=7
        def shift(poly):
            out=[]
            for scalar in reversed(poly):
                out=p.add(p.mul(out,[root,1]),[scalar])[:cut]
            return out
        value=p.eval(C.P,root);ratio=k.div(value,6)
        assert int(k.log[ratio])%3==0
        cube=int(k.exp[int(k.log[ratio])//3])
        zeta=k.power(25,130208)
        y0=e.mul(e.Q,k.mul(cube,k.power(zeta,args.sheet)))
        rhs=p.scale(shift(C.P),k.inv(value));h=[1]
        for n in range(1,cut):
            hh=p.power(h,3)
            h.append(k.div(k.sub(rhs[n] if n<len(rhs) else 0,hh[n] if n<len(hh) else 0),3))
        y=ep.scale(h,y0)
        yi=[e.inv(y0)]
        for n in range(1,cut):
            coefficient=ep.mul(y,yi)
            yi.append(e.neg(e.div(coefficient[n] if n<len(coefficient) else 0,y0)))
        assert ep.mul(y,yi)[:cut]==[1]+[0]*(cut-1)
        aa=ep.mul(shift(z),yi)[:cut]
        def evaluate(function):
            out=[]
            for char in range(3):
                out=ep.add(out,ep.mul(shift(function[char]),ep.power(y,char)))
            return out[:cut]
        A=[]
        for cs in U:
            vals=[evaluate(c) for c in cs];short=[]
            for j in range(4):
                out=[]
                for hh in range(j,4):
                    out=ep.add(out,ep.scale(ep.mul(vals[hh],ep.power(aa,hh-j)),comb(hh,j)%5))
                short.append(out[:cut])
            A.append(short)
        tags=[(j,n) for j in range(4) for n in range(3-j,7-2*j)]
        assert len(tags)==10
        matrix=[]
        for j,n in tags:
            row=[]
            for short in A:
                entry=[]
                for hh in range(j,4):
                    degree=hh-j;ix=n-degree
                    coefficient=short[hh][ix] if 0<=ix<len(short[hh]) else 0
                    entry=ep.add(entry,ep.shift([e.mul(comb(hh,j)%5,coefficient)] if coefficient else [],degree))
                row.append(entry)
            matrix.append(row)
        probes=[]
        for c in (0,1,2):
            numeric=np.array([[ep.eval(f,c) for f in row] for row in matrix],dtype=np.uint64)
            _,piv=e.rref(numeric)
            probes.append({'slope':c,'rank':len(piv)})
        minors=[determinant(ep,matrix[:omit]+matrix[omit+1:]) for omit in range(10)]
        gcd=[];multipliers=[[] for _ in range(10)]
        for ix,minor in enumerate(minors):
            if not minor:continue
            if not gcd:
                factor=e.inv(minor[-1]);gcd=ep.scale(minor,factor);multipliers[ix]=[factor]
            else:
                gcd,left,right=extended_gcd(ep,gcd,minor)
                multipliers=[ep.mul(left,f) for f in multipliers]
                multipliers[ix]=ep.add(multipliers[ix],right)
            if gcd==[1]:break
        identity=[]
        for coefficient,minor in zip(multipliers,minors):identity=ep.add(identity,ep.mul(coefficient,minor))
        assert identity==gcd
        results.append({'root_K_code':root,'y0_extension_code':y0,'row_tags':tags,
                        'polynomial_matrix':matrix,'bounded_rank_probes':probes,
                        'maximal_minors_by_omitted_row':minors,'maximal_minor_gcd':gcd,
                        'gcd_identity_multipliers':multipliers})
    report={'scope':'exact 10x9 first-slope polynomial incidence on fixed lower V0, with verified maximal-minor gcd identities',
            'sheet':args.sheet,
            'variable':'c','shift':'W=T+c*r','shifted_orders':[7,5,3,1],'records':results}
    filename='shifted_concentrated_projection'+(f'_sheet{args.sheet}' if args.sheet else '')+'.json'
    (args.work/'data'/filename).write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps([{key:item[key] for key in ('root_K_code','bounded_rank_probes','maximal_minor_gcd')} for item in results]))


if __name__=='__main__':
    main()
