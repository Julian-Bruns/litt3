#!/usr/bin/env python3
"""Exact finite-jet Frobenius tests for split smooth plane branches.

Requires Python 3 and NumPy. All arithmetic is scalar over F_p; no
extension-field or optimized semilinear matrix conventions are used.

The inputs are exact polynomials phi_i(x), with zero constant coefficient
and nonzero linear coefficient. Their pairwise contact orders determine
c_i = sum_{j != i} ord(phi_i - phi_j), and N=max(c_i). The conductor
contains every branch-supported x^N, so truncation at x^N is exact for
Q = (direct sum F_p[[x]]) / F_p[[x,y]]/(product(y-phi_i(x))).

Run this file for a deterministic regression suite. The public function
analyze(branches, p=5) returns all Frobenius kernel and image dimensions.
"""

from __future__ import annotations

import json
from collections.abc import Iterable

import numpy as np


class RowSpace:
    """Incremental exact Gaussian elimination over a prime field."""

    def __init__(self, dimension: int, p: int):
        self.dimension = dimension
        self.p = p
        self.rows: dict[int, np.ndarray] = {}

    def reduce(self, vector: np.ndarray) -> np.ndarray:
        result = np.asarray(vector, dtype=np.int64).copy() % self.p
        for pivot in sorted(self.rows):
            coefficient = int(result[pivot])
            if coefficient:
                result = (result - coefficient * self.rows[pivot]) % self.p
        return result

    def add(self, vector: np.ndarray) -> bool:
        reduced = self.reduce(vector)
        nonzero = np.flatnonzero(reduced)
        if not len(nonzero):
            return False
        pivot = int(nonzero[0])
        reduced = reduced * pow(int(reduced[pivot]), -1, self.p) % self.p
        self.rows[pivot] = reduced
        return True

    def __len__(self) -> int:
        return len(self.rows)


def polynomial(terms: dict[int, int]) -> list[int]:
    result = [0] * (max(terms, default=0) + 1)
    for degree, coefficient in terms.items():
        result[degree] = coefficient
    return result


def derivative(phi: list[int], p: int = 5) -> list[int]:
    result = [degree * phi[degree] % p for degree in range(1, len(phi))]
    while result and result[-1] == 0:
        result.pop()
    return result


def frobenius(vector: np.ndarray, branches: int, cutoff: int, q: int) -> np.ndarray:
    """p^e power on scalar-F_p branch jets, where q=p^e."""
    source = vector.reshape(branches, cutoff)
    result = np.zeros((branches, cutoff), dtype=np.int64)
    for degree in range((cutoff - 1) // q + 1):
        result[:, q * degree] = source[:, degree]
    return result.reshape(branches * cutoff)


def analyze(branches: Iterable[list[int]], p: int = 5) -> dict:
    if p < 2 or any(p % d == 0 for d in range(2, int(p**0.5) + 1)):
        raise ValueError("p must be prime")
    phis = [[int(c) % p for c in phi] for phi in branches]
    r = len(phis)
    if r < 2:
        raise ValueError("use at least two branches")
    if any(len(phi) < 2 or phi[0] != 0 or phi[1] == 0 for phi in phis):
        raise ValueError("branches must meet at zero and be etale over both axes")

    contacts = [[0] * r for _ in range(r)]
    for i in range(r):
        for j in range(i):
            length = max(len(phis[i]), len(phis[j]))
            difference = [
                ((phis[i][d] if d < len(phis[i]) else 0)
                 - (phis[j][d] if d < len(phis[j]) else 0)) % p
                for d in range(length)
            ]
            nonzero = [d for d, coefficient in enumerate(difference) if coefficient]
            if not nonzero:
                raise ValueError("branches must be distinct")
            contacts[i][j] = contacts[j][i] = nonzero[0]

    conductor = [sum(row) for row in contacts]
    cutoff = max(conductor)
    delta = sum(conductor) // 2
    dimension = r * cutoff
    truncated = []
    for phi in phis:
        value = np.zeros(cutoff, dtype=np.int64)
        value[: min(cutoff, len(phi))] = phi[:cutoff]
        truncated.append(value)

    # The ring is free over F_p[[x]] with basis 1,y,...,y^(r-1).
    ring = RowSpace(dimension, p)
    powers = [np.eye(1, cutoff, dtype=np.int64).reshape(cutoff) for _ in phis]
    for y_degree in range(r):
        for shift in range(cutoff):
            vector = np.zeros((r, cutoff), dtype=np.int64)
            for i in range(r):
                vector[i, shift:] = powers[i][: cutoff - shift]
            ring.add(vector.reshape(dimension))
        if y_degree + 1 < r:
            powers = [
                np.convolve(powers[i], truncated[i])[:cutoff] % p
                for i in range(r)
            ]

    assert dimension - len(ring) == delta, "normalization-defect check failed"
    for row in ring.rows.values():
        assert not np.any(ring.reduce(frobenius(row, r, cutoff, p)))

    # Rank(F^e on Q) = dim((R + F^e(normalization))/R).
    ranks = [delta]
    kernels = [0]
    e, q = 0, 1
    while True:
        e += 1
        q *= p
        image = RowSpace(dimension, p)
        for i in range(r):
            for degree in range((cutoff - 1) // q + 1):
                vector = np.zeros(dimension, dtype=np.int64)
                vector[i * cutoff + q * degree] = 1
                image.add(ring.reduce(vector))
        ranks.append(len(image))
        kernels.append(delta - len(image))
        if q >= cutoff:
            break
    assert ranks[-1] == r - 1, "stable branch-constant dimension failed"
    assert all(left >= right for left, right in zip(ranks, ranks[1:]))
    return {
        "p": p,
        "branches": phis,
        "contacts": contacts,
        "conductor": conductor,
        "cutoff": cutoff,
        "delta": delta,
        "rank_F_powers": ranks,
        "ker_F_powers": kernels,
        "stable_dimension": r - 1,
    }


def main() -> None:
    tests: dict[str, list[list[int]]] = {
        "transverse_triple": [[0, 1], [0, 2], [0, 3]],
        "transverse_quadruple": [[0, 1], [0, 2], [0, 3], [0, 4]],
        "equal_contact_4_unperturbed": [
            polynomial({1: 1}), polynomial({1: 1, 4: 1}),
            polynomial({1: 1, 4: 2}),
        ],
        "equal_contact_4_x5_perturbation": [
            polynomial({1: 1}), polynomial({1: 1, 4: 1}),
            polynomial({1: 1, 4: 2, 5: 1}),
        ],
        "equal_contact_5_unperturbed": [
            polynomial({1: 1}), polynomial({1: 1, 5: 1}),
            polynomial({1: 1, 5: 2}),
        ],
        "equal_contact_5_x6_perturbation": [
            polynomial({1: 1}), polynomial({1: 1, 5: 1}),
            polynomial({1: 1, 5: 2, 6: 1}),
        ],
        "mixed_contacts_1_5_25": [
            polynomial({1: 1}), polynomial({1: 1, 25: 1}),
            polynomial({1: 1, 5: 1}), polynomial({1: 2}),
        ],
        "mixed_contacts_1_5_25_perturbed": [
            polynomial({1: 1}), polynomial({1: 1, 25: 1, 26: 1}),
            polynomial({1: 1, 5: 1, 6: 1}), polynomial({1: 2, 2: 1}),
        ],
    }
    for contact in (1, 2, 4, 5, 6, 25, 125):
        tests[f"two_branches_contact_{contact}"] = [
            polynomial({1: 1}),
            polynomial({1: 2}) if contact == 1 else polynomial({1: 1, contact: 1}),
        ]

    results = {name: analyze(branches) for name, branches in tests.items()}
    constant = results["equal_contact_5_unperturbed"]
    perturbed = results["equal_contact_5_x6_perturbation"]
    assert constant["contacts"] == perturbed["contacts"]
    assert constant["rank_F_powers"] == [15, 3, 2]
    assert perturbed["rank_F_powers"] == [15, 4, 2]
    sharp_constant = results["equal_contact_4_unperturbed"]
    sharp_perturbed = results["equal_contact_4_x5_perturbation"]
    assert sharp_constant["contacts"] == sharp_perturbed["contacts"]
    assert sharp_constant["rank_F_powers"] == [12, 3, 2]
    assert sharp_perturbed["rank_F_powers"] == [12, 4, 2]
    assert [derivative(phi) for phi in sharp_constant["branches"]] == [
        derivative(phi) for phi in sharp_perturbed["branches"]
    ]
    for contact in (1, 2, 4, 5, 6, 25, 125):
        result = results[f"two_branches_contact_{contact}"]
        assert result["rank_F_powers"] == [
            (contact + 5**e - 1) // 5**e
            for e in range(len(result["rank_F_powers"]))
        ]
    for name, result in results.items():
        summary = {key: value for key, value in result.items() if key != "branches"}
        print(name, json.dumps(summary, separators=(",", ":")))
    print("PASS: conductor dimensions, Frobenius stability, two-branch formula, and same-contact/same-derivative counterexample")


if __name__ == "__main__":
    main()
