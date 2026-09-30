#!/usr/bin/env sage -python
"""Certify the backup's degree-one nonisotropic Pluecker locus.

Run with Sage. Generated receipts belong outside the litt3 workspace.
The geometric completeness and the local quadratic normalization are
proved in the companion human-readable note.
"""

import argparse
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, binomial


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    k = GF(125, "a", modulus=PolynomialRing(GF(5), "r")([1, 1, 0, 1]))
    a = k.gen()
    ring = PolynomialRing(k, "x")
    x = ring.gen()
    f = x * (x - 1) * (x - 2) * (x - 3) * (x - a)

    def code(c):
        coeff = list(k(c).polynomial())
        return sum(int(v) * 5**i for i, v in enumerate(coeff))

    def row(poly):
        return [code(c) for c in poly.list()]

    # [h^4] f(t+h)^3 is H(t)^5 by Lucas's congruence.
    cube = f**3
    H = ring([cube[5*j + 4]**25 for j in range(3)])
    t = a**2 + 3*a + 4
    s = a**2 + 4*a + 4
    assert H == (2*a**2 + a) * (x - t)**2
    assert H.gcd(f) == 1
    assert s**2 == f(t) != 0
    assert t**5 == a
    assert s**5 == 4*a**2 + 2*a + 1

    coefficients = [
        sum(c * binomial(i, j) * t**(i-j)
            for i, c in enumerate(cube.list()) if i >= j) / f(t)**3
        for j in range(4)
    ]
    B = sum(coefficients[j] * (x-t)**j for j in range(4))
    A = s * B
    quotient, remainder = (A**2-f).quo_rem((x-t)**5)
    lead = 4*a**2 + a + 3
    assert remainder == 0
    assert quotient == lead * (x-a)
    assert A(a) == 0
    assert A(t) == s
    assert A.degree() == 3

    # The y-term is 2*A*y^5 and has zero Cartier image, since deg A=3.
    norm_numerator = f**3 + f**2 * A**2
    relative_norm = ring([norm_numerator[5*j+4] for j in range(3)])
    c = a + 1
    assert relative_norm == c * (x-t**5)**2
    lam = a**2 + 3*a + 3
    assert lam**2 * c == -1

    # All six Weierstrass primitive lines have nonzero norms, but the
    # norm is never the required section with divisor 2*F(W).
    weierstrass = []
    for b in [None, k(0), k(1), k(2), k(3), a]:
        numerator = f**2 if b is None else (x-b)*f**2
        image = [numerator[4], numerator[9]]
        assert image != [0, 0]
        mismatch = image[1] if b is None else image[0] + b**5 * image[1]
        assert mismatch != 0
        weierstrass.append({
            "branch_coordinate": "infinity" if b is None else code(b),
            "relative_Cartier_row": [code(v) for v in image],
            "double_zero_mismatch": code(mismatch),
        })

    # Local normalization. A primitive tensor a0+...+a4*z^4 maps to
    # a0*e01+3*a1*e02+a2*(e03+3*e12)+3*a3*e13+a4*e23.
    poly = PolynomialRing(GF(5), names=("u", "a0", "a1", "a2", "a3", "a4"))
    u, a0, a1, a2, a3, a4 = poly.gens()
    p01, p02, p03 = a0, 3*a1, 3*u + a2
    p12, p13, p23 = u + 3*a2, 3*a3, a4
    wedge_square = 2*(p01*p23-p02*p13+p03*p12)
    duality_square = a2**2 + 2*a0*a4 + 2*a1*a3
    assert wedge_square == u**2 + duality_square

    out = {
        "field": "F5[a]/(a^3+a+1), code c0+5*c1+25*c2",
        "curve_coefficients_ascending": row(f),
        "nonbranch_locus_H": row(H),
        "H_factor": {"leading": code(2*a**2+a), "root": code(t), "multiplicity": 2},
        "points_on_Y": [
            {"x": code(t), "y": code(s)},
            {"x": code(t), "y": code(-s)},
        ],
        "points_on_Y_twist": [
            {"x": code(t**5), "y": code(s**5)},
            {"x": code(t**5), "y": code(-s**5)},
        ],
        "A_over_s_coefficients": row(B),
        "A_coefficients": row(A),
        "norm_factor_quotient": row(quotient),
        "residual_zero_on_Y": {"x": code(a), "y": 0},
        "relative_quadratic_norm_numerator": row(relative_norm),
        "relative_quadratic_norm_constant": code(c),
        "Pluecker_lambda": code(lam),
        "weierstrass_checks": weierstrass,
        "local_quadratic_normalization_verified": True,
        "number_of_geometric_eligible_primitive_lines": 2,
        "number_of_geometric_nonisotropic_degree_one_planes": 4,
        "all_planes_defined_over_F125": True,
        "passed": True,
    }
    if args.output:
        workspace = Path(__file__).resolve().parents[2]
        target = args.output.resolve()
        assert not target.is_relative_to(workspace), "Write generated receipts outside litt3"
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(json.dumps(out, indent=2) + "\n")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
