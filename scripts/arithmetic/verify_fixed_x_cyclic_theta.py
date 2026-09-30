#!/usr/bin/env python3
"""Independent stdlib check of all AS directions and the theta Bezout identity."""
import argparse
import hashlib
import json
import struct
from pathlib import Path


def add(a,b):
    return (a%5+b%5)%5+5*((a//5+b//5)%5)


def mul0(a,b):
    x,y,u,v = a%5,a//5,b%5,b//5
    return (x*u+3*y*v)%5+5*((x*v+y*u+y*v)%5)


MUL = [[mul0(a,b) for b in range(25)] for a in range(25)]
NEG = [((-a%5)%5)+5*((-(a//5))%5) for a in range(25)]


def power(a,n):
    ans = 1
    while n:
        if n&1:
            ans = MUL[ans][a]
        a = MUL[a][a]
        n >>= 1
    return ans


def trim(a):
    while a and not a[-1]:
        a.pop()
    return a


def padd(a,b):
    return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0)
                 for i in range(max(len(a),len(b)))])


def scale(a,c):
    return trim([MUL[c][x] for x in a])


def conv5(a,b):
    if not a or not b:
        return []
    # Each unsigned integer coefficient is at most 16*min(lengths),
    # below 2^32 here. There can be no carry between packed coefficients.
    assert 16*min(len(a),len(b)) < 2**32
    aa = int.from_bytes(struct.pack('<'+'I'*len(a),*a),'little')
    bb = int.from_bytes(struct.pack('<'+'I'*len(b),*b),'little')
    count = len(a)+len(b)-1
    raw = (aa*bb).to_bytes(4*count,'little')
    return [x[0]%5 for x in struct.iter_unpack('<I',raw)]


def pmul(a,b):
    if not a or not b:
        return []
    sa = [(i,c) for i,c in enumerate(a) if c]
    sb = [(i,c) for i,c in enumerate(b) if c]
    if min(len(sa),len(sb)) <= 8:
        ans = [0]*(len(a)+len(b)-1)
        for i,c in sa:
            for j,d in sb:
                ans[i+j] = add(ans[i+j],MUL[c][d])
        return trim(ans)
    a0,a1 = [x%5 for x in a],[x//5 for x in a]
    b0,b1 = [x%5 for x in b],[x//5 for x in b]
    cc = conv5(a0,b0)
    dd = conv5(a1,b1)
    ee = conv5([(x+y)%5 for x,y in zip(a0,a1)],[(x+y)%5 for x,y in zip(b0,b1)])
    return trim([((x+3*y)%5)+5*((z-x)%5) for x,y,z in zip(cc,dd,ee)])


def from_sparse(a):
    if not a:
        return []
    out = [0]*(max(e for e,c in a)+1)
    for e,c in a:
        assert out[e] == 0
        out[e] = c
    return trim(out)


def matmul(a,b):
    return [[sumf(MUL[x][y] for x,y in zip(row,col)) for col in zip(*b)] for row in a]


def sumf(values):
    ans = 0
    for v in values:
        ans = add(ans,v)
    return ans


def rank(a):
    a = [row[:] for row in a]
    r = 0
    for j in range(len(a[0])):
        i = next((i for i in range(r,len(a)) if a[i][j]),None)
        if i is None:
            continue
        a[r],a[i] = a[i],a[r]
        a[r] = [MUL[power(a[r][j],23)][x] for x in a[r]]
        for i in range(len(a)):
            if i != r and a[i][j]:
                c = NEG[a[i][j]]
                a[i] = [add(x,MUL[c][y]) for x,y in zip(a[i],a[r])]
        r += 1
    return r


def serre_from_curve(curve,gaps):
    precision = 24
    def prod(a,b):
        return pmul(a,b)[:precision]
    def compose(poly,v):
        ans = []
        for a in reversed(poly):
            ans = padd(prod(ans,v),[a])
        return ans[:precision]
    def inv(v):
        assert v and v[0]
        b = [power(v[0],23)]
        for n in range(1,precision):
            c = sumf(MUL[v[i]][b[n-i]] for i in range(1,min(n+1,len(v))))
            b.append(MUL[b[0]][NEG[c]])
        return trim(b)
    v = [0,1]
    rev = curve[::-1]
    for _ in range(precision):
        v = ([0]+compose(rev,v))[:precision]
    assert v == ([0]+compose(rev,v))[:precision]
    u = inv(v[1:])
    uinv = inv(u)
    def upower(e):
        z,base = [1],u if e>=0 else uinv
        for _ in range(abs(e)):
            z = prod(z,base)
        return z
    # 3(q*u'-u), including the q factor on the derivative.
    derivative = [MUL[(3*(j-1))%5][a] for j,a in enumerate(u)]
    forms = [(i,1) for i in range(3)]+[(i,2) for i in range(6)]
    out = []
    for g in gaps:
        row = []
        for i,j in forms:
            shift = g-1-(10*j-3*i-4)
            power_series = prod(upower(i-3*j),derivative)
            row.append(power_series[shift//3] if shift>=0 and shift%3==0 and shift//3<len(power_series) else 0)
        out.append(row)
    return out


def verify(cert_path,theta_path):
    c = json.loads(cert_path.read_text())
    theta = json.loads(theta_path.read_text())
    assert hashlib.sha256(theta_path.read_bytes()).hexdigest() == c['theta_sha256']
    serre = serre_from_curve(theta['F_ascending'],c['gap_basis'])
    assert serre == c['serre_matrix'] and rank(serre) == 9
    curve = theta['F_ascending']
    cube = pmul(pmul(curve,curve),curve)
    coefficient = lambda poly,n:poly[n] if 0<=n<len(poly) else 0
    cartier5 = [[0]*9 for _ in range(9)]
    for i in range(3):
        for j in range(6):
            cartier5[i][j+3] = coefficient(curve,5*i+4-j)
    for i in range(6):
        for j in range(3):
            cartier5[i+3][j] = coefficient(cube,5*i+4-j)
    frob0 = c['frobenius_X']
    assert matmul(list(map(list,zip(*frob0))),serre) == matmul([[power(a,5) for a in row] for row in serre],cartier5)
    z = c['coordinate_linearized_matrix']
    assert len(z) == 9 and rank(z) == 6
    coord = [from_sparse([(5**j,a) for j,a in enumerate(row) if a]) for row in z]
    extracted = []
    for a,v in zip(c['coordinate_extractor'],coord):
        extracted = padd(extracted,scale(v,a))
    assert extracted == [0,1]
    lin = from_sparse([(5**j,a) for j,a in enumerate(c['linearized_ascending_fifth_power_coefficients']) if a])
    assert len(lin) == 15626 and lin[-1] == 1 and lin[1] != 0 and lin[0] == 0
    ff = c['frobenius_X_first_twist']
    assert ff == [[power(a,5) for a in row] for row in c['frobenius_X']]
    fifth = [from_sparse([(5*i,power(a,5)) for i,a in enumerate(v) if a]) for v in coord]
    for row,v in zip(ff,coord):
        eq = scale(v,4)
        for a,w in zip(row,fifth):
            eq = padd(eq,scale(w,a))
        if len(eq) == len(lin):
            eq = padd(eq,scale(lin,NEG[eq[-1]]))
        assert not eq
    assert rank(ff) == 6
    assert rank(matmul(ff,[[power(a,5) for a in row] for row in ff])) == 6

    # Re-evaluate the published quartic, rather than trusting its substitution.
    quartic = []
    for exponents,a in theta['quartic_terms']:
        term = [a]
        for v,e in zip(coord,exponents):
            for _ in range(e):
                term = pmul(term,v)
        quartic = padd(quartic,term)
    assert quartic == from_sparse(c['quartic_substitution_sparse'])
    aa = from_sparse(c['bezout_certificate']['linearized_quotient_multiplier'])
    bb = from_sparse(c['bezout_certificate']['quartic_multiplier'])
    lhs = padd(pmul(aa,lin[1:]),pmul(bb,quartic))
    assert lhs == [1]
    assert quartic[:4] == [0,0,0,0]
    compressed = c['compressed_bezout']
    lp = from_sparse(compressed['linearized_quotient_in_s24'])
    qp = from_sparse(compressed['quartic_quotient_in_s24'])
    assert lin == from_sparse([(24*i+1,a) for i,a in enumerate(lp) if a])
    assert quartic == from_sparse([(24*i+12,a) for i,a in enumerate(qp) if a])
    assert padd(pmul(from_sparse(compressed['left_multiplier']),lp),
                pmul(from_sparse(compressed['right_multiplier']),qp)) == [1]
    print('Curve Laurent residues and independent polynomial Cartier duality: PASS')
    print('15625 distinct AS vectors parametrized; extractor checked: PASS')
    print('All Frobenius fixed equations, stable rank and relative twist: PASS')
    print('Published 117-term quartic independently substituted: PASS')
    print('Explicit Bezout identity (L/s)*A + quartic*B = 1: PASS')
    print('Compressed degree651/312 Bezout identity: PASS')
    print('All 3906 nonzero AS directions avoid the quartic: PASS')


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--certificate',type=Path,required=True)
    ap.add_argument('--theta',type=Path,default=Path('../litt3-computation-data/theta_jump_20260915/fixed_x_theta_quartic.json'))
    args = ap.parse_args()
    verify(args.certificate,args.theta)
