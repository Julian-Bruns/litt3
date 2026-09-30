#!/usr/bin/env python3
"""Bounded exact check of the abstract Cartier-tensor boundary model.

This constructs no curve or common cover.  Field elements (a,b) mean
a+b*zeta, with zeta^2+zeta+1=0 over F5.
"""
import itertools
import json


def mul(x, y):
    a, b = x
    c, d = y
    return ((a*c-b*d) % 5, (a*d+b*c-b*d) % 5)


def power(x, n):
    result = (1, 0)
    while n:
        if n & 1:
            result = mul(result, x)
        x = mul(x, x)
        n //= 2
    return result


def add(a, b):
    return tuple((x+y) % 3 for x, y in zip(a, b))


def neg(a):
    return tuple(-x % 3 for x in a)


def lam(a):
    return next(1 if x == 1 else 4 for x in a if x)


def beta(a, b):
    if a == b:
        return None
    return neg(add(a, b)), (lam(add(a, neg(b))), 0)


def check(m):
    points = list(itertools.product(range(3), repeat=m))
    zero = (0,) * m
    unit_vectors = [tuple(int(i == j) for i in range(m)) for j in range(m)]
    zeta = (0, 1)
    assert power(zeta, 3) == (1, 0) and zeta != (1, 0)
    generators = []
    for v in unit_vectors:
        generators.append({a: (add(a, v), (1, 0)) for a in points})
        generators.append({a: (a, power(zeta, sum(x*y for x, y in zip(v, a)) % 3))
                           for a in points})
    generators.append({a: (a, zeta) for a in points})
    checks = 0
    for gen in generators:
        for a in points:
            for b in points:
                original = beta(a, b)
                aa, ca = gen[a]
                bb, cb = gen[b]
                transformed = beta(aa, bb)
                if original is None:
                    assert transformed is None
                    continue
                out, coefficient = original
                expected_point, expected_scale = gen[out]
                actual_point, actual_scale = transformed
                # In F25 the inverse of fifth-power Frobenius is fifth power.
                actual_scale = mul(actual_scale, power(mul(ca, cb), 5))
                expected_scale = mul(coefficient, expected_scale)
                assert (actual_point, actual_scale) == (expected_point, expected_scale)
                checks += 1
    lines = set()
    for a in points:
        for v in points:
            if v != zero:
                lines.add(tuple(sorted((a, add(a, v), add(a, add(v, v))))))
    for line in lines:
        outputs = [beta(a, b) for a, b in itertools.combinations(line, 2)]
        assert set(out for out, scale in outputs) == set(line)
        assert all(scale != (0, 0) for out, scale in outputs)
    for left, right in itertools.combinations(lines, 2):
        assert len(set(left).intersection(right)) <= 1
    v = unit_vectors[0]
    parallel = {tuple(sorted((a, add(a, v), add(a, add(v, v))))) for a in points}
    assert len(parallel) == 3 ** (m-1)
    assert set().union(*(set(line) for line in parallel)) == set(points)
    return {'m': m, 'dimension': 3**m, 'heisenberg_order': 3**(2*m+1),
            'affine_lines': len(lines), 'orbit_parallel_lines': len(parallel),
            'generator_basis_pair_checks': checks, 'status': 'PASS'}


if __name__ == '__main__':
    print(json.dumps({'scope': 'Abstract algebra only; no geometric realization',
                      'checks': [check(2), check(3)]}, indent=2))
