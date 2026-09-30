#!/usr/bin/env sage -python
"""Exact PGL2 stabilizer of the UNWEIGHTED eleven-point branch set.

This is stronger than Aut(X)=C3: a branch-set automorphism moving
infinity need not preserve the Kummer exponents.  SageMath required.
Generated output belongs outside the research workspace.
"""
import argparse
import itertools
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, identity_matrix, matrix


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    field = GF(5**8, name="b")
    polynomials = PolynomialRing(field, "x")
    x = polynomials.gen()

    def code(value):
        values = [int(c) for c in field(value).polynomial().list()]
        return values + [0]*(8-len(values))

    a = sorted((x*x-x-3).roots(multiplicities=False), key=code)[0]
    assert a*a == a+3
    coefficients = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    p = sum((field(c % 5) + field(c // 5)*a)*x**i
            for i, c in enumerate(coefficients))
    assert p.gcd(p.derivative()) == 1
    roots = sorted(p.roots(multiplicities=False), key=code)
    assert len(roots) == 10
    points = [(field(1), field(0))] + [(r, field(1)) for r in roots]

    def normalize(point):
        u, v = point
        assert u or v
        return (u/v, field(1)) if v else (field(1), field(0))

    point_set = set(points)

    def chart(triple):
        # Sends the ordered triple (a,b,c) to (infinity,0,1).
        aa, bb, cc = triple
        ca = cc[0]*aa[1] - cc[1]*aa[0]
        cb = cc[0]*bb[1] - cc[1]*bb[0]
        result = matrix(field, [[bb[1]*ca, -bb[0]*ca],
                               [aa[1]*cb, -aa[0]*cb]])
        assert result.det()
        expected = [(field(1), field(0)), (field(0), field(1)),
                    (field(1), field(1))]
        for z, target in zip(triple, expected):
            assert normalize((result[0, 0]*z[0]+result[0, 1]*z[1],
                              result[1, 0]*z[0]+result[1, 1]*z[1])) == target
        return result

    source = chart(points[:3])
    survivors = []
    first_failure_histogram = {}
    candidates = 0
    for target in itertools.permutations(points, 3):
        transform = chart(target).inverse()*source
        candidates += 1
        for index, z in enumerate(points):
            image = normalize((transform[0, 0]*z[0]+transform[0, 1]*z[1],
                               transform[1, 0]*z[0]+transform[1, 1]*z[1]))
            if image not in point_set:
                first_failure_histogram[index] = first_failure_histogram.get(index, 0)+1
                break
        else:
            scalar = next(entry for entry in transform.list() if entry)
            transform /= scalar
            survivors.append([[code(transform[i, j]) for j in range(2)]
                              for i in range(2)])
            assert transform == identity_matrix(field, 2)
    assert candidates == 990 and len(survivors) == 1
    assert sum(first_failure_histogram.values()) == 989
    result = {
        "scope": "Unweighted geometric branch-set stabilizer only; no common cover constructed",
        "field_size": 5**8,
        "field_modulus_ascending": [int(c) for c in field.modulus().list()],
        "a_in_field_basis": code(a),
        "P_coefficients_F25_codes": coefficients,
        "finite_roots_in_field_basis": [code(r) for r in roots],
        "candidate_ordered_triples": candidates,
        "rejected_at_point_index": first_failure_histogram,
        "surviving_projective_matrices": survivors,
        "geometric_stabilizer_order": len(survivors),
        "status": "PASS"
    }
    output = json.dumps(result, indent=2)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output)
    print(output, end="")


if __name__ == "__main__":
    main()
