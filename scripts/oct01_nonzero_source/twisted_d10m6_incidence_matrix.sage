#!/usr/bin/env sage
"""Literal bivariate top-eight cubic incidence, using cubic products first."""
from sage.all import *
import argparse,time,sys,numpy as np
from pathlib import Path
from itertools import combinations_with_replacement
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);ap.add_argument('--compact-only',action='store_true');ap.add_argument('--uncleared-auxiliary',action='store_true');args=ap.parse_args();data=args.work/'data';start=time.time();suffix='uncleared' if args.uncleared_auxiliary else 'incidence'
saved=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));K=saved['K'];RR=saved['RR'];eta,lam=RR.gens();R=saved['R'];A=saved['A'];x=R.gen();Gamma=saved['cleared_auxiliary_solution'];compat=saved['top_compatibility'];delta=sum((cc*eta**i for i,cc in enumerate(saved['auxiliary_delta'].list())),RR.zero())
def eta_degree(function):return max((cc.degree(eta) for component in function.lift().list() for cc in component.list()),default=-1)
DD=max(map(eta_degree,saved['D']));UU=max(eta_degree(f) for cs in saved['U_top_eight'] for f in cs);FF=max(map(eta_degree,saved['F']));VV=eta_degree(saved['v']);GG=max(f.degree(eta) for f in Gamma.list());bound=max(delta.degree(eta)+2*UU+10*DD,10*DD+FF+max(VV+delta.degree(eta),DD+GG));
if args.uncleared_auxiliary:bound=max(2*UU+10*DD,10*DD+FF+max(VV,DD))
eta_width=int(bound)+1;lambda_width=int(3);stride=lambda_width*eta_width
N=PolynomialRing(K,'h',implementation='NTL');h=N.gen();zero=[N.zero()]*3;one=[N.one(),N.zero(),N.zero()]
def scalar(f):return N({int(ll)+lambda_width*int(ee):cc for (ee,ll),cc in RR(f).dict().items()})
def encode(function):
    result=zero[:]
    for char,component in enumerate(function.lift().list()):
        terms={}
        for xx,cc in enumerate(component.list()):
            for (ee,ll),coefficient in cc.dict().items():
                assert ee<=bound and ll<=2
                terms[int(ll)+lambda_width*int(ee)+stride*int(xx)]=coefficient
        result[char]=N(terms)
    return result
PP=N({stride*int(i):K(cc) for i,cc in enumerate(saved['P'].list()) if cc})
def add(a,b):return [aa+bb for aa,bb in zip(a,b)]
def neg(a):return [-cc for cc in a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return [cc*c for cc in a]
def mul(a,b):
    q0=a[0]*b[0];q1=a[1]*b[1];q2=a[2]*b[2];q01=(a[0]+a[1])*(b[0]+b[1])-q0-q1;q02=(a[0]+a[2])*(b[0]+b[2])-q0-q2;q12=(a[1]+a[2])*(b[1]+b[2])-q1-q2
    return [q0+PP*q12,q01+PP*q2,q02+q1]
F=list(map(encode,saved['F']));D=list(map(encode,saved['D']));U=[list(map(encode,cs)) for cs in saved['U_top_eight']];v=encode(saved['v']);aux=[[encode(f) for f in ns] for ns in saved['auxiliary_functions']];d,c,b,a=D;delta_ntl=scalar(delta);gam=[[scalar(f) for f in row] for row in Gamma.rows()]
powers=[one]
for i in range(8):powers.append(mul(powers[-1],a))
E=[[one,zero,zero],[zero,one,zero],[zero,zero,one],[neg(d),neg(c),neg(b)]];E.append([sub(neg(mul(b,t)),ad) for t,ad in zip(E[3],[zero,mul(a,d),mul(a,c)])])
for i in range(5,11):E.append([sub(sub(neg(mul(b,E[i-1][j])),mul(mul(a,c),E[i-2][j])),mul(mul(mul(a,a),d),E[i-3][j])) for j in range(3)])
def reduce_scaled(poly,exponent):
    result=[zero[:] for _ in range(3)]
    for i,coefficient in enumerate(poly):
        for j in range(3):result[j]=add(result[j],mul(coefficient,mul(powers[exponent-max(0,i-2)],E[i][j])))
    return result
RF=reduce_scaled(F,8);RU=[reduce_scaled(poly,3) for poly in U]
print('CUBIC_REDUCTIONS_READY','SECONDS',time.time()-start,flush=True)
def product2(left,right):
    q0=mul(left[0],right[0]);q1=mul(left[1],right[1]);q2=mul(left[2],right[2]);q01=sub(sub(mul(add(left[0],left[1]),add(right[0],right[1])),q0),q1);q02=sub(sub(mul(add(left[0],left[2]),add(right[0],right[2])),q0),q2);q12=sub(sub(mul(add(left[1],left[2]),add(right[1],right[2])),q1),q2);raw=[q0,q01,add(q02,q1),q12,q2]
    return reduce_scaled(raw,2)
pairs=list(combinations_with_replacement(range(8),2));columns=[]
for column,(i,j) in enumerate(pairs):
    factor=1 if i==j else 2;ur=product2(RU[i],RU[j]);out=[scale(mul(powers[2],t),factor*(N.one() if args.uncleared_auxiliary else delta_ntl)) for t in ur]
    if j<3:
        if args.uncleared_auxiliary:Q=[scale(v,factor*h**(stride*(i+j))),zero,zero]
        else:
            n=[scale([sum((gam[k][i+j]*functions[h][char] for k,functions in enumerate(aux)),N.zero()) for char in range(3)],-factor) for h in range(3)];n0,n1,n2=n;Q=[sub(sub(sub(scale(v,factor*delta_ntl*h**(stride*(i+j))),mul(a,n2)),mul(b,n1)),mul(c,n0)),neg(add(mul(a,n1),mul(b,n0))),neg(mul(a,n0))]
        fq=product2(RF,Q);out=[sub(tt,ff) for tt,ff in zip(out,fq)]
    columns.append(out)
    if (column+1)%6==0:print('COLUMNS',column+1,'SECONDS',time.time()-start,flush=True)
if args.uncleared_auxiliary:
    for n0,n1,n2 in aux:
        Q=[neg(add(add(mul(a,n2),mul(b,n1)),mul(c,n0))),neg(add(mul(a,n1),mul(b,n0))),neg(mul(a,n0))];columns.append([neg(t) for t in product2(RF,Q)])
    print('UNCLEARED_AUXILIARY_COLUMNS_READY',len(columns),'SECONDS',time.time()-start,flush=True)
if args.compact_only:
    tags=[('critical',degree,char,xx) for degree in range(3) for char in range(3) for xx in range(1+max(int(column[degree][char].degree())//stride for column in columns))];positions={tag:i for i,tag in enumerate(tags)};critical_count=len(tags)
    for ll in range(2):
        for zz in range(8):tags.append(('compatibility',ll,zz))
    if args.uncleared_auxiliary:
        for ll in range(15):tags.append(('auxiliary_endpoint',ll))
    encoded=np.zeros((len(tags),len(columns),3*eta_width),dtype=np.uint32);codes={K.from_integer(i):i for i in range(int(K.order()))};maxeta=-1;maxlam=-1
    for col,column in enumerate(columns):
        for degree,element in enumerate(column):
            for char,component in enumerate(element):
                for exponent,coefficient in component.dict().items():
                    exponent=int(exponent);lp=exponent%lambda_width;ep=(exponent//lambda_width)%eta_width;xx=exponent//stride;encoded[positions[('critical',degree,char,xx)],col,3*ep+lp]=codes[coefficient];maxeta=max(maxeta,ep);maxlam=max(maxlam,lp)
    for ll in range(2):
        for zz in range(8):
            row=critical_count+8*ll+zz
            for col,(i,j) in enumerate(pairs):
                f=compat[ll,zz] if i==j==zz else compat[ll,j] if i==zz else compat[ll,i] if j==zz else RR.zero()
                for (ep,lp),coefficient in f.dict().items():encoded[row,col,3*int(ep)+int(lp)]=codes[coefficient]
    if args.uncleared_auxiliary:
        MM=saved['auxiliary_matrix'];forcing=saved['auxiliary_forcing']
        for ll in range(15):
            row=critical_count+16+ll
            for col,(i,j) in enumerate(pairs):
                f=(1 if i==j else 2)*forcing[ll][i+j] if j<3 else RR.zero()
                for (ep,lp),coefficient in RR(f).dict().items():encoded[row,col,3*int(ep)+int(lp)]=codes[coefficient]
            for col in range(15):
                for ep,coefficient in enumerate(MM[ll,col].list()):encoded[row,36+col,3*ep]=codes[coefficient]
    encoded=encoded[:,:,:3*(int(maxeta)+1)];values=np.zeros((len(tags),len(columns)),dtype=np.uint64);prime=int(5)
    for exponent in range(8):values+=(((encoded//np.uint32(prime**exponent))%np.uint32(prime)).sum(axis=int(2),dtype=np.uint64)%np.uint64(prime))*np.uint64(prime**exponent)
    evaluated=matrix(K,len(tags),len(columns),[K.from_integer(int(c)) for row in values for c in row]);rank=evaluated.rank()
    np.savez_compressed(str(data/f'twisted_d10m6_{suffix}_compact_{args.root}.npz'),coefficients=encoded)
    save({'scope':'literal bivariate necessary top-eight cubic incidence; independentaux columns retain auxiliarydelta0' if args.uncleared_auxiliary else 'literal bivariate necessary top-eight cubic incidence; auxiliarydelta0 retained separately','root':int(args.root),'K':K,'beta':saved['beta'],'alpha':saved['alpha'],'RR':RR,'row_tags':tags,'pairs':pairs,'fixed_pivot_rows':list(evaluated.transpose().pivots()),'auxiliary_delta':saved['auxiliary_delta'],'source_H':saved['H'],'top_compatibility':compat,'pseudo_scale':int(10),'kronecker_eta_bound':int(bound),'kronecker_eta_width':eta_width,'kronecker_lambda_width':lambda_width,'setup_path':str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj')},str(data/f'twisted_d10m6_{suffix}_compact_metadata_{args.root}.sobj'))
    print('COMPACT_MATRIX_READY',len(tags),len(columns),'ETADEG',maxeta,'LAMDEG',maxlam,'FIXEDRANK',rank,'SECONDS',time.time()-start,flush=True);sys.exit(int(0))
components=[]
for column in columns:
    functions=[[{} for _ in range(3)] for _ in range(3)]
    for degree,element in enumerate(column):
        for char,component in enumerate(element):
            groups={}
            for exponent,coefficient in component.dict().items():
                ll=int(exponent)%lambda_width;ee=(int(exponent)//lambda_width)%eta_width;xx=int(exponent)//stride;groups.setdefault(xx,{})[(ee,ll)]=coefficient
            functions[degree][char]={xx:RR(terms) for xx,terms in groups.items()}
    components.append(functions)
tags=[('critical',degree,char,xx) for degree in range(3) for char in range(3) for xx in range(1+max(max(f[degree][char],default=-1) for f in components))]
M=matrix(RR,len(tags)+16,36)
for row,(_,degree,char,xx) in enumerate(tags):
    for column,functions in enumerate(components):M[row,column]=functions[degree][char].get(xx,RR.zero())
critical_count=len(tags)
for ll in range(2):
    for zz in range(8):
        row=critical_count+8*ll+zz;tags.append(('compatibility',ll,zz))
        for column,(i,j) in enumerate(pairs):
            if i==j==zz:M[row,column]=compat[ll,zz]
            elif i==zz:M[row,column]=compat[ll,j]
            elif j==zz:M[row,column]=compat[ll,i]
assert len(tags)==M.nrows()
maxeta=max(f.degree(eta) for f in M.list());maxlam=max(f.degree(lam) for f in M.list());evaluated=matrix(K,[[f(K.one(),K.one()) for f in row] for row in M.rows()]);rank=evaluated.rank();assert rank==36
print('MATRIX_READY',M.nrows(),M.ncols(),'ETADEG',maxeta,'LAMDEG',maxlam,'FIXEDRANK',rank,'SECONDS',time.time()-start,flush=True)
save({'scope':'literal bivariate necessary top-eight cubic incidence; auxiliarydelta0 must be treated separately; no universalrankclaim','root':int(args.root),'K':K,'beta':saved['beta'],'alpha':saved['alpha'],'RR':RR,'matrix':M,'row_tags':tags,'pairs':pairs,'fixed_pivot_rows':list(evaluated.transpose().pivots()),'auxiliary_delta':saved['auxiliary_delta'],'source_H':saved['H'],'top_compatibility':compat,'pseudo_scale':int(10),'kronecker_eta_bound':int(bound),'kronecker_eta_width':eta_width,'kronecker_lambda_width':lambda_width,'setup_path':str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj')},str(data/f'twisted_d10m6_incidence_matrix_{args.root}.sobj'))
