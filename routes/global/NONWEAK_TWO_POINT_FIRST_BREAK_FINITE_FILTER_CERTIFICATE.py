"""Exact finite conditional filter, not a ramification-realization test."""

from math import gcd


def divisors(n):
    return [d for d in range(1, n+1) if n % d == 0]


def valuation5(n):
    assert n > 0
    v = 0
    while n % 5 == 0:
        n //= 5
        v += 1
    return v


def power5_residue(target, modulus):
    """Return (exponent residue, period), or None, by the exact finite orbit."""
    assert gcd(5, modulus) == 1
    target %= modulus
    x, exponent = 1 % modulus, 0
    answer = None
    while True:
        if x == target:
            answer = exponent
        x = 5*x % modulus
        exponent += 1
        if x == 1 % modulus:
            break
    return None if answer is None else (answer, exponent)


before_tail = []
rows = []
for D in divisors(16):
    for a in range(1, D):
        if gcd(a, D) != 1 or a % 5 == 0:
            continue
        # Enumerate c directly, independently of the initial h-loop calculation.
        for c in divisors(a+D):
            h = (a+D)//c
            if h < 2 or gcd(a, c) != 1 or c % 5 == 0:
                continue
            for b in range(1, 9):
                if a*b > c or b % 5 == 0:
                    continue
                B = a*(b+1)+D
                assert 0 < B < 48
                v = valuation5(B)
                if v:
                    before_tail.append((D, a, h, c, b, B, v))
                for s in range(1, 5):
                    if (s+1)//2 > v:
                        continue
                    if (c-a*b)*5**s < 5*a:
                        continue
                    tame_bound = b*(5**s-1)
                    if tame_bound % c:
                        continue
                    for t in divisors(tame_bound//c):
                        if t % 5 == 0:
                            continue
                        congruence = power5_residue(-h, a*t)
                        if congruence is not None:
                            rows.append((D, a, h, c, b, s, t,
                                         c*t, a*t, *congruence))

assert sorted(before_tail) == [(8, 1, 3, 3, 1, 10, 1),
                               (8, 1, 9, 1, 1, 10, 1)]
assert rows == [(8, 1, 3, 3, 1, 2, t, 3*t, t,
                 1 if t == 8 else 0, 2 if t == 8 else 1)
                for t in (1, 2, 4, 8)]
print("before-tail table:", sorted(before_tail))
print("rows (D,a,h,c,b,s,t,m,N,q_residue,q_period):")
for row in rows:
    print(row)
genuine_tame_rows = [row for row in rows if row[8] >= 2]
assert [row[6] for row in genuine_tame_rows] == [2, 4, 8]
print("With genuine tame inertia N>=2, retain t=2,4,8 only.")
print("PASS: four raw / three genuine-tame formal rows; no realizability asserted.")
