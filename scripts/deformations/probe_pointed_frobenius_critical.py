#!/usr/bin/env sage -python
"""Exact critical-divisor reconnaissance in the cubic Frobenius model.

No iteration or all-height certificate is produced. Polynomial data belong
outside the research workspace.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import *
from probe_pointed_kummer import (theta_from_rosenhain, kummer_from_node,
                                  ducrohet_quintics, frobenius_coefficients)
from probe_frobenius_heisenberg_quotient import invariants, descend_forms, encoded


def normalize(f):
    return f/f.leading_coefficient()


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
    start=time.monotonic()
    large=GF(5**12,'b');U=PolynomialRing(large,'u');u=U.gen()
    alpha=(u**3+u+1).roots(multiplicities=False)[0]
    node=theta_from_rosenhain(large(2),large(3),alpha)
    Rlarge=PolynomialRing(large,names=['x0','x1','x2','x3'])
    _,coefflarge=kummer_from_node(node,Rlarge)
    k,emb=large.subfields(6)[0];back=emb.section()
    a,b,c,d=coeff=tuple(back(t) for t in coefflarge)
    R=PolynomialRing(k,names=['x0','x1','x2','x3']);x=R.gens()
    inv=invariants(x);K=inv[0]+2*a*inv[1]+b*inv[2]+c*inv[3]+d*inv[4]
    V=ducrohet_quintics(coeff,R);K1=frobenius_coefficients(K)
    # In degree p, the homogeneous 4x4 ordinary Jacobian is zero by Euler.
    # Add the value row and use three derivative rows instead.
    numerator=matrix(R,[V]+[[v.derivative(x[i]) for v in V] for i in (1,2,3)]).det()
    J,rem=numerator.quo_rem(x[0]);assert rem==0 and J.degree()==16
    factors=list(J.factor())
    print('Critical factor degrees',[(f.degree(),e) for f,e in factors],flush=True)
    pull,rem=R(K(*V)).quo_rem(K1);assert rem==0
    square_factors=list(pull.factor());assert all(e%2==0 for _,e in square_factors)
    S=normalize(prod(f**(e//2) for f,e in square_factors))
    assert S.degree()==8
    T,rem=J.quo_rem(S);assert rem==0
    T=normalize(T)
    assert T.degree()==8 and normalize(S)!=normalize(T)
    Q=PolynomialRing(k,names=['S','P','Q1','Q2','Q3'])
    descended,info=descend_forms([S,T],inv,2,Q)
    print('Both critical octics descend to quadrics',flush=True)
    sq, tq=descended
    # The second component is not automatically carried into the Kummer
    # boundary. Checking the entire polynomial removes that shortcut.
    assert R(K(*V)).reduce([T])!=0
    receipt=dict(kind='cubic_frobenius_critical_divisors',status='exact_experiment',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 field_modulus=str(k.modulus()),critical_degree=16,
                 factor_degrees=[(f.degree(),e) for f,e in factors],
                 kummer_pullback_is_source_times_octic_square=True,
                 jacobian_is_product_of_two_distinct_octics=True,
                 invariant_descent=info,quotient_critical_quadrics=[encoded(f) for f in descended],
                 second_component_not_mapped_into_kummer=True,
                 seconds=round(time.monotonic()-start,2))
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('Completed in',receipt['seconds'],'seconds; no height verdict.',flush=True)


if __name__=='__main__':main()
