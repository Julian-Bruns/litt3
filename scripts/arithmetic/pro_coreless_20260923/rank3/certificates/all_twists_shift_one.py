"""Certificate for h^0(Sym^3(K)(3O))=0.

The cubic orbit product for gamma then proves
    h^0(K(O) tensor L)=0 for every degree-zero line L.

This is a geometric all-twist vanishing, not a finite-field point search.
It is NOT a decision of the rank-three finite-coefficient existence question.

Run with Python 3.10+ and NumPy:
    python all_twists_shift_one.py
"""
from __future__ import annotations

import json
import math
from pathlib import Path

import numpy as np

import period_two as p


def symmetric_matrix(m: int, d: int):
    """Section reconstruction for Sym^m(K)(dO) in the supplied Cech frames."""
    e = {(-i, 2): c for i, c in enumerate(p.ff.C_COEFFICIENTS, 1)}
    negative_e = {mon: p.ff.negative(c) for mon, c in e.items()}
    powers = [{(0, 0): 1}]
    for _ in range(m):
        powers.append(p.multiply_functions(powers[-1], negative_e))
    free = [(i, mon) for i in range(m + 1)
            for mon in p.section_monomials(d - 5 * m + 11 * i)]
    rows = [(i, mon) for i in range(m + 1)
            for mon in p.cech_monomials(d - 5 * m + 11 * i)]
    columns = []
    for level, monomial in free:
        f = [{} for _ in range(m + 1)]
        output = {}
        for i in range(m, -1, -1):
            terms = {}
            for j in range(i + 1, m + 1):
                coefficient = math.comb(j, i) % 5
                term = p.multiply_functions(powers[j - i], f[j])
                term = {u: p.ff.multiply(coefficient, v) for u, v in term.items()
                        if p.ff.multiply(coefficient, v)}
                terms = p.add_functions(terms, term)
            f[i] = {u: p.ff.negative(v) for u, v in terms.items() if u[0] >= 0}
            if i == level:
                f[i] = p.add_functions(f[i], {monomial: 1})
            output.update({(i, u): v for u, v in terms.items() if u[0] < 0})
        columns.append([output.get(row, 0) for row in rows])
    matrix = np.array(columns, dtype=np.uint8).T
    return matrix, free, rows


def verify() -> None:
    matrix, free, rows = symmetric_matrix(3, 3)
    assert matrix.shape == (32, 18)
    rank, kernel, _ = p.rref_nullspace(matrix)
    assert rank == 18 and kernel.shape[1] == 0
    blocks = []
    expected_shapes = [(9, 8), (13, 8), (10, 2)]
    expected_determinants = [6, 12, 12]
    # The symmetric frame has weight (m-i); multiplying by y^b
    # gives character (m-i+b) modulo three.
    for character in range(3):
        cols = [j for j, (i, (a, b)) in enumerate(free)
                if (3 - i + b) % 3 == character]
        rr = [j for j, (i, (a, b)) in enumerate(rows)
              if (3 - i + b) % 3 == character]
        other = [j for j in range(len(rows)) if j not in rr]
        assert not np.any(matrix[np.ix_(other, cols)])
        block = matrix[np.ix_(rr, cols)]
        block_rank, _, selected = p.rref_nullspace(block.T)
        assert block.shape == expected_shapes[character]
        assert block_rank == len(cols)
        minor = block[selected, :]
        determinant = p.determinant(minor)
        assert determinant == expected_determinants[character]
        blocks.append({
            "character": character, "shape": list(block.shape),
            "column_indices_zero_based": cols,
            "selected_row_indices_zero_based": [rr[i] for i in selected],
            "minor": minor.tolist(), "determinant_code": determinant,
        })
        print(f"Character {character}: {block.shape}; maximal minor [{determinant}].")
    here = Path(__file__).resolve().parent
    np.savez_compressed(here / "symmetric_shift_data.npz", matrix=matrix)
    output = {
        "section_space": "H^0(Sym^3(K)(3O))", "dimension": 0,
        "matrix_shape": list(matrix.shape), "matrix_rank": rank,
        "free_coordinates_i_xexp_yexp": [[i, a, b] for i, (a, b) in free],
        "row_coordinates_i_xexp_yexp": [[i, a, b] for i, (a, b) in rows],
        "character_blocks": blocks,
        "consequence": "H^0(K(O) tensor L)=0 for every L in Pic^0(X), by the cubic orbit product.",
        "existence_question_decided": False,
    }
    (here / "symmetric_shift_certificate.json").write_text(json.dumps(output, indent=2) + "\n")
    print("Certified: h^0(Sym^3(K)(3O))=0, hence the stated geometric all-twist vanishing.")


if __name__ == "__main__":
    verify()
