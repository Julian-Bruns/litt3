#!/usr/bin/env python3
"""Independent Sage audit of every exceptional contact chart and other samples.

Run with sage -python. Exhaustiveness is supplied by the complete C++
certificate and replay. This uses Sage's absolute field GF(5^56), native
polynomial arithmetic, and the unexpanded rational jet equations.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing

ap = argparse.ArgumentParser()
ap.add_argument('--data', type=Path, required=True)
ap.add_argument('--directory', type=Path, required=True)
ap.add_argument('--output', type=Path, required=True)
args = ap.parse_args()
start = time.monotonic()
data = json.loads(args.data.read_text())
K = GF(5**56, 'c')
R = PolynomialRing(K, 'x')
x = R.gen()
beta = (x*x-x-3).roots(multiplicities=False)[0]
def code(c):
    return K(c % 5) + (c // 5)*beta
alpha = R([code(c) for c in data['KM']]).roots(multiplicities=False)[0]
zeta = R([code(c) for c in data['LM']]).roots(multiplicities=False)[0]
assert zeta**29 == 1 and zeta != 1
def embed(row):
    return sum(code(c)*alpha**i for i,c in enumerate(row))
rows = {name: [embed(row) for row in data[name]]
        for name in ('ROOTS','HS','FS','GS','JS')}
roots = rows['ROOTS']
assert [roots[0]**(25**i) for i in range(4)] == roots
Q = R.fraction_field()
RW = PolynomialRing(Q, 'W')
W = RW.gen()
WW = PolynomialRing(K, 'w')
w = WW.gen()
stats = Counter()

def saturate(g, forbidden):
    assert forbidden != 0
    while g.degree() > 0:
        common = g.gcd(forbidden)
        if common.degree() <= 0:
            break
        g = g.quo_rem(common)[0]
    return g

def check(case, recorded):
    j0,k0,l0,u0,t0,v0,r0 = case
    vm = (v0+t0) % 29
    def term(name, root, phase, power):
        return rows[name][root]*zeta**(phase*power % 29)
    def diff(name,power,aa,pa,bb,pb):
        return term(name,aa,pa,power)-term(name,bb,pb,power)
    def avg(name,power,aa,pa,bb,pb):
        return (term(name,aa,pa,power)+term(name,bb,pb,power))/2
    a,b = roots[0]-roots[j0], roots[k0]-roots[l0]
    f,c,d,e = [diff(name,p,0,0,j0,u0)
               for name,p in [('HS',1),('FS',4),('GS',5),('JS',8)]]
    h,i,j,k = [diff(name,p,k0,v0,l0,vm)
               for name,p in [('HS',1),('FS',4),('GS',5),('JS',8)]]
    if f == h == 0:
        assert recorded == 1
        assert a == c == d == e == b == i == j == k == 0
        return 'both_endpoint_differences_zero'
    dp,ep = [avg(name,p,0,0,j0,u0) for name,p in [('GS',5),('JS',8)]]
    jp,kp = [avg(name,p,k0,v0,l0,vm) for name,p in [('GS',5),('JS',8)]]
    r = zeta**r0
    en,ed = r**8*jp-kp, r**8*ep-dp
    assert en != 0 and ed != 0
    eps = en/ed

    # Reconstruct from the rational square-root jets, without using the
    # coefficient arrays or polynomial Euclidean routines of the C++ code.
    uu = (1-W)/r
    ll = r-x*x*W/r
    vv = (Q(r*r/(x*x))-1+4*r*uu-r*r*uu*uu)/(2*r*r)
    mm = (x*x-ll*ll+4*r*ll-r*r)/2
    A = 2*eps*r*r*x*x*(e-(x/(eps*r)*(j-ll*h)+uu*c+(vv-uu*uu)*a))
    B = 2*eps*r**3*(d-(x/(eps*r)*(k-ll*i+(ll*ll-mm)*b)+uu*f))
    A = [R(c0) for c0 in A.list()]
    B = [R(c0) for c0 in B.list()]
    den = R(eps*(f-r**7*a)+x**3*(b-r**7*h))
    num = R(-r*(eps*(d-r**7*c)+x*(i-r**7*j)))

    # Check all points where solving the contact equation for W is illegal.
    common = den.gcd(num)
    if common:
        common = saturate(common,x)
    actual_contact = common == 0 or common.degree() > 0
    if actual_contact:
        assert recorded & 128
        assert common != 0
        root_list = common.roots(multiplicities=False)
        # Completeness is checked here; no search only in the base field.
        assert sum(m for _,m in common.roots()) == common.degree()
        assert root_list
        for xx in root_list:
            aw = WW([c0(xx) for c0 in A])
            bw = WW([c0(xx) for c0 in B])
            gw = aw.gcd(bw)
            if gw and gw.degree() == 0:
                stats['contact_already_excluded_by_jets'] += 1
                continue
            line = (eps*a+xx**3*h)*w+eps*c*r+j*r*xx
            if line == 0:
                stats['contact_has_no_actual_pole'] += 1
                continue
            hh = 4*xx**2*r**4*(jp-eps*ep)**2-(r*r+xx**2*(1-2*w))*line**2
            gw = gw.gcd(hh)
            if gw and gw.degree() == 0:
                stats['contact_opposite_sheet_contradiction'] += 1
                continue
            before = int(gw.degree())
            gw = saturate(gw,line)
            stats['roots_removed_by_missing_pole'] += before-int(gw.degree())
            before = int(gw.degree())
            gw = saturate(gw,xx**2*w*w-r*r)
            stats['roots_removed_by_nonsquarefree_model'] += before-int(gw.degree())
            assert gw != 0 and gw.degree() == 0, (case,gw)
        stats['all_contact_configurations_checked'] += 1
    else:
        assert not recorded & 128

    if den == 0:
        assert recorded & 127 == 4
        return 'regular_chart_empty'
    def subst(coeffs):
        value = sum(Q(cc)*(Q(num)/Q(den))**ii for ii,cc in enumerate(coeffs))
        return R(value.numerator())
    aa,bb = subst(A),subst(B)
    gg = aa.gcd(bb)
    gg = saturate(gg,x*den)
    assert gg != 0 and gg.degree() == 0, (case,gg)
    assert recorded & 127 == 5
    return 'regular_chart_excluded_by_two_jets'

reps = []
for u0 in range(29):
    for t0 in range(29):
        for v0 in range(29):
            a0 = (u0,t0,v0)
            orbit = [a0]
            for _ in range(6):
                orbit.append(tuple(24*s % 29 for s in orbit[-1]))
            if a0 == min(orbit):
                reps.append(a0)
assert len(reps) == 3485
hashes = {}
checked = 0
for j0 in range(4):
    path = args.directory / f'degree7_genus0_final_j{j0}.bin'
    cert = path.read_bytes()
    assert len(cert) == 3*1617040
    stages = cert[::3]
    counts = Counter(stages)
    assert counts[133] == (232 if j0 == 0 else 242)
    assert counts[1] == (580 if j0 == 0 else 0)
    assert set(counts) <= {1,5,133}
    assert all(v < 28 for v in cert[1::3])
    assert all(0 < v < 25 for v in cert[2::3])
    hashes[path.name] = hashlib.sha256(cert).hexdigest()
    for index,stage in enumerate(stages):
        if stage & 128 or index % 7919 == 0:
            q0,r0 = divmod(index,29)
            q0,phase = divmod(q0,len(reps))
            k0,l0 = divmod(q0,4)
            case = (j0,k0,l0,*reps[phase],r0)
            stats[check(case,stage)] += 1
            checked += 1
            if checked % 100 == 0:
                print('independent cases checked',checked,flush=True)
assert stats['all_contact_configurations_checked'] == 958
out = {'status':'PASS', 'scope':'All 958 contact charts, plus deterministic supplementary records; exhaustive arithmetic replay is separate.',
       'checked':checked, 'statistics':dict(stats), 'field_modulus':str(K.modulus()),
       'beta':str(beta),'alpha':str(alpha),'zeta':str(zeta),
       'certificate_sha256':hashes,'seconds':time.monotonic()-start}
args.output.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
