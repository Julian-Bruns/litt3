#!/usr/bin/env sage-python
"""Explicit genus-six model for the R=u(u-1) neutral D10 quotient.

Factor [5] on the ordinary elliptic Prym through relative Frobenius.
The resulting Verschiebung gives the original etale degree-five map.
All assertions concern characteristic-five curves and rational functions.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, EllipticCurve


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    ring = PolynomialRing(GF(5), "T")
    T = ring.gen()
    field = GF(625, "t", modulus=T**4 + 4*T**3 + T**2 + 4*T + 3)
    t = field.gen()
    polynomials = PolynomialRing(field, "s")
    s = polynomials.gen()
    E = EllipticCurve(field, [0, -t, 0, 1, -t])
    multiply = E.multiplication_by_m(5, x_only=True)
    def remove_variable_frobenius(poly):
        assert all(int(power) % 5 == 0 for power in poly.dict())
        return polynomials({int(power) // 5: value for power, value in poly.dict().items()})
    numerator = remove_variable_frobenius(multiply.numerator())
    denominator = remove_variable_frobenius(multiply.denominator())
    assert numerator.degree() == 5 and denominator.degree() == 4
    assert numerator.gcd(denominator) == 1
    is_square, d = denominator.is_square(root=True)
    assert is_square and d**2 == denominator
    q = numerator / denominator
    assert q.derivative()
    S5 = s**3 - t**5 * s**2 + s - t**5
    target_cubic_numerator = (numerator**3 - t*numerator**2*denominator
                            + numerator*denominator**2 - t*denominator**3)
    J2, remainder = target_cubic_numerator.quo_rem(S5)
    assert not remainder
    is_square, J = J2.is_square(root=True)
    assert is_square and J**2 == J2
    curve = numerator * (numerator-denominator) * S5
    assert curve.degree() == 13 and curve.gcd(curve.derivative()) == 1
    y_multiplier = J / d**5
    Fq = q * (q-1) * (q-2) * (q-3) * (q-t)
    assert y_multiplier**2 * curve == Fq
    # No ramification of the degree-five curve map: the differential
    # eta_C pulls to a nowhere-zero multiple of eta_T away from infinity,
    # with the correct canonical divisor.  Check the exact multiplier.
    eta_multiplier = q.derivative() / y_multiplier
    assert d.gcd(d.derivative()) == 1 and denominator.gcd(curve) == 1
    assert (eta_multiplier/denominator).is_constant()
    assert eta_multiplier/denominator in [t**2+2, -(t**2+2)]
    print("q =", q)
    print("Y^2 =", curve)
    print("v =", y_multiplier, "* Y")
    print("h*(du/v) =", eta_multiplier, "* ds/Y")
    encode = lambda value: [int(field(value).polynomial()[i]) for i in range(4)]
    poly_encode = lambda poly: [encode(c) for c in polynomials(poly)]
    result = dict(status="PASS", field_modulus=[int(c) for c in field.modulus()],
                  numerator=poly_encode(numerator), denominator=poly_encode(denominator),
                  denominator_square_root=poly_encode(d), elliptic_y_numerator=poly_encode(J),
                  hyperelliptic_polynomial=poly_encode(curve),
                  elliptic_source_polynomial=poly_encode(S5),
                  eta_numerator=poly_encode(eta_multiplier.numerator()),
                  eta_denominator=poly_encode(eta_multiplier.denominator()),
                  genus=6, degree_to_original_genus2=5,
                  scope="Actual Verschiebung pullback and D10 quotient; no W4 lift asserted.")
    Path(args.output).write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()
