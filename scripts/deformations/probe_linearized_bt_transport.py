#!/usr/bin/env python3
"""Exact linearized Frobenius transport; not an actual nonlinear jet theorem.

Coefficients are rational linear combinations of formal symbols Z_s,
with sigma(Z_s)=Z_(s+1). The seed is b(0)=Z_-1 and the infinitesimal
window displacement is J=Z_-1-Z_1. This records exact valuations,
including all nonleading Frobenius terms.
"""
import argparse
import json
from fractions import Fraction
from pathlib import Path


def add(a, b, factor=Fraction(1), shift=0):
    out = dict(a)
    for i, v in b.items():
        out[i+shift] = out.get(i+shift, Fraction(0))+factor*v
        if not out[i+shift]:
            del out[i+shift]
    return out


def valuation(q, p=5):
    def v(n):
        out = 0
        while n and n % p == 0:
            out += 1
            n //= p
        return out
    return v(q.numerator)-v(q.denominator)


def probe(max_degree, p=5):
    b = [{} for _ in range(max_degree+1)]
    b[0] = {-1: Fraction(1)}
    for n in range(1, max_degree+1):
        if n % (p*p) == 0:
            b[n] = add(b[n], b[n//(p*p)], shift=2)
        power = 1
        k = 0
        while 1+power <= n:
            numerator = n-1-power
            denominator = p*power
            if numerator % denominator == 0:
                m = numerator//denominator
                factor = -Fraction(1, p) if k == 0 else Fraction(2*(-1)**(k+1), p)
                b[n] = add(b[n], b[m], factor, k+1)
            power *= p
            k += 1

    # a+sigma(a)=t*sigma(b)/p, with a(0)=0; c=sigma(b)/p.
    a = [{} for _ in b]
    c = [{} for _ in b]
    for n in range(max_degree+1):
        if n % p == 0:
            c[n] = add({}, b[n//p], Fraction(1, p), 1)
        if n:
            a[n] = add({}, c[n-1])
            if n % p == 0:
                a[n] = add(a[n], a[n//p], Fraction(-1), 1)

    # Check all four entries of K F - F sigma(K)=J E11.
    for n in range(max_degree+1):
        top_left = dict(b[n])
        if n % p == 0:
            top_left = add(top_left, c[n//p], -p, 1)
        if n:
            top_left = add(top_left, a[n-1])
            if (n-1) % p == 0:
                top_left = add(top_left, a[(n-1)//p], Fraction(-1), 1)
        assert top_left == ({-1: Fraction(1), 1: Fraction(-1)} if n == 0 else {})
        diagonal = add({}, c[n], p)
        if n % p == 0:
            diagonal = add(diagonal, b[n//p], Fraction(-1), 1)
        assert not diagonal
        lower = add({}, a[n], Fraction(-1))
        if n % p == 0:
            lower = add(lower, a[n//p], Fraction(-1), 1)
        if n:
            lower = add(lower, c[n-1])
        assert not lower

    records = []
    previous = 1
    for n, value in enumerate(b):
        if not value:
            continue
        v = min(valuation(q, p) for q in value.values())
        if v < previous:
            previous = v
            records.append({'degree': n, 'valuation': v,
                            'coefficient': {str(i): str(q) for i, q in value.items()}})
    predictions = []
    level = 1
    while (p**level-1)//2 <= max_degree:
        m = (p**level-1)//2
        assert b[m] == {level-1: Fraction((-1)**level, p**level)}
        assert all(not v or min(valuation(q, p) for q in v.values()) > -level
                   for v in b[:m])
        predictions.append({'level': level, 'first_degree': m,
                            'coefficient': f'(-1)^{level}*Z_{level-1}/{p}^{level}'})
        level += 1
    return {'max_degree': max_degree, 'prime': p,
            'record_valuations_upper_right': records,
            'verified_thresholds': predictions,
            'frobenius_matrix_identity': 'K F-F sigma(K)=J E11',
            'scope': 'First-order characteristic-zero transport only; nonlinear actual-coordinate terms are not certified.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--max-degree', type=int, default=1600)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = probe(args.max_degree)
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Generated evidence must be outside litt3')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
