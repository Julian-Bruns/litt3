#!/usr/bin/env python3
"""Exact K-only source and numerator setup after Y=y/y0,T=y0*w."""
import argparse,json,sys
from pathlib import Path
from math import comb
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES,P_CODES,Q_CODES
from infinity import InfinitySystem
from shifted_concentrated_projection import determinant
from concentrated_d0_polynomial_numerator import left_inverse,matmul
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';k=Field(args.work/'cache');p=Poly(k)
    chosen=next(r for r in json.loads((data/'shifted_concentrated_projection.json').read_text())['records'] if r['root_K_code']==args.root);y0code=chosen['y0_extension_code'];assert y0code%390625==0 and y0code<390625**2;b0=y0code//390625
    scalar=p.eval(P_CODES,args.root);assert scalar==k.mul(6,k.power(b0,3));C=Curve(k);C.P=p.scale(P_CODES,k.inv(scalar));Z=p.sub(B0_CODES,L0_CODES)
    family=json.loads((data/'adapted_family.json').read_text());t=family['t'];system=InfinitySystem(k,family);original=Curve(k);characters=[1,1,1,1,1,2,0,0,2,2,2,2,2];Sbasis=[]
    for ix,column in enumerate(system.N):
        nn=[f[:] for f in column];nn[0]=original.zero();ss,q=original.frame(nn);out=[]
        for j,function in enumerate(ss):
            components=[]
            for char,poly in enumerate(function):
                exponent=char-j-4-characters[ix]
                assert not poly or exponent%3==0
                components.append(p.scale(poly,k.power(scalar,exponent//3)) if poly else [])
            out.append(components)
        Sbasis.append(out)
    q0=C.monomial(0,1);q0=C.mul(q0,C.polyx(p.exactdiv(p.sub(Q_CODES,p.power(B0_CODES,5)),p.power(C.P,2))))
    def pi(function,n):
        raw=C.mul(C.polyx(p.power(Z,n)),function);out=C.zero()
        for char,component in enumerate(raw):
            power,target=divmod(char-n,3);out[target]=p.mul(component,p.power(C.P,power)) if power>=0 else p.divmod(component,p.power(C.P,-power))[0]
        return out
    def numerator(a5,a4,rs):
        c3=C.add(pi(a4,1),rs[3]);c2=C.add(C.neg(C.add(C.scale(pi(c3,1),3),pi(a4,2))),rs[2]);c1=C.add(C.neg(C.add(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3)),pi(a4,3))),rs[1]);c0=C.add(C.neg(C.add(C.add(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3)),pi(a4,4)),pi(a5,5))),rs[0]);return [c0,c1,c2,c3,a4,a5]
    def rows(cs):
        out=[]
        for j in range(3):
            clear=C.zero()
            for hh in range(j,6):
                term=C.mul(C.polyx(p.power(Z,hh-j)),cs[hh]);term=C.mul(term,C.power(C.monomial(0,1),5-hh));clear=C.add(clear,C.scale(term,comb(hh,j)%5))
            modulus=p.power(t,3-j)
            for component in clear:
                rem=p.mod(component,modulus);out.extend(rem+[0]*(len(modulus)-1-len(rem)))
        return out
    labels=[];rawlower=[]
    for j in range(4):
        for b,char in monomials(25-j):
            rs=[C.zero() for _ in range(4)];rs[j]=C.monomial(b,char);rawlower.append(numerator(C.zero(),C.zero(),rs));labels.append([j,b,char])
    J=np.array([rows(cs) for cs in rawlower],dtype=np.uint32).T;ker,piv,_=k.kernel(J);assert len(ker)==9 and len(piv)==53
    rowpiv=k.rref(J.T)[1];square=J[np.ix_(rowpiv,piv)];rr,pp=k.rref(np.hstack((square,np.eye(53,dtype=np.uint32))));inverse=rr[:,53:];assert np.array_equal(k.matmul(square,inverse),np.eye(53,dtype=np.uint32))
    cok,_,_=k.kernel(J.T);assert len(cok)==1
    def combine(weights,cols):
        out=[C.zero() for _ in range(6)]
        for coefficient,column in zip(weights,cols):
            if coefficient:
                for j in range(6):out[j]=C.add(out[j],C.scale(column[j],int(coefficient)))
        return out
    lower=[combine(row,rawlower) for row in ker];particular=[];toplabels=[];old=[]
    for degree,bound in ((5,16),(4,20)):
        for b,char in monomials(bound):
            aa=C.monomial(b,char);raw=numerator(aa if degree==5 else C.zero(),aa if degree==4 else C.zero(),[C.zero() for _ in range(4)]);rhs=np.array(rows(raw),dtype=np.uint32);sol=k.mulv(k.matmul(inverse,rhs[rowpiv,None])[:,0],4);weights=np.zeros(62,dtype=np.uint32);weights[piv]=sol
            particular.append([C.add(f,g) for f,g in zip(raw,combine(weights,rawlower))]);toplabels.append([degree,b,char]);old.append(int(k.matmul(cok,rhs[:,None])[0,0]))
    cut=7
    def shift(poly):
        out=[]
        for coefficient in reversed(poly):out=p.add(p.mul(out,[args.root,1]),[coefficient])[:cut]
        return out
    rhs=shift(C.P);assert rhs[0]==1;yy=[1]
    for n in range(1,cut):
        power=p.power(yy,3);yy.append(k.div(k.sub(rhs[n] if n<len(rhs) else 0,power[n] if n<len(power) else 0),3))
    yi=[1]
    for n in range(1,cut):yi.append(k.neg((p.mul(yy,yi)+[0]*cut)[n]))
    aa=p.mul(shift(Z),yi)[:cut];slope=p.eval(p.derivative(t),args.root)
    def series(function):
        out=[]
        for char in range(3):out=p.add(out,p.mul(shift(function[char]),p.power(yy,char)))
        return out[:cut]
    tags=[(j,n) for j in range(4) for n in range(3-j,7-2*j)]
    def extra(columns):
        output=[[] for _ in tags]
        for cs in columns:
            values=list(map(series,cs));short=[]
            for j in range(6):
                out=[]
                for hh in range(j,6):out=p.add(out,p.scale(p.mul(values[hh],p.power(aa,hh-j)),comb(hh,j)%5))
                short.append(out[:cut])
            for row,(j,n) in enumerate(tags):
                out=[]
                for hh in range(j,6):
                    power=hh-j;ix=n-power;coefficient=short[hh][ix] if 0<=ix<len(short[hh]) else 0
                    if coefficient:out=p.add(out,[0]*power+[k.mul(k.mul(coefficient,comb(hh,j)%5),k.power(slope,power))])
                output[row].append(out)
        return output
    M=extra(lower);Et=extra(particular);L=left_inverse(p,M);assert matmul(p,L,M)==[[[1] if i==j else [] for j in range(9)] for i in range(9)]
    w=[p.scale(determinant(p,[row for j,row in enumerate(M) if j!=i]),1 if i%2==0 else 4) for i in range(10)]
    for j in range(9):assert not matmul(p,[w],[[row[j]] for row in M])[0][0]
    new=matmul(p,[w],Et)[0]
    points=json.loads((data/'shifted_concentrated_projection.json').read_text())['records'];omega=int(k.exp[390624//3]);endpoints=[]
    for record in points:
        other=record['y0_extension_code']//390625
        for j in range(3):
            y=k.mul(k.div(other,b0),k.power(omega,j));assert k.power(y,3)==p.eval(C.P,record['root_K_code']);endpoints.append([record['root_K_code'],y])
    auxker=json.loads((data/'critical_quadratic_fixed_input.json').read_text())['auxiliary_kernel'];auxlabels=[(j,b,char) for j,bound in enumerate((10,12,14)) for b,char in monomials(bound)];aux=[]
    for vector in auxker:
        eta_functions=[C.zero() for _ in range(3)]
        for coefficient,(j,b,char) in zip(vector,auxlabels):
            if coefficient:eta_functions[j]=C.add(eta_functions[j],C.monomial(b,char,coefficient))
        n0=eta_functions[0];n1=C.add(pi(n0,1),eta_functions[1]);n2=C.add(C.sub(C.add(C.scale(pi(eta_functions[1],1),2),C.scale(pi(pi(n0,1),1),2)),pi(n0,2)),eta_functions[2]);aux.append([n0,n1,n2])
    source=next(record for record in json.loads((data/'concentrated_d10m6_source_family.json').read_text())['records'] if record['root']==args.root);vfree=C.zero()
    for nn,(b,char) in zip(source['cy_numerators'][13:],monomials(10)):
        quotient=p.exactdiv(nn,source['H']);assert len(quotient)<=1
        if quotient:vfree=C.add(vfree,C.monomial(b,char,k.mul(quotient[0],k.power(scalar,-3))))
    vfseries=series(vfree);assert not any((vfseries+[0]*5)[:4]) and vfseries[4]
    output={'scope':'exact K-defined twisted source/numerator setup; no source existence decision','root':args.root,'coordinate_change':'Y=y/y0,T=y0*w; phi0=y0^5 phi; Dnew=y0^-6 D(T/y0)','y0_code':y0code,'y0_cubed_K':scalar,'P_twisted':C.P,'t':t,'Z':Z,'q0':q0,'source_S_basis':Sbasis,'source_characters':characters,'v_scale_K':k.power(scalar,-3),'freev_function':vfree,'freev_endpoint_series':vfseries,'endpoints':endpoints,'auxiliary_functions':aux,'Y_endpoint_series':yy,'inverse_Y_endpoint_series':yi,'base_translation_endpoint_series':aa,'center_slope_K':slope,'lower_labels':labels,'lower_matrix':J.tolist(),'lower_kernel':ker.tolist(),'lower_functions':lower,'top_labels':toplabels,'particular_functions':particular,'ordinary_top_form':old,'extra_matrix':M,'extra_top_matrix':Et,'polynomial_left_inverse':L,'concentrated_top_form':new,'extra_row_tags':tags}
    (data/f'twisted_concentrated_setup_{args.root}.json').write_text(json.dumps(output,separators=(',',':'))+'\n');print('TWISTED_SETUP',args.root,'LOWERRANK',len(piv),'LEFTINVERSE_DEG',max(len(f)-1 for row in L for f in row),'NEWFORMDEG',max(len(f)-1 for f in new),'SOURCE_COLUMNS',len(Sbasis))
if __name__=='__main__':main()
