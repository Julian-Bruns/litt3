#!/usr/bin/env sage -python
"""Exact dormant polynomial and Frobenius orbit on the cubic backup.

The universal scheme identification is the separate symbolic checker.
This script specializes its displayed formula, checks irreducibility by
modular powers, and records the single five-cycle of geometric points.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    A = PolynomialRing(GF(5), 'a'); a = A.gen()
    k = GF(125, 'alpha', modulus=a**3+a+1); alpha = k.gen()
    R = PolynomialRing(k, 'T'); T = R.gen()
    a0, a1, a2, a3, a4 = k(0), alpha, -alpha-1, alpha+1, -alpha-1
    W = T**2+3*a4*T+3*a3
    V = -a2+(a4+2*T)*W
    P = (2*a0-2*a1*T+a2*W-V*W).monic()
    expected = (T**5+(alpha+1)*T**4+(2*alpha**2+3)*T**3
                +3*alpha**2*T**2+(3*alpha**2+alpha+1)*T
                +2*alpha**2+2*alpha+3)
    assert P == expected
    assert P.gcd(P.derivative()) == 1
    q_power = pow(T, 125, P)
    assert P.gcd(q_power-T) == 1
    fifth_power = pow(T, 125**5, P)
    assert fifth_power == T
    assert P.is_irreducible()
    # Five prime degree: the two modular-power tests are also a complete
    # irreducibility certificate, independent of the factorization command.
    orbit = [T]
    for _ in range(5):
        orbit.append(pow(orbit[-1], 125, P))
    assert len(set(orbit[:-1])) == 5 and orbit[-1] == T
    receipt = dict(
        field_polynomial=str(k.modulus()), dormant_polynomial=str(P),
        coefficients=[[int(c) for c in v.polynomial().list()]
                      for v in P.list()],
        derivative_gcd=str(P.gcd(P.derivative())),
        rational_root_gcd=str(P.gcd(q_power-T)),
        fifth_frobenius_remainder=str(fifth_power),
        frobenius_orbit=[str(v) for v in orbit],
        irreducible=True, degree=5,
        source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        universal_checker_sha256=hashlib.sha256(
            Path(__file__).with_name('check_genus_two_dormant_quintic.sage').read_bytes()
        ).hexdigest(),
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2)+'\n')
    print('PASS: five dormant connections form one F125-Frobenius orbit.')
    print(P)


if __name__ == '__main__':
    main()
