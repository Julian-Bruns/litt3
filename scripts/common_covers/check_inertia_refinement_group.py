#!/usr/bin/env python3
"""Frozen PSL2(F7) surface/inertia certificate; stdlib, one core, no search."""
from itertools import product
from time import perf_counter


def canonical(a):
    a = tuple(x % 7 for x in a)
    return min(a, tuple(-x % 7 for x in a))


def mul(a, b):
    x, y, z, w = a
    p, q, r, s = b
    return canonical((x*p+y*r, x*q+y*s, z*p+w*r, z*q+w*s))


def inv(a):
    x, y, z, w = a
    return canonical((w, -y, -z, x))


def power(a, n):
    b = ID
    for _ in range(n):
        b = mul(b, a)
    return b


def comm(a, b):
    return mul(mul(a, b), mul(inv(a), inv(b)))


def generated(gens):
    known, todo = {ID}, [ID]
    while todo:
        a = todo.pop()
        for b in gens:
            c = mul(a, b)
            if c not in known:
                known.add(c)
                todo.append(c)
    return known


ID = canonical((1, 0, 0, 1))
A, B = (1, 1, 0, 1), (1, 0, 1, 1)
TAU = {2: (0, 1, 6, 0), 3: (0, 1, 6, 1), 4: (0, 1, 6, 3)}
PAIRS = {
    2: [((0,1,6,2), (0,1,6,1)), ((0,2,3,3), (1,3,6,5))],
    3: [((0,1,6,2), (0,1,6,1)), ((0,1,6,1), (1,3,3,3)),
        ((0,3,2,0), (0,2,3,3))],
    4: [((0,1,6,2), (0,1,6,1)), ((0,1,6,0), (0,1,6,0)),
        ((0,1,6,1), (0,1,6,2)), ((0,1,6,3), (1,5,1,6))],
}


def check():
    start = perf_counter()
    group = {canonical(a) for a in product(range(7), repeat=4)
             if (a[0]*a[3]-a[1]*a[2]) % 7 == 1}
    assert len(group) == 168 and generated((A, B)) == group
    for a in group:
        assert mul(a, inv(a)) == ID
    for t in (comm(A, B), *TAU.values()):
        conjugates = {mul(mul(g, t), inv(g)) for g in group}
        assert generated(conjugates) == group
    for n, t in TAU.items():
        assert power(t, n) == ID
        assert all(power(t, j) != ID for j in range(1, n))
        for j, (c, d) in enumerate(PAIRS[n]):
            assert canonical(c) in group and canonical(d) in group
            assert mul(mul(comm(A, B), comm(c, d)), power(t, j)) == ID
        print(f'PASS index {n}: all {n} surface residues, full inertia closure')
    assert [n*(e+1) % 5 for e,n in ((1,3),(2,2),(3,4))] == [1,1,1]
    print(f'PASS order168, generators, perfectness; {perf_counter()-start:.3f}s')


if __name__ == '__main__':
    check()
