#!/usr/bin/env python3
"""Reconstruct the full degree10 discriminant of the Sym3(F^*K) section net.

Sage Python; finite interpolation reconstructs polynomial identities,
not a finite search for geometric square points.
"""
import argparse
import itertools
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('sections',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));alpha=k.gen()
    R=PolynomialRing(k,'x');x=R.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    def code(v):
        vv=v.polynomial();return int(vv[0])+5*int(vv[1])
    data=json.loads(args.sections.read_text());basis=[]
    for section in data['sections']:
        row=[]
        for index,residue in zip((0,5,10,15),(0,2,1,0)):
            entries=section['affine'][index];assert all(r==residue for r,m,a in entries)
            row.append(sum(decode(a)*x**m for r,m,a in entries))
        basis.append(row)
    P=R([decode(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
    def discr(parameters):
        a,b,c,d=[sum(parameters[j]*basis[j][i] for j in range(3)) for i in range(4)]
        return P**2*b**2*c**2+P*a*c**3+P**2*b**3*d+3*a**2*d**2+3*P*a*b*c*d
    exponents=[(4-i-j,i,j) for i in range(5) for j in range(5-i)]
    points=[(k.one(),k(i),k(j)) for i in range(5) for j in range(5-i)]
    evaluation=matrix(k,[[a**i*b**j*c**h for i,j,h in exponents] for a,b,c in points])
    assert evaluation.is_invertible();inverse=evaluation.inverse()
    vals=[discr(point) for point in points]
    assert all(v.degree()<=10 for v in vals)
    coefficients=[inverse*vector(k,[v[n] for v in vals]) for n in range(11)]
    checks=[(k.zero(),k.one(),k.zero()),(k.zero(),k.zero(),k.one()),
            (alpha,k.one(),alpha+1),(k.one(),alpha,alpha+2),(alpha,alpha+1,alpha+3)]
    for point in checks:
        mon=vector(k,[point[0]**i*point[1]**j*point[2]**h for i,j,h in exponents])
        rebuilt=R([row.dot_product(mon) for row in coefficients])
        assert rebuilt==discr(point)
    out={'status':'PASS','scope':'Complete homogeneous quartic parameter net of degree<=10 x-discriminants; no geometric square-locus decision.',
         'parameter_monomials':exponents,'x_coefficients':[[code(v) for v in row] for row in coefficients],
         'interpolation_determinant':code(evaluation.det()),'independent_parameter_checks':len(checks)}
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: full discriminant net reconstructed; x-degree<=10;15 exact interpolation values and5 other parameter checks.')

if __name__=='__main__':main()
