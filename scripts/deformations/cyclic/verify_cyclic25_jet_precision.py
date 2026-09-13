#!/usr/bin/env python3
"""Independent exact jet/Taylor precision check; standard library only.

This verifies universal matrix-polynomial identities, not their use in
the global Hodge comparison. p is a formal variable evaluated at 5.
"""
from math import factorial

JET = 9
NV = 1 + 3 * JET  # p, r0 jets, r1 jets, r2 jets
ZERO = (0,) * NV


def const(c):
    return {} if c == 0 else {ZERO: c}


def var(i):
    m = list(ZERO)
    m[i] = 1
    return {tuple(m): 1}


def add(*polys):
    out = {}
    for poly in polys:
        for m, c in poly.items():
            out[m] = out.get(m, 0) + c
    return {m: c for m, c in out.items() if c}


def mul(a, b):
    out = {}
    for m, c in a.items():
        for n, d in b.items():
            v = tuple(x + y for x, y in zip(m, n))
            out[v] = out.get(v, 0) + c * d
    return {m: c for m, c in out.items() if c}


def power(a, n):
    out = const(1)
    for _ in range(n):
        out = mul(out, a)
    return out


def derivative(poly):
    out = {}
    for m, c in poly.items():
        for group in range(3):
            for j in range(JET - 1):
                i = 1 + group * JET + j
                if m[i]:
                    n = list(m)
                    n[i] -= 1
                    n[i + 1] += 1
                    n = tuple(n)
                    out[n] = out.get(n, 0) + c * m[i]
    return {m: c for m, c in out.items() if c}


def v5(n):
    assert n
    n = abs(n)
    v = 0
    while n % 5 == 0:
        n //= 5
        v += 1
    return v


def valuation(poly):
    return min((m[0] + v5(c) for m, c in poly.items()), default=10**9)


P = var(0)
R = [var(1 + j) for j in range(JET)]


def advance(k):
    return [
        [add(mul(P, derivative(k[0][j])), mul(power(P, 2), mul(R[0], k[1][j]))) for j in range(2)],
        [add(mul(P, derivative(k[1][j])), k[0][j]) for j in range(2)],
    ]


def substitute_previous_digits(poly):
    out = {}
    for m, c in poly.items():
        term = mul(const(c), power(P, m[0]))
        for j in range(JET):
            replacement = add(R[j], mul(P, var(1 + JET + j)),
                              mul(power(P, 2), var(1 + 2 * JET + j)))
            term = mul(term, power(replacement, m[1 + j]))
        out = add(out, term)
    return out


def main():
    k = [[const(1), {}], [{}, const(1)]]
    matrices = [k]
    for n in range(1, 9):
        k = advance(k)
        matrices.append(k)
        assert all(valuation(entry) >= n - 1 for row in k for entry in row)

    assert matrices[2] == [
        [mul(power(P, 2), R[0]), mul(power(P, 3), R[1])],
        [{}, mul(power(P, 2), R[0])],
    ]
    assert matrices[3] == [
        [mul(power(P, 3), R[1]), mul(power(P, 4), add(R[2], power(R[0], 2)))],
        [mul(power(P, 2), R[0]), mul(const(2), mul(power(P, 3), R[1]))],
    ]
    assert matrices[5][1][0] == mul(power(P, 4), add(power(R[0], 2), mul(const(3), R[2])))

    for n in range(1, 9):
        for row in matrices[n]:
            for entry in row:
                varied = substitute_previous_digits(entry)
                first = {m: c for m, c in varied.items() if any(m[1 + JET:1 + 2 * JET])}
                second = {m: c for m, c in varied.items() if any(m[1 + 2 * JET:])}
                multiple = {m: c for m, c in varied.items() if sum(m[1 + JET:]) >= 2}
                assert valuation(first) - v5(factorial(n)) >= 3
                assert valuation(second) - v5(factorial(n)) >= 4
                assert valuation(multiple) - v5(factorial(n)) >= 4

    # General tail bound follows from v5(n!) <= (n-1)/4.
    for n in range(6, 20001):
        den, power5 = 0, 5
        while power5 <= n:
            den += n // power5
            power5 *= 5
        assert n - 1 - den >= 4
        for j in (2, 3):
            if n >= j:
                # v5(j! (n-j)!) <= v5(n!), so this is a lower bound.
                assert j + n - 1 - den >= 4
    print('PASS: K2, K3, (K5)_21 = p^4*(r^2+3*r_second)')
    print('PASS: previous r1 enters only at p^3; r2 and nonlinear r1 changes vanish modulo p^4')
    print('PASS: Taylor n>=6 vanishes modulo p^4; factorial tail checked through n=20000')
    print('Scope: universal polynomial/precision checks, not global Hodge gluing')


if __name__ == '__main__':
    main()
