#!/usr/bin/env python3
"""New exact degree-eight critical-algebra gate, without factoring/resultants."""
import argparse
import json
from pathlib import Path

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
def bezout(a, b):
    original_a, original_b = a[:], b[:]
    u0, u1, v0, v1 = [1], [], [], [1]
    while b:
        quotient, remainder = pdiv(a, b)
        a, b = b, remainder
        u0, u1 = u1, padd(u0, [neg(v) for v in pmul(quotient, u1)])
        v0, v1 = v1, padd(v0, [neg(v) for v in pmul(quotient, v1)])
    scale = power(a[-1], 23)
    gcd = [mul(scale, v) for v in a]
    u0, v0 = [mul(scale, v) for v in u0], [mul(scale, v) for v in v0]
    assert padd(pmul(u0, original_a), pmul(v0, original_b)) == gcd
    return {'gcd': gcd, 'first_coefficient': u0, 'second_coefficient': v0}

# c+5d means c+d*a, where a^2=a+3.
P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
q0 = [24, 2, 1]
critical = derivative(P)
checks = {'Pprime_Psecond': bezout(critical, derivative(critical)),
          'Pprime_P': bezout(critical, P), 'Pprime_q0': bezout(critical, q0)}
assert all(v['gcd'] == [1] for v in checks.values())
q5 = [1]
for _ in range(5):
    q5 = pmul(q5, q0)
R = pdiv(pmul(q5, checks['Pprime_P']['second_coefficient']), critical)[1]
columns, v = [], [1]
for _ in range(8):
    columns.append(v + [0] * (8 - len(v)))
    v = pdiv(pmul(v, R), critical)[1]
matrix = [[columns[j][i] for j in range(8)] for i in range(8)]
work = [row[:] for row in matrix]
determinant = 1
for j in range(8):
    pivot = next((i for i in range(j, 8) if work[i][j]), None)
    assert pivot is not None
    if pivot != j:
        work[j], work[pivot] = work[pivot], work[j]
        determinant = neg(determinant)
    value = work[j][j]
    determinant = mul(determinant, value)
    work[j] = [mul(power(value, 23), x) for x in work[j]]
    for i in range(j + 1, 8):
        value = work[i][j]
        work[i] = [add(x, neg(mul(value, y))) for x, y in zip(work[i], work[j])]
assert determinant
receipt = {'field': 'F5[a]/(a^2-a-3)', 'coefficient_order': 'ascending',
           'P': P, 'q0': q0, 'critical_polynomial_Pprime': critical,
           'bezout_checks': checks, 'R0_mod_Pprime': R,
           'power_matrix_columns_1_to_R7': matrix, 'determinant': determinant,
           'outcome': 'eight squarefree ordinary critical points with eight distinct nonzero finite values',
           'checks': ['three direct Bezout multiplication identities',
                      'eight power columns by direct modular multiplication',
                      'nonzero exact F25 determinant']}
parser = argparse.ArgumentParser()
parser.add_argument('--output', type=Path)
args = parser.parse_args()
if args.output:
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2) + '\n')
print(json.dumps({'critical_degree': len(critical) - 1, 'power_matrix_rank': 8,
                  'determinant': determinant, 'gcd_checks': [v['gcd'] for v in checks.values()]}))
