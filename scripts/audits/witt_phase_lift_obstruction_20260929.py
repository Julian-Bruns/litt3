#!/usr/bin/env python3
"""Four fixed resonance rows and one Cartier-image obstruction.

Uses the independently checked plain-Python field arithmetic of the
unbounded-phase audit.  No Witt lift of either curve or map is assumed,
and no endpoint multiset or supported-section sweep is performed.
"""
import argparse
import itertools
import json
from pathlib import Path

import unbounded_phase_separation_20260929 as f


def bpower(x, n):
    result = 1
    while n:
        if n & 1:
            result = f.bmul(result, x)
        x = f.bmul(x, x)
        n >>= 1
    return result


def bpoly_mul(a, b):
    result = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            result[i+j] = f.badd(result[i+j], f.bmul(x, y))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    A = [1, 21, 14, 22, 13]
    c = [22, 7, 9, 23]
    # Coefficient of the first free resonance d in Z_3; Z_4 is d-free.
    kappa3 = [23, 23, 17, 12]
    ev, mul, pw, divide = f.evaluate, f.mul, f.power, f.divide
    add, sub, C = f.add, f.sub, f.const
    data, rows = [], []
    for i, alpha in enumerate([pw(f.ALPHA, 25**i) for i in range(4)]):
        p0 = ev(P, alpha)
        ap = ev(f.derivative(A), alpha)
        app = ev(f.derivative(f.derivative(A)), alpha)
        rhs = divide(mul(C(3), mul(pw(ap, 3), pw(p0, 2))), pw(C(13), 3))
        lead = pw(rhs, pow(29, -1, 5**8-1))
        a1 = divide(mul(C(13), pw(lead, 4)), ap)
        a2 = divide(sub(mul(C(f.bmul(4, 13)), mul(pw(lead, 3), ev(c, alpha))),
                        divide(mul(app, pw(a1, 2)), C(2))), ap)
        # lambda=[d]u_3, mu=[d]u_4, q=[d^2]u_5.
        lam = divide(mul(C(f.bmul(4, 13)), pw(lead, 3)), ap)
        mu = divide(sub(mul(C(13), add(mul(C(4), mul(pw(lead, 3), ev(kappa3, alpha))),
                                       mul(C(2), mul(pw(lead, 2), ev(c, alpha))))),
                        mul(app, mul(a1, lam))), ap)
        quadratic = divide(mul(C(13), pw(lead, 2)), ap)
        assert lam != f.ZERO and quadratic != f.ZERO
        J = add(add(divide(mu, mul(a1, lam)), divide(a2, pw(a1, 2))),
                sub(divide(app, mul(C(2), ap)),
                    divide(mul(C(2), ev(f.derivative(P), alpha)), mul(C(3), p0))))
        row = [J, add(f.ONE, mul(alpha, J))]
        rows.append(row)
        data.append({"root_index": i, "a1": a1, "a2": a2,
                     "u3_linear_resonance": lam, "u4_linear_resonance": mu,
                     "u5_quadratic_resonance": quadratic, "J": J, "row": row})
    determinant = sub(mul(rows[0][0], rows[1][1]), mul(rows[0][1], rows[1][0]))
    assert rows[0][0] == (14, 19, 1, 0)
    assert determinant == (7, 20, 13, 2)

    P3 = bpoly_mul(bpoly_mul(P, P), P)
    # Cartier maps the A-space to M^[1/5]=M^[5] in the B-space.
    matrix = [[bpower(P3[5*i+4-j], 5) if 0 <= 5*i+4-j < len(P3) else 0
               for j in range(3)] + [int(i == 0)] for i in range(6)]
    witness = None
    for indices in itertools.combinations(range(6), 4):
        columns = [tuple(matrix[i][j] for i in indices) for j in range(4)]
        det = f.determinant(columns)
        if det:
            witness = {"rows": indices, "matrix": [matrix[i] for i in indices], "determinant": det}
            break
    assert witness is not None, "theta unexpectedly lies in the Cartier image"
    result = {"status": "PASS", "field": "E=F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5])",
              "scope": "fixed first-resonance obstruction to a label-only Witt weight-one coefficient",
              "rows": data, "first_two_row_determinant": determinant,
              "theta_not_in_cartier_image": witness,
              "formal_resonance_realization_on_global_spans_claimed": False,
              "global_cancellation_excluded": False, "large_sweeps": 0}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print("PASS: resonance determinant", determinant, "; theta Cartier-augmentation minor", witness["determinant"])


if __name__ == "__main__":
    main()
