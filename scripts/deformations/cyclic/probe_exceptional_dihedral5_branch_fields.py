#!/usr/bin/env sage-python
"""Residue fields and complete-response injectivity at all375 fourth roots."""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--certificate',required=True)
ap.add_argument('--output',required=True)
args=ap.parse_args();path=Path(args.certificate)
doc=json.loads(path.read_text());start=time.monotonic()
P=PolynomialRing(GF(5),'t');k=GF(625,'t',modulus=P(doc['field_modulus']))
R=PolynomialRing(k,names=('u0','u1','v0','v1'),order='degrevlex')
decode=lambda rows:R({tuple(t['exponents']):k(t['coefficient']) for t in rows})
eq=[decode(p) for p in doc['input_equations']]
gb=[decode(p) for p in doc['groebner_basis']]
basis=[decode(p) for p in doc['standard_monomials']]
index={b.exponents()[0]:i for i,b in enumerate(basis)};n=len(basis)
def col(p):
    v=vector(k,n)
    for ex,c in R(p).reduce(gb).dict().items():v[index[ex]]=c
    return v
s=sum(k.gen()**j*x for j,x in enumerate(R.gens()))
M=matrix(k,[col(s*b) for b in basis]).transpose()
print('Multiplication matrix constructed',n,flush=True)
h=M.charpoly('s')
assert h.degree()==375 and h.is_squarefree()
factors=list(h.factor());print('Residue degrees:',[(f.degree(),e) for f,e in factors],flush=True)
v=col(1);cols=[]
for j in range(n):
    cols.append(v);v=M*v
Krylov=matrix(k,cols).transpose()
coordinate_coefficients=Krylov.solve_right(matrix(k,[col(x) for x in R.gens()]).transpose())
S=h.parent();coords=[S(list(coordinate_coefficients.column(i))) for i in range(4)]
assert (sum(k.gen()**j*c for j,c in enumerate(coords))-S.gen())%h==0
assert all(e(*coords)%h==0 for e in eq)
print('Complete separating coordinates verified',flush=True)
Jplus=matrix(R,[[eq[i].derivative(R.gen(j)) for j in range(2)] for i in range(2)])
A=matrix(k,[[eq[i].derivative(R.gen(j)) for j in range(2,4)] for i in range(2,4)])
J=matrix(R,4,4,lambda i,j:eq[i].derivative(R.gen(j)) if j<2 else sum(
    k(ex[j]//5)*c*R.monomial(*(ex[a]-(5 if a==j else 0) for a in range(4)))
    for ex,c in eq[i].dict().items() if ex[j]>=5))
enc=lambda c:[int(k(c).polynomial()[i]) for i in range(4)]
encode_poly=lambda p:[enc(c) for c in p.list()]
rows=[]
for f,multiplicity in factors:
    assert multiplicity==1 and f.is_irreducible()
    d=f.degree();L=S.quotient(f,'w');w=L.gen()
    point=[c(w) for c in coords]
    assert all(e(*point)==0 for e in eq)
    jl=matrix(L,4,4,lambda i,j:J[i,j](*point))
    pp=jl[:2,:2];pn=jl[:2,2:];np=jl[2:,:2];nn=jl[2:,2:]
    schur=nn-np*pp.inverse()*pn
    assert schur.det()!=0
    # v^5=M0*v. Iterating4d times gives v=P*v, and cyclic descent
    # on this fixed subspace recovers the F5-kernel dimension.
    M0=-schur.inverse()*matrix(L,A)
    product=matrix.identity(L,2);twist=M0
    for a in range(4*d):
        product=twist*product
        twist=twist.apply_map(lambda c:c**5)
    kernel_dim=2-(product-matrix.identity(L,2)).rank()
    row={'degree_over_F625':int(d),'factor':encode_poly(f),
         'complete_response_kernel_dimension_F5':int(kernel_dim),
         'complete_response_bijective_over_residue_field':kernel_dim==0}
    rows.append(row);print('Orbit degree',d,'kernel dimension',kernel_dim,flush=True)
out={'status':'PASS complete fourth residue fields and finite-field response test',
     'input_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'separating_linear_form':[enc(k.gen()**i) for i in range(4)],
     'separating_polynomial':encode_poly(h),
     'coordinates':[encode_poly(c) for c in coords],
     'orbits':rows,'total_geometric_points':sum(r['degree_over_F625'] for r in rows),
     'seconds':time.monotonic()-start}
Path(args.output).write_text(json.dumps(out,indent=2)+'\n')
print(out['status'],'seconds:',out['seconds'],flush=True)
