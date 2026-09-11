#!/usr/bin/env sage-python
"""Semilinear Fitting diagnostics for the actual D10 cover matrices.

This uses the characteristic-five matrices only.  It does not compute a
higher inverse-Cartier obstruction or infer existence of a Witt tower.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    source = json.loads(Path(args.input).read_text())
    polynomial_ring = PolynomialRing(GF(5), "z")
    field = GF(5 ** (len(source["field_modulus"]) - 1), name="a",
               modulus=polynomial_ring(source["field_modulus"]))
    a = field.gen()
    decode = lambda coefficients: sum(field(c) * a ** i for i, c in enumerate(coefficients))

    def fitting(operator):
        current = matrix.identity(field, operator.nrows())
        ranks = [operator.nrows()]
        for _ in range(operator.nrows() + 1):
            current = operator * current.apply_map(lambda c: c ** 5)
            ranks.append(int(current.rank()))
            if ranks[-1] == ranks[-2]:
                break
        assert ranks[-1] == ranks[-2]
        drops = [ranks[i] - ranks[i + 1] for i in range(len(ranks) - 1)]
        blocks = {str(i + 1): drops[i] - drops[i + 1]
                  for i in range(len(drops) - 1) if drops[i] != drops[i + 1]}
        return dict(iterate_ranks=ranks, nilpotent_blocks=blocks,
                    nilpotent_dimension=operator.nrows() - ranks[-1],
                    bijective_dimension=ranks[-1])

    rows = []
    for record in source["covers"]:
        full = matrix(field, [[decode(value) for value in row]
                              for row in record["hodge_matrix"]],
                      implementation="generic", sparse=False)
        plus = record["quotient_basis"]
        minus = [i for i in range(30) if i not in plus]
        row = dict(pair=record["pair"],
                   base=fitting(full[:3, :3]),
                   double=fitting(full[:6, :6]),
                   closure=fitting(full),
                   quotient=fitting(full.matrix_from_rows_and_columns(plus, plus)),
                   antiquotient=fitting(full.matrix_from_rows_and_columns(minus, minus)))
        rows.append(row)
        print(json.dumps(row), flush=True)
    Path(args.output).write_text(json.dumps(dict(status="PASS", rows=rows,
        scope="Exact semilinear Fitting ranks only; no higher-Witt calculation."), indent=2) + "\n")


if __name__ == "__main__":
    main()
