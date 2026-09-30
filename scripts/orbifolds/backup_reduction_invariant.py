#!/usr/bin/env sage-python
"""A nonzero absolute invariant of the backup, evaluated via an integral lift.

The usual I2-based absolute invariants all vanish at five here, so they
must not be used to identify or exclude this special curve.
"""
from sage.all import QQ, PolynomialRing, NumberField, HyperellipticCurve
from pathlib import Path
import json
import sys


def main():
    output=Path(sys.argv[1]);output.parent.mkdir(parents=True,exist_ok=True)
    P=PolynomialRing(QQ,'a');a=P.gen();K=NumberField(a**3+a+1,'alpha');alpha=K.gen()
    R=PolynomialRing(K,'u');u=R.gen()
    C=HyperellipticCurve(u*(u-1)*(u-2)*(u-3)*(u-alpha))
    i2,i4,i6,i10=C.igusa_clebsch_invariants()
    prime=K.prime_above(5);residue=K.residue_field(prime);reduce=residue.reduction_map()
    assert i10.valuation(prime)==0
    target=reduce(i4**5/i10**2);minimal=target.minpoly()
    assert minimal.degree()==3
    print('I2,I4,I6,I10 reductions:',[reduce(v) for v in (i2,i4,i6,i10)],flush=True)
    print('I4^5/I10^2 =',target,'; minimal polynomial =',minimal,flush=True)
    output.write_text(json.dumps({'lift_polynomial':'a^3+a+1',
        'invariant':'I4^5/I10^2, Sage Igusa-Clebsch convention',
        'target':str(target),'minimal_polynomial_ascending':[int(c) for c in minimal.list()],
        'warning':'I2-based Kohel absolute invariants all reduce to zero; this invariant is only a necessary comparison test.'},indent=2)+'\n')


if __name__=='__main__':main()
