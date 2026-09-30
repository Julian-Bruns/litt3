#!/usr/bin/env python3
"""Small independent rational audit of a marked relation superlattice.

Does not execute Jacobian arithmetic, prove a marked-point order, or
reprove primality of the primes supplied by the Sage factorization.
"""
import argparse
import hashlib
import json
import math
from fractions import Fraction as F
from pathlib import Path


PI = [3814697265625, -305175781250, -177001953125, 13916015625,
      -1210937500, 1451562500, 48171875, -58884375, 3536250, 601875,
      141450, -94215, 3083, 3716, -124, 57, -29, -2, 1]
Q = [1, 0, 0, 0, 1, 0, 0, 0, 1]


def reduce_q(polynomial):
    a = list(polynomial) + [0] * max(0, 8-len(polynomial))
    for i in range(len(a)-1, 7, -1):
        c = a[i]
        a[i] = 0
        a[i-4] -= c
        a[i-8] -= c
    return a[:8]


def inverse_and_det(a):
    n = len(a)
    b = [[F(x) for x in row] + [F(i == j) for j in range(n)]
         for i, row in enumerate(a)]
    det = F(1)
    for j in range(n):
        pivot = next(i for i in range(j, n) if b[i][j])
        if pivot != j:
            b[pivot], b[j] = b[j], b[pivot]
            det = -det
        c = b[j][j]
        det *= c
        b[j] = [x/c for x in b[j]]
        for i in range(n):
            if i != j:
                c = b[i][j]
                b[i] = [x-c*y for x, y in zip(b[i], b[j])]
    return [row[n:] for row in b], det


def trim(a):
    while a and a[-1] == 0:
        a.pop()
    return a


def remainder(a, b, ell):
    a = trim([x % ell for x in a])
    while len(a) >= len(b):
        shift = len(a)-len(b)
        c = a[-1]*pow(b[-1], -1, ell) % ell
        for j, x in enumerate(b):
            a[j+shift] = (a[j+shift]-c*x) % ell
        trim(a)
    return a


def gcd_mod(a, b, ell):
    a, b = trim([x % ell for x in a]), trim([x % ell for x in b])
    while b:
        a, b = b, remainder(a, b, ell)
    c = pow(a[-1], -1, ell)
    return [x*c % ell for x in a]


def product(a, b):
    return [[sum(x*y for x, y in zip(row, col)) for col in zip(*b)]
            for row in a]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("receipt", type=Path)
    p.add_argument("output", type=Path)
    args = p.parse_args()
    raw = args.receipt.read_bytes()
    rec = json.loads(raw)
    M = [reduce_q([0]*i+PI) for i in range(8)]
    minv, mdet = inverse_and_det(M)
    exponent = math.lcm(*(c.denominator for row in minv for c in row))
    assert exponent == int(rec["module_exponent"])

    basis = [[int(c) for c in row] for row in rec["basis_rows"]]
    inverse, index = inverse_and_det(basis)
    assert inverse == [[F(c) for c in row] for row in rec["inverse_rows"]]
    rows = rec["modular_rows"]
    for item in rows:
        ell, root = int(item["prime"]), int(item["root"])
        assert 0 <= root < ell and exponent % ell == 0
        assert gcd_mod(PI, Q, ell) == [-root % ell, 1]
        values = [pow(root, i, ell) for i in range(8)]
        assert all(sum(x*y for x, y in zip(row, values)) % ell == 0
                   for row in basis)
    primes = [int(row["prime"]) for row in rows]
    assert len(set(primes)) == len(primes)
    assert all(math.gcd(a, b) == 1 for i, a in enumerate(primes)
               for b in primes[i+1:])
    assert abs(index) == math.prod(primes)

    twelve = [reduce_q([0]*j+[1]) for j in range(12)]
    coordinates = product(twelve, inverse)
    assert coordinates == [[F(c) for c in row]
                           for row in rec["twelve_point_coordinate_rows"]]
    maximum = max(abs(c) for row in coordinates for c in row)
    cutoff = math.ceil(1/maximum)-1
    assert maximum == F(rec["max_coordinate"])
    assert cutoff == int(rec["supported_function_invariance_through"])
    assert cutoff*maximum < 1 <= (cutoff+1)*maximum
    # The only integral relations among the twelve reduced monomials
    # equate the three multiplicities in each residue class modulo four.
    for i in range(4):
        assert all(twelve[i][j]+twelve[i+4][j]+twelve[i+8][j] == 0
                   for j in range(8))
    output = {
        "status": "PASS small conditional lattice arithmetic",
        "input": str(args.receipt),
        "input_sha256": hashlib.sha256(raw).hexdigest(),
        "input_is_conditional": bool(rec["conditional"]),
        "point_order_independently_verified": False,
        "primality_reproved": False,
        "necessary_hypothesis": "Every listed prime divides the actual order of kappa",
        "presented_module_order": str(abs(mdet)),
        "presented_module_exponent": str(exponent),
        "modular_rows_checked": len(rows),
        "superlattice_index": str(abs(index)),
        "max_coordinate": str(maximum),
        "conditional_invariance_cutoff": cutoff,
        "checks": {"modular_gcds": True, "lattice_congruences": True,
                   "index": True, "rational_inverse": True,
                   "all_twelve_coordinate_rows": True,
                   "strict_cutoff": True, "sheet_relations": True},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2)+"\n")
    print("PASS conditional lattice arithmetic:", len(rows), "rows; cutoff", cutoff)


if __name__ == "__main__":
    main()
