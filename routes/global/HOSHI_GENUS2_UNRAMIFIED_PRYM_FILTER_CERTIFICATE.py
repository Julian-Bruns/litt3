"""All fifteen unramified-double-cover elliptic-Prym filters; exact Sage.

Run: sage -python HOSHI_GENUS2_UNRAMIFIED_PRYM_FILTER_CERTIFICATE.py
No genus-six twists are constructed or analyzed here.
"""

from itertools import combinations
from sage.all import GF, PolynomialRing, prod

R0 = PolynomialRing(GF(5),"T")
T = R0.gen()
k = GF(25,name="r",modulus=T**2+2)
r = k.gen()
assert r**2 == 3 and r**5 == -r
R = PolynomialRing(k,"t")
t = R.gen()
F = 2*t**6+2*t**4+3*t**2+4
roots = [4*r,3*r+4,3*r+1,2*r+4,2*r+1,r]
assert len(set(roots)) == 6
assert F == 2*prod(t-a for a in roots)
survivors = []
for i,j in combinations(range(6),2):
    pair = (t-roots[i])*(t-roots[j])
    quartic = prod(t-roots[e] for e in range(6) if e not in [i,j])
    assert pair*quartic == F/2
    assert quartic.is_squarefree()
    hasse = (quartic**2)[4]
    p_rank_Bprime = 1+int(hasse != 0)
    print("pair indices",(i,j),"pair polynomial",pair,
          "elliptic Hasse scalar",hasse,"p-rank Bprime",p_rank_Bprime)
    if hasse == 0:
        survivors.append((i,j,pair,quartic))
assert [(i,j) for i,j,pair,quartic in survivors] == [(1,2),(3,4)]
assert set(pair for i,j,pair,quartic in survivors) == {
    t**2+r*t+1,t**2-r*t+1}
qplus = t**2+r*t+1
quartic_plus = t**4-r*t**3+3*t**2+3*r*t+2
assert qplus*quartic_plus == F/2
assert (quartic_plus**2)[4] == 0
print("PASS: exactly two supersingular-Prym classes, t^2 +/- r*t + 1.")
print("These classes are exchanged by Frobenius r -> -r.")
