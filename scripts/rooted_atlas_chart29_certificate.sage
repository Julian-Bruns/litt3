#!/usr/bin/env sage
"""Polynomial (not constant) certificate for rooted first-oper chart29.

This uses the saved exact affine-elimination trail, with no Groebner solve.
"""
import hashlib,json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
folder=Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first/chart-29')
source=root/'Research/computations/canonical_atlas_system.json'
d=json.loads(source.read_text()); meta=json.loads((folder/'metadata.json').read_text())
assert hashlib.sha256(source.read_bytes()).hexdigest()==meta['source_sha256']
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
P=PolynomialRing(k,names=['v%d'%i for i in range(32)]+['b30','b31','w'],order='degrevlex')
v=P.gens()[:32]; b=[P.zero()]*29+[P.one()]+list(P.gens()[32:34])
cache={}
def get(c):
    if c not in cache: cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
def tensor(key,count):
    return [sum((get(d[key][i][r][h])**5*v[i]*b[h] for i in range(32) for h in range(29,32)),P.zero()) for r in range(count)]
n=tensor('N_tensor',64); s=tensor('R_tensor',32)
original=n+s[:29]+[s[29]-1]
loc=dict(zip(P.variable_names(),P.gens())); loc['a']=a
parse=lambda x:P(sage_eval(x,locals=loc))
record=json.loads((folder/'initial_rref.json').read_text())
rows=[parse(f) for f in record['rows']]
C=matrix(k,[[get(c) for c in row] for row in record['row_combinations']])
assert all(sum((cc*f for cc,f in zip(row,original)),P.zero())==g for row,g in zip(C.rows(),rows))
trail=json.loads((folder/'needs_polynomial_certificate.json').read_text())
assert len(trail['steps'])==1
step=trail['steps'][0]; elim={parse(z):parse(g) for z,g in step['substitution'].items()}
sub=P.hom([elim.get(z,z) for z in P.gens()],P)
reduced=[sub(f) for f in rows]
mons=sorted(set(m for f in reduced for m in f.monomials()),key=str)
M=matrix(k,[[f.monomial_coefficient(m) for m in mons] for f in reduced])
target=vector(k,[1 if m==1 else 0 for m in mons])
lam=M.transpose().solve_right(target)
assert M.transpose()*lam==target
f=sum((cc*g for cc,g in zip(lam,rows)),P.zero())
weights=vector(P,lam*C)
for z,g in elim.items():
    equation=z-g; index=rows.index(equation)
    assert f.degree(z)<=1
    quotient=f.derivative(z)
    f-=quotient*equation
    weights-=quotient*vector(P,C.row(index))
assert f==1
assert sum((cc*g for cc,g in zip(weights,original)),P.zero())==1
out={'chart':int(29),'source_sha256':meta['source_sha256'],
     'equation_order':meta['original_low_equation_order'],
     'polynomial_multipliers':[str(f) for f in weights],
     'identity_sum_multipliers_times_original_chart_rows_equals_one_verified':True,
     'max_multiplier_degree':int(max(f.total_degree() for f in weights if f)),
     'certificate_type':'Polynomial ideal certificate, NOT a constant row combination',
     'scope':'Only first-oper rooted chart29; no whole-oper exclusion.'}
(folder/'polynomial_certificate.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({name:value for name,value in out.items() if name!='polynomial_multipliers'},indent=2))
