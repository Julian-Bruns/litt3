#!/usr/bin/env python3
"""Export two already retained fixed source tuples for the new cubic incidence."""
import argparse,json,sys
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES,Q_CODES
from infinity import InfinitySystem

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args()
    k=Field(args.work/'cache');p=Poly(k);C=Curve(k);data=args.work/'data'
    family=json.loads((data/'adapted_family.json').read_text());system=InfinitySystem(k,family)
    Z=p.sub(B0_CODES,L0_CODES)
    def pi(c,n):
        raw=C.mul(C.polyx(p.power(Z,n)),c);out=C.zero()
        for char,component in enumerate(raw):
            power,target=divmod(char-n,3)
            out[target]=p.mul(component,p.power(C.P,power)) if power>=0 else p.divmod(component,p.power(C.P,-power))[0]
        return out
    def num(a5,a4,rs):
        c3=C.add(pi(a4,1),rs[3]);c2=C.neg(C.add(C.scale(pi(c3,1),3),pi(a4,2)));c2=C.add(c2,rs[2])
        c1=C.neg(C.add(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3)),pi(a4,3)));c1=C.add(c1,rs[1])
        c0=C.neg(C.add(C.add(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3)),pi(a4,4)),pi(a5,5)));c0=C.add(c0,rs[0])
        return [c0,c1,c2,c3,a4,a5]
    aux_labels=[(j,b,r) for j,bound in enumerate((10,12,14)) for b,r in monomials(bound)]
    forms=np.zeros((3,18),dtype=np.uint32)
    for col,(j,b,r) in enumerate(aux_labels):
        if r==0 and j in (0,1):
            rem=p.mod(p.mul(Z,[0]*b+[1]),C.P)
            if j==0:
                forms[0,col]=rem[9] if len(rem)>9 else 0;forms[1,col]=rem[8] if len(rem)>8 else 0
            else:forms[2,col]=k.mul(2,rem[9] if len(rem)>9 else 0)
        elif (j,b,r)==(0,0,1):
            rem=p.mod(p.power(Z,2),C.P);forms[2,col]=rem[9] if len(rem)>9 else 0
    aux_kernel,_,_=k.kernel(forms);assert len(aux_kernel)==15
    aux=[]
    for vector in aux_kernel:
        eta=[C.zero() for _ in range(3)]
        for scalar,(j,b,r) in zip(vector,aux_labels):
            if scalar:eta[j]=C.add(eta[j],C.monomial(b,r,int(scalar)))
        n0=eta[0];n1=C.add(pi(n0,1),eta[1])
        n2=C.add(C.sub(C.add(C.scale(pi(eta[1],1),2),C.scale(pi(pi(n0,1),1),2)),pi(n0,2)),eta[2])
        aux.append([n0,n1,n2])
    records=[]
    for name in ('quadratic_torsion_d10_m3_seed1','quadratic_torsion_d0_m12_seed1'):
        old=json.loads((data/(name+'.json')).read_text());source=old['source_S_coordinates']
        N=[C.zero() for _ in range(6)]
        for scalar,column in zip(source,system.N):
            for j in range(6):N[j]=C.add(N[j],C.scale(column[j],scalar))
        v=C.zero()
        for scalar,(b,r) in zip(old['v_coefficients'],monomials(10)):v=C.add(v,C.monomial(b,r,scalar))
        N[0]=v;N[5]=C.add(N[5],C.mul(v,C.polyx(Q_CODES)));S,q=C.frame(N)
        F=[C.add(C.add(C.mul(v,C.power(q,2)),C.mul(q,S[0])),C.power(C.polyx(family['t']),3))]
        F.extend(C.mul(q,S[j]) for j in range(1,5));F.append(C.add(S[0],C.scale(C.mul(v,q),2)));F.extend(S[1:]);F.append(v)
        D=[C.scale(S[j],j) for j in range(1,5)];columns=[]
        for label in old['numerator_labels']:
            rs=[C.zero() for _ in range(4)];kind=label[0]
            if kind=='m4':
                m=C.monomial(label[1],label[2]);columns.append(num(C.mul(v,m),C.mul(S[4],m),rs))
            elif kind=='m5':columns.append(num(C.zero(),C.mul(v,C.monomial(label[1],label[2])),rs))
            else:
                _,j,b,r=label;rs[j]=C.monomial(b,r);columns.append(num(C.zero(),C.zero(),rs))
        U=[];m4=[]
        for vector in old['numerator_kernel']:
            cs=[C.zero() for _ in range(6)]
            for scalar,column in zip(vector,columns):
                if scalar:
                    for j in range(6):cs[j]=C.add(cs[j],C.scale(column[j],scalar))
            U.append(cs);m4.append(C.polyx(vector[:3]))
        records.append({'name':name,'F':F,'D':D,'v':v,'U':U,'m4':m4,'old_scope':old['scope']})
    (data/'critical_quadratic_fixed_input.json').write_text(json.dumps({'P':C.P,'auxiliary_functions':aux,'auxiliary_kernel':aux_kernel.tolist(),'gap_forms':forms.tolist(),'records':records},separators=(',',':'))+'\n')
    print('EXPORTED',[(r['name'],len(r['U'])) for r in records],flush=True)
if __name__=='__main__':main()
