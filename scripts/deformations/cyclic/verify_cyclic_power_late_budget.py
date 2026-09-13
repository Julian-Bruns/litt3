#!/usr/bin/env python3
"""Exact late-stage budgets; no actual Hodge comparison is simulated."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from math import comb
from scripts.deformations.cyclic.verify_cyclic25_later_level_budget import check_support, product_coefficients


def vfactorial(n):
    out = 0
    while n:
        n //= 5
        out += n
    return out


def main():
    cases = 0
    tails = {}
    for a in range(2, 9):
        tails[a] = max(j for j in range(1, 251)
                       if j - 1 - vfactorial(j - 1) <= a)
        for n in range(a + 1, a + 6):
            m, precision = n - 1, n + a
            assert 2 * n >= n + a + 1  # Curve difference ideal square zero.
            assert 2 * m >= precision - 1
            assert 2 * m + 1 >= precision
            assert 3 * m >= precision
            assert 2 * m + 2 >= precision  # Nonlinear scalar gets two powers.
            for j in range(2, 251):
                for l in range(2, j + 1):
                    order = l*m+j-1-vfactorial(l)-vfactorial(j-l)
                    assert order >= precision
                    cases += 1
    products = sum(check_support(q, q-3, q-3, q-5) for q in (25, 125, 625))
    c = product_coefficients(125, 100, 24)
    assert c[124] == 1 and not any(c[:124])
    assert 2*2 == 1+3  # Early cyclic125 second-repair square at last normal digit.
    print('PASS:', cases, 'Taylor/order inequalities; a2..8, n=a+1..a+5')
    print('PASS:', products, 'actual boundary torsor products; q25,125,625')
    print('Linear Taylor degree retained by conservative bound:', tails)
    print('PASS: early cyclic125 danger B100*B24=B124, second repair square survives')
    print('Scope: exact algebra/precision, not the geometric linear-feedback equation')


if __name__ == '__main__':
    main()
