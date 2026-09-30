#!/usr/bin/env python3
"""Exact bounded checks for the full truncated-coordinate group scheme.

This is a representation-theoretic model, not a common-cover construction.
The all-height proof is in Proofs/cartier_and_spin/
truncated_coordinate_algebra_model.md. Receipts belong outside litt3.
"""

import argparse
import hashlib
import json
from math import comb
from pathlib import Path


def valuation(i, p):
    answer = 0
    while i % p == 0:
        answer += 1
        i //= p
    return answer


def components(graph):
    """Kosaraju, with iterative depth-first search."""
    seen, order = set(), []
    for root in graph:
        if root in seen:
            continue
        seen.add(root)
        stack = [(root, iter(graph[root]))]
        while stack:
            vertex, neighbors = stack[-1]
            try:
                nxt = next(neighbors)
            except StopIteration:
                order.append(vertex)
                stack.pop()
                continue
            if nxt not in seen:
                seen.add(nxt)
                stack.append((nxt, iter(graph[nxt])))
    reverse = {i: set() for i in graph}
    for i, neighbors in graph.items():
        for j in neighbors:
            reverse[j].add(i)
    seen, result = set(), []
    for root in reversed(order):
        if root in seen:
            continue
        block, stack = set(), [root]
        seen.add(root)
        while stack:
            i = stack.pop()
            block.add(i)
            for j in reverse[i]:
                if j not in seen:
                    seen.add(j)
                    stack.append(j)
        result.append(block)
    return result


def check_height(p, r):
    q = p ** r
    graph = {i: set() for i in range(1, q)}
    for i in graph:
        # t -> t+b, b^q=0. These are group-SCHEME coefficient maps.
        for j in range(1, i + 1):
            if comb(i, j) % p:
                graph[i].add(j)
        # t -> t+a*t^m, a an indeterminate, 2<=m<q.
        for m in range(2, q):
            for ell in range(1, min(i, (q - 1 - i) // (m - 1)) + 1):
                if comb(i, ell) % p:
                    graph[i].add(i + ell * (m - 1))
    found = sorted(components(graph), key=min)
    expected = [{i for i in graph if valuation(i, p) == s} for s in range(r)]
    if found != expected:
        raise RuntimeError((p, r, 'incorrect strongly connected components'))
    for s, block in enumerate(found):
        reachable, stack = set(block), list(block)
        while stack:
            for j in graph[stack.pop()]:
                if j not in reachable:
                    reachable.add(j)
                    stack.append(j)
        want = {i for i in graph if i % (p ** s) == 0}
        if reachable != want:
            raise RuntimeError((p, r, s, 'incorrect closure'))
    return {
        'p': p, 'height': r, 'dimension': q - 1,
        'component_sizes_by_valuation': [len(v) for v in found],
        'proper_nonzero_submodule_dimensions': [p ** j - 1 for j in range(1, r)],
        'coaction_edges': sum(map(len, graph.values())),
        'status': 'PASS',
    }


def check_pairing():
    p = 5

    def multiply(left, right):
        answer = {}
        for a, ca in left.items():
            for b, cb in right.items():
                exponents = tuple(x + y for x, y in zip(a, b))
                if exponents[0] >= p or exponents[-1] >= p:
                    continue
                answer[exponents] = (answer.get(exponents, 0) + ca * cb) % p
        return {a: c for a, c in answer.items() if c}

    def derivative(poly):
        answer = {}
        for exponents, c in poly.items():
            degree = exponents[-1]
            if degree:
                answer[exponents[:-1] + (degree - 1,)] = c * degree % p
        return {a: c for a, c in answer.items() if c}

    phi = {}
    for i in range(p):
        powers = [0] * (p + 1)
        powers[i], powers[-1] = 1, i
        phi[tuple(powers)] = 1
    powers = [{(0,) * (p + 1): 1}]
    for i in range(1, p):
        powers.append(multiply(powers[-1], phi))
    for i in range(1, p):
        for j in range(1, p):
            transformed = multiply(powers[i], derivative(powers[j]))
            value = {a[:-1]: c for a, c in transformed.items() if a[-1] == p - 1}
            expected = {(0, p, 0, 0, 0): j} if i + j == p else {}
            if value != expected:
                raise RuntimeError((i, j, value, expected))
    # Antidiagonal entries 4,3,2,1; reversal sign (-1)^6=1.
    return {'p': p, 'determinant': 4 * 3 * 2 * 1 % p,
            'similitude_character': 'a1^5', 'status': 'PASS'}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    payload = {
        'scope': 'Bounded checks of the formal group-scheme model; no curve or span is constructed.',
        'source_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'lattices': [check_height(5, r) for r in range(1, 5)],
        'pairing': check_pairing(),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, indent=2) + '\n')
    print(json.dumps(payload, indent=2))


if __name__ == '__main__':
    main()
