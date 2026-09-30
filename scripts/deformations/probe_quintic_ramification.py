#!/usr/bin/env sage -python
"""Inspect the actual cubic-backup Frobenius ramification divisor.

This is a research probe, not an all-height stability certificate.
The homogeneous Jacobian determinant vanishes in degree five; use
the projective differential instead. All output is external.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import *
from probe_pointed_kummer import (theta_from_rosenhain,kummer_from_node,
                                  ducrohet_quintics,frobenius_coefficients)


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    started=time.monotonic();k=GF(5**12,'b')
    A=PolynomialRing(k,'a');a=A.gen()
    alpha=(a**3+a+1).roots(multiplicities=False)[0]
    node=theta_from_rosenhain(k(2),k(3),alpha)
    R=PolynomialRing(k,names=['x0','x1','x2','x3']);x=R.gens()
    K,coeff=kummer_from_node(node,R);K1=frobenius_coefficients(K)
    V=ducrohet_quintics(coeff,R)
    quotient,rem=K(*V).quo_rem(K1);assert not rem
    fac=quotient.factor();assert all(e%2==0 for _,e in fac)
    H=R(fac.unit().sqrt())*prod(f**(e//2) for f,e in fac)
    assert K(*V)==K1*H**2
    rows=[[V[i]]+[V[i].derivative(x[j]) for j in range(1,4)] for i in range(4)]
    determinant=matrix(R,rows).det()
    ram,rem=determinant.quo_rem(x[0]);assert not rem and ram
    assert ram.is_homogeneous() and ram.degree()==16
    residual,rem=ram.quo_rem(H);assert not rem
    assert residual.degree()==8
    for j in range(4):
        other=[h for h in range(4) if h!=j]
        dj=matrix(R,[[V[i]]+[V[i].derivative(x[h]) for h in other] for i in range(4)]).det()
        assert dj==(-1)**j*x[j]*ram
    factors=ram.factor()
    result=dict(status='exploratory_exact_arithmetic',
        field_modulus=str(k.modulus()),alpha=str(alpha),
        source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        builder_sha256=hashlib.sha256(Path(__file__).with_name('probe_pointed_kummer.py').read_bytes()).hexdigest(),
        H=str(H),ramification=str(ram),residual=str(residual),
        ramification_factors=[dict(degree=int(f.degree()),multiplicity=int(e),polynomial=str(f)) for f,e in factors],
        gcd_H_residual_degree=int(H.gcd(residual).degree()),
        gcd_K1_residual_degree=int(K1.gcd(residual).degree()),
        all_projective_charts_agree=True,seconds=float(round(time.monotonic()-started,2)))
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print({key:result[key] for key in ['status','gcd_H_residual_degree','gcd_K1_residual_degree','seconds']},flush=True)
    print('ramification factors',[(f['degree'],f['multiplicity']) for f in result['ramification_factors']],flush=True)


if __name__=='__main__':main()
