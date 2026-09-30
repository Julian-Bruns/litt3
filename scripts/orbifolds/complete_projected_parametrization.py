#!/usr/bin/env sage-python
"""Recover the omitted saturation inverse by exact polynomial arithmetic.

The modified solver exports candidates for every coordinate except its first
auxiliary inverse. Nothing is accepted until all original equations vanish
in the resulting rational algebra. This is independent of modular confidence.
"""
from sage.all import QQ, ZZ, PolynomialRing, lcm
from pathlib import Path
import ast
import hashlib
import json
import sys


def main():
    root=Path(sys.argv[1])
    if hasattr(sys,'set_int_max_str_digits'):sys.set_int_max_str_digits(0)
    dump=(root/'projected.ms').read_text()
    degree,nvars,w_data,coordinate_data=ast.literal_eval(dump)
    source=(root/'linear.ms').read_text().splitlines();names=source[0].split(',')
    assert len(names)==nvars and names[0]=='inv' and source[1]=='0'
    P=PolynomialRing(QQ,'z');z=P.gen();w=P(w_data[1]);den=w.derivative()
    assert w.degree()==degree==w_data[0] and w.gcd(den)==1
    assert len(coordinate_data)==nvars-2
    K=P.quotient(w,'theta');theta=K.gen()
    values=[-K(P(entry[0][1]))/(QQ(entry[1])*K(den)) for entry in coordinate_data]+[theta]
    R=PolynomialRing(QQ,names=names)
    equations=[R(e) for e in '\n'.join(source[2:]).split(',') if e.strip()]
    inv=R.gen(0);last=equations[-1]
    assert last.degree(inv)==1 and last.subs({inv:0})==-1
    assert all(e.degree(inv)==0 for e in equations[:-1])
    provisional=R.hom([K(0)]+values,K)
    open_factor=provisional(last.derivative(inv))
    assert open_factor.lift().gcd(w)==1
    values=[1/open_factor]+values
    evaluate=R.hom(values,K)
    for i,e in enumerate(equations):
        assert evaluate(e)==0, 'Original equation %d failed exact substitution'%i
    entries=[]
    for v in values[:-1]:
        numerator=-(v*K(den)).lift()
        denominator=lcm([c.denominator() for c in numerator.list()])
        integers=[int(c*denominator) for c in numerator.list()]
        entries.append([[int(numerator.degree()),integers],int(denominator)])
    output=[0,[0,nvars,degree,names,[0]*(nvars-1)+[1],
               [1,[w_data,[int(den.degree()),[int(c) for c in den.list()]],entries]]]]
    (root/'parametrization.ms').write_text(repr(output)+':\n')
    report={'degree':degree,'all_original_equations':True,'open_factor_invertible':True,
            'omitted_coordinate':'inv','method':'exact inversion in QQ[z]/(w)',
            'projected_sha256':hashlib.sha256(dump.encode()).hexdigest()}
    (root/'projection_completion.json').write_text(json.dumps(report,indent=2)+'\n')
    print(report,flush=True)


if __name__=='__main__':main()
