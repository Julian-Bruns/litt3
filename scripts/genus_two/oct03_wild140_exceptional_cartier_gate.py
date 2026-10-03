#!/usr/bin/env python3
"""Tiny NEW wild140 A1+yB1 gate over all six BACKUP origins.

No carrier census or accepted certificate is replayed. Computes polynomial
gcds over F125, so the surviving roots are over the entire algebraic closure.
"""
import json
from pathlib import Path
from oct03_n24_cartier_gate import add, neg, mul, inv, trim, pmul, gcd, rem


def pa(a, b):
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def pn(a):
    return trim([neg(v) for v in a])


def ps(a, c):
    return trim([mul(v, c) for v in a])


def zm(a, b):
    out = [[] for _ in range(len(a) + len(b) - 1)]
    for i, u in enumerate(a):
        for j, v in enumerate(b):
            out[i + j] = pa(out[i + j], pmul(u, v))
    while out and not out[-1]:
        out.pop()
    return out


def zp(a, n):
    out = [[1]]
    for _ in range(n):
        out = zm(out, a)
    return out


def zc(a, i):
    return a[i] if i < len(a) else []


def ev(p, x):
    out = 0
    for a in reversed(p):
        out = add(mul(out, x), a)
    return out


def main():
    old = json.loads(Path('/Users/julian/Documents/litt3-computation-data/oct03_n24_cartier_gate/backup_cartier_gate.json').read_text())
    records = []
    for item in old['records']:
        phi = [[v] if v else [] for v in item['phi']]
        phi2, phi3 = zp(phi, 2), zp(phi, 3)
        b = [[0, 4], [1]]  # B=z-r, coefficients in F125[r]
        cubic = zc(zm(phi, zp(b, 3)), 4)
        common = zm(phi3, zp(b, 2))
        l0, l1 = zc(common, 14), zc(common, 13)
        exceptional = gcd(gcd(cubic, l0), l1)
        a = [l1, pn(l0)]
        p = zm(zp(a, 3), phi2)
        q = zm(a, common)
        p4, p9 = zc(p, 4), zc(p, 9)
        q4, q9 = ps(zc(q, 4), 3), ps(zc(q, 9), 3)
        compatibility = pa(pmul(p4, q9), pn(pmul(p9, q4)))
        survivors = gcd(cubic, compatibility)
        normalized = ps(cubic, inv(cubic[-1]))
        derivative = [mul(v, i % 5) for i, v in enumerate(cubic)][1:]
        triple = None
        if len(normalized) == 4:
            root = mul(normalized[2], 3)
            if pmul(pmul([neg(root), 1], [neg(root), 1]),
                    [neg(root), 1]) == normalized:
                triple = {'root': root, 'A_direction': [ev(v, root) for v in a],
                          'P_rows': [ev(v, root) for v in [p4, p9]],
                          'Q_rows': [ev(v, root) for v in [q4, q9]]}
        records.append({'origin': item['origin'], 'phi': item['phi'],
                        'B_cubic': cubic, 'A_linear_row': [l0, l1],
                        'zero_linear_row_gcd': exceptional,
                        'A_direction': a, 'P_rows': [p4, p9],
                        'Q_rows': [q4, q9],
                        'compatibility': compatibility,
                        'compatibility_gcd': survivors,
                        'normalized_B_cubic': normalized,
                        'B_cubic_derivative_gcd': gcd(cubic, derivative),
                        'both_P_rows_gcd': gcd(gcd(cubic, p4), p9),
                        'both_Q_rows_gcd': gcd(gcd(cubic, q4), q9),
                        'triple_root': triple})
    out = {'field': old['field'], 'records': records,
           'zero_linear_row_origins': sum(len(x['zero_linear_row_gcd']) > 1 for x in records),
           'mixed_candidate_origins': sum(len(x['compatibility_gcd']) > 1 for x in records)}
    dest = Path('/Users/julian/Documents/litt3-computation-data/oct03_wild140_exceptional_cartier_gate/backup_gate.json')
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(out, indent=2) + '\n')
    print(json.dumps({k: v for k, v in out.items() if k != 'records'}))
    print(dest)
    for x in records:
        print(x['origin'], 'linear-row gcd', x['zero_linear_row_gcd'],
              'mixed compatibility gcd', x['compatibility_gcd'],
              'triple root', x['triple_root'])


if __name__ == '__main__':
    main()
