"""Exhaust degree-n projected divisors B satisfying 2B ~ 2nO.

This enumerates bounded integer multiplicities at the 13 fixed points,
not coefficient-field points. Every section kernel is computed over the
full field of definition of those points, hence also over its algebraic
closure. Arithmetic Frobenius rotations reduce the divisor enumeration.
"""
import itertools
import json
import sys
import time
from pathlib import Path

n=int(sys.argv[1]) if len(sys.argv)>1 else 11
limit=int(sys.argv[3]) if len(sys.argv)>3 else 0
started=time.monotonic()
k=GF(5**24,'g',impl='pari_ffelt')
R=PolynomialRing(k,'x'); x=R.gen()
beta=(x**2-x-3).roots(multiplicities=False)[0]
def dec(c):return k(c%5)+k(c//5)*beta
P=R([dec(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
A=R([dec(c) for c in (1,21,14,22,13)])
alpha=A.roots(multiplicities=False)[0]
y0=(x**3-P(alpha)).roots(multiplicities=False)[0]
points=[(alpha**(25**i),y0**(25**i)) for i in range(12)]
assert len(set(points))==12
assert all(A(a)==0 and b**3==P(a) for a,b in points)
bound=n//5
assert bound==2, 'This run specializes to occupancy bound two.'

# Hasse Taylor coefficients at every marked finite point.
PS=PowerSeriesRing(k,'z',default_prec=4); z=PS.gen()
series=[]
for a,b in points:
    yy=PS(b)
    target=PS(P(a+z))
    for j in range(1,4):
        yy+=((target-yy**3)[j]/(3*b**2))*z**j
    assert (yy**3-target).valuation()>=4
    series.append((a+z,yy))

def canonical(w):
    return w==min(w[j:]+w[:j] for j in range(12))

rows=[]; cases=[]; actual=0; tested=0; total_orbits=0
for bO in range(3):
    d=2*(n-bO)
    basis=[(i,j) for j in range(3) for i in range(d//3+1) if 3*i+10*j<=d]
    jets=[]
    for xx,yy in series:
        vals=[xx**i*yy**j for i,j in basis]
        jets.append([[v[t] for v in vals] for t in range(4)])
    for w0 in itertools.product(range(3),repeat=12):
        if sum(w0)!=n-bO or min(w0)!=0:continue
        if sum(v>0 for v in w0)+(bO>0)<7:continue
        w=tuple(w0)
        if not canonical(w):continue
        total_orbits+=1
        if limit and tested>=limit:continue
        tested+=1
        conditions=[]
        for i,m in enumerate(w):conditions+=jets[i][:2*m]
        mat=matrix(k,conditions)
        rank=mat.rank()
        cases.append([bO,list(w),int(rank),len(basis)])
        if rank<len(basis):
            ker=mat.right_kernel()
            assert ker.dimension()==1
            v=ker.basis()[0]
            polynomial=all(v[t]==0 for t,ij in enumerate(basis) if ij[1]>0)
            orbit=len(set(w[j:]+w[:j] for j in range(12)))
            actual+=orbit
            rows.append({'infinity_weight':bO,'weights':list(w),'orbit_size':orbit,
                         'polynomial_in_x':bool(polynomial)})
        if tested%1000==0:
            print('tested',tested,'surviving_orbits',len(rows),'seconds',round(time.monotonic()-started,2),flush=True)
result={'n':n,'complete':not limit or tested==total_orbits,'tested_orbits':tested,
        'total_orbits':total_orbits,'surviving_divisors':actual,'surviving_orbits':rows,
        'cases':cases,
        'seconds':time.monotonic()-started,'field_modulus':str(k.modulus()),
        'field_generator':str(k.gen()),'beta':str(beta),'alpha':str(alpha),'y0':str(y0)}
if len(sys.argv)>2:Path(sys.argv[2]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps({a:b for a,b in result.items() if a!='cases'},indent=2,default=int),flush=True)
