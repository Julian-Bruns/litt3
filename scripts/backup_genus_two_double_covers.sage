#!/usr/bin/env sage
"""Exact ordinarity of all fifteen connected etale double covers of C_alpha.

For each branch pair, sqrt(A),sqrt(B) gives a Klein-four cover of P1,
with F=A*B and C: v^2=F. Its other quotients have genera0 and1.
The sum of quotient pullbacks is an isogeny of power-of-two degree;
hence this actual genus-three etale double cover is ordinary iff both
C and the elliptic quotient y^2=B are ordinary. Infinity is included.
"""
import itertools
import json
from pathlib import Path

k=GF(125,name='a',modulus=PolynomialRing(GF(5),'z')([1,1,0,1]));a=k.gen()
R=PolynomialRing(k,'u');u=R.gen()
F=u*(u-1)*(u-2)*(u-3)*(u-a)
branches=[k(0),k(1),k(2),k(3),a,None]
encode=lambda c:[int(v) for v in k(c).polynomial().list()]
polynomial=lambda f:[encode(c) for c in f.list()]
rows=[]
for indices in itertools.combinations(range(6),int(2)):
    A=prod(u-branches[i] for i in indices if branches[i] is not None)
    B=F//A
    assert A*B==F and A.degree() in [1,2] and B.degree() in [3,4]
    assert A.is_squarefree() and B.is_squarefree() and A.gcd(B)==1
    hasse=(B**2)[4]
    assert hasse
    rows.append({'branch_pair_indices':list(indices),
                 'A_coefficients':polynomial(A),'elliptic_B_coefficients':polynomial(B),
                 'elliptic_Hasse_invariant':encode(hasse),'etale_double_cover_ordinary':True})
assert len(rows)==15
out={'status':'all15 connected geometric etale double covers are ordinary; author computation',
     'field_modulus':[1,1,0,1],
     'branch_points':[None if b is None else encode(b) for b in branches],
     'infinity_index':5,'covers':rows,
     'proof_scope':'Actual genus-three double covers of the backup C only; no arbitrary etale-cover ordinarity claim.'}
target=Path(__file__).resolve().parents[1]/'Research/computations/backup_genus_two_double_covers.json'
target.write_text(json.dumps(out,indent=1,default=int)+'\n')
print(json.dumps({'output':str(target),'ordinary_double_covers':15},indent=1,default=int),flush=True)
