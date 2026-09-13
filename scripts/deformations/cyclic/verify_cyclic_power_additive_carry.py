#!/usr/bin/env python3
"""Exact mixed-additive cyclic norm tests; no Hodge geometry is certified.

Coefficient module: K=(Z/5^(a+1))^2, with Phi(x,y)=(x,-y), the
coefficient Frobenius on the unramified quadratic algebra s^2=2.
Test L=e^2 Phi+5 C(e), with arbitrary, noncommuting 2x2 coefficient
operators. All arithmetic uses integers. No external packages.
"""

import argparse
import json
import random
import time
from math import comb


def phi(vector, modulus):
    return (vector[0] % modulus, -vector[1] % modulus)


def matrix_product(left, right, modulus):
    a, b, c, d = left
    x, y, z, w = right
    return ((a*x+b*z) % modulus, (a*y+b*w) % modulus,
            (c*x+d*z) % modulus, (c*y+d*w) % modulus)


def apply_operator(operator, vector, relation, modulus):
    q = len(vector)
    out = [[0, 0] for _ in range(2*q-1)]
    support = [(j, x, y) for j, (x, y) in enumerate(vector) if x or y]
    for i, (a, b, c, d) in enumerate(operator):
        if a or b or c or d:
            for j, x, y in support:
                out[i+j][0] += a*x+b*y
                out[i+j][1] += c*x+d*y
    for i in range(2*q-2, q-1, -1):
        x, y = (out[i][0] % modulus, out[i][1] % modulus)
        if x or y:
            for j, coefficient in enumerate(relation):
                if coefficient:
                    out[i-q+j][0] -= coefficient*x
                    out[i-q+j][1] -= coefficient*y
    return [(x % modulus, y % modulus) for x, y in out[:q]]


def residual(operator, vector, eta, relation, norm, modulus):
    return [((x-n*eta[0]) % modulus, (y-n*eta[1]) % modulus)
            for (x, y), n in zip(
                apply_operator(operator, vector, relation, modulus), norm)]


def add_digit(vector, correction, scale, modulus):
    return [((x+scale*z) % modulus, (y+scale*w) % modulus)
            for (x, y), (z, w) in zip(vector, correction)]


def divided(raw, scale):
    assert all(x % scale == y % scale == 0 for x, y in raw)
    return [(x//scale % 5, y//scale % 5) for x, y in raw]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--max-power', type=int, choices=[1, 2, 3], default=3)
    parser.add_argument('--seed', type=int, default=20260910)
    args = parser.parse_args()
    rng = random.Random(args.seed)
    started = time.monotonic()
    field = [(x, y) for x in range(5) for y in range(5)]
    records = []
    for power in range(1, args.max_power+1):
        q = 5**power
        modulus = 5**(power+1)
        relation = [comb(q, j) % modulus for j in range(q)]
        relation[0] = 0  # F=(1+e)^q-1, not (1+e)^q.
        norm = [comb(q, j+1) % modulus for j in range(q)]
        if power <= 2:
            samples = [(c, d, rng.choice(field)) for c in field for d in field]
        else:
            samples = [tuple(rng.choice(field) for _ in range(3))
                       for _ in range(12)]
        # Every primitive kernel reduction, with independently varied operators.
        samples += [((0, 0), (0, 0), b) for b in field]
        solved = 0
        noncommuting = 0
        for c, d, b in samples:
            correction_operators = [tuple(rng.randrange(modulus//5)
                                           for _ in range(4)) for _ in range(q)]
            # Test operators outside the scalar coefficient-multiplier class.
            m0, m1 = correction_operators[:2]
            if matrix_product(m0, m1, 5) != matrix_product(m1, m0, 5):
                noncommuting += 1
            operator = [tuple(5*x % modulus for x in block)
                        for block in correction_operators]
            a0, a1, a2, a3 = operator[2]
            operator[2] = ((a0+1) % modulus, a1, a2, (a3-1) % modulus)
            vector = [(0, 0)]*q
            vector[q-3], vector[q-2], vector[q-1] = (
                phi(c, 5), phi(d, 5), phi(b, 5))
            eta = c
            for digit in range(1, power):
                scale = 5**digit
                r = divided(residual(operator, vector, eta, relation,
                                     norm, modulus), scale)
                assert r[:2] == [(0, 0), (0, 0)], ('early cokernel', power, digit)
                repair = [phi((-x, -y), 5) for x, y in r[2:]] + [(0, 0)]*2
                eta_digit = rng.choice(field)
                extra = phi(eta_digit, 5)
                old = repair[q-3]
                repair[q-3] = ((old[0]+extra[0]) % 5, (old[1]+extra[1]) % 5)
                repair[q-2], repair[q-1] = rng.choice(field), rng.choice(field)
                threshold = 5**(power-digit)-3
                assert all(x == (0, 0) for x in repair[:threshold]), (
                    'repair support', power, digit)
                eta = ((eta[0]+scale*eta_digit[0]) % modulus,
                       (eta[1]+scale*eta_digit[1]) % modulus)
                vector = add_digit(vector, repair, scale, modulus)
            eta_digit = rng.choice(field)
            eta = ((eta[0]+5**power*eta_digit[0]) % modulus,
                   (eta[1]+5**power*eta_digit[1]) % modulus)
            r = divided(residual(operator, vector, eta, relation,
                                 norm, modulus), 5**power)
            expected = [((-c[0]) % 5, (-c[1]) % 5),
                        ((-2*c[0]-d[0]) % 5, (-2*c[1]-d[1]) % 5)]
            assert r[:2] == expected, ('last carry', power, c, d, b, r[:2])
            if c == d == (0, 0):
                repair = [phi((-x, -y), 5) for x, y in r[2:]] + [(0, 0)]*2
                vector = add_digit(vector, repair, 5**power, modulus)
                assert all(x == (0, 0) for x in residual(
                    operator, vector, eta, relation, norm, modulus))
                assert all(x % 5 == y % 5 == 0 for x, y in vector[:-1])
                assert tuple(x % 5 for x in vector[-1]) == phi(b, 5)
                solved += 1
        assert noncommuting > 0
        record = dict(group_order=q, coefficient_rank=2, samples=len(samples),
                      noncommuting_correction_samples=noncommuting,
                      completed_norm_solutions=solved,
                      last_coordinates='(-c,-2c-d), c,d already Phi transported',
                      early_cokernel_zero=True, status='PASS')
        records.append(record)
        print(json.dumps(record), flush=True)
    print(json.dumps(dict(status='PASS', seed=args.seed,
                          total_samples=sum(r['samples'] for r in records),
                          seconds=round(time.monotonic()-started, 4),
                          scope='Finite exact additive algebra tests; not exhaustive or Hodge geometry')))


if __name__ == '__main__':
    main()
