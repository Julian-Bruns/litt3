#!/usr/bin/env python3
"""Check the Frobenius evaluation identity for the actual Cartier radical.

Uses the already recorded F25 coefficient convention and beta rows.
Generated receipts belong outside the research workspace.
"""

import argparse
import json
from pathlib import Path

import cartier_two_form_certificate as f25


def fifth(poly):
    result = [0] * (5 * (len(poly) - 1) + 1)
    for i, coefficient in enumerate(poly):
        result[5 * i] = f25.power(coefficient, 5)
    return f25.trim(result)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    p = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    q = [[24, 2, 1], [5, 16, 0, 1], [5, 20, 0, 0, 8, 1]]
    beta = [[4, 16, 3, 18, 21],
            [10, 13, 0, 10, 6],
            [15, 3, 3, 18, 18, 4]]
    w = [3, 1, 13, 11, 8, 17, 9, 3]
    lhs = f25.p_add(
        f25.p_sub(f25.p_mul(fifth(beta[2]), q[0]),
                  f25.p_mul(fifth(beta[1]), q[1])),
        f25.p_mul(fifth(beta[0]), q[2]))
    rhs = f25.p_scale(f25.p_mul(f25.p_mul(p, p), w), 3)
    assert lhs == rhs
    receipt = {
        "coefficient_field": "F5[a]/(a^2-a-3), code c0+5*c1",
        "identity": "b12^5*q0-b02^5*q1+b01^5*q2 = 3*P^2*W",
        "fifth_power": "polynomial fifth power, coefficients and exponents",
        "degree": len(lhs) - 1,
        "coefficients": lhs,
        "passed": True,
    }
    rendered = json.dumps(receipt, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")


if __name__ == "__main__":
    main()
