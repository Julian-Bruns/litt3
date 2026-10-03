#!/usr/bin/env python3
"""Six new Cartier gates on the ACCEPTED complete BACKUP cubic-norm algebra.

No torsion census or norm-equation computation is replayed.
"""
import json
from math import comb
from pathlib import Path

import oct03_n24_cartier_gate as f


def padd(p, q):
    return f.trim([f.add(f.coeff(p, i), f.coeff(q, i)) for i in range(max(len(p), len(q)))])


def scale(p, a):
    return f.trim([f.mul(x, a) for x in p])


def main():
    source = Path('/Users/julian/Documents/litt3-computation-data/legacy_workspace_computations/backup_genus_two_torsion.json')
    data = json.loads(source.read_text())
    separator = [f.enc(x) for x in data['separator_coefficients']]
    b = [[f.enc(x) for x in p] for p in data['B_coefficients_as_polynomials_in_lambda']]
    finite = [0, 1, 2, 3, 5]
    records = []
    for origin in [None] + finite:
        branch = finite if origin is None else [0] + [f.inv(f.sub(r, origin)) for r in finite if r != origin]
        phi = f.roots_poly(branch)
        phi2 = f.pmul(phi, phi)
        if origin is None:
            bp = b
        else:
            bp = []
            for j in range(4):
                k = 3 - j
                p = []
                for i in range(k, 4):
                    p = padd(p, scale(b[i], f.mul(comb(i, k) % 5, f.power(origin, i - k))))
                bp.append(p)
        gates = []
        for n in (4, 9):
            p = []
            for j in range(4):
                p = padd(p, scale(bp[j], f.coeff(phi2, n - j)))
            gates.append(f.rem(p, separator))
        common = f.gcd(f.gcd(separator, gates[0]), gates[1])
        records.append({'origin': origin, 'phi': phi, 'gates': gates, 'gcd': common})
    out = {
        'input': str(source),
        'scope': 'Complete accepted 40 norm points, all 80 signed cubic classes, six Weierstrass origins',
        'field': data['field'],
        'records': records,
        'positive_degree_gcds': sum(len(r['gcd']) != 1 for r in records),
    }
    artifact = Path('/Users/julian/Documents/litt3-computation-data/oct03_n18_cartier_gate/backup_cartier_gate.json')
    artifact.parent.mkdir(parents=True, exist_ok=True)
    artifact.write_text(json.dumps(out, indent=2) + '\n')
    print(json.dumps({'positive_degree_gcds': out['positive_degree_gcds'], 'gcd_degrees': [len(r['gcd']) - 1 for r in records]}))
    print(artifact)


if __name__ == '__main__':
    main()
