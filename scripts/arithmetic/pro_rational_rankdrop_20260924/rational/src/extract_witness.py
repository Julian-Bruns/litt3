#!/usr/bin/env python3
"""Reconstruct checked unit-ideal witness coefficients for one certificate cell."""
from __future__ import annotations
import argparse,json
from pathlib import Path
from reference_matrices import *

def enc(v):
    if isinstance(v,tuple) and len(v)==14 and all(isinstance(x,int) for x in v):return to_code(v)
    if isinstance(v,list):return [enc(x) for x in v]
    return v

def extract(n:int,index:int,phase:int)->dict:
    path=ROOT/'certificates'/f'n{n:02}.rrc';d,count=read_header(path)
    if d!=n-3:raise ValueError('degree mismatch')
    mask,w,fingerprint=read_record(path,index);I=pole_indices(mask);E=evaluation_spaces(I)
    M,v=phase_kernel(I,E,phase);reason=w[phase];kind=check_reason(reason,I,E,v)
    b,c=divmod(phase,8)
    out={'status':'CHECKED','n':n,'d':d,'record_index':index,'phase_index':phase,
         'pole_mask':mask,'pole_exponents':I,'phase_codes_at_first_three_poles':[1,MU_CODES[b],MU_CODES[c]],
         'reason_byte':reason,'kind':kind,'field_encoding':'seven base-25 digits; see inputs/field.json',
         'basis':'independent partial-fraction bases, not the polynomial bases used by the stored fingerprint',
         'parameter_basis1':enc(E['parameter_basis1']),'parameter_basis2':enc(E['parameter_basis2']),
         'row_linear_forms_L':enc(M),'cofactor_kernel_vector':enc(v),
         'stored_polynomial_basis_fingerprint':fingerprint}
    if kind=='power':
        X,Y=forms(E,reason);ell,_=forms(E,0);ev=dot(ell,v)
        if ev==ZERO:raise ArithmeticError('first required evaluation unexpectedly vanishes')
        beta=div(dot(X,v),ev);gamma=div(dot(Y,v),ev);q3=ROOTS[3*I[reason]%29]
        a0=sub(power(gamma,8),mul(q3,power(beta,8)))
        if a0==ZERO:raise ArithmeticError('zero obstruction coefficient')
        bs=row_coefficients(M,[sub(x,mul(beta,e)) for x,e in zip(X,ell)])
        cs=row_coefficients(M,[sub(y,mul(gamma,e)) for y,e in zip(Y,ell)])
        out.update({'obstruction_pole_index':reason,'obstruction_pole_cubed':enc(q3),
                    'ell':enc(ell),'X':enc(X),'Y':enc(Y),'beta':enc(beta),'gamma':enc(gamma),
                    'a0':enc(a0),'b_row_coefficients':enc(bs),'c_row_coefficients':enc(cs),
                    'checked_relations':['X=beta*ell+sum b_i*L_i','Y=gamma*ell+sum c_i*L_i','a0=gamma^8-q^3*beta^8 != 0'],
                    'definitions':{'H':'Y^8-q^3*X^8','S_X':'sum_{j=0}^7 X^(7-j)*(beta*ell)^j','S_Y':'sum_{j=0}^7 Y^(7-j)*(gamma*ell)^j','C_i':'c_i*S_Y-q^3*b_i*S_X'},
                    'unit_identity':'1=(1-z*ell)*sum_{j=0}^7(z*ell)^j+(z^8/a0)*H-(z^8/a0)*sum_i C_i*L_i'})
    else:
        if kind=='pole_zero':
            j=reason-32;X,Y=forms(E,j);ell=X if dot(X,v)==ZERO else Y
            label=f'B_{1 if ell==X else 2}(pole[{j}])'
        else:
            key,offset=[('lead1',0),('lead2',2),('constant1',0),('constant2',2)][reason-64]
            ell=(E[key]+[ZERO,ZERO]) if offset==0 else ([ZERO,ZERO]+E[key]);label=key
        if dot(ell,v)!=ZERO:raise ArithmeticError('linear zero witness failed')
        bs=row_coefficients(M,ell)
        out.update({'required_nonzero_form':label,'ell':enc(ell),'b_row_coefficients':enc(bs),
                    'checked_relations':['ell=sum b_i*L_i'],
                    'unit_identity':'1=(1-z*ell)+z*sum_i b_i*L_i'})
    return out

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--n',type=int,required=True);p.add_argument('--record',type=int,required=True);p.add_argument('--phase',type=int,required=True);p.add_argument('--output',type=Path)
    args=p.parse_args()
    if not 7<=args.n<=26 or not 0<=args.phase<64:p.error('invalid degree or phase')
    result=extract(args.n,args.record,args.phase);text=json.dumps(result,indent=2)+'\n'
    if args.output:args.output.write_text(text)
    else:print(text,end='')
