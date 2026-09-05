"""Complete geometric dormant-connection test on the single genus-six twist.

Run with sage -python. Extension-field matrix routines are never used.
The only optimized matrix is over the prime field F5, and every resulting
kernel vector is directly checked in F_(5^120). The field modulus is fixed.
"""

from itertools import product
from time import monotonic
from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix
import HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE as small

start = monotonic()
small_identity = [[small.k(i == j) for j in range(4)] for i in range(4)]
small_N = small.scalar_product(small.M,[[c**5 for c in row] for row in small.M])

def scalar_matrix_power(a,n):
    result = small_identity
    while n:
        if n % 2:
            result = small.scalar_product(result,a)
        a = small.scalar_product(a,a)
        n //= 2
    return result

assert scalar_matrix_power(small_N,60) == small_identity
assert all(scalar_matrix_power(small_N,n) != small_identity for n in [30,20,12])
prime = GF(5)
R0 = PolynomialRing(prime,"s")
modulus_coefficients = [
    4,1,1,3,0,4,0,1,4,2,0,1,0,1,0,0,1,2,1,4,3,3,2,2,2,4,0,0,1,3,
    4,1,3,4,2,3,3,4,4,3,4,0,1,0,0,4,4,3,1,0,4,3,4,2,0,3,2,0,4,4,
    2,3,1,1,3,1,3,2,3,1,2,4,4,1,0,3,0,3,0,4,0,0,2,1,0,4,2,3,0,0,
    2,0,1,4,4,2,1,2,0,4,0,1,3,1,0,1,0,2,1,3,3,2,0,2,2,4,3,4,0,1,1,
]
modulus = R0(modulus_coefficients)
assert modulus.degree() == 120 and modulus.is_irreducible()
K = GF(5**120,name="s",modulus=modulus)
s = K.gen()
embedding_coefficients = [
    1,4,4,4,1,4,4,3,4,4,4,0,2,2,1,0,2,1,3,4,2,0,0,2,2,2,2,0,0,0,
    1,1,2,4,3,4,4,2,2,4,3,4,4,3,0,1,2,0,4,3,1,2,1,4,0,0,4,1,0,1,
    3,2,1,0,0,4,4,1,3,1,4,1,1,2,1,1,3,0,4,2,3,4,4,0,1,1,3,3,2,4,
    3,3,0,0,4,4,3,1,4,4,0,4,4,1,4,3,4,2,1,4,1,0,2,0,3,1,0,4,1,2,
]
r = K(R0(embedding_coefficients))
assert r**2 == 3 and r**5 == -r
print("FIELD constructed; seconds",monotonic()-start,flush=True)
print("Embedding r coefficients:",list(r.polynomial()),flush=True)

def embed(c):
    p = small.k(c).polynomial()
    return sum((K(p[i])*r**i for i in range(p.degree()+1)),K(0))

M = [[embed(c) for c in row] for row in small.M]
M5 = [[c**5 for c in row] for row in M]
powers = [s**i for i in range(120)]

def coordinates(c):
    result = list(c.polynomial())
    return result+[prime(0)]*(120-len(result))

# x^5 = M^(5) x, expanded into 480 linear equations over F5.
columns = []
for j in range(4):
    for power in powers:
        values = [-M5[i][j]*power for i in range(4)]
        values[j] += power**5
        columns.append(sum((coordinates(c) for c in values),[]))
prime_matrix = matrix(prime,columns).transpose()
kernel = prime_matrix.right_kernel()
assert kernel.dimension() == 4
fixed = []
for row in kernel.basis():
    x = [sum((K(row[120*j+i])*powers[i] for i in range(120)),K(0))
         for j in range(4)]
    assert all(x[i]**5 == sum((M5[i][j]*x[j] for j in range(4)),K(0))
               for i in range(4))
    # Also verify direct coordinate reconstruction of the prime-field row.
    assert sum((coordinates(c) for c in x),[]) == list(row)
    fixed.append(x)
assert len(fixed) == 4
assert small.scalar_rank([list(row) for row in kernel.basis()]) == 4
print("KERNEL dimension four; all four geometric fixed vectors directly verified;",
      "seconds",monotonic()-start,flush=True)

# One explicit ordinary affine point, away from every denominator used.
# t0=1, v0=1, h0=2+2r; q(1)e(1)=1+3r=(2+2r)^2.
S = PowerSeriesRing(K,"epsilon",default_prec=5)
epsilon = S.gen()
tt = 1+epsilon
FF = 2*tt**6+2*tt**4+3*tt**2+4
AA = 2*tt**8+4*tt**6+2
BB = tt**2+4
qq = tt**2+r*tt+1
vv = S(1)
for unused in range(3):
    vv = (vv+FF/vv)/2
ee = AA+BB*vv
hh = S(2+2*r)
for unused in range(3):
    hh = (hh+qq*ee/hh)/2
assert vv**2 == FF and hh**2 == qq*ee
assert vv[0] != 0 and hh[0] != 0 and qq[0] != 0 and ee[0] != 0

def evaluate_polynomial(poly):
    return sum((embed(poly[i])*tt**i for i in range(poly.degree()+1)),S(0))

anti_series = []
for c in small.basis:
    a,b = small.polynomial_pair(c)
    anti_series.append((evaluate_polynomial(a)+evaluate_polynomial(b)*vv)/(vv*hh))
fixed_series = [sum((x[j]*anti_series[j] for j in range(4)),S(0))
                for x in fixed]
# The invariant Cartier-fixed form from B is t dt/v.
fixed_series.append(tt/vv)
assert len(fixed_series) == 5

# A globally regular dormant origin is the connection declaring
# xi=q^3 dt/(v h) horizontal; its 5-divisor is justified in the note.
unit = qq**3/(vv*hh)
origin = -unit.derivative()/unit

def derivative_jets(series):
    return [series[0],series[1],2*series[2],6*series[3]]

origin_jets = derivative_jets(origin)
form_jets = [derivative_jets(g) for g in fixed_series]
scaled = [[[K(c)*x for x in jets] for c in range(5)] for jets in form_jets]

def P4(jets):
    a,da,d2a,d3a = jets
    return a**4-a**2*da+3*da**2+4*a*d2a-d3a

survivors = []
checked = 0
for c in product(range(5),repeat=5):
    jets = [origin_jets[j]+sum((scaled[i][c[i]][j] for i in range(5)),K(0))
            for j in range(4)]
    if P4(jets) == 0:
        survivors.append(c)
    checked += 1
assert checked == 3125
print("ALL 3125 dormant connections tested at the explicit ordinary point.",flush=True)
print("SURVIVORS",len(survivors),survivors,flush=True)
print("SECONDS",monotonic()-start,flush=True)
if not survivors:
    print("PASS: no maximal Tango structure exists; every dormant connection")
    print("has nonzero Cartier obstruction at this single regular point.")
else:
    print("These are only point-test survivors, not a certified Tango count.")

def filter_at_point(t0,v0,h0,candidates):
    """Independently form the necessary Taylor jets at another regular point."""
    xx = S(t0)+epsilon
    ff = 2*xx**6+2*xx**4+3*xx**2+4
    aa = 2*xx**8+4*xx**6+2
    bb = xx**2+4
    qq_local = xx**2+r*xx+1
    vv_local = S(v0)
    assert vv_local[0]**2 == ff[0] and vv_local[0] != 0
    for unused in range(3):
        vv_local = (vv_local+ff/vv_local)/2
    ee_local = aa+bb*vv_local
    hh_local = S(h0)
    assert hh_local[0]**2 == (qq_local*ee_local)[0]
    assert hh_local[0] != 0 and qq_local[0] != 0 and ee_local[0] != 0
    for unused in range(3):
        hh_local = (hh_local+qq_local*ee_local/hh_local)/2
    assert vv_local**2 == ff and hh_local**2 == qq_local*ee_local

    def ev(poly):
        return sum((embed(poly[i])*xx**i for i in range(poly.degree()+1)),S(0))

    anti = []
    for c in small.basis:
        a,b = small.polynomial_pair(c)
        anti.append((ev(a)+ev(b)*vv_local)/(vv_local*hh_local))
    forms = [sum((z[j]*anti[j] for j in range(4)),S(0)) for z in fixed]
    forms.append(xx/vv_local)
    u_local = qq_local**3/(vv_local*hh_local)
    connection = -u_local.derivative()/u_local
    origin_local = derivative_jets(connection)
    jets_local = [derivative_jets(g) for g in forms]
    result = []
    for c in candidates:
        values = [origin_local[j]+sum((K(c[i])*jets_local[i][j] for i in range(5)),K(0))
                  for j in range(4)]
        if (t0,v0,h0) == (K(0),K(3),K(2)):
            assert c == (0,0,0,0,1)
            assert values == [K(0),K(4),K(0),K(0)]
            assert P4(values) == 3
        if P4(values) == 0:
            result.append(c)
    return result

# Together with the first point these are nine distinct ordinary points.
# They are used ONLY to reject connections: every tuple is rejected at
# one of them, so no global zero-count/interpolation theorem is needed.
points = [(K(1),K(1),2+2*r)]
points += [(K(1),K(4),2+2*r),(K(1),K(1),-2-2*r),(K(1),K(4),-2-2*r)]
points += [(K(4),K(1),2-2*r),(K(4),K(4),2-2*r),
           (K(4),K(1),-2+2*r),(K(4),K(4),-2+2*r)]
points += [(K(0),K(3),K(2))]
assert len(points) == 9 and len(set(points)) == 9
for number,point in enumerate(points[1:],start=2):
    survivors = filter_at_point(*point,survivors)
    print("POINT",number,"survivors",len(survivors),survivors,flush=True)
    if not survivors:
        break
print("EXACT GEOMETRIC TANGO COUNT",len(survivors),survivors,flush=True)
print("TOTAL SECONDS",monotonic()-start,flush=True)
assert survivors == []
print("PASS: every geometric dormant canonical connection was rejected.")
