#!/usr/bin/env python3
"""Check the degree-thirteen branch polynomial used in the orbit Pro batch.

Run with Sage's Python. This checks the polynomial identity, reducedness,
disjointness, and the local transverse branched-plane example. The
geometric saturation and degree argument is in the accompanying note.
"""

import argparse
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix, version


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).resolve().parents[3]
        / "litt3-computation-data"
        / "cartier_positive_plane_branch_20260923"
        / "verification.json",
    )
    args = parser.parse_args()
    K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
    a = K.gen()
    R = PolynomialRing(K, "x")
    x = R.gen()
    decode = lambda n: K(n % 5) + K(n // 5) * a
    encode = lambda c: int(c.polynomial()[0]) + 5 * int(c.polynomial()[1])
    poly = lambda ns: R([decode(n) for n in ns])
    P = poly([11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1])
    W = poly([3, 1, 13, 11, 8, 17, 9, 3])
    A = poly([1, 21, 14, 22, 13])
    q = [poly(ns) for ns in ([24, 2, 1], [5, 16, 0, 1],
                             [5, 20, 0, 0, 8, 1])]
    r = [decode(19) + x, -decode(16) - x,
         decode(20) + decode(14) * x + decode(15) * x**2]
    determinant = sum(
        r[i]**5 * (q[(i+1) % 3] * q[(i+2) % 3].derivative()
                   - q[(i+2) % 3] * q[(i+1) % 3].derivative())
        for i in range(3)
    )
    assert determinant == P * A
    assert r[0] + r[1] == 3
    assert A.degree() == 4 and A.is_squarefree()
    assert A.gcd(P) == 1 and A.gcd(W) == 1
    assert A.is_irreducible()

    form = matrix(K, 4, 4,
                  lambda i, j: K(1) / K(i+1) if i+j == 3 else K(0))
    p = matrix(K, [[1, 0, 0, 0], [0, 0, 1, 0]])
    qlocal = matrix(K, [[1, 1, 0, 0], [0, 0, 1, 2]])
    assert p * form * p.transpose() == 0
    assert qlocal * form * qlocal.transpose() == 0
    assert p.stack(qlocal).det() != 0
    for f, g in ((R(1), x**2), (1+x, x**2+2*x**3)):
        wr = f*g.derivative()-f.derivative()*g
        assert wr[0] == 0 and wr[1] != 0

    receipt = {
        "status": "PASS",
        "sage": version(),
        "scope": "Exact arithmetic only; geometric proof is in the research note",
        "identity": "sum r_i^5 (q_j q_k' - q_k q_j') = P*A",
        "determinant_degree": int(determinant.degree()),
        "A_ascending": [encode(c) for c in A.list()],
        "A_monic_ascending": [encode(c) for c in A.monic().list()],
        "squarefree_and_coprime_to_PW": True,
        "irreducible_over_F25": True,
        "transverse_lagrangian_local_example": True,
        "both_local_wronskians_have_simple_zero": True,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print(json.dumps(receipt, indent=2))


if __name__ == "__main__":
    main()
