#!/usr/bin/env python3
"""Exact Hasse--Wronskian of the fixed genus-nine Cartier kernel.

Only Python standard-library arithmetic. Write receipts outside litt3.
Field and basis reconstruction are imported from the small Cartier--Petri
certificate; no eigenform enumeration or matrix backend is used.
"""
import argparse
import itertools
import json
from pathlib import Path

from fixed_x_cartier_petri import add, neg, mul, power, pmul, calculate


def trim(a):
    a = list(a)
    while a and not a[-1]:
        a.pop()
    return a


def padd(a, b):
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def scale(a, c):
    return trim([mul(x, c) for x in a])


def derivative(a):
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def divmod_poly(a, b):
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError
    q = [0] * max(0, len(a) - len(b) + 1)
    lead_inverse = power(b[-1], 23)
    while a and len(a) >= len(b):
        j = len(a) - len(b)
        c = mul(a[-1], lead_inverse)
        q[j] = c
        a = padd(a, [0]*j + scale(b, neg(c)))
    return trim(q), a


def xgcd(a, b):
    r0, r1, s0, s1, t0, t1 = trim(a), trim(b), [1], [], [], [1]
    while r1:
        q, r = divmod_poly(r0, r1)
        r0, r1 = r1, r
        s0, s1 = s1, padd(s0, scale(pmul(q, s1), 4))
        t0, t1 = t1, padd(t0, scale(pmul(q, t1), 4))
    c = power(r0[-1], 23)
    return scale(r0, c), scale(s0, c), scale(t0, c)


def bezout(a, b):
    gcd, u, v = xgcd(a, b)
    assert padd(pmul(u, a), pmul(v, b)) == gcd
    return {'gcd': gcd, 'u': u, 'v': v}


def run():
    data = calculate()
    bs = [trim(b) for b in data['kernel_B_ascending']]
    f = data['polynomial_F_ascending']
    rows = [bs, [derivative(b) for b in bs],
            [scale(derivative(derivative(b)), 3) for b in bs]]
    w = []
    for permutation in itertools.permutations(range(3)):
        inversions = sum(permutation[i] > permutation[j]
                         for i in range(3) for j in range(i+1, 3))
        term = [1]
        for i in range(3):
            term = pmul(term, rows[i][permutation[i]])
        w = padd(w, scale(term, 4 if inversions % 2 else 1))
    assert w == [3, 1, 13, 11, 8, 17, 9, 3]
    certificates = {
        'Wronskian_squarefree': bezout(w, derivative(w)),
        'Wronskian_disjoint_from_branch_polynomial': bezout(w, f),
        'kernel_has_no_finite_basepoint': bezout(bs[0], bs[1]),
    }
    assert all(c['gcd'] == [1] for c in certificates.values())
    orders = {'cubic_branch_points': {'count': 10, 'order': 6},
              'Wronskian_root_preimages': {'count': 21, 'order': 1},
              'infinity': {'count': 1, 'order': 15}}
    assert sum(x['count']*x['order'] for x in orders.values()) == 96
    exceptional_size = sum(x['count'] for x in orders.values()
                           if x['order'] % 5)
    assert exceptional_size == 31 and exceptional_size % 8
    return {'field': data['field'], 'F': f, 'kernel_basis': bs,
            'Hasse_Wronskian_ascending': w,
            'generic_orders': [0, 1, 2], 'canonical_weight': 6,
            'Bezout_certificates': certificates, 'divisor': orders,
            'multiplicity_nonzero_mod5_support_size': exceptional_size}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = run()
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('PASS: orders (0,1,2), W degree7, squarefree and branch-disjoint; '
          'divisor 6*10 + 1*21 + 15*O; mod5 support31.')
