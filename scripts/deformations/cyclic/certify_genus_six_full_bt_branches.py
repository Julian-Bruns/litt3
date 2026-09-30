#!/usr/bin/env sage-python
"""Exact three-branch and common-field check for the genus-six full repair.

Uses the already certified whole fourth map and fixed primary kernel.
It does not replace the integral effectivity or late-response theorem.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--data',required=True)
ap.add_argument('--output',required=True)
args=ap.parse_args();data=Path(args.data)
paths=[data/n for n in ['exceptional_dihedral5_certificate.json',
       'exceptional_dihedral5_cubic_point.json','exceptional_dihedral5_model.json']]
cert,cfg,model=[json.loads(p.read_text()) for p in paths]
assert cert['status'].startswith('PASS exact fourth calibration')
P=PolynomialRing(GF(5),'t')
k=GF(625,'t',modulus=P([3,4,1,4,1]))
R=PolynomialRing(k,4,'x');x=R.gens()
E=[R({tuple(c['exponents']):k(c['coefficient']) for c in row}) for row in cert['polynomials']]
Q=PolynomialRing(k,'l');modulus=Q([k(c) for c in cfg['extension_polynomial']])
assert modulus.is_irreducible() and modulus.degree()==3
K=Q.quotient(modulus,'l');l=K.gen()
y0=[sum(K(k(row[4*j:4*j+4]))*l**j for j in range(3)) for row in cfg['parameters']]
kernel=matrix(K,[[k(c) for c in row] for row in model['kernel_basis']]).transpose()
primary=matrix(K,[[k(c) for c in row] for row in model['hodge_matrix']])
assert kernel.rank()==4 and primary.rank()==11
assert primary*kernel.apply_map(lambda c:c**5)==0
Y=PolynomialRing(k,2,'y');ys=Y.gens()
even=[Y({tuple(v//5 for v in ex[:2]):c for ex,c in e.dict().items()
         if ex[2]==ex[3]==0}) for e in E[:2]]
A=matrix(K,[[e.monomial_coefficient(x[j]) for j in (2,3)] for e in E[2:]])
assert A.det()!=0
enc=lambda c:[int(K(c).lift()[j].polynomial()[i]) for j in range(3) for i in range(4)]
basis=[K(k.gen()**i)*l**j for j in range(3) for i in range(4)]
rows=[];points=[]
for orbit in range(3):
    y=[c**(625**orbit) for c in y0]
    pt=vector(K,[c**(5**11) for c in y])
    assert all(a**5==b for a,b in zip(pt,y))
    assert all(e(*pt)==0 for e in E)
    jac=matrix(K,[[e.derivative(v)(*y[:2]) for v in ys] for e in even])
    assert jac.det()!=0
    B=matrix(K,2,2,lambda i,j:sum(K(c)*pt[0]**ex[0]*pt[1]**ex[1]
                  for ex,c in E[i+2].dict().items()
                  if ex[j+2]==5 and ex[5-(j+2)]==0))
    columns=[]
    for n in range(24):
        v=vector(K,[basis[n%12] if n//12==i else 0 for i in range(2)])
        out=A*v+B*v.apply_map(lambda c:c**5)
        columns.append(enc(out[0])+enc(out[1]))
    M=matrix(GF(5),columns).transpose()
    assert M.rank()==24 and M.det()==1
    inverse=M.inverse()
    assert M*inverse==inverse*M==matrix.identity(GF(5),24)
    points.append(pt)
    rows.append({'orbit_index':orbit,'fifth_power_parameters':[enc(c) for c in y],
                 'actual_parameters':[enc(c) for c in pt],
                 'positive_jacobian_determinant':enc(jac.det()),
                 'negative_response_rank':24,'negative_response_determinant':1})
differences=[]
for i in range(3):
    for j in range(i+1,3):
        d=kernel*(points[j]-points[i])
        assert d!=0 and primary*d.apply_map(lambda c:c**5)==0
        differences.append({'i':i,'j':j,'source_cohomology_difference':[enc(c) for c in d]})
assert vector(K,y0)==vector(K,[c**(625**3) for c in y0])
rank=matrix(K,[kernel*(points[j]-points[0]) for j in (1,2)]).rank()
out={'status':'PASS three distinct actual third classes and fixed-field full responses',
     'input_hashes':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'field_degree':12,'branches':rows,'pairwise_differences':differences,
     'difference_rank':int(rank),
     'scope':'Three conjugate whole fourth zeros with distinct preceding source classes. Existing audited late-response and actual BT/Hodge dictionary supply full groups; this check alone is not an effectivity theorem.'}
Path(args.output).write_text(json.dumps(out,indent=2)+'\n')
print(out['status']);print('Difference rank:',rank,'; all three negative determinants:1')
