"""Independent exact algebra checks used by verify.py (standard library only)."""
import itertools
import json
import math
from pathlib import Path
from finite25 import (add, sub, mul, inv, neg, powf, trim, pa, ps, pm,
                      ppow, scale, divmodp, rem, egcd, der)


def recompute_affine(endpoint):
    P, A = endpoint['P'], endpoint['A']
    H = rem(pm(ppow(P, 2, A), ppow(der(A), 3, A)), A)
    H += [0] * (4 - len(H))
    R = [[0] * 30 for _ in range(4)]
    for j in range(30):
        xp = ppow([0, 1], j, A)
        for i, c in enumerate(xp):
            R[i][29-j] = mul(c, math.comb(29, j) % 5)
    R = [trim(p) for p in R]
    pivot = next(i for i, x in enumerate(H) if x)
    G = [ps(scale(R[i], H[pivot]), scale(R[pivot], H[i]))
         for i in range(4) if i != pivot]
    return H, R, pivot, G


def verify_exact_data(root: Path):
    endpoint = json.loads((root/'data/endpoint.json').read_text())
    cyclo = json.loads((root/'data/cyclotomic.json').read_text())
    cert = json.loads((root/'data/affine_bezout.json').read_text())
    assert endpoint['P'] == [11,22,18,5,19,20,15,16,9,22,1]
    assert endpoint['A'] == [1,21,14,22,13]
    assert mul(5, 5) == 8  # beta^2 = beta + 3
    for a in range(25):
        assert add(a, neg(a)) == 0
        if a:
            assert mul(a, inv(a)) == 1
        for b in range(25):
            assert mul(a,b) == mul(b,a)
            for c in range(25):
                assert mul(mul(a,b),c) == mul(a,mul(b,c))
                assert mul(a,add(b,c)) == add(mul(a,b),mul(a,c))
    print('PASS F25 arithmetic: all 25^3 associativity/distributivity triples; all inverses.')
    P, A = endpoint['P'], endpoint['A']
    for p,q,label in [(P,der(P),'P squarefree'),(A,der(A),'A squarefree'),
                      (P,A,'P and A coprime'),(P,der(A),"P and A prime coprime")]:
        assert egcd(p,q)[0] == [1], label
    print('PASS exact squarefreeness/coprimality checks used in the local proof.')
    f = cyclo['irreducible_polynomial_ascending']
    assert f == [1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]
    assert rem([1]*29,f) == []
    assert next(i for i in range(1,29) if pow(5,i,29)==1) == 14
    assert pow(5,7,29)==28
    print('PASS Phi_29 divisibility and ord_29(5)=14; the specified F5 polynomial is irreducible.')
    H,R,pivot,G = recompute_affine(endpoint)
    assert H == cert['H'] == [3,21,7,14]
    assert R == cert['R'] and pivot == cert['pivot'] and G == cert['G']
    result = []
    for b,g in zip(cert['bezout'],G):
        result = pa(result,pm(b,g))
    assert result == cert['gcd'] == [1]
    print('PASS affine-label Bezout identity: sum B_i(q) G_i(q)=1 over F25[q].')
    print('     H mod A = [3,21,7,14]; cross-product degrees = 29,29,29; Bezout degrees = 28,28,-1.')
    return f


def verify_three_point_minors(f):
    exponents = (0,1,4)
    perms = []
    for p in itertools.permutations(range(3)):
        invs = sum(p[i]>p[j] for i in range(3) for j in range(i+1,3))
        perms.append((p, -1 if invs%2 else 1))
    checked = 0
    for tail in itertools.combinations(range(1,29),2):
        roots = (0,)+tail
        pol = [0]*29
        for perm,sign in perms:
            ix = sum(roots[i]*exponents[perm[i]] for i in range(3)) % 29
            pol[ix] = (pol[ix]+sign)%5
        assert rem(pol,f), ('zero three-point minor', roots)
        checked += 1
    assert checked == 378
    print('PASS all 378 normalized three-point minors for exponents (0,1,4); no zero.')


def verify_schur_identities():
    """Verify the three determinant formulas as polynomial identities over Z.

    This uses formal polynomial reduction by the monic root polynomial,
    not evaluations or the formulas used by the C++ finite-field checker.
    """
    for d in (3,4,5):
        n = 2*d+2
        one = {(0,)*n:1}
        def var(k):
            if k == 0:
                return one.copy()
            a = [0]*n; a[k-1]=1
            return {tuple(a):1}
        def plus(a,b,sgn=1):
            out = dict(a)
            for m,c in b.items():
                out[m] = out.get(m,0)+sgn*c
                if not out[m]:
                    del out[m]
            return out
        def times(a,b):
            out = {}
            for x,c in a.items():
                for y,z in b.items():
                    m = tuple(v+w for v,w in zip(x,y))
                    out[m] = out.get(m,0)+c*z
            return {m:c for m,c in out.items() if c}
        def product(*args):
            r = one
            for a in args:
                r = times(r,a)
            return r
        reduced = []
        for k in range(8+d):
            v = [{} for _ in range(n)]
            if k < n:
                v[k] = one.copy()
            else:
                # x^k = e1 x^(k-1) - e2 x^(k-2) + ...
                for r in range(1,n+1):
                    for j in range(n):
                        v[j] = plus(v[j],times(var(r),reduced[k-r][j]),
                                    1 if r%2 else -1)
            reduced.append(v)
        mat = [[reduced[k][r] for k in range(7,8+d)] for r in range(d+1,n)]
        determinant = {}
        for p in itertools.permutations(range(d+1)):
            term = one
            for i,j in enumerate(p):
                term = times(term,mat[i][j])
                if not term:
                    break
            sign = -1 if sum(p[i]>p[j] for i in range(d+1) for j in range(i+1,d+1))%2 else 1
            determinant = plus(determinant,term,sign)
        if d == 3:
            expected = product(var(4),var(4),var(4))
            expected = plus(expected,product(var(3),var(4),var(5)),-2)
            expected = plus(expected,product(var(2),var(5),var(5)))
            expected = plus(expected,product(var(3),var(3),var(6)))
            expected = plus(expected,product(var(2),var(4),var(6)),-1)
        elif d == 4:
            expected = plus(product(var(5),var(5)),product(var(4),var(6)),-1)
        else:
            expected = var(6)
        assert determinant == expected, (d, determinant, expected)
        print(f'PASS formal determinant/Vandermonde identity for d={d} over Z ({len(expected)} monomials).')


def run(root):
    f = verify_exact_data(root)
    verify_three_point_minors(f)
    verify_schur_identities()
