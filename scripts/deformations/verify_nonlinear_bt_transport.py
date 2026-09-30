#!/usr/bin/env python3
"""Bounded checks of the nonlinear finite-jet integrality estimate.

This checks the rational Frobenius recursion, including mixed h terms.
It does not certify a chosen initial matrix is an effective full fiber
comparison, nor the Grothendieck--Messing interpretation of the first
Hodge defect. Those are separate steps of the human proof.
"""
import argparse
import json
from pathlib import Path

from verify_bt_obstruction_transport import field


def check():
    rows = []
    for nlevel in range(1, 6):
        precision = 3*nlevel+5
        modulus = 5**precision
        add, neg, mul, power = field(3, [1, 1, 0], modulus)
        zero, one, alpha = (0, 0, 0), (1, 0, 0), (0, 1, 0)
        def sc(x):
            return (x % modulus, 0, 0)
        def inverse(x):
            return power(x, 124*5**(3*(precision-1))-1)
        sigma_alpha = power(alpha, 5)
        for _ in range(precision):
            residual = add(add(power(sigma_alpha, 3), sigma_alpha), one)
            derivative = add(mul(sc(3), power(sigma_alpha, 2)), one)
            sigma_alpha = add(sigma_alpha, neg(mul(residual, inverse(derivative))))
        sigma_alpha2 = mul(sigma_alpha, sigma_alpha)
        def sigma(x):
            return add(add(sc(x[0]), mul(sc(x[1]), sigma_alpha)),
                       mul(sc(x[2]), sigma_alpha2))
        def sigma2(x):
            return sigma(sigma(x))
        assert sigma(sigma2(alpha)) == alpha
        def divide5(x):
            assert all(c % 5 == 0 for c in x), (nlevel, x)
            return tuple(c//5 for c in x)
        def valuation(x):
            if x == zero:
                return precision
            v = precision
            for c in x:
                if c:
                    w = 0
                    while c % 5 == 0:
                        c //= 5
                        w += 1
                    v = min(v, w)
            return v
        breaks = [(5**r-1)//2 for r in range(nlevel+1)]
        degree = breaks[-1]
        for case in range(3):
            # Arbitrary higher initial digits and nonlinear h terms.
            h = {i: mul(sc(5**nlevel), (case+i+1, i+2, 2*case+i))
                 for i in (0, 1, 2, 7, 17) if i <= degree}
            a = [zero]*(degree+1)
            b = [zero]*(degree+1)
            a[0] = add(one, mul(sc(5**nlevel), (case+1, 2, 1)))
            b[0] = mul(sc(5**nlevel), add(alpha, mul(sc(5), (case, 1, 3))))
            for m in range(1, degree+1):
                an = zero
                if m % 25 == 0:
                    an = add(an, sigma2(a[m//25]))
                if (m-1) % 5 == 0:
                    an = add(an, divide5(sigma(b[(m-1)//5])))
                if m >= 5 and (m-5) % 25 == 0:
                    an = add(an, neg(divide5(sigma2(b[(m-5)//25]))))
                for i, hi in h.items():
                    if m >= i and (m-i) % 5 == 0:
                        an = add(an, divide5(mul(hi, sigma(b[(m-i)//5]))))
                a[m] = an
                bn = zero
                if m % 25 == 0:
                    bn = add(bn, sigma2(b[m//25]))
                if (m-1) % 5 == 0:
                    bn = add(bn, sigma(a[(m-1)//5]))
                bn = add(bn, neg(a[m-1]))
                for i, hi in h.items():
                    if m >= i and (m-i) % 5 == 0:
                        bn = add(bn, mul(hi, sigma(a[(m-i)//5])))
                b[m] = bn
                wb = max(r for r in range(nlevel+1) if breaks[r] <= m)
                wa = max([0]+[r for r in range(1, nlevel+1) if breaks[r]-1 <= m])
                assert valuation(bn) >= nlevel-wb, (nlevel, case, m, 'b')
                assert valuation(an) >= nlevel-wa, (nlevel, case, m, 'a')
            critical = []
            expected = b[0]
            for r in range(1, nlevel+1):
                expected = neg(divide5(sigma(expected)))
                residual = add(b[breaks[r]], neg(expected))
                assert valuation(residual) >= nlevel-r+1, (nlevel, case, r)
                critical.append({'degree': breaks[r], 'valuation': valuation(b[breaks[r]])})
            assert all(valuation(v) >= 1 for v in b[:degree])
            assert valuation(b[degree]) == 0
            # Every lower-left coefficient needed at this finite jet is integral.
            for m in range(degree//5+1):
                divide5(sigma(b[m]))
            rows.append({'level': nlevel, 'case': case, 'degree': degree,
                         'working_padic_precision': precision,
                         'critical_coefficients': critical})
    return {'status': 'PASS', 'cases': rows,
            'scope': 'Nonlinear coefficient bounds and critical congruence only; no effectivity claim.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = check()
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Generated evidence must be outside litt3')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
