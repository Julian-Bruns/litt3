"""Necessary integral norm remainders in the all-finite-support branch.

Assumes the proved reductions h_*E is cubic-invariant, Norm(T)=0,
and n<=9. Exhausts the integer occupancy patterns, not field-valued
unknowns. A surviving remainder is not an actual etale cover.
"""
import itertools
import json
import sys
import time
from pathlib import Path
start=time.monotonic()
n=int(sys.argv[1]) if len(sys.argv)>1 else 5
assert 4<=n<=9
F=GF(5**8,'g',impl='pari_ffelt'); R=PolynomialRing(F,'x'); x=R.gen()
beta=(x**2-x-3).roots(multiplicities=False)[0]
def dec(a):return F(a%5)+F(a//5)*beta
P=R([dec(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
A=R([dec(a) for a in (1,21,14,22,13)])
Q=R([dec(a) for a in (0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24)])
alpha=A.roots(multiplicities=False)[0]
roots=[alpha**(25**i) for i in range(4)]
L=R.fraction_field(); W=PolynomialRing(L,'w'); w=W.gen()
mod=w**5-x
Z=-sum(a**(5**7)*w**i for i,a in enumerate(Q))%mod
assert Z**5%mod==-L(Q)
change=matrix(L,[[((Z**j)%mod)[i] for j in range(5)] for i in range(5)])
inverse=change.inverse()
assert change*inverse==identity_matrix(L,5)
print('prepared change of p-basis',time.monotonic()-start,flush=True)
rows=[]; survivors=[]; total=0
for eO in range(n+1):
    if (5*n-eO)%3:continue
    S=(5*n-eO)//3
    for m in itertools.product(range(1,n+1),repeat=4):
        if sum(m)!=S:continue
        if m!=min(m[i:]+m[:i] for i in range(4)):continue
        total+=1
        star=prod((w-r**(5**7))**(3*v) for r,v in zip(roots,m))%mod
        v=inverse*vector(L,[star[i] for i in range(5)])
        assert sum(v[j]*(Z**j%mod) for j in range(5))%mod==star
        violations=[]
        for j,r in enumerate(v):
            if not r:continue
            den=R(r.denominator());num=R(r.numerator())
            if P**(n//3)%den:
                violations.append((j,'finite_denominator',str(den.gcd(A))))
            losses=[3*a+max(0,eO-j-5*a) for a in range((n-j)//5+1)]
            infinity_bound=n-4*j-ceil(min(losses)/3)
            if num.degree()-den.degree()>infinity_bound:
                violations.append((j,'infinity_degree',int(num.degree()-den.degree())))
        row={'infinity_occupancy':eO,'fiber_occupancies':list(m),
             'violations':violations}
        rows.append(row)
        if not violations:survivors.append(row)
result={'n':n,'orbit_count':total,'surviving_orbits':survivors,'cases':rows,
        'seconds':time.monotonic()-start,'scope':'necessary norm remainder integrality and pole bounds only',
        'field_modulus':str(F.modulus()),'beta':str(beta),'alpha':str(alpha)}
if len(sys.argv)>2:Path(sys.argv[2]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('cases','field_modulus','beta','alpha')},indent=2,default=int),flush=True)
