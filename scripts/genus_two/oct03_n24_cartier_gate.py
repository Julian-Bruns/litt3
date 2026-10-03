#!/usr/bin/env python3
"""New focused degree24 Cartier gate; exact F125 arithmetic, no source search.

F125=F5[a]/(a^3+a+1). Output is raw evidence outside the research workspace.
"""
import itertools
import json
from pathlib import Path


def digs(a):
    return (a % 5, a // 5 % 5, a // 25)


def enc(a):
    return sum((v % 5) * 5**i for i, v in enumerate(a))


def add(a, b):
    return enc([x + y for x, y in zip(digs(a), digs(b))])


def neg(a):
    return enc([-x for x in digs(a)])


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    c = [0] * 5
    for i, x in enumerate(digs(a)):
        for j, y in enumerate(digs(b)):
            c[i + j] += x * y
    for i in (4, 3):
        c[i - 2] -= c[i]
        c[i - 3] -= c[i]
    return enc(c[:3])


def power(a, n):
    out = 1
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n >>= 1
    return out


def inv(a):
    assert a
    out = power(a, 123)
    assert mul(a, out) == 1
    return out


def trim(p):
    p = list(p)
    while p and not p[-1]:
        p.pop()
    return p


def pmul(p, q):
    out = [0] * (len(p) + len(q) - 1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            out[i + j] = add(out[i + j], mul(x, y))
    return trim(out)


def roots_poly(roots):
    out = [1]
    for r in roots:
        out = pmul(out, [neg(r), 1])
    return out


def rem(p, q):
    p, q = trim(p), trim(q)
    assert q
    while len(p) >= len(q):
        scale = mul(p[-1], inv(q[-1]))
        off = len(p) - len(q)
        for j, v in enumerate(q):
            p[off + j] = sub(p[off + j], mul(scale, v))
        p = trim(p)
    return p


def gcd(p, q):
    p, q = trim(p), trim(q)
    while q:
        p, q = q, rem(p, q)
    if not p:
        return []
    return [mul(x, inv(p[-1])) for x in p]


def coeff(p, i):
    return p[i] if 0 <= i < len(p) else 0


def cartier_vector(p, phi2):
    a = pmul(p, phi2)
    return [coeff(a, 4), coeff(a, 9)]


def main():
    assert power(5, 3) == sub(neg(5), 1)
    finite = [0, 1, 2, 3, 5]
    records = []
    for origin in [None] + finite:
        branch = finite if origin is None else [0] + [inv(sub(r, origin)) for r in finite if r != origin]
        phi = roots_poly(branch)
        phi2 = pmul(phi, phi)
        partitions = []
        for pair in itertools.combinations(range(5), 2):
            d2 = roots_poly([branch[i] for i in pair])
            d3 = roots_poly([branch[i] for i in range(5) if i not in pair])
            a, b = cartier_vector(d2, phi2), cartier_vector(d3, phi2)
            det = sub(mul(a[0], b[1]), mul(a[1], b[0]))
            partitions.append({'pair': pair, 'd2': d2, 'd3': d3, 'columns': [a, b], 'det': det})
        linear = [cartier_vector([0] * j + [1], phi2) for j in range(4)]
        invariant = []
        for w in branch:
            equations = []
            for row in (0, 1):
                k0, k1, k2, k3 = [linear[j][row] for j in range(4)]
                equations.append(trim([
                    sub(k3, mul(w, k2)),
                    add(mul(3, k2), mul(mul(2, w), k1)),
                    sub(k1, mul(w, k0)),
                ]))
            common = gcd(*equations)
            invariant.append({'w': w, 'equations': equations, 'gcd': common})
        records.append({'origin': origin, 'branch': branch, 'phi': phi, 'partitions': partitions, 'invariant': invariant})
    out = {
        'field': {'prime': 5, 'modulus': [1, 1, 0, 1], 'alpha_code': 5},
        'records': records,
        'partition_count': 60,
        'zero_partition_determinants': sum(not r['det'] for x in records for r in x['partitions']),
        'invariant_count': 30,
        'positive_degree_invariant_gcds': sum(len(r['gcd']) != 1 for x in records for r in x['invariant']),
    }
    artifact = Path('/Users/julian/Documents/litt3-computation-data/oct03_n24_cartier_gate/backup_cartier_gate.json')
    artifact.parent.mkdir(parents=True, exist_ok=True)
    artifact.write_text(json.dumps(out, indent=2) + '\n')
    print(json.dumps({k: v for k, v in out.items() if k != 'records'}))
    print(artifact)


if __name__ == '__main__':
    main()
