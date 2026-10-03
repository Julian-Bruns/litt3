# REPAIRED SOURCE PREPARED ONLY. The first leased execution stopped at the
# exact-polynomial cube check before any matrix. A new execution needs a lease.
# Changed purpose: all 3003 fixed six-point degree-ten divisor classes3E-30O.
# This does not enumerate actual sources or infer an etale endpoint replacement.
from sage.all import *
import json, time

started = time.monotonic()
soft_seconds = 10.0

def emit(kind, **data):
    print(json.dumps(dict(kind=kind, elapsed=time.monotonic()-started, **data),
                     sort_keys=True), flush=True)

R = PolynomialRing(GF(5), 'T')
T = R.gen()
modulus = T**4 + 3
assert modulus.is_irreducible()
K = GF(625, 'a', modulus=modulus)
a = K.gen()
beta = 3+a**2
d = -a**2
assert beta**2 == beta+3 and d == 3-beta and d**2 == 2
zeta = 3+3*beta
assert zeta**3 == 1 and zeta != 1 and a**25 == -a

def embed(n):
    return K(n % 5) + K(n // 5)*beta

def enc(c):
    v = list(K(c).polynomial())
    return sum(int(v[i])*5**i for i in range(len(v)))

p25 = [8,3,21,23,22,12,22,21,1,22,1]
p = [embed(c) for c in p25]
def evalp(u):
    return sum(p[i]*u**i for i in range(len(p)))
assert evalp(a)*evalp(-a) == 2*d
assert evalp(a)**208 == 1
y0 = evalp(a).nth_root(3)
assert y0**3 == evalp(a)
points = [(a,zeta**j*y0) for j in range(3)]
points += [(-a,zeta**j*y0**25) for j in range(3)]
assert all(v**625 == v and y**625 == y and y**3 == evalp(v)
           for v,y in points)

S = PowerSeriesRing(K, 't', default_prec=30)
t = S.gen()

def local_y(u,v):
    shifted = S(sum(p[i]*(u+t)**i for i in range(11))).add_bigoh(30)
    coeff = [K(v)]
    for n in range(1,30):
        known = S(coeff)**3
        coeff.append((shifted[n]-known[n])/(3*v**2))
    result = S(coeff).add_bigoh(30)
    assert (result**3-shifted).is_zero()
    return result

basis = [(i,j) for j in range(3) for i in range(11)
         if 3*i+10*j <= 30]
assert len(basis) == 22
jets = []
series = []
for u,v in points:
    sy = local_y(u,v)
    series.append([enc(sy[n]) for n in range(30)])
    columns = [(u+t)**i * sy**j for i,j in basis]
    jets.append([[columns[c][n] for c in range(22)] for n in range(30)])

emit('setup', field_modulus=[3,0,0,0,1],
     encoding='sum c_i*5^i for c_i*a^i, 0<=i<4',
     beta=enc(beta), d=enc(d), zeta=enc(zeta),
     points=[[enc(u),enc(v)] for u,v in points], basis=basis,
     local_y_series=series,
     jet_stacks=[[[enc(c) for c in row] for row in point] for point in jets],
     expected_cases=3003, soft_seconds=soft_seconds)

def compositions(total, slots, prefix=()):
    if slots == 1:
        yield prefix+(total,)
    else:
        for v in range(total+1):
            yield from compositions(total-v,slots-1,prefix+(v,))

checked = 0
failures = []
for weights in compositions(10,6):
    if time.monotonic()-started >= soft_seconds:
        emit('UNRESOLVED', reason='soft deadline; incomplete fixed-divisor scan',
             checked=checked, failures=failures)
        break
    rows = []
    for j,w in enumerate(weights):
        rows.extend(jets[j][:3*w])
    assert len(rows) == 30
    M = matrix(K, rows)
    pivots = list(M.transpose().pivots())
    rank = len(pivots)
    if rank == 22:
        determinant = M.matrix_from_rows(pivots).det()
        assert determinant != 0
        emit('fixed_divisor_full_rank', weights=list(weights),
             pivot_rows=pivots, determinant=enc(determinant))
    else:
        kernel = M.right_kernel().basis()
        assert kernel and all(M*v == 0 for v in kernel)
        witness = [[enc(c) for c in v] for v in kernel]
        failures.append(dict(weights=list(weights),rank=rank,kernel=witness))
        emit('fixed_divisor_rank_drop', weights=list(weights), rank=rank,
             kernel=witness)
    checked += 1
else:
    assert checked == 3003
    emit('PASS' if not failures else 'UNRESOLVED', checked=checked,
         failures=failures,
         scope='fixed effective degree-ten six-q-point divisors3E-30O only')
