#!/usr/bin/env sage-python
"""Independent finite-algebra audit; no geometric realization is asserted.

Use ordered words g^a h^b c^d, rather than the producer's upper-triangular
coordinate convention. Thus multiplication has central term -b*a'.
"""
import argparse
import itertools
import json
import time
from pathlib import Path

from sage.all import GF, matrix, vector


def check(p):
    k = GF(p)
    labels = list(itertools.product(range(p), repeat=3))
    lookup = {g: i for i, g in enumerate(labels)}
    size = len(labels)
    unit = vector(k, [int(g == (0, 0, 0)) for g in labels])
    identity = matrix.identity(k, size)

    def product(u, v):
        a, b, c = u
        d, e, f = v
        return ((a + d) % p, (b + e) % p, (c + f - b*d) % p)

    def translation(g, left=False):
        result = matrix(k, size, size)
        for i, h in enumerate(labels):
            result[i, lookup[product(g, h) if left else product(h, g)]] = 1
        return result

    generators = [(1, 0, 0), (0, 1, 0), (0, 0, 1)]
    right = [translation(g) - identity for g in generators]
    left = [translation(g, left=True) - identity for g in generators]
    x, y, z = right
    assert x*y-y*x == z*(identity+y)*(identity+x)
    assert x**p == y**p == z**p == matrix(k, size, size)

    pbw = [unit*x**a*y**b*z**c for a, b, c in labels]
    weight = [a+b+2*c for a, b, c in labels]
    assert matrix(k, pbw).rank() == size
    # Generate powers independently from both sides, retaining the central
    # generator. The two row spaces must agree at every level.
    current = identity.row_space()
    dimensions = []
    for depth in range(4*(p-1)+2):
        expected = matrix(k, [v for v, w in zip(pbw, weight) if w >= depth],
                          ncols=size).row_space()
        assert current == expected
        dimensions.append(int(current.dimension()))
        base = current.basis_matrix()
        next_right = (base*right[0]).stack(base*right[1]).stack(base*right[2]).row_space()
        next_left = (base*left[0]).stack(base*left[1]).stack(base*left[2]).row_space()
        assert next_right == next_left
        current = next_right

    hilbert = [dimensions[i]-dimensions[i+1] for i in range(len(dimensions)-1)]
    width = max(dimensions[i]-dimensions[i+2] for i in range(len(dimensions)-2))
    assert width == p*p

    # All index-p quotients, including non-coordinate characters. Norm from
    # each free quotient module is the basis of characteristic coset sums.
    quotient_tests = []
    for slope in [None] + list(range(p)):
        aa, bb = (0, 1) if slope is None else (1, slope)
        chi = [(aa*a+bb*b) % p for a, b, _ in labels]
        norm = matrix(k, [[int(v == j) for v in chi] for j in range(p)])
        assert norm.rank() == p
        for g, operator in zip(generators, right):
            shift = (aa*g[0]+bb*g[1]) % p
            qop = matrix(k, p, p)
            for j in range(p):
                qop[j, (j+shift) % p] += 1
                qop[j, j] -= 1
            assert norm*operator == qop*norm
        quotient_tests.append([aa, bb])

    # f=x has a nonzero linear term, detected by chi(g)=1, chi(h)=0:
    # its cyclic quotient has cokernel dimension one. This is an algebra
    # test of the geometric exclusion, not a geometric counterexample.
    linear_cokernel = size-int(x.rank())
    cyclic_x = matrix(k, p, p)
    for j in range(p):
        cyclic_x[j, (j+1) % p] += 1
        cyclic_x[j, j] -= 1
    assert p-cyclic_x.rank() == 1
    return {"p": p, "order": size, "radical_dimensions": dimensions,
            "hilbert": hilbert, "width": width,
            "norm_quotients": quotient_tests,
            "excluded_linear_cokernel": linear_cokernel}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    start = time.monotonic()
    rows = [check(p) for p in [3, 5]]
    # Independent coefficient counts, using tuples rather than convolution.
    abelian = []
    for q in [5, 25, 125]:
        for rank in [1, 2, 3]:
            h = [0] * (rank*(q-1)+1)
            for point in itertools.product(range(q), repeat=rank):
                h[sum(point)] += 1
            width = max(a+b for a, b in zip(h+[0], [0]+h))
            expected = 2 if rank == 1 else 2*q-1 if rank == 2 else (3*q*q-1)//2
            assert width == expected
            abelian.append({"q": q, "rank": rank, "width": width})
    receipt = {"status": "PASS", "heisenberg": rows, "abelian": abelian,
               "seconds": time.monotonic()-start,
               "scope": "Independent actual group-algebra radical and quotient-norm tests; no geometric realization."}
    Path(args.output).write_text(json.dumps(receipt, indent=2)+"\n")
    print(json.dumps(receipt))


if __name__ == "__main__":
    main()
