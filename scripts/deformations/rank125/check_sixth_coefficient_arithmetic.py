#!/usr/bin/env python3
"""Exact arithmetic certificate only; this does not compute a sixth obstruction."""
from math import factorial

MOD = 5**6
ZERO, ONE, T = (0, 0, 0), (1, 0, 0), (0, 1, 0)

def add(a, b):
    return tuple((x+y) % MOD for x, y in zip(a, b))

def neg(a):
    return tuple(-x % MOD for x in a)

def mul(a, b):
    c = [0] * 5
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] += x*y
    # T^3 = -T-1.
    for i in (4, 3):
        c[i-3] -= c[i]
        c[i-2] -= c[i]
    return tuple(x % MOD for x in c[:3])

def power(a, n):
    if n < 0:
        raise ValueError('Exponent must be nonnegative.')
    r = ONE
    while n:
        if n & 1:
            r = mul(r, a)
        a = mul(a, a)
        n //= 2
    return r

def inverse(a):
    if not any(x % 5 for x in a):
        raise ZeroDivisionError('Nonunit in the unramified coefficient ring.')
    x = power(a, 123)
    for _ in range(4):
        x = mul(x, add((2, 0, 0), neg(mul(a, x))))
    assert mul(a, x) == ONE
    return x

def defining_polynomial(a):
    return add(add(power(a, 3), a), ONE)

def main():
    s = power(T, 5)
    for _ in range(4):
        derivative = add(mul((3, 0, 0), power(s, 2)), ONE)
        s = add(s, neg(mul(defining_polynomial(s), inverse(derivative))))
    def sigma(a):
        return add(add((a[0], 0, 0), mul((a[1], 0, 0), s)),
                   mul((a[2], 0, 0), power(s, 2)))
    assert defining_polynomial(s) == ZERO
    assert tuple(x % 5 for x in s) == tuple(x % 5 for x in power(T, 5))
    assert tuple(x % 3125 for x in s) == (2871, 571, 2744)
    assert sigma(sigma(sigma(T))) == T
    assert s == (15371, 571, 15244)
    print('sigma(T) modulo 15625:', s)
    print('Defining equation, residue, old truncation, order three: PASS')
    # Coefficients in exp(5 A) modulo 5^6. Cancel all factors of 5
    # in the denominator before taking a modular inverse.
    result = []
    for j in range(1, 7):
        denominator, vp = factorial(j), 0
        while denominator % 5 == 0:
            denominator //= 5
            vp += 1
        result.append((j, (5**(j-vp) * pow(denominator, -1, MOD)) % MOD))
    print('Source exponential coefficients j=1,...,6:', result)
    assert result[-1][1] == (3125 * pow(144, -1, MOD)) % MOD
    print('No full tuple, relative sixth image, or sixth obstruction is certified.')

if __name__ == '__main__':
    main()
