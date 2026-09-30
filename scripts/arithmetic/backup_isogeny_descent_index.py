#!/usr/bin/env python3
"""Exact integer certificate for the backup's cubic descent obstruction."""

import argparse
import json
from fractions import Fraction
from pathlib import Path


def certificate():
    rows = []
    # A is the trace of a degree-four 5-Weil polynomial, so |A| <= 8.
    # The trace of the cubes must be 8, whence A divides 8.
    for a in range(-8, 9):
        if not a or 8 % a:
            continue
        b = Fraction(a * a + 15 - Fraction(8, a), 3)
        if b.denominator != 1:
            continue
        b = int(b)
        powers = [4, a, a * a - 2 * b, a**3 - 3 * a * b + 15 * a]
        powers.append(a * powers[3] - b * powers[2] + 5 * a * powers[1] - 100)
        for r in (5, 6):
            powers.append(a * powers[r - 1] - b * powers[r - 2]
                          + 5 * a * powers[r - 3] - 25 * powers[r - 4])
        assert powers[3] == 8
        numerator = powers[3] ** 2 - powers[6]
        assert numerator % 2 == 0
        rows.append({"trace": a, "second_coefficient": b,
                     "power_sums_0_to_6": powers,
                     "cubed_second_coefficient": numerator // 2})
    assert {(r["trace"], r["second_coefficient"]) for r in rows} == {
        (-4, 11), (-1, 8), (2, 5), (8, 26)}
    assert all(r["cubed_second_coefficient"] != 182 for r in rows)
    return {"backup_weil_polynomial_ascending": [15625, -1000, 182, -8, 1],
            "necessary_cubic_root_candidates": rows,
            "no_cubic_weil_root": True}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = certificate()
    body = json.dumps(data, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(body)
    print(body, end="")
