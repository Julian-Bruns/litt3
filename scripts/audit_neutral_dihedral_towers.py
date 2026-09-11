#!/usr/bin/env sage-python
"""Independent bounded algebra checks for the all-q dihedral proof.

These are stress tests of the new semilinear lemma and norm specialization,
not a construction of higher-cover Laurent matrices or higher Witt lifts.
No producer module is imported.  Run with Sage and one BLAS/OpenMP thread.
"""

import argparse
import hashlib
import json
import random
import time
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix, pari


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    started = time.monotonic()
    rng = random.Random(20260911)
    prime = GF(5)
    base_polys = PolynomialRing(prime, "x")
    x = base_polys.gen()
    field = GF(25, name="z", modulus=x**2 + 2)
    z = field.gen()
    polys = PolynomialRing(field, "v")
    v = polys.gen()

    def random_coefficient():
        return field(rng.randrange(5)) + z * field(rng.randrange(5))

    results = []
    norm_results = []
    for q, trials in [(5, 8), (25, 5), (125, 1)]:
        ring = polys.quotient(v**q, "vbar")
        vb = ring.gen()

        def frobenius(value):
            return ring(polys([c**5 for c in ring(value).lift().list()]))

        def twisted(mat):
            return matrix(ring, mat.nrows(), mat.ncols(),
                          [frobenius(c) for c in mat.list()])

        def expanded(mat, parity=None):
            degrees = [i for i in range(q) if parity is None or i % 2 == parity]
            coordinates = [(block, i) for block in range(2) for i in degrees]
            index = {coordinate: i for i, coordinate in enumerate(coordinates)}
            entries = {}
            for source, (source_block, source_degree) in enumerate(coordinates):
                for target_block in range(2):
                    for shift, coefficient in enumerate(mat[target_block, source_block].lift()):
                        if not coefficient or shift + source_degree >= q:
                            continue
                        target_coordinate = (target_block, shift + source_degree)
                        assert target_coordinate in index
                        entries[index[target_coordinate], source] = coefficient
            return matrix(field, len(coordinates), len(coordinates), entries)

        basis = matrix(ring, [[1, 0], [z, 1]])
        twisted_basis_inverse = twisted(basis).inverse()
        for trial in range(trials):
            # A generic even matrix, with a nonzero v^2 determinant term.
            coefficients = [
                sum((ring(random_coefficient()) * vb**(2*j)
                     for j in range((q + 1)//2)), ring.zero())
                for _ in range(4)
            ]
            if coefficients[2].lift()[0] == 0:
                coefficients[2] += 1
            generic = matrix(ring, [
                [vb**2 * coefficients[0], 1 + vb**2 * coefficients[1]],
                [vb**2 * coefficients[2], vb**2 * coefficients[3]],
            ])
            actual = basis * generic * twisted_basis_inverse
            conjugate = twisted(actual)
            constant = matrix(ring, 2, 2,
                              [entry.lift()[0] for entry in actual.list()])
            constant_conjugate = twisted(constant)
            assert constant.det() == 0 and any(constant.list())
            assert constant * constant_conjugate == 0
            assert constant**2 != 0
            assert actual * conjugate != actual**2
            assert actual.det().lift().valuation() == 2
            assert all(all(not c or i % 2 == 0
                           for i, c in enumerate(entry.lift()))
                       for entry in actual.list())
            pair = actual * conjugate
            unit = matrix(ring, 2, 2,
                          [ring(entry.lift() // v**2) for entry in pair.list()])
            assert pair == vb**2 * unit
            assert unit.det().lift()[0] != 0

            indices = set(range(q + 2)) if q <= 25 else {
                0, 1, 2, 3, 4, 5, 60, 61, 62, 63, 122, 123, 124, 125, 126
            }
            product = matrix.identity(ring, 2)
            ranks = []
            for n in range(q + 2):
                if n in indices:
                    # PARI uses the explicit field modulus.  The local Sage
                    # gfpn dense backend gives a wrong rank even for
                    # [[z,1],[3,z]] over this NONPRIMITIVE modulus.
                    whole = int(pari(expanded(product)).matrank())
                    positive = int(pari(expanded(product, 0)).matrank())
                    negative = int(pari(expanded(product, 1)).matrank())
                    expected_positive = max(q + 1 - n, 0)
                    expected_negative = max(q - 1 - n, 0)
                    assert positive == expected_positive
                    assert negative == expected_negative
                    assert whole == positive + negative
                    ranks.append({"iterate": n, "whole": whole,
                                  "positive": positive, "negative": negative})
                if n < q + 1:
                    product = product * (actual if n % 2 == 0 else conjugate)
            assert product == 0
            # Ordinary composition does not even have nilpotent residue.
            assert constant**(q + 1) != 0
            results.append({"q": q, "trial": trial, "ranks": ranks,
                            "ordinary_powers_are_invalid": True,
                            "semilinear_square_unit": True})

        # Work independently in the group-algebra parameter e=sigma-1.
        sigma = 1 + vb
        subgroup_generator = sigma**5
        norm = sum((subgroup_generator**j for j in range(q//5)), ring.zero())
        assert norm == vb**(q - 5)
        sigma_inverse = sum(((-vb)**j for j in range(q)), ring.zero())
        e_inverted = sigma_inverse - 1
        anti_parameter = sigma - sigma_inverse
        assert anti_parameter.lift()[1] == 2

        def inversion(value):
            return ring(value).lift()(e_inverted)

        assert inversion(anti_parameter) == -anti_parameter
        assert inversion(norm) == norm
        assert frobenius(norm) == norm
        lower = polys.quotient(v**5, "ebar")

        def reduce_lower(value):
            return lower(ring(value).lift())

        def norm_lift(value):
            return norm * ring(lower(value).lift())

        # Six source/target free columns, non-F5 coefficients, and arbitrary
        # high terms test BOTH sides of the linearized norm specialization.
        def random_element():
            return ring(polys([random_coefficient() for _ in range(q)]))

        arbitrary = matrix(ring, 6, 6, [random_element() for _ in range(36)])
        vector = matrix(ring, 6, 1, [random_element() for _ in range(6)])
        norm_vector = vector.apply_map(lambda entry: norm * entry)
        direct = arbitrary * twisted(norm_vector)
        lowered_matrix = matrix(lower, 6, 6,
                                [reduce_lower(entry) for entry in arbitrary.list()])
        lowered_vector = matrix(lower, 6, 1,
                                [reduce_lower(frobenius(entry)) for entry in vector.list()])
        lowered_image = lowered_matrix * lowered_vector
        comparison = matrix(ring, 6, 1,
                            [norm_lift(entry) for entry in lowered_image.list()])
        assert direct == comparison
        assert all(inversion(norm_lift(reduce_lower(entry))) ==
                   norm_lift(reduce_lower(inversion(entry)))
                   for entry in vector.list())
        norm_results.append({"q": q, "norm_exponent": q-5,
                             "invariant_dimension_per_free_column": 5,
                             "six_column_frobenius_specialization": True,
                             "inversion_equivariance": True})

    root = Path(__file__).resolve().parents[1]
    candidate = root / "Research/NEUTRAL_DIHEDRAL_TOWERS_CANDIDATE.md"
    output = {
        "verdict": "PASS",
        "auditor": "/root/audit_actual_heisenberg_defect",
        "date": "2026-09-11",
        "scope": "Independent finite algebra stress checks, not actual higher-Witt lifts",
        "coefficient_field": "F5[z]/(z^2+2)",
        "seed": 20260911,
        "script_sha256": digest(__file__),
        "candidate_sha256": digest(candidate),
        "matrix_trials": results,
        "norm_specialization": norm_results,
        "seconds": round(time.monotonic() - started, 6),
    }
    Path(args.output).write_text(json.dumps(output, indent=2) + "\n")
    print(json.dumps({"verdict": output["verdict"], "matrix_trials": len(results),
                      "rank_checks": sum(3*len(row["ranks"]) for row in results),
                      "seconds": output["seconds"], "output": args.output}), flush=True)


if __name__ == "__main__":
    main()
