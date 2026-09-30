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
    kk=GF(125,'b');EE=E.change_ring(kk)
    assert EE.order()==130
    odd=[];trace=[]
    def pi(P):return EE(0) if not P else EE(P[0]**5,P[1]**5)
    for P in EE.points():
        if 65*P==EE(0):odd.append(P)
        C=P+pi(P)+pi(pi(P))
        if not C:trace.append(P)
        V=-4*P-pi(P)
        assert pi(V)==5*P
        assert (not(P+pi(P)+pi(pi(P))))==((not P) or cubic(P[0]**2)==0)
        assert (65*P==EE(0))==(not(V+pi(V)+pi(pi(V))))
    assert len(odd)==65 and len(trace)==13
    # Check the CM identity, including the sign of the chosen unit.
    for P in EE.points():
        ii=EE(0) if not P else EE(-P[0],2*P[1])
        assert pi(P)==-2*P+ii
    S=PolynomialRing(k,names=['U','A']);U,A=S.gens()
    f=U**3*(U+3)**2-A
    assert f.resultant(f.derivative(U),U)==-A**3
    receipt=dict(kind='dormant_verschiebung_quotient',elliptic_curve='y^2=x^3+3*x',
                 verschiebung_x=str(vx),verschiebung_y_multiplier=str(vy),
                 z='x*y/(2*x^2+3)',artin_schreier_identity='z^5-z=3*Vx*Vy',
                 quotient_polynomial=str(f),discriminant=str(-A**3),
                 trace13_x_squared_polynomial=str(cubic),
                 rational_elliptic_order=130,odd_subgroup_order=65,frobenius_trace_kernel_order=13,
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS Verschiebung, Artin-Schreier quotient, degree-five model and trace13 subgroup.')


if __name__=='__main__':main()
