#!/usr/bin/env python3
"""Six new quadratic Cartier kernels; no torsion or carrier replay."""
import json
from pathlib import Path
from oct03_n24_cartier_gate import add, sub, neg, mul, inv, pmul, gcd, cartier_vector


def main():
    old = json.loads(Path('/Users/julian/Documents/litt3-computation-data/oct03_n24_cartier_gate/backup_cartier_gate.json').read_text())
    records = []
    for item in old['records']:
        phi = item['phi']
        phi2 = pmul(phi, phi)
        cols = [cartier_vector([0] * j + [1], phi2) for j in range(3)]
        a, b, d = cols
        determinant = sub(mul(a[0], b[1]), mul(b[0], a[1]))
        assert determinant, 'accepted ordinarity must give independent regular columns'
        c0 = mul(sub(mul(b[0], d[1]), mul(d[0], b[1])), inv(determinant))
        c1 = mul(sub(mul(d[0], a[1]), mul(a[0], d[1])), inv(determinant))
        quadratic = [c0, c1, 1]
        assert cartier_vector(quadratic, phi2) == [0, 0]
        records.append({'origin': item['origin'], 'phi': phi, 'columns': cols,
                        'regular_determinant': determinant, 'quadratic': quadratic,
                        'discriminant': sub(mul(c1, c1), mul(4, c0)),
                        'branch_gcd': gcd(quadratic, phi)})
    out = {'field': old['field'], 'records': records,
           'repeated_root_count': sum(not r['discriminant'] for r in records),
           'branch_root_count': sum(len(r['branch_gcd']) > 1 for r in records)}
    artifact = Path('/Users/julian/Documents/litt3-computation-data/oct03_n42_quadratic_cartier_gate/backup_quadratic_gate.json')
    artifact.parent.mkdir(parents=True, exist_ok=True)
    artifact.write_text(json.dumps(out, indent=2) + '\n')
    print(json.dumps(out))


if __name__ == '__main__':
    main()
