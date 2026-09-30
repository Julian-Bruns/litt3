#!/usr/bin/env sage-python
"""Verify the explicit RUR, Rabin factors and finite-field late responses.

No multiplication-matrix characteristic polynomial or elimination is used.
Small-orbit responses also have a direct restriction-of-scalars rank check.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector, power_mod, prime_divisors, prod, lcm

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--fields',required=True)
ap.add_argument('--certificate',required=True)
ap.add_argument('--output',required=True)
args=ap.parse_args();start=time.monotonic()
fp=Path(args.fields);cp=Path(args.certificate)
d=json.loads(fp.read_text());cert=json.loads(cp.read_text())
assert d['input_sha256']==hashlib.sha256(cp.read_bytes()).hexdigest()
P=PolynomialRing(GF(5),'t');k=GF(625,'t',modulus=P(cert['field_modulus']))
S=PolynomialRing(k,'s');s=S.gen()
decode=lambda row:S([k(c) for c in row])
h=decode(d['separating_polynomial']);cs=[decode(c) for c in d['coordinates']]
assert h.degree()==375 and h.is_monic() and h.gcd(h.derivative())==1
assert (sum(k(a)*c for a,c in zip(d['separating_linear_form'],cs))-s)%h==0
R=PolynomialRing(k,4,'x');xx=R.gens()
eq=[R({tuple(t['exponents']):k(t['coefficient']) for t in row}) for row in cert['input_equations']]
assert all(e(*cs)%h==0 for e in eq)
factors=[decode(row['factor']) for row in d['orbits']]
assert prod(factors)==h
for f in factors:
    degree=f.degree();value=s
    checks={degree//ell for ell in prime_divisors(degree)}
    for j in range(1,degree+1):
        value=power_mod(value,625,f)
        if j in checks:assert f.gcd(value-s)==1
    assert (value-s)%f==0
print('Complete375-point RUR and all Rabin factors: PASS',flush=True)
J=matrix(R,4,4,lambda i,j:eq[i].derivative(xx[j]) if j<2 else sum(
   k(ex[j]//5)*c*R.monomial(*(ex[a]-(5 if a==j else 0) for a in range(4)))
   for ex,c in eq[i].dict().items() if ex[j]>=5))
A=matrix(k,[[eq[i].derivative(xx[j]) for j in (2,3)] for i in (2,3)])
rows=[]
for row,f in zip(d['orbits'],factors):
    degree=f.degree();L=S.quotient(f,'w');w=L.gen();point=[c(w) for c in cs]
    j=matrix(L,4,4,lambda a,b:J[a,b](*point))
    B=j[2:,2:]-j[2:,:2]*j[:2,:2].inverse()*j[:2,2:]
    M=-B.inverse()*matrix(L,A)
    # Alternative iteration: P_{a+1}=P_a^[5]*M.
    product=matrix.identity(L,2)
    for z in range(4*degree):product=product.apply_map(lambda c:c**5)*M
    dim=2-(product-matrix.identity(L,2)).rank()
    assert dim==row['complete_response_kernel_dimension_F5']
    direct=None
    if degree<=10:
        basis=[L(k.gen()**i)*w**j for j in range(degree) for i in range(4)]
        def flatten(c):
            p=L(c).lift()
            return [int(k(p[j]).polynomial()[i]) for j in range(degree) for i in range(4)]
        columns=[]
        for j in range(2):
            for b in basis:
                v=vector(L,[b if i==j else 0 for i in range(2)])
                out=matrix(L,A)*v+B*v.apply_map(lambda c:c**5)
                columns.append(flatten(out[0])+flatten(out[1]))
        small=matrix(GF(5),columns).transpose()
        direct=small.ncols()-small.rank();assert direct==dim
    rows.append({'degree':int(degree),'kernel_dimension':int(dim),
                 'direct_scalar_check':direct is not None})
    print('Degree',degree,'kernel',dim,'direct scalar:',direct is not None,flush=True)
good=sum(r['degree'] for r in rows if r['kernel_dimension']==0)
common=int(lcm(r['degree'] for r in rows if r['kernel_dimension']==0))
assert good==169 and common==114
out={'status':'PASS complete residue census and169 bijective arithmetic branches',
    'field_receipt_sha256':hashlib.sha256(fp.read_bytes()).hexdigest(),
    'certificate_sha256':hashlib.sha256(cp.read_bytes()).hexdigest(),
    'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'orbits':rows,'good_geometric_roots':good,'unresolved_arithmetic_roots':375-good,
    'common_tower_field_degree_over_F5':4*common,
    'seconds':time.monotonic()-start,
    'scope':'Explicit RUR and Rabin verification without elimination; low-degree scalar ranks independently test the monodromy criterion. Nonbijective branches are not claimed arithmetically ineffective.'}
Path(args.output).write_text(json.dumps(out,indent=2)+'\n')
print(out['status'],'seconds:',out['seconds'],flush=True)
