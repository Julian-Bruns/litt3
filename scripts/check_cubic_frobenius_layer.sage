"""Actual first ramified Frobenius layer via Arul's cubic Kummer formula.
Derivation independently audited2026-09-07; a matrix rank is not a cover exclusion.
"""
from pathlib import Path
import json, re
root=Path(__file__).resolve().parents[1]
source=(root/'routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage').read_text()
k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
R=PolynomialRing(k,'x');x=R.gen()
match=re.search(r'\bfX = \((.*?)\n\)',source,re.S)
F=R(sage_eval('('+match.group(1)+')',locals={'x':x,'a':a}))
factor=next(f for f,e in F.factor() if f.degree()==4)
K=k.extension(factor,'b');Q=K.cardinality()
roots=F.change_ring(K).roots(multiplicities=False)
assert len(roots)==10 and Q==25**4
zeta=K(k.multiplicative_generator()**8)
assert zeta!=1 and zeta**3==1
lookup={zeta**j:GF(3)(j) for j in range(3)}
columns=[]
for i in range(10):
    tt=[GF(3).zero()]*10
    for j in range(10):
        if j!=i:
            tt[j]=lookup[(roots[i]-roots[j])**((Q-1)//3)]
    tt[i]=-sum(tt)
    columns.append(vector(GF(3),[tt[j]-tt[9] for j in range(9)]))
U=matrix(GF(3),columns[:9]).transpose()
assert sum(columns)==0
V=U**2-identity_matrix(GF(3),9)
print(json.dumps(dict(status='EXACT_FIRST_LAYER_MATRIX',q=int(Q),
    U=[[int(c) for c in row] for row in U.rows()],
    characteristic_polynomial=[int(c) for c in U.charpoly().list()],
    rank_U=int(U.rank()),nullity_U=9-int(U.rank()),
    nullity_V=9-int(V.rank()),
    generalized_one_nullities=[9-int((V**j).rank()) for j in range(1,5)],
    scope='Audited Kummer formula; certifies the Smith refinement, not a cover exclusion.'),default=int))
