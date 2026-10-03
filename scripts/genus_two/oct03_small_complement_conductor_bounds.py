#!/usr/bin/env python3
"""Tiny exact integer certificate; no group or covering enumeration."""

import json
from fractions import Fraction
from math import comb
from pathlib import Path


def fraction(value):
    return {"numerator": value.numerator, "denominator": value.denominator}


def main():
    rows = []
    for n in range(11, 20):
        d = n - 10
        degree = comb(n, d)
        counts = {}
        for order in range(2, n + 1):
            if n % order:
                continue
            counts[str(order)] = comb(n // order, d // order) if d % order == 0 else 0
        largest = max(counts.values())
        eta = 1 - Fraction(largest, degree)
        assert eta >= Fraction(10, 11)
        # At normalized E-genus 16, the worst base genus is zero.
        smallest_genus_gap = (eta - Fraction(1, 2)) * 16 - 2 * (1 - eta)
        assert smallest_genus_gap >= Fraction(70, 11)
        rows.append({
            "n": n,
            "complement": d,
            "resolvent_degree": degree,
            "free_element_fixed_subset_counts_by_order": counts,
            "maximum_nonidentity_fixed_subsets": largest,
            "eta": fraction(eta),
            "minimum_genus_gap_for_u_at_least_16": fraction(smallest_genus_gap),
        })

    payload = {
        "scope": "All n=11..19; semiregular subgroup Burnside bound, including wild lower groups",
        "method": "Binomial integers and exact fractions only; no group enumeration",
        "uniform_eta": fraction(Fraction(10, 11)),
        "uniform_genus_gap": fraction(Fraction(70, 11)),
        "checks": {"all_eta_bounds": True, "all_genus_gap_bounds": True},
        "rows": rows,
    }
    target = Path(__file__).resolve().parents[3] / "litt3-computation-data" / "oct03_small_complement_conductor_bounds" / "bounds.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(payload, indent=2) + "\n")
    print(json.dumps({"rows": len(rows), "uniform_eta": "10/11", "uniform_genus_gap": "70/11", "output": str(target)}))


if __name__ == "__main__":
    main()
