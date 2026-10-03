#!/usr/bin/env python3
"""Polynomial-power witnesses for the seven reverse exclusions.

Standard library only; no factorization or extension-field package.
It suffices that base semisimple order divides m and some target root
fails the necessary 2*m order bound. Frobenius powers are 3 and2.
"""
import ast
from pathlib import Path

root = Path(__file__).resolve().parents[2]
tree = ast.parse((root/'scripts/arithmetic/check_degree2_frobenius_orbits.py').read_text())
xc = next(ast.literal_eval(n.value) for n in tree.body
          if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and
          t.id == 'coefficients' for t in n.targets))
yc = [15625, -1000, 182, -8, 1]
witnesses = {7:274514, 11:32478620, 13:1608936, 17:1094236464,
             19:5227320, 23:12484359976, 31:295834560}


def trim(a, p):
    a = [v % p for v in a]
    while a and not a[-1]:
        a.pop()
    return a


def divmodp(a, b, p):
    a, b = trim(a, p), trim(b, p)
    assert b
    q = [0]*max(0, len(a)-len(b)+1)
    while len(a) >= len(b):
        j = len(a)-len(b)
        c = a[-1]*pow(b[-1], -1, p) % p
        q[j] = c
        for i, x in enumerate(b):
            a[i+j] = (a[i+j]-c*x) % p
        a = trim(a, p)
    return trim(q, p), a


def gcdp(a, b, p):
    while b:
        a, b = b, divmodp(a, b, p)[1]
    return trim([x*pow(a[-1], -1, p) for x in a], p)


def derivative(a, p):
    return trim([i*a[i] for i in range(1, len(a))], p)


def radical(a, p):
    q, r = divmodp(a, gcdp(a, derivative(a, p), p), p)
    assert not r and gcdp(q, derivative(q, p), p) == [1]
    return q


def mulmod(a, b, mod, p):
    c = [0]*(len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] += x*y
    return divmodp(c, mod, p)[1]


def xpower(n, mod, p):
    r, a = [1], [0,1]
    while n:
        if n & 1:
            r = mulmod(r, a, mod, p)
        a = mulmod(a, a, mod, p)
        n //= 2
    return r


if __name__ == '__main__':
    for p, m in witnesses.items():
        xr = trim(xc, p)
        assert gcdp(xr, derivative(xr, p), p) == [1]
        # The target degree is below p: derivative division retains all roots.
        assert len(yc)-1 < p
        yr = radical(trim(yc, p), p)
        assert xpower(3*m, xr, p) == [1]
        remainder = xpower(4*m, yr, p)
        assert remainder != [1]
        print(f'ell={p}: base bound m={m}; target power remainder={remainder}; PASS')
    print('Seven reverse witnesses independently verified; no untested-prime claim.')
