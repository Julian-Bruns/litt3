"""Exhaustive geometric cube test for a degree-ten norm supported over A.

Run with SageMath. A nonzero scalar in the coefficient field is allowed
to acquire a cube root over the algebraic closure; only the MONIC part
is tested. This is not a finite-field point search.
"""
import json
import sys
from pathlib import Path

F5 = GF(5)
R0 = PolynomialRing(F5, 'B')
B = R0.gen()
F25 = F5.extension(B**2-B-3, 'beta')
beta = F25.gen()
def dec(c):
    return F25(c % 5) + F25(c // 5)*beta
R1 = PolynomialRing(F25, 't')
t = R1.gen()
M = R1([dec(c) for c in (5,2,6,7,1)])
assert M.is_irreducible()
K = F25.extension(M, 'alpha')
alpha = K.gen()
R = PolynomialRing(K, 'x')
x = R.gen()
P = R([dec(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
A = R([dec(c) for c in (1,21,14,22,13)])
roots = [alpha**(25**i) for i in range(4)]
assert len(set(roots)) == 4
assert all(A(a) == 0 and P(a) != 0 for a in roots)

def enc(c):
    row = list(K(c).lift())
    row += [F25.zero()]*(4-len(row))
    def small(a):
        r = list(F25(a).polynomial())
        r += [F5.zero()]*(2-len(r))
        return int(r[0]) + 5*int(r[1])
    return [small(a) for a in row]

def monic_cube_test(D):
    if D == 0:
        return True, {"zero": True}
    degree = int(D.degree())
    if degree % 3:
        return False, {"degree": degree, "obstruction": "degree_not_divisible_by_three"}
    E = D.monic()
    m = degree // 3
    root = x**m
    for j in range(m-1,-1,-1):
        root += ((E-root**3)[2*m+j]/3)*x**j
    residual = E-root**3
    data = {"degree":degree, "monic_root":[enc(a) for a in root]}
    if residual:
        j = int(residual.degree())
        data.update({"obstruction":"nonzero_cube_residual", "residual_degree":j,
                     "residual_coefficient":enc(residual[j])})
        return False, data
    data["leading_coefficient"] = enc(D.leading_coefficient())
    return True, data

rows=[]
solutions=[]
for a in range(11):
    for b in range(11-a):
        for c in range(11-a-b):
            weights=(a,b,c,10-a-b-c)
            S=prod((x-r)**m for r,m in zip(roots,weights))
            ok,data=monic_cube_test(S-P)
            data["weights"]=list(weights)
            rows.append(data)
            if ok:
                solutions.append(data)
assert len(rows)==286
result={"scope":"all geometric degree-ten functions a(x)+y with zeros over A",
        "field":"F25[alpha]/(5+2t+6t^2+7t^3+t^4), F25 codes beta^2=beta+3",
        "number_of_compositions":len(rows),"solutions":solutions,"rows":rows}
if len(sys.argv)>1:
    Path(sys.argv[1]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps({k:result[k] for k in ('scope','number_of_compositions','solutions')},indent=2,default=int))
