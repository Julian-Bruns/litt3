#!/usr/bin/env sage
"""NEW bounded symbolic first Hermitian/Cartier gate; no endpoint replay.

Only interpolation and ten 3x3 determinants over F5(a), no Groebner basis.
The variables in Vtwist are fifth powers of the actual V coefficients.
"""
import json
from itertools import combinations
from pathlib import Path
R = PolynomialRing(GF(5), 'a')
a = R.gen()
K = R.fraction_field()
a = K(a)
q = 4/a**3
S = PolynomialRing(K, 'w')
w = S.gen()
phi = w**5 + q*w**4 + 4*w + 4*q
b = w-a
d = phi + b*phi.derivative()/2
p = phi*b**3
assert p[4] == 0
h = sum(p[i]/GF(5)(i+1)*w**(i+1) for i in range(p.degree()+1) if p[i])
assert h.derivative() == p
def twist(f):
    return sum(f[i]**5*w**i for i in range(f.degree()+1))
qt = twist(phi**2*b**4)
st = twist(phi*b)
dt = twist(d**5)
pt = twist(p)
xs = [K(i) for i in range(1,5)] + [-q,a]
zs = [x**5 for x in xs]
assert len(set(zs)) == 6
iv = S.zero()
for i,(x,z) in enumerate(zip(xs,zs)):
    li = prod((w-u)/(z-u) for j,u in enumerate(zs) if j != i)
    iv += 2*h(x)*d(x)**5*li
assert all(iv(x**5)==2*h(x)*d(x)**5 for x in xs)
assert st == prod(w-z for z in zs)
def interpolant(alpha):
    # T0 is initially ZERO; it remains the only interpolation freedom.
    v=iv
    rr=alpha*dt+qt*v
    for j in range(25,20,-1):
        u=-rr[j]
        v += u*st*w**(j-20)
        rr=alpha*dt+qt*v
        assert rr[j] == 0
    assert rr.degree() <= 20
    assert all(v(x**5)==2*h(x)*d(x)**5 for x in xs)
    return rr
r0=interpolant(K(0))
r1=interpolant(K(1))
rt=qt*st
indices=[4,9,14,19,24]
columns=[[ (rr*pt)[j] for j in indices] for rr in [r0,r1-r0,rt]]
mat=matrix(K,5,3,lambda i,j: columns[j][i])
minors=[]
for rows in combinations(range(5),3):
    mm=mat.matrix_from_rows(rows)
    det=mm.det()
    direct=(mm[0,0]*(mm[1,1]*mm[2,2]-mm[1,2]*mm[2,1])
           -mm[0,1]*(mm[1,0]*mm[2,2]-mm[1,2]*mm[2,0])
           +mm[0,2]*(mm[1,0]*mm[2,1]-mm[1,1]*mm[2,0]))
    assert det==direct
    if det: minors.append((rows,R(det.numerator()),R(det.denominator())))
assert minors
g=R.zero()
for _,num,_ in minors: g=g.gcd(num)
g=g.monic()
assert g==(R.gen()**4-1)**11
# All poles of the rational formulas are excluded by a!=0,q notin F5.
support=R.gen()*(R.gen()**12-1)
for _,num,den in minors:
    rest=den
    while rest.degree()>0:
        common=rest.gcd(support)
        assert common.degree()>0
        rest=rest//common
# Exact Bezout lifts of the common numerator gcd, checked directly.
bez=[]
gg=R.zero()
for _,num,_ in minors:
    new,s,t=gg.xgcd(num)
    bez=[s*z for z in bez]+[t]
    gg=new
bez=[z/gg.leading_coefficient() for z in bez]
assert sum(z*num for z,(_,num,_) in zip(bez,minors))==g
metadata={
    'nonzero_minor_count':len(minors),
    'largest_numerator_degree':int(max(num.degree() for _,num,_ in minors)),
    'largest_denominator_degree':int(max(den.degree() for _,num,den in minors)),
    'minor_numerator_gcd':str(g),
    'gcd_factorization':str(g.factor()),
    'matrix_rank_over_F5a':int(mat.rank()),
}
def coefficients(f): return [int(x) for x in f.list()]
receipt={"metadata":metadata,"minors":[{
    "rows":list(rows),"numerator":coefficients(num),"denominator":coefficients(den),
    "bezout_coefficient":coefficients(z)
} for z,(rows,num,den) in zip(bez,minors)]}
target=Path(__file__).resolve().parents[3]/'litt3-computation-data'/'oct03_fixed_pure_odd_cartier'
target.mkdir(parents=True,exist_ok=True)
(target/'first_tier_minors.json').write_text(json.dumps(receipt,sort_keys=True))
print(json.dumps(metadata,sort_keys=True))
