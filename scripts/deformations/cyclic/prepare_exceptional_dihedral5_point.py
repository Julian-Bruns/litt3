#!/usr/bin/env sage-python
"""Choose an exploratory hyperelliptic W4 candidate over the cubic base extension."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--candidate',required=True);ap.add_argument('--output',required=True)
args=ap.parse_args()
D=json.loads(Path(args.candidate).read_text())
assert all(r['match'] for r in D['extra_checks']) and all(D['quadratic_frobenius_checks'])
P=PolynomialRing(GF(5),'t');k=GF(625,'t',modulus=P([3,4,1,4,1]))
R=PolynomialRing(k,4,'x');x=R.gens()
E=[R({tuple(c['exponents']):k(c['coefficient']) for c in row}) for row in D['polynomials']]
Y=PolynomialRing(k,2,'y',order='lex');y=Y.gens()
even=[Y({tuple(ei//5 for ei in ex[:2]):c for ex,c in e.dict().items() if ex[2]==ex[3]==0}) for e in E[:2]]
B=Y.ideal(even).groebner_basis()
Q=PolynomialRing(k,'a');a=Q.gen();p=Q(B[-1](0,a))
assert p.degree()==3 and p.is_irreducible() and B[0].degree(y[0])==1
K=Q.quotient(p,'l');l=K.gen();pt=[-B[0](0,l),l]
assert all(e(*pt)==0 for e in even)
enc=lambda c:[int(c.polynomial()[i]) for i in range(4)]
def flat(c):
    coeff=K(c).lift()
    return sum((enc(coeff[i]) for i in range(3)),[])
parameters=[flat(c) for c in pt]+[[0]*12,[0]*12]
ordinary=matrix(k,[[E[i].monomial_coefficient(x[j]) for j in [2,3]] for i in [2,3]])
even_det=matrix(K,[[e.derivative(v)(*pt) for v in y] for e in even]).det()
assert ordinary.det()!=0 and even_det!=0
result=dict(status='Candidate only; requires direct integral reconstruction',
            field_degree=12,field_modulus=[3,4,1,4,1],
            coefficient_basis='tau^i*lambda^j, i=0..3 fastest, j=0..2',
            extension_polynomial=[enc(p[i]) for i in range(4)],
            parameters=parameters,positive_candidate_jacobian_determinant=flat(even_det),
            odd_ordinary_determinant=enc(ordinary.det()),
            original_candidate_sha256=hashlib.sha256(Path(args.candidate).read_bytes()).hexdigest())
Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
print('PASS candidate over irreducible cubic; both candidate response determinants nonzero')
print(json.dumps(parameters))
