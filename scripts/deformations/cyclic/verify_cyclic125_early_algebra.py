#!/usr/bin/env python3
"""Exact C125 early-stage algebra. No higher Hodge comparison asserted."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from math import comb
from scripts.deformations.cyclic.verify_cyclic25_later_level_budget import product_coefficients

Q, MOD = 125, 25


def diff(v):
    return [(v[(i+1) % Q]-v[i]) % MOD for i in range(Q)]


def power_diff(v, r):
    for _ in range(r):
        v = diff(v)
    return v


def binomial_coordinates(v, modulus):
    out = []
    while v:
        out.append(v[0] % modulus)
        v = [(b-a) % modulus for a, b in zip(v, v[1:])]
    return out


def product_check(c):
    r, low = Q-c, 2*c-2
    # The invariant RHS is e^(Q-2c+1) A_2 + 5 e^(Q/5-2c+1) A_2.
    rhs_power, after_division = Q-2*c+1, Q//5-2*c+1
    v = power_diff([1]+[0]*(Q-1), r)
    lifts = []
    for j in range(low+1):
        b = [comb(i, rhs_power+j) % MOD if i >= rhs_power+j else 0
             for i in range(Q)]
        lift = power_diff(b, rhs_power)
        assert binomial_coordinates([x % 5 for x in lift], 5) == \
               [int(i == j) for i in range(Q)]
        lifts.append(lift)
    for shift in range(Q):
        other = v[shift:]+v[:shift]
        product = [a*b % MOD for a,b in zip(v, other)]
        coords = binomial_coordinates([x % 5 for x in product], 5)
        assert not any(coords[low+1:])
        matching = [sum(coords[j]*lifts[j][i] for j in range(low+1)) % MOD
                    for i in range(Q)]
        residual = [(x-y) % MOD for x,y in zip(product,matching)]
        assert all(x % 5 == 0 for x in residual)
        divided = binomial_coordinates([x//5 for x in residual], 5)
        assert not any(divided[Q-after_division:])
    # Translation reduces all Q^2 delta-basis pairs to the Q tested shifts.
    print(f'PASS: (e^{r} A_2)^2 subset e^{rhs_power} A_2 + 5 e^{after_division} A_2')
    print(f'      {Q} relative-shift pairs certify all {Q*Q} delta-basis pairs')


def pure_kernel_carries():
    modulus = 625
    relation = [comb(Q,j) % modulus for j in range(Q)]
    relation[0] = 0
    def e2(v):
        a = [0,0]+v
        for i in range(Q+1,Q-1,-1):
            for j in range(Q):
                a[i-Q+j] -= a[i]*relation[j]
        return [x % modulus for x in a[:Q]]
    x = [0]*Q
    x[123] = 1
    supports = []
    for digit in (1,2):
        raw = e2(x)
        assert all(v % 5**digit == 0 for v in raw)
        residue = [(v//5**digit) % 5 for v in raw]
        assert residue[:2] == [0,0]
        repair = [(-v) % 5 for v in residue[2:]]+[0,0]
        support = [i for i,v in enumerate(repair) if v]
        supports.append((digit,support))
        x = [(v+5**digit*w) % modulus for v,w in zip(x,repair)]
    raw = e2(x)
    assert all(v % 125 == 0 for v in raw)
    residue = [(v//125) % 5 for v in raw]
    assert residue[:2] == [0,4]
    print('PASS: pure third divided residue = -e; normal orientation +e')
    print('First/second linear repair supports:',supports)


def main():
    for c in (2,3,4,5):
        v = power_diff([1]+[0]*(Q-1), Q-c)
        for shift in range(Q):
            coeffs = binomial_coordinates(v[shift:]+v[:shift], MOD)
            assert all(x % 5 == 0 for x in coeffs[c:])
            assert not any(coeffs[100+c:])
    print('PASS: exact wrap-support P_(c-1)+5P_(100+c-1), c2..5')
    product_check(2)
    product_check(3)
    pure_kernel_carries()
    c = product_coefficients(125,100,24)
    assert c[124] == 1 and not any(c[:124])
    # A SINGLE square also escapes eA, not only a polarized product.
    sq = [a+b+2*z for a,b,z in zip(product_coefficients(125,100,100),
                                  product_coefficients(125,24,24),c)]
    assert sq[124] % 5 == 2
    print('PASS: (B100+B24)^2 has B124 coefficient2; it lies outside eA')
    print('Scope: integral functions and linear residues; actual nonlinear Hodge class open')


if __name__ == '__main__':
    main()
