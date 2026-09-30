#!/usr/bin/env python3
"""Exact Hessian generator check in characteristic five; no dependencies."""
import argparse
import json
from collections import deque
from pathlib import Path


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def mul(a, b):
    x, y, z, t = a % 5, a // 5, b % 5, b // 5
    return (x*z-y*t) % 5 + 5*((x*t+y*z-y*t) % 5)


def power(a, n):
    r = 1
    while n:
        if n & 1:
            r = mul(r, a)
        a = mul(a, a)
        n //= 2
    return r


def mm(a, b):
    return tuple(add(add(mul(a[3*i], b[j]), mul(a[3*i+1], b[3+j])),
                     mul(a[3*i+2], b[6+j])) for i in range(3) for j in range(3))


I = (1, 0, 0, 0, 1, 0, 0, 0, 1)


def norm(a):
    c = power(next(x for x in a if x), 23)
    return tuple(mul(c, x) for x in a)


def pairing(a):
    dual = tuple(power(a[3*j+i], 5) for i in range(3) for j in range(3))
    result = mm(dual, a)
    c = result[0]
    assert c and result == tuple(mul(c, x) for x in I)
    return c


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    w, w2 = 5, power(5, 2)
    assert power(w, 3) == 1 and w != 1 and power(w, 5) == w2
    generators = [(0,1,0,0,0,1,1,0,0), (1,0,0,0,w,0,0,0,w2),
                  (1,1,1,1,w,w2,1,w2,w), (1,0,0,0,w,0,0,0,w)]
    scalars = [pairing(a) for a in generators]
    assert scalars == [1,1,3,1]
    seen, queue = {I}, deque([I])
    while queue:
        a = queue.popleft()
        for b in generators:
            c = norm(mm(a, b))
            if c not in seen:
                seen.add(c)
                queue.append(c)
        assert len(seen) <= 216
    assert len(seen) == 216
    for a in seen:
        pairing(a)
        assert tuple(power(x,25) for x in a) == a
    receipt = dict(status='PASS', field='F5[w]/(w^2+w+1)',
                   coding='a+5b denotes a+b*w', generators=generators,
                   generator_similitudes=scalars, projective_order=len(seen),
                   scope='Generator and group arithmetic only; classification is a cited input.')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2)+'\n')
    print('PASS: four pairings, 216 projective matrices, coefficient25-power identity.')


if __name__ == '__main__':
    main()
