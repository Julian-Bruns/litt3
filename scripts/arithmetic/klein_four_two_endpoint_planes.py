#!/usr/bin/env python3
"""Export the exact forced-label fields for the two-endpoint plane test."""
import argparse
import json
from pathlib import Path
from klein_four_constant_character_jet import F


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    data = F.construct_data()
    rows = []
    for alpha, base in zip(data['alpha_roots'], data['B_base']):
        alpha, base = tuple(alpha), tuple(base)
        der = F.ev(F.f.der(F.f.A), alpha)
        ca = F.es(F.ei(der), F.f.A[-1])
        la = F.em(ca, F.ea(
            F.em(F.ev(F.f.der(F.f.P), alpha), F.ei(F.ev(F.f.P, alpha))),
            F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)), alpha), F.ei(der)))))
        rows.append([alpha] + [F.ep(base, 25**((3*j) % 4)) for j in range(4)]
                    + [F.em(ca, F.ep(base, 4)), F.em(la, F.ep(base, 5))])
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({
        'A_monic': F.AMONIC, 'D7': F.D7,
        'columns': ['alpha', 'b', 'sigma_b', 'sigma2_b', 'sigma3_b', 'a', 'c'],
        'sigma': 'M-Frobenius restricts to 25^3 on K0; fixes zeta',
        'rows': rows}, indent=2) + '\n')
    with args.output.with_suffix('.dat').open('w') as f:
        print(*F.AMONIC, file=f)
        print(*F.D7, file=f)
        for row in rows:
            for a in row:
                print(*a, file=f)
    print(args.output.with_suffix('.dat'))


if __name__ == '__main__':
    main()
