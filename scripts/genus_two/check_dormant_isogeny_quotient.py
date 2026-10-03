#!/usr/bin/env sage -python
"""Exact Verschiebung quotient of the characteristic-five dormant family."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import *


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    k=GF(5);R=PolynomialRing(k,'x');x=R.gen();E=EllipticCurve(k,[3,0])
    vx=(x**5+2*x**3+x)/(x**4+3*x**2+1)
    vy=vx.derivative()
    assert vy**2*(x**3+3*x)==vx**3+3*vx
    assert E.multiplication_by_m(5,x_only=True)==vx**5
    # The invariant differential multiplier of V is one. Hence this
    # x-coordinate and y'=V_x'(x)y give V, not its negative.
    h=x**5*(x**3+3*x)**2/(2*x**10+3)-x/(2*x**2+3)
    assert h==3*vx*vy
    AA=(x**3+3*x)**2*h**4
    assert AA==(vx**2)**3*(vx**2+3)**2
    cubic=x**3+4*x**2+3*x+4
    assert cubic.is_irreducible()
    quotient=x**3*(x+3)**2
    assert ((quotient**3+3*quotient**2+4)%cubic)==0
    # The proof derives pi=-2+i and C=2-3i from one rational point.
    # Modulo D(x^2), [2]P=[3]iP; no finite-point enumeration is used.
    P=E(1,2)
    assert 2*P==E(4,1) and 3*P==E(-P[0],2*P[1])
    g=x**3+3*x
    slope2=(3*x**2+3)/(2*g)
    x2=g*slope2**2-2*x
    y2=slope2*(x-x2)-1
    slope3=(y2-1)/(x2-x)
    x3=g*slope3**2-x2-x
    y3=slope3*(x-x3)-1
    D=cubic(x**2)
    for identity in [x2+x3,y2-2*y3]:
        assert identity.numerator()%D==0
        assert identity.denominator().gcd(D)==1
    S=PolynomialRing(k,names=['U','A']);U,A=S.gens()
    f=U**3*(U+3)**2-A
    assert f.resultant(f.derivative(U),U)==-A**3
    receipt=dict(kind='dormant_verschiebung_quotient',elliptic_curve='y^2=x^3+3*x',
                 verschiebung_x=str(vx),verschiebung_y_multiplier=str(vy),
                 z='x*y/(2*x^2+3)',artin_schreier_identity='z^5-z=3*Vx*Vy',
                 quotient_polynomial=str(f),discriminant=str(-A**3),
                 trace13_x_squared_polynomial=str(cubic),
                 trace_kernel_check='CM proof plus exact doubling/tripling identities modulo D(x^2)',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS Verschiebung, Artin-Schreier quotient, degree-five model and trace13 subgroup.')


if __name__=='__main__':main()
