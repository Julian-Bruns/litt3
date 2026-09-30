#!/usr/bin/env python3
"""Exact full discriminant net for the invariant cubics of F^*K(O).

Run with Sage Python. Interpolation determines homogeneous quartic
identities over all geometric parameters; it is not a point search.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector

def compositions(total,length):
    if length==1:
        yield (total,);return
    for i in range(total+1):
        for tail in compositions(total-i,length-1):yield (i,)+tail

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('sections',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.sections.read_text());assert len(data['sections'])==7
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));alpha=k.gen()
    R=PolynomialRing(k,'x');x=R.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    def code(v):
        t=v.polynomial();return int(t[0])+5*int(t[1])
    basis=[]
    for section in data['sections']:
        row=[]
        for index,residue in zip((0,5,10,15),(0,2,1,0)):
            entries=section['affine'][index];assert all(r==residue for r,m,a in entries)
            row.append(sum(decode(a)*x**m for r,m,a in entries))
        basis.append(row)
    P=R([decode(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
    def discr(parameters):
        a,b,c,d=[sum(parameters[j]*basis[j][i] for j in range(7)) for i in range(4)]
        return P**2*b**2*c**2+P*a*c**3+P**2*b**3*d+3*a**2*d**2+3*P*a*b*c*d
    exponents=list(compositions(4,7))
    points=[(k.one(),)+tuple(k(i) for i in e[1:]) for e in exponents]
    evaluation=matrix(k,[[__import__('functools').reduce(lambda a,b:a*b,(v**i for v,i in zip(pt,ee)),k.one())
                          for ee in exponents] for pt in points])
    assert evaluation.nrows()==210 and evaluation.is_invertible()
    inverse=evaluation.inverse();values=[discr(pt) for pt in points]
    assert all(v.degree()<=14 for v in values)
    coefficients=[inverse*vector(k,[v[n] for v in values]) for n in range(15)]
    checks=[tuple(k(int(i==j)) for i in range(7)) for j in range(1,7)]
    checks += [tuple(alpha**(i+j)+k(i%5) for i in range(7)) for j in range(1,5)]
    for pt in checks:
        mon=vector(k,[__import__('functools').reduce(lambda a,b:a*b,(v**i for v,i in zip(pt,ee)),k.one()) for ee in exponents])
        assert R([row.dot_product(mon) for row in coefficients])==discr(pt)
    result={'status':'PASS','scope':'Complete homogeneous quartic discriminant on seven invariant parameters; no square-locus decision.',
            'O_shift':1,'parameter_monomials':exponents,'x_coefficients':[[code(a) for a in row] for row in coefficients],
            'interpolation_determinant':code(evaluation.det()),'additional_checks':len(checks)}
    args.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('PASS: degree14 discriminant net in seven parameters;210 interpolation values and10 separate identity checks.')

if __name__=='__main__':main()
