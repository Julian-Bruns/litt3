#!/usr/bin/env python3
"""Bounded fixed-source quadratic-trace probe; no global emptiness claim.

Inputs are reconstructed from the full audited coefficient family. Each sampled
base point gives necessary equations, and no interpolation extrapolation is made.
"""
import argparse
import json
import sys
from itertools import combinations_with_replacement
from math import comb
from pathlib import Path
import numpy as np

ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES,Q_CODES,inverse_mod
from infinity import InfinitySystem


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--work',type=Path,required=True)
    ap.add_argument('--points',type=int,default=100)
    ap.add_argument('--d',type=int,default=10)
    ap.add_argument('--m',type=int,default=3)
    ap.add_argument('--seed',type=int,default=1)
    args=ap.parse_args()
    k=Field(args.work/'cache');p=Poly(k);C=Curve(k)
    fam=json.loads((args.work/'data/adapted_family.json').read_text())
    t=fam['t'];z=p.sub(B0_CODES,L0_CODES)
    system=InfinitySystem(k,fam)
    part=[] if args.d==10 else [10-args.d]
    rec=system.record(args.d,part,args.m)
    assert rec['status']=='nonempty_linear_incidence_only'
    source=np.array(rec['origin'],dtype=np.uint32)
    for i,direction in enumerate(rec['directions']):
        source=k.addv(source,k.mulv(np.array(direction,dtype=np.uint32),args.seed+i+1))
    assert source[0]==1
    assert all(np.any(k.matmul(source[None,:],np.array([row],dtype=np.uint32).T)) for row in rec['nonzero_forms'])
    N=[C.zero() for _ in range(6)]
    for scalar,row in zip(source,system.N):
        for i in range(6):N[i]=C.add(N[i],C.scale(row[i],int(scalar)))
    vb=monomials(10);v=C.zero()
    vp=[args.seed+i for i in range(5)]
    if args.d!=10:
        vp=[args.seed+i if 3*b+10*r<=args.d else 0 for i,(b,r) in enumerate(vb)]
    for scalar,(b,r) in zip(vp,vb):v=C.add(v,C.monomial(b,r,scalar))
    assert C.pole(v)==args.d
    N[0]=v;N[5]=C.add(N[5],C.mul(v,C.polyx(Q_CODES)))
    S,q=C.frame(N)
    assert C.pole(S[4])==args.m
    tau=C.power(C.polyx(t),3)
    F=[C.add(C.add(C.mul(v,C.power(q,2)),C.mul(q,S[0])),tau)]
    F.extend([C.mul(q,S[i]) for i in range(1,5)])
    F.append(C.add(S[0],C.scale(C.mul(v,q),2)))
    F.extend(S[1:]);F.append(v)
    assert len(F)==11
    D=[C.scale(S[i],i) for i in range(1,5)]

    def pi(c,n):
        raw=C.mul(C.polyx(p.power(z,n)),c);out=C.zero()
        for r,comp in enumerate(raw):
            quotient,target=divmod(r-n,3)
            out[target]=p.mul(comp,p.power(C.P,quotient)) if quotient>=0 else p.divmod(comp,p.power(C.P,-quotient))[0]
        return out
    def num(a5,a4,rs):
        c3=C.add(pi(a4,1),rs[3])
        c2=C.add(C.neg(C.add(C.scale(pi(c3,1),3),pi(a4,2))),rs[2])
        c1=C.add(C.neg(C.add(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3)),C.scale(pi(a4,3),4))),rs[1])
        c0=C.add(C.neg(C.add(C.add(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3)),pi(a4,4)),pi(a5,5))),rs[0])
        return [c0,c1,c2,c3,a4,a5]
    def jetrows(cs):
        out=[]
        for j in range(3):
            clear=C.zero()
            for h in range(j,6):
                scale=comb(h,j)%5
                if scale:
                    term=C.mul(C.polyx(p.power(z,h-j)),cs[h])
                    term=C.mul(term,C.power(C.monomial(0,1),5-h))
                    clear=C.add(clear,C.scale(term,scale))
            modulus=p.power(t,3-j)
            for comp in clear:
                r=p.mod(comp,modulus);out.extend(r+[0]*(len(modulus)-1-len(r)))
        assert len(out)==54
        return out
    columns=[];labels=[]
    for b in range(3):
        m=C.monomial(b,0);columns.append(num(C.mul(v,m),C.mul(S[4],m),[C.zero() for _ in range(4)]));labels.append(['m4',b,0])
    for b,r in vb:
        columns.append(num(C.zero(),C.mul(v,C.monomial(b,r)),[C.zero() for _ in range(4)]));labels.append(['m5',b,r])
    for j in range(4):
        for b,r in monomials(25-j):
            rs=[C.zero() for _ in range(4)];rs[j]=C.monomial(b,r)
            columns.append(num(C.zero(),C.zero(),rs));labels.append(['r',j,b,r])
    J=np.array([jetrows(cs) for cs in columns],dtype=np.uint32).T
    kernel,piv,_=k.kernel(J)
    assert not np.any(k.matmul(J,kernel.T))
    U=[]
    for vector in kernel:
        cs=[C.zero() for _ in range(6)]
        for scalar,col in zip(vector,columns):
            if scalar:
                for j in range(6):cs[j]=C.add(cs[j],C.scale(col[j],int(scalar)))
        U.append(cs)
    sym=list(combinations_with_replacement(range(len(U)),2))
    eta0=[C.monomial(b,r) for b,r in monomials(20)]
    eta1=[C.monomial(b,r) for b,r in monomials(32)]
    eta2=[C.monomial(b,r) for b,r in monomials(44)]
    v2=C.power(v,2)
    eta10=[pi(C.mul(v,c),1) for c in eta0]
    eta20=[C.sub(C.scale(pi(C.mul(v,pi(C.mul(v,c),1)),1),2),pi(C.mul(v2,c),2)) for c in eta0]
    eta21=[C.scale(pi(C.mul(v,c),1),2) for c in eta1]
    assert len(eta0)+len(eta1)+len(eta2)==72
    def evaluate(c,x,y):
        return k.add(k.add(p.eval(c[0],x),k.mul(y,p.eval(c[1],x))),k.mul(k.power(y,2),p.eval(c[2],x)))
    matrix=[];points=[];skips=[]
    for x in range(1,200000):
        value=p.eval(C.P,x)
        if not value or int(k.log[value])%3:continue
        y=int(k.exp[int(k.log[value])//3])
        vf=evaluate(v,x,y);tf=p.eval(t,x)
        if not vf or not tf:continue
        ff=[evaluate(c,x,y) for c in F];dd=[evaluate(c,x,y) for c in D]
        fm=p.scale(ff,k.inv(vf));phi=[evaluate(q,x,y),0,0,0,0,1]
        fw=p.mul(phi,dd)
        if p.gcd(ff,fw)!=[1]:
            skips.append([x,'inseparable fibre']);continue
        di=inverse_mod(p,dd,fm);g=p.mod(p.power(di,2),fm)
        traces=[]
        for n in range(13):
            h=p.mod(p.mul(g,fw),fm)
            traces.append(k.div(h[9] if len(h)>9 else 0,vf))
            g=p.mod([0]+g,fm)
        uu=np.array([[evaluate(c,x,y) for c in cs] for cs in U],dtype=np.uint32)
        gramrows=[]
        for j in range(3):
            hank=np.array([[traces[a+b+j] for b in range(6)] for a in range(6)],dtype=np.uint32)
            gram=k.matmul(k.matmul(uu,hank),uu.T)
            coeff=[k.mul(int(gram[a,b]),1 if a==b else 2) for a,b in sym]
            gramrows.append(k.mulv(np.array(coeff,dtype=np.uint32),k.power(vf,j)).tolist())
        erows=[
            [k.neg(evaluate(c,x,y)) for c in eta0]+[0]*(len(eta1)+len(eta2)),
            [k.neg(evaluate(c,x,y)) for c in eta10]+[k.neg(evaluate(c,x,y)) for c in eta1]+[0]*len(eta2),
            [k.neg(evaluate(c,x,y)) for c in eta20]+[k.neg(evaluate(c,x,y)) for c in eta21]+[k.neg(evaluate(c,x,y)) for c in eta2],
        ]
        matrix.extend([gramrows[j]+erows[j] for j in range(3)])
        points.append([x,y])
        if len(points)==args.points:break
    assert len(points)==args.points
    matrix=np.array(matrix,dtype=np.uint32)
    erank=len(k.rref(matrix[:,len(sym):])[1])
    fullrank=len(k.rref(matrix)[1])
    cok,_,_=k.kernel(matrix[:,len(sym):].T)
    projected=k.matmul(cok,matrix[:,:len(sym)])
    qrank=len(k.rref(projected)[1])
    assert fullrank==erank+qrank
    linear_kernel,_,_=k.kernel(matrix)
    relations=[]
    for vector in linear_kernel:
        zz=np.zeros((len(U),len(U)),dtype=np.uint32)
        for scalar,(i,j) in zip(vector,sym):
            zz[i,j]=int(scalar);zz[j,i]=int(scalar)
        if not np.any(zz):continue
        raw=[C.zero() for _ in range(11)]
        for scalar,(i,j) in zip(vector,sym):
            if not scalar:continue
            scale=k.mul(int(scalar),1 if i==j else 2)
            for aa in range(6):
                for bb in range(6):
                    raw[aa+bb]=C.add(raw[aa+bb],C.scale(C.mul(U[i][aa],U[j][bb]),scale))
        pulled=k.matmul(k.matmul(kernel.T,zz),kernel)
        relations.append({
            'symmetric_rank':len(k.rref(zz)[1]),
            'raw_product_identity':all(C.pole(c)<0 for c in raw),
            'top_eight_coordinate_support':bool(np.any(pulled[:8,:])),
            'quadratic_vector':vector[:len(sym)].tolist(),
            'symmetric_matrix':zz.tolist(),
            'pulled_matrix':pulled.tolist(),
        })
    report={
        'scope':'bounded fixed-source necessary quadratic-trace test, no global coefficient exclusion',
        'd':args.d,'m':args.m,'seed':args.seed,'source_S_coordinates':source.tolist(),
        'v_coefficients':vp,'numerator_dimension':len(U),'numerator_endpoint_rank':len(piv),
        'sampled_base_points':len(points),'quadratic_coordinates':len(sym),'eta_coordinates':72,
        'eta_rank':erank,'full_rank':fullrank,'projected_quadratic_rank':qrank,
        'projected_quadratic_kernel_dimension':len(sym)-qrank,'matrix':matrix.tolist(),
        'points':points,'skipped_separable_fibres':skips,'numerator_kernel':kernel.tolist(),
        'numerator_labels':labels,'quadratic_coordinate_pairs':sym,
        'quadratic_kernel_relations':relations,
    }
    out=args.work/'data'/f'quadratic_torsion_d{args.d}_m{args.m}_seed{args.seed}.json'
    out.write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({key:report[key] for key in ('scope','d','m','seed','numerator_dimension','sampled_base_points','quadratic_coordinates','eta_rank','full_rank','projected_quadratic_rank','projected_quadratic_kernel_dimension')},indent=2))
    print(json.dumps({'quadratic_kernel_relations':[{key:r[key] for key in ('symmetric_rank','raw_product_identity','top_eight_coordinate_support')} for r in relations]}))

if __name__=='__main__':main()
