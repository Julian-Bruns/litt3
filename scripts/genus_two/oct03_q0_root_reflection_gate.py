#!/usr/bin/env python3
"""New bounded F25 reflection gate; no polynomial factoring or search."""
import argparse
import json
from pathlib import Path

# c+5d denotes c+d*a, with a^2=a+3 in characteristic five.
def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)

def neg(a):
    return (-a % 5) % 5 + 5 * (-(a // 5) % 5)

def mul(a, b):
    c, d, e, f = a % 5, a // 5, b % 5, b // 5
    return (c * e + 3 * d * f) % 5 + 5 * ((c * f + d * e + d * f) % 5)

def power(a, n):
    v = 1
    while n:
        if n & 1:
            v = mul(v, a)
        a, n = mul(a, a), n // 2
    return v

def trim(a):
    while a and not a[-1]:
        a.pop()
    return a

def padd(a, b):
    return trim([add(a[i] if i < len(a) else 0, b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])

def pmul(a, b):
    v = [0] * max(0, len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            v[i + j] = add(v[i + j], mul(x, y))
    return trim(v)

def pdiv(a, b):
    a, b = trim(a[:]), trim(b[:])
    assert b
    q = [0] * max(0, len(a) - len(b) + 1)
    while len(a) >= len(b):
        j, c = len(a) - len(b), mul(a[-1], power(b[-1], 23))
        q[j] = c
        a = padd(a, [0] * j + [neg(mul(c, x)) for x in b])
    return trim(q), a

def derivative(a):
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])

P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
q0 = [24, 2, 1]
q9 = [1]
for _ in range(9):
    q9 = pmul(q9, q0)
obstruction = padd(pmul(derivative(P), derivative(P)), [neg(v) for v in q9])
a, b = P[:], obstruction[:]
u0, u1, v0, v1 = [1], [], [], [1]
while b:
    quotient, remainder = pdiv(a, b)
    a, b = b, remainder
    u0, u1 = u1, padd(u0, [neg(v) for v in pmul(quotient, u1)])
    v0, v1 = v1, padd(v0, [neg(v) for v in pmul(quotient, v1)])
scale = power(a[-1], 23)
gcd = [mul(scale, v) for v in a]
u0, v0 = [mul(scale, v) for v in u0], [mul(scale, v) for v in v0]
assert padd(pmul(u0, P), pmul(v0, obstruction)) == gcd
assert gcd == [21, 1]
assert derivative(derivative(P))
parser = argparse.ArgumentParser()
parser.add_argument('--output', type=Path)
args = parser.parse_args()
receipt = {'field': 'F5[a]/(a^2-a-3)', 'coefficient_order': 'ascending',
           'P': P, 'q0': q0, 'obstruction': obstruction, 'gcd': gcd,
           'bezout_P': u0, 'bezout_obstruction': v0,
           'P_second_derivative': derivative(derivative(P)),
           'checks': ['direct Bezout multiplication equals the recorded monic gcd', 'P second derivative nonzero']}
if len(gcd) == 2:
    r = neg(gcd[0])
    def evaluate(f, x):
        v = 0
        for coefficient in reversed(f):
            v = add(mul(v, x), coefficient)
        return v
    numerator, denominator = [add(q0[0], mul(q0[1], r)), r], [neg(r), 1]
    def ppow(f, n):
        v = [1]
        for _ in range(n):
            v = pmul(v, f)
        return v
    transform = []
    for i, coefficient in enumerate(P):
        term = pmul(ppow(numerator, i), ppow(denominator, 11 - i))
        transform = padd(transform, [mul(coefficient, v) for v in term])
    scalar = mul(evaluate(q0, r), evaluate(derivative(P), r))
    residual = padd(transform, [neg(mul(scalar, v)) for v in P])
    assert residual
    receipt['reflection_candidate'] = r
    receipt['full_reflection_residual'] = residual
    receipt['checks'].append('sole reflection candidate has nonzero full substitution residual')
if args.output:
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2) + '\n')
print(json.dumps({'gcd': gcd, 'P_second_derivative': receipt['P_second_derivative'],
                  'reflection_candidate': receipt.get('reflection_candidate'),
                  'full_reflection_residual': receipt.get('full_reflection_residual'),
                  'direct_Bezout_check': True}))
