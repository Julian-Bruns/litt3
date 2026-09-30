#!/usr/bin/env python3
"""Exact F_25 checks of the specified polynomial and Cartier input data.

Standard-library only. Codes i+5*j mean i+j*a, a^2=a+3.
This does NOT check Aut(X), geometric simplicity of J(X), or the supplied
all-degree tensor-quotient theorem. Those remain stated inputs.
"""
import json


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a):
    return (-a % 5) % 5 + 5 * ((-(a // 5)) % 5)


def mul(a, b):
    a0, a1, b0, b1 = a % 5, a // 5, b % 5, b // 5
    return (a0*b0+3*a1*b1) % 5 + 5*((a0*b1+a1*b0+a1*b1) % 5)


def power(a, n):
    r = 1
    while n:
        if n & 1:
            r = mul(r, a)
        a = mul(a, a)
        n >>= 1
    return r


def trim(p):
    p = list(p)
    while p and p[-1] == 0:
        p.pop()
    return p


def plus(p, q):
    out = list(p) + [0]*max(0, len(q)-len(p))
    for i, a in enumerate(q):
        out[i] = add(out[i], a)
    return trim(out)


def times(p, q):
    if not p or not q:
        return []
    out = [0]*(len(p)+len(q)-1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i+j] = add(out[i+j], mul(a, b))
    return trim(out)


def scale(p, a):
    return trim([mul(v, a) for v in p])


def remainder(p, q):
    p, q = trim(p), trim(q)
    if not q:
        raise ZeroDivisionError('zero polynomial divisor')
    inv = power(q[-1], 23)
    while len(p) >= len(q):
        j, c = len(p)-len(q), mul(p[-1], inv)
        for i, a in enumerate(q):
            p[j+i] = add(p[j+i], neg(mul(c, a)))
        p = trim(p)
    return p


def gcd(p, q):
    while q:
        p, q = q, remainder(p, q)
    return scale(p, power(p[-1], 23)) if p else []


def derivative(p):
    return trim([mul(i % 5, p[i]) for i in range(1, len(p))])


def fifth_cartier_polynomial(p):
    # C(sum c_i*x^i dx) = sum c_(5j+4)^(1/5)*x^j dx.
    # On F_25, inverse Frobenius is the fifth power again.
    return trim([power(p[i], 5) for i in range(4, len(p), 5)])


P = [11,22,18,5,19,20,15,16,9,22,1]
A = [1,21,14,22,13]
Q = [0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
PHI = [[13,8,12,20,19,20], [6,0,12,12,16,11], [0,2,11,12,17,2]]
P3 = times(times(P, P), P)


def cartier_squared(h):
    # C(h dx/y^2) = C(hP dx)/y,
    # C(g dx/y) = C(gP^3 dx)/y^2.
    return fifth_cartier_polynomial(times(fifth_cartier_polynomial(times(h, P)), P3))


def main():
    assert mul(5, 5) == add(5, 3)
    for a in range(1, 25):
        assert power(a, 24) == 1
    assert derivative(Q) == times(P, times(A, A))
    assert gcd(P, derivative(P)) == [1]
    assert gcd(A, derivative(A)) == [1]
    assert gcd(P, A) == [1]
    assert scale(A, power(A[-1], 23)) == [5,2,6,7,1]
    row = [1]
    for expected in PHI:
        row = cartier_squared(row)
        assert row == expected
    phi4 = cartier_squared(row)
    assert phi4 == plus(plus(scale(PHI[0], 13), scale(PHI[1], 24)), scale(PHI[2], 10))
    q4, q5 = [6,23,14,0,1], [10,11,24,0,0,1]
    assert len(q4)-1 == 4 and len(q5)-1 == 5
    assert derivative(q4) and derivative(q5)
    gaps = [j for j in range(1, 25) if not any(j == 3*a+10*b for a in range(9) for b in range(3))]
    assert gaps == [1,2,4,5,7,8,11,14,17]
    print(json.dumps({
        'field_arithmetic': 'passed',
        'Q_prime_equals_P_A_squared': True,
        'P_and_A_squarefree_and_coprime': True,
        'A_monic_associate': [5,2,6,7,1],
        'Cartier_squared_rows': PHI,
        'Cartier_fourth_iterate_relation': True,
        'phi4_row': phi4,
        'q4_q5_coprime_degrees_and_separable': True,
        'semigroup_gaps': gaps,
        'scope': 'Polynomial and Cartier input identities only; not the global recognition decision.'
    }, indent=2))


if __name__ == '__main__':
    main()
