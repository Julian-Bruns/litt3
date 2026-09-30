#!/usr/bin/env python3
"""Exact bounded certificate for the first Frobenius HN calculation.

Run with Sage's Python. JSON goes to stdout; store generated receipts outside
the repository. The accompanying note proves geometric stability from these
extension coefficients; the script does not enumerate etale covers.
"""
import json

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    base = GF(5)
    field = GF(25, "a", modulus=PolynomialRing(base, "z")([2, 4, 1]))
    a = field.gen()
    ring = PolynomialRing(field, "x")
    x = ring.gen()

    def code(n):
        return field(n % 5) + (n // 5) * a

    def encode(c):
        row = field(c).polynomial().list()
        return sum(int(v) * 5**i for i, v in enumerate(row))

    def poly(row):
        return ring([code(n) for n in row])

    def codes(f):
        return [encode(c) for c in f.list()]

    def dot(u, v):
        return sum(s * t for s, t in zip(u, v))

    P = poly([11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1])
    W = poly([3, 1, 13, 11, 8, 17, 9, 3])
    q = [poly(row) for row in
         ([24, 2, 1], [5, 16, 0, 1], [5, 20, 0, 0, 8, 1])]
    r2 = [poly([19, 1]), -poly([16, 1]), poly([20, 14, 15])]
    r3 = [ring(1), -poly([18, 24, 24, 18]), poly([3, 7, 23, 14])]
    v0 = [poly(row) for row in
          ([22, 16, 0, 4, 10], [7, 4, 0, 21], [8, 19, 1, 1])]
    v1 = [poly(row) for row in
          ([14, 5, 0, 12, 13], [10, 12, 0, 14], [3, 4, 18, 18])]
    assert (dot(r2, v0), dot(r3, v0)) == (x, ring(1))
    assert (dot(r2, v1), dot(r3, v1)) == (ring(1), ring(0))
    w = [s - x*t for s, t in zip(v0, v1)]
    assert (dot(r2, w), dot(r3, w)) == (ring(0), ring(1))
    assert P.gcd(P.derivative()) == 1
    assert W.gcd(W.derivative()) == 1
    assert P.gcd(W) == 1

    # These are full polynomial fifth powers, including coefficients.
    S2 = dot([v**5 for v in v1], q)
    S3 = dot([v**5 for v in w], q)
    assert (S2.degree(), S3.degree()) == (22, 27)
    assert S2.gcd(P) == S2.gcd(W) == 1
    assert S3.gcd(P) == S3.gcd(W) == 1
    Q = P*W
    A = (-S2 * S3.inverse_mod(Q)) % Q
    assert A.degree() == 16
    assert (S2 + A*S3) % Q == 0

    # e=A/(yW)=y^2 A/(PW) in H^1(O(-11O)).
    # Its y^2-character basis is y^2*x^-m for 1<=m<=10.
    coeff = []
    degree = Q.degree()
    for m in range(1, 11):
        previous = sum(coeff[j-1] * Q[degree-m+j]
                       for j in range(1, m))
        coeff.append((A[degree-m] - previous) / Q[degree])
    expected = [2, 16, 16, 7, 1, 2, 7, 1, 24, 11]
    assert [encode(c) for c in coeff] == expected

    hankel4 = matrix(field, [[coeff[i+j] for j in range(4)]
                             for i in range(4)])
    hankel5 = matrix(field, [[coeff[i+j] for j in range(5)]
                             for i in range(5)])
    assert hankel4.det() == code(12)
    assert hankel5.det() == 0 and hankel5.rank() == 4
    recurrence = hankel4.solve_right(-vector(field, coeff[4:8]))
    g = ring(list(recurrence) + [field(1)])
    assert g == poly([5, 2, 6, 7, 1])
    assert g.gcd(P) == 1
    residual = [sum(g[j] * coeff[i+j] for j in range(5))
                for i in range(6)]
    assert residual == [field(0)]*5 + [code(16)]

    print(json.dumps({
        "coefficient_field": "F25, a^2=a+3",
        "frobenius_convention": "absolute; relative transport changes all coefficients",
        "quotient_lifts": "PASS",
        "P_W_squarefree_and_disjoint": "PASS",
        "S2_degree": int(S2.degree()),
        "S3_degree": int(S3.degree()),
        "S2_S3_units_on_D": "PASS",
        "S2_ascending_codes": codes(S2),
        "S3_ascending_codes": codes(S3),
        "A_ascending_codes": codes(A),
        "extension_y2_coefficients": expected,
        "Hankel4_determinant": encode(hankel4.det()),
        "Hankel5_determinant": encode(hankel5.det()),
        "Hankel5_rank": int(hankel5.rank()),
        "four_atom_recurrence_ascending_codes": codes(g),
        "recurrence_coprime_to_P": "PASS",
        "six_recurrence_residuals": [encode(c) for c in residual],
        "scope": "Exact extension certificate; stability is proved in the note."
    }, indent=2))


if __name__ == "__main__":
    main()
