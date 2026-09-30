#!/usr/bin/env python3
"""Exact finite-field checks for an étale counterexample to assertion (2).

Python 3, standard library only. Coefficients are codes c0+5*c1 with
0 <= c0,c1 < 5, representing c0+c1*a and a^2=a+3.
All polynomial coefficient lists are ascending.

The geometric proof is in counterexample_README.md. This script checks every
finite algebraic identity used there; it does not enumerate 15,625 sheets.
"""
from __future__ import annotations
import json
from pathlib import Path

Poly = list[int]

def add(x: int, y: int) -> int:
    return ((x % 5 + y % 5) % 5) + 5 * ((x // 5 + y // 5) % 5)

def neg(x: int) -> int:
    return (-x % 5) + 5 * ((-(x // 5)) % 5)

def sub(x: int, y: int) -> int:
    return add(x, neg(y))

def mul(x: int, y: int) -> int:
    x0, x1, y0, y1 = x % 5, x // 5, y % 5, y // 5
    return ((x0*y0 + 3*x1*y1) % 5
            + 5*((x0*y1 + x1*y0 + x1*y1) % 5))

def power(x: int, n: int) -> int:
    if n < 0:
        return power(inv(x), -n)
    z = 1
    while n:
        if n & 1:
            z = mul(z, x)
        x = mul(x, x)
        n //= 2
    return z

def inv(x: int) -> int:
    if not x:
        raise ZeroDivisionError('zero in F25')
    return power(x, 23)

def div(x: int, y: int) -> int:
    return mul(x, inv(y))

def trim(p: Poly) -> Poly:
    p = p[:] or [0]
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p

def coeff(p: Poly, i: int) -> int:
    return p[i] if 0 <= i < len(p) else 0

def padd(p: Poly, q: Poly) -> Poly:
    return trim([add(coeff(p, i), coeff(q, i))
                 for i in range(max(len(p), len(q)))])

def pneg(p: Poly) -> Poly:
    return [neg(a) for a in p]

def psub(p: Poly, q: Poly) -> Poly:
    return padd(p, pneg(q))

def pscale(p: Poly, a: int) -> Poly:
    return trim([mul(c, a) for c in p])

def pmul(p: Poly, q: Poly) -> Poly:
    z = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            z[i+j] = add(z[i+j], mul(a, b))
    return trim(z)

def ppow(p: Poly, n: int) -> Poly:
    if n < 0:
        raise ValueError('negative polynomial exponent')
    z = [1]
    while n:
        if n & 1:
            z = pmul(z, p)
        p = pmul(p, p)
        n //= 2
    return z

def pdiv(p: Poly, q: Poly) -> tuple[Poly, Poly]:
    p, q = trim(p), trim(q)
    if q == [0]:
        raise ZeroDivisionError('zero polynomial')
    z = [0] * max(1, len(p) - len(q) + 1)
    while p != [0] and len(p) >= len(q):
        i, a = len(p)-len(q), div(p[-1], q[-1])
        z[i] = a
        p = psub(p, [0]*i + pscale(q, a))
    return trim(z), trim(p)

def monomial(i: int) -> Poly:
    return [0]*i + [1]

def evaluate(p: Poly, x: int) -> int:
    z = 0
    for a in reversed(p):
        z = add(mul(z, x), a)
    return z

def det3(m: list[list[int]]) -> int:
    return add(sub(mul(m[0][0], sub(mul(m[1][1],m[2][2]),
                                    mul(m[1][2],m[2][1]))),
                   mul(m[0][1], sub(mul(m[1][0],m[2][2]),
                                    mul(m[1][2],m[2][0])))),
               mul(m[0][2], sub(mul(m[1][0],m[2][1]),
                                mul(m[1][1],m[2][0]))))

P = [11,22,18,5,19,20,15,16,9,22,1]
B = [22,16,11,3,15,11,2,6,12,14]
J = [7,8,9]
r, s = 15, 7
lam = 12
nu = [3,17,10]
mu = [16,4,7]
M = [[14,3,5],[15,17,7],[0,18,16]]
R_expected = [[18,17,5,19,15,8,4,14,3,5],
              [19,16,16,3,16,24,18,15,17,7],
              [1,16,14,20,19,21,19,0,18,16]]
E_expected = [[0],[1],[19,15,16,9,22,1]]
K_expected = [[0,0,0,0,19,1],
              [0,0,0,0,8,7,5,11,16,22],
              [0,0,0,0,14,20,5,18,19,15]]
A_low_expected = [4,18,8,12,2]
C_low_expected = [2,14,21,4,23,6,13]

def main() -> None:
    # Sanity check the finite-field implementation.
    assert mul(5,5) == 8  # a^2 = a+3
    for a in range(25):
        assert power(a,25) == a
        assert add(a,neg(a)) == 0
        if a:
            assert mul(a,inv(a)) == 1
    assert evaluate(P,r) == power(s,3) == 14
    assert power(s,2) == 2 and mul(3,power(s,2)) == 1
    assert mul(lam,s) == 15
    assert s != 0
    assert det3(M) == 15

    # Construct all coefficients by Euclidean division, independently of
    # the radix-P construction used in finding the example.
    P3, P4, P16, P17 = (ppow(P,e) for e in (3,4,16,17))
    V, R, L, E, R5, L5, K = [], [], [], [], [], [], []
    for row,j in enumerate(J):
        q16, lj = pdiv(monomial(25*j), P16)
        vj, rj = pdiv(q16,P)
        assert len(lj) <= 160 and len(rj) <= 10
        assert rj == R_expected[row]
        assert [coeff(rj,i) for i in J] == M[row]
        # Exact identity needed for the chart at infinity.
        assert padd(padd(pmul(P17,vj),pmul(P16,rj)),lj) == monomial(25*j)
        rlow = psub(rj,[0]*7+M[row])
        assert len(rlow) <= 7
        # U_j = rlow/y^2 + L_j/y^50 is regular at O:
        # ord >= 20-3*6=2 and 500-3*159=23.
        V.append(vj); R.append(rj); L.append(lj)

        q3, l5j = pdiv(monomial(5*j),P3)
        ej, r5j = pdiv(q3,P)
        kj = trim([0]*4 + [coeff(r5j,i) for i in range(4,10)])
        assert ej == E_expected[row] and kj == K_expected[row]
        assert len(l5j) <= 30
        assert padd(padd(pmul(P4,ej),pmul(P3,r5j)),l5j) == monomial(5*j)
        assert len(psub(r5j,kj)) <= 4
        # d_j^5 - y^2 E_j - K_j/y is regular at O:
        # its two pieces have orders >= 1 and >= 13.
        E.append(ej); R5.append(r5j); L5.append(l5j); K.append(kj)

    # Six independent classes: the d_j occupy the y^-2 sector; their
    # fifth powers occupy the y^-1 sector with this nonzero minor.
    minor = [[coeff(k,i) for i in (5,6,7)] for k in K]
    assert det3(minor) == 18

    D, rem = pdiv(psub(P,[power(s,3)]),[neg(r),1])
    assert rem == [0]
    muK = [0]
    for a,kj in zip(mu,K):
        muK = padd(muK,pscale(kj,a))
    nuX = [0]*7+nu
    low1 = psub(psub(B,muK),pscale(D,div(lam,mul(3,power(s,2)))))
    low2 = psub(pneg(nuX),pscale(D,div(lam,mul(3,s))))
    assert low1 == A_low_expected
    assert low2 == C_low_expected
    assert len(low1) == 5 and len(low2) <= 7
    # This proves the pole <=2 identity for b/y at every point over O.

    data = {
        'field':'F5[a]/(a^2-a-3); code c0+5*c1 means c0+c1*a',
        'polynomial_order':'ascending', 'P':P, 'B':B,
        'point':{'x':r,'y':s}, 'cover_degree':25**3,
        'variable_indices':J, 'M':M, 'det_M':det3(M),
        'V':V, 'R':R, 'L':L, 'E':E, 'R5':R5, 'L5':L5, 'K':K,
        'lambda':lam, 'nu':nu, 'mu':mu, 'D':D,
        'low_numerator_over_y':low1, 'low_numerator_over_y_squared':low2,
        'connectedness_minor':minor, 'connectedness_minor_determinant':18
    }
    out = Path(__file__).resolve().with_name('epsilon_counterexample_coefficients.json')
    out.write_text(json.dumps(data,indent=2)+'\n', encoding='utf-8')
    print('PASS: F25 arithmetic and P([15]) = [7]^3 = [14].')
    print('PASS: cover matrix determinant [15] is nonzero.')
    print('PASS: all 25-power identities and infinity-chart pole bounds.')
    print('PASS: all 5-power identities and six-class independence (minor [18]).')
    print('PASS: exact lift identity; residual pole at O is at most 2.')
    print('Counterexample: connected etale degree 15625; G=h^*([15],[7]).')
    print('Wrote',out.name)

if __name__ == '__main__':
    main()
