"""Certificates for residual contact <=2 and modification degree bounds.

The verifier checks the finite arithmetic in the proof, not arbitrary
covers or arbitrary divisors.  Riemann--Roch and the pole analysis are
proved in the accompanying report.
"""
import json
from math import comb
from ff25 import *


def run():
    B = interpolate_B()
    # M=x^2+m1*x+m0, C=c0+c1*x.  High coefficients of M*B-C*P
    # must vanish if its degree is <=6. Unknowns: m0,m1,c0,c1.
    columns = []
    for j in range(2):
        poly = [0] * j + B
        columns.append([poly[i] if i < len(poly) else 0 for i in range(7, 12)])
    for j in range(2):
        poly = [0] * j + pneg(P)
        columns.append([poly[i] if i < len(poly) else 0 for i in range(7, 12)])
    matrix = [list(row) for row in zip(*columns)]
    rhs_poly = [0, 0] + B
    rhs = [neg(rhs_poly[i]) for i in range(7, 12)]
    assert matrix == [[6, 2, 14, 10], [12, 6, 21, 14],
                      [14, 12, 8, 21], [0, 14, 4, 8], [0, 0, 0, 4]]
    assert rhs == [19, 3, 24, 18, 16]
    left_null = [14, 6, 3, 10, 1]
    assert [dot(left_null, col) for col in columns] == [0, 0, 0, 0]
    assert dot(left_null, rhs) == 8
    augmented_det = determinant([row + [rhs[i]] for i, row in enumerate(matrix)])
    assert augmented_det == 23
    # Exceptional finite pair in an unramified cubic fiber:
    # (x-r)(B-U)+c*y3=B9*P would be necessary.
    r = sub(mul(B[8], inv(B[9])), P[9])
    defect = sub(sub(B[7], mul(r, B[8])), mul(B[9], P[8]))
    assert r == 18 and defect == 20
    pole_bases = {}
    for bound in (3, 4, 12, 13, 14):
        pole_bases[str(bound)] = [[i, j, 3 * i + 10 * j]
                                 for j in range(3) for i in range(bound // 3 + 1)
                                 if 3 * i + 10 * j <= bound]
    assert len(pole_bases['12']) == 6
    assert len(pole_bases['13']) == len(pole_bases['14']) == 7
    stable_rows = []
    for size in range(6, 11):
        degree = 7 - size
        non_lambda_bound = 6 - size
        line_bound = max(-2, non_lambda_bound)
        assert 2 * line_bound < degree
        stable_rows.append({"size": size, "number": comb(13, size),
                            "bundle_degree": degree,
                            "non_lambda_line_degree_at_most": non_lambda_bound,
                            "all_line_degrees_at_most": line_bound})
    assert sum(row['number'] for row in stable_rows) == 5720
    for size in (5, 11):
        assert 2 * max(-2, 6-size) <= 7-size
    return {"status": "PASS", "two_missing_fibers_matrix": matrix,
            "rhs": rhs, "left_null_vector": left_null,
            "left_null_times_rhs": 8, "augmented_determinant": augmented_det,
            "exceptional_pair_forced_x": r, "exceptional_pair_defect": defect,
            "pole_bases_x_i_y_j": pole_bases, "stable_modifications": stable_rows,
            "total_stable_modifications": 5720,
            "scope": "Finite algebra for the residual-contact theorem, not an all-cover decision."}


if __name__ == "__main__":
    print(json.dumps(run(), indent=2))
