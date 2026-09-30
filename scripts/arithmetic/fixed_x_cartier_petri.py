#!/usr/bin/env python3
"""Exact Cartier-kernel and Cartier--Petri calculation for the fixed genus9 X.

Field code c0+5*c1 means c0+c1*a, with a^2=a+3 over F5.
This small calculation does not rerun the eigenform factorization.
Write generated receipts outside litt3 with --output.
"""
import argparse
import json
from pathlib import Path


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a):
    return (-a % 5) % 5 + 5 * (-(a // 5) % 5)


def mul(a, b):
    a0, a1 = a % 5, a // 5
    b0, b1 = b % 5, b // 5
    return (a0*b0 + 3*a1*b1) % 5 + 5*((a0*b1 + a1*b0 + a1*b1) % 5)


def power(a, n):
    r = 1
    while n:
        if n & 1:
            r = mul(r, a)
        a = mul(a, a)
        n >>= 1
    return r


def dot(a, b):
    r = 0
    for x, y in zip(a, b):
        r = add(r, mul(x, y))
    return r


def pmul(a, b):
    r = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            r[i+j] = add(r[i+j], mul(x, y))
    return r


def coefficient(a, i):
    return a[i] if 0 <= i < len(a) else 0


def rref(a):
    a = [r[:] for r in a]
    pivots = []
    for j in range(len(a[0])):
        k = next((k for k in range(len(pivots), len(a)) if a[k][j]), None)
        if k is None:
            continue
        i = len(pivots)
        a[i], a[k] = a[k], a[i]
        u = power(a[i][j], 23)
        a[i] = [mul(u, x) for x in a[i]]
        for k in range(len(a)):
            if k != i and a[k][j]:
                u = neg(a[k][j])
                a[k] = [add(x, mul(u, y)) for x, y in zip(a[k], a[i])]
        pivots.append(j)
    return a, pivots


def kernel(a):
    r, pivots = rref(a)
    out = []
    for j in range(len(a[0])):
        if j in pivots:
            continue
        v = [0] * len(a[0])
        v[j] = 1
        for i, k in enumerate(pivots):
            v[k] = neg(r[i][j])
        out.append(v)
    return out


def rank(a):
    return len(rref(a)[1])


def matmul(a, b):
    return [[dot(r, c) for c in zip(*b)] for r in a]


def cartier_polynomial(a):
    return [power(a[j], 5) for j in range(4, len(a), 5)]


def primitive(b, f):
    bf = pmul(b, f)
    out = [0] * (len(bf) + 1)
    for j, a in enumerate(bf):
        if (j + 1) % 5 == 0:
            assert a == 0, (j, a)
        else:
            out[j+1] = mul(a, power((j+1) % 5, 23))
    assert [mul((j+1) % 5, out[j+1]) for j in range(len(bf))] == bf
    return out


def calculate():
    f = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    f3 = pmul(pmul(f, f), f)
    n = [[coefficient(f, 5*i+4-j) for j in range(6)] for i in range(3)]
    m = [[coefficient(f3, 5*i+4-j) for j in range(3)] for i in range(6)]
    h = matmul(n, [[power(x, 5) for x in r] for r in m])
    assert rank(h) == rank(n) == rank(m) == 3
    bs = kernel(n)
    assert len(bs) == 3 and all(not any(dot(r, b) for r in n) for b in bs)
    ps = [primitive(b, f) for b in bs]
    products = {}
    for i in range(3):
        for j in range(3):
            products[i, j] = cartier_polynomial(pmul(pmul(ps[i], bs[j]), f))
    assert all(not any(products[i, i]) for i in range(3))
    assert all(products[j, i] == [neg(x) for x in products[i, j]]
               for i in range(3) for j in range(3))
    pairs = [(0, 1), (0, 2), (1, 2)]
    mu = [products[pair] for pair in pairs]
    mu_columns = [list(r) for r in zip(*mu)]
    return {
        'field': {'p': 5, 'modulus_ascending': [2, 4, 1], 'encoding': 'c0+5*c1'},
        'polynomial_F_ascending': f,
        'N': n, 'M': m, 'H_N_times_M_fifth_power': h,
        'rank_N': rank(n), 'rank_M': rank(m), 'rank_H': rank(h),
        'kernel_B_ascending': bs,
        'primitive_P_ascending': ps,
        'pair_order_zero_based': pairs,
        'mu_B_ascending': mu,
        'rank_mu': rank(mu_columns),
        'N_times_mu': matmul(n, mu_columns),
        'rank_N_times_mu': rank(matmul(n, mu_columns)),
        'identities': {'kernel': True, 'primitive_derivatives': True, 'alternating': True},
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = calculate()
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in
          ['rank_N', 'rank_M', 'rank_H', 'kernel_B_ascending',
           'mu_B_ascending', 'rank_mu', 'N_times_mu', 'rank_N_times_mu']}, indent=2))
