#!/usr/bin/env python3
"""Four additional universal jets at a concentrated finite endpoint."""
import argparse
import json
import sys
from math import comb
from pathlib import Path
import numpy as np

ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,B0_CODES,L0_CODES
from cubic_extension import CubicExtension
from endpoint_jets import ENDPOINT_ROOTS


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args()
    k=Field(args.work/'cache');p=Poly(k);C=Curve(k);e=CubicExtension(k)
    data=json.loads((args.work/'data/lower_numerator_product_space.json').read_text())
    U=data['numerator_coefficients'];assert len(U)==9
    quadric=np.array(data['quadratic_symmetric_matrix'],dtype=np.uint64)
    z=p.sub(B0_CODES,L0_CODES)
    clear=[]
    for j in range(4):
        funcs=[]
        for cs in U:
            out=C.zero()
            for h in range(j,4):
                term=C.mul(C.polyx(p.power(z,h-j)),cs[h])
                term=C.mul(term,C.power(C.monomial(0,1),5-h))
                out=C.add(out,C.scale(term,comb(h,j)%5))
            funcs.append(out)
        clear.append(funcs)
    rho=e.Q;zeta=k.power(25,130208)
    assert e.power(rho,3)==6
    results=[]
    for root in ENDPOINT_ROOTS:
        def shift(poly,cut):
            out=[]
            for scalar in reversed(poly):
                out=p.add(p.mul(out,[root,1]),[scalar])[:cut]
            return out+[0]*(cut-len(out))
        value=p.eval(C.P,root)
        ratio=k.div(value,6);assert int(k.log[ratio])%3==0
        cube=int(k.exp[int(k.log[ratio])//3]);assert k.power(cube,3)==ratio
        rhs=p.scale(shift(C.P,4),k.inv(value));h=[1]
        for n in range(1,4):
            power=p.power(h,3)
            coefficient=power[n] if n<len(power) else 0
            h.append(k.div(k.sub(rhs[n],coefficient),3))
        assert p.power(h,3)[:4]==p.trim(rhs)
        for sheet in range(3):
            y0=e.mul(rho,k.mul(cube,k.power(zeta,sheet)))
            matrix=np.zeros((4,9),dtype=np.uint64)
            for j in range(4):
                n=3-j
                for col,function in enumerate(clear[j]):
                    coefficient=0
                    for char in range(3):
                        product=p.mul(shift(function[char],n+1),p.power(h,char))
                        scalar=product[n] if n<len(product) else 0
                        coefficient=e.add(coefficient,e.mul(e.power(y0,char),scalar))
                    matrix[j,col]=coefficient
            _,piv=e.rref(matrix)
            assert len(piv)==4
            restriction=e.matmul(matrix,quadric)
            _,qpiv=e.rref(restriction)
            assert len(qpiv)==2
            results.append({'root_K_code':root,'sheet':sheet,'extra_rows_on_V0':matrix.tolist(),'rank':len(piv),
                            'extra_rows_times_raw_quadric_rank':len(qpiv),
                            'lower_concentrated_symmetric_square_rank':15})
    report={
        'scope':'four extra necessary unshifted jets at any concentrated finite endpoint, no actual-source assertion',
        'extra_orders':[[0,3],[1,2],[2,1],[3,0]],
        'lower_V0_dimension':9,'all_nine_extra_ranks': [item['rank'] for item in results],
        'generic_numerator_dimension':12,'exceptional_numerator_dimension':13,
        'lower_concentrated_dimension':5,'lower_concentrated_multiplication_rank':15,
        'endpoint_matrices':results,
    }
    (args.work/'data/concentrated_endpoint_projection.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({key:report[key] for key in ('scope','all_nine_extra_ranks','generic_numerator_dimension','exceptional_numerator_dimension','lower_concentrated_multiplication_rank')}))


if __name__=='__main__':
    main()
