"""Geometric classification of degree-twelve functions supported over A.

A function of exact pole degree twelve is a monic quartic a(x)+b*y
after constant scaling. Its norm is a(x)^3+c*P(x), c=b^3. The roots
of P are disjoint from A. Enumerate support multiplicities, not field
values of c, and compute the polynomial ideal of the cube condition.
"""
import json
import sys
from pathlib import Path
F5=GF(5)
R0=PolynomialRing(F5,'B'); B=R0.gen()
F25=F5.extension(B**2-B-3,'beta'); beta=F25.gen()
def dec(a): return F25(a%5)+F25(a//5)*beta
R1=PolynomialRing(F25,'t'); t=R1.gen()
M=R1([dec(a) for a in (5,2,6,7,1)])
assert M.is_irreducible()
K=F25.extension(M,'alpha'); alpha=K.gen()
C=PolynomialRing(K,'c'); c=C.gen()
R=PolynomialRing(C,'x'); x=R.gen()
P=R([dec(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
A=R([dec(a) for a in (1,21,14,22,13)])
roots=[alpha**(25**i) for i in range(4)]
assert len(set(roots))==4 and all(A(r)==0 and P(r)!=0 for r in roots)
def enc(a):
    vals=list(K(a).lift()); vals+=[F25.zero()]*(4-len(vals))
    ans=[]
    for v in vals:
        row=list(F25(v).polynomial());row+=[F5.zero()]*(2-len(row))
        ans.append(int(row[0])+5*int(row[1]))
    return ans
rows=[]; exceptions=[]; rational=0
for a in range(13):
    for b in range(13-a):
        for d in range(13-a-b):
            weights=(a,b,d,12-a-b-d)
            S=prod((x-r)**m for r,m in zip(roots,weights))
            target=S-c*P
            root=x**4
            for j in range(3,-1,-1):
                root+=((target-root**3)[8+j]/3)*x**j
            residual=target-root**3
            coefficients=[C(v) for v in residual]
            common=C.zero()
            multipliers=[]
            for v in coefficients:
                common,u,w=common.xgcd(v)
                multipliers=[u*a for a in multipliers]+[w]
            assert common
            scale=common.leading_coefficient()
            common/=scale
            multipliers=[a/scale for a in multipliers]
            assert sum(a*b for a,b in zip(multipliers,coefficients))==common
            # All geometric c roots are c=0 exactly when the gcd is c^r.
            r=int(common.valuation(c))
            reduced=common//c**r
            row={'weights':list(weights),'gcd':[enc(v) for v in common],
                 'degree':int(common.degree()),'zero_root_multiplicity':r,
                 'root':[[enc(v) for v in C(a)] for a in root],
                 'residual':[[enc(v) for v in a] for a in coefficients],
                 'bezout':[[enc(v) for v in a] for a in multipliers]}
            rows.append(row)
            if reduced.degree()>0: exceptions.append(row)
            if r:rational+=1
assert len(rows)==455
result={'scope':'geometric pole-degree-twelve functions with zeros over A',
        'number_of_compositions':455,'nonzero_c_patterns':exceptions,
        'zero_c_patterns':rational,'rows':rows}
if len(sys.argv)>1:
    Path(sys.argv[1]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps({k:result[k] for k in ('scope','number_of_compositions',
                  'nonzero_c_patterns','zero_c_patterns')},indent=2,default=int))
