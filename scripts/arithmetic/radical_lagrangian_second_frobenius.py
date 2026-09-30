#!/usr/bin/env python3
"""Exact second-Frobenius section locus for the fixed radical family.

Run with Sage's Python. This is a height-two calculation only. The source
uses the canonical absolute-Frobenius coefficient convention; F^2 fixes
F_25, so the equivalent twice-relative twist has the same equation and
coefficient rows. Generated receipts and Smith certificates go outside
the research repository.
"""

import argparse
from copy import copy
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, version


def bareiss_determinant(M):
    """Exact fraction-free determinant, avoiding generic charpoly growth."""
    assert M.nrows() == M.ncols()
    A = copy(M)
    ring = A.base_ring()
    previous = ring(1)
    sign = ring(1)
    for k in range(A.nrows()-1):
        pivot_row = next((i for i in range(k, A.nrows()) if A[i, k]), None)
        if pivot_row is None:
            return ring(0)
        if pivot_row != k:
            A.swap_rows(k, pivot_row)
            sign = -sign
        pivot = A[k, k]
        for i in range(k+1, A.nrows()):
            for j in range(k+1, A.ncols()):
                numerator = pivot*A[i, j]-A[i, k]*A[k, j]
                A[i, j], remainder = numerator.quo_rem(previous)
                assert not remainder
            A[i, k] = 0
        previous = pivot
    return sign*A[-1, -1] if A.nrows() else ring(1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    out = Path(args.output_dir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    started = time.monotonic()

    K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
    a = K.gen()
    decode = lambda n: K(n % 5) + K(n // 5) * a

    def encode(v):
        row = list(K(v).polynomial())
        return int(row[0] if row else 0) + 5 * int(row[1] if len(row) > 1 else 0)

    R = PolynomialRing(K, "t")
    t = R.gen()
    S = PolynomialRing(K, "x")
    P_codes = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    a_codes = [19, 9, 15, 6, 16]
    b_codes = [4, 16, 17, 22, 14]
    P = S([decode(n) for n in P_codes])
    av = [decode(n) for n in a_codes]
    bv = [decode(n) for n in b_codes]
    assert all(v**25 == v for v in av + bv + list(P))

    # e_c^[25] = y P(x)^8 sum_j (a_j-t b_j) x^(-25j), t=c^25.
    # H^1(O(-150O)) in the y-character has basis y*x^-k, 1<=k<=53.
    full = {}
    for j in range(1, 6):
        for i, coefficient in enumerate(P**8):
            exponent = i - 25*j
            full[exponent] = full.get(exponent, R(0)) + coefficient*(av[j-1]-t*bv[j-1])
    reduced = {e: v for e, v in full.items() if -53 <= e <= -1 and v}

    # Verify reduction agrees with direct 25th powering of the original
    # Laurent extension. y^25 = y*P^8 is the only cubic reduction.
    assert P.degree() == 10 and (P**8).degree() == 80
    assert av[0] - decode(11)*bv[0] == 0
    assert [av[j]-decode(11)*bv[j] for j in range(5)] == [K(0)]*4+[decode(20)]

    def block(target_count, source_count, coefficients):
        return matrix(R, [[coefficients.get(-k-j, R(0))
                           for j in range(source_count)]
                          for k in range(1, target_count+1)])

    product = {}
    for e, v in reduced.items():
        for i, coefficient in enumerate(P):
            product[e+i] = product.get(e+i, R(0)) + v*coefficient

    blocks = [
        ("domain_1_target_y", block(28, 26, reduced)),
        ("domain_y_target_y2", block(31, 22, reduced)),
        ("domain_y2_target_1", block(24, 19, product)),
    ]
    assert sum(M.ncols() for _, M in blocks) == 67
    assert sum(M.nrows() for _, M in blocks) == 83

    def polynomial_codes(p):
        return [encode(v) for v in R(p).list()]

    def matrix_codes(M):
        return [[polynomial_codes(M[i, j]) for j in range(M.ncols())]
                for i in range(M.nrows())]

    summaries = []
    all_exceptional = R(1)
    generic_h0 = 0
    special_h0 = 0
    for name, M in blocks:
        tick = time.monotonic()
        print(json.dumps({"stage": "smith_start", "block": name,
                          "shape": [M.nrows(), M.ncols()]}), flush=True)
        D, U, V = M.smith_form()
        assert U*M*V == D
        assert bareiss_determinant(U).degree() == 0
        assert bareiss_determinant(V).degree() == 0
        assert all(not D[i, j] for i in range(D.nrows())
                   for j in range(D.ncols()) if i != j)
        diagonal = [R(D[i, i]) for i in range(min(D.nrows(), D.ncols()))]
        nonzero = [v.monic() for v in diagonal if v]
        assert diagonal[:len(nonzero)] and all(not v for v in diagonal[len(nonzero):])
        assert all(nonzero[i+1] % nonzero[i] == 0 for i in range(len(nonzero)-1))
        rank = len(nonzero)
        generic_h0 += M.ncols()-rank
        maximal_minor_gcd = R(1)
        for v in nonzero:
            maximal_minor_gcd *= v
        factors = list(maximal_minor_gcd.factor())
        for f, _ in factors:
            all_exceptional = all_exceptional.lcm(f)
        rank_at_old = M.subs(t=decode(11)).rank()
        special_h0 += M.ncols()-rank_at_old
        assert rank_at_old == sum(bool(v(decode(11))) for v in nonzero)
        cert = {
            "coefficient_field": "F25, a^2=a+3; code n0+5*n1=n0+n1*a",
            "parameter": "t=c^25", "row_order": "k=1,...,target_count",
            "matrix": matrix_codes(M), "smith": matrix_codes(D),
            "left_unimodular": matrix_codes(U), "right_unimodular": matrix_codes(V),
            "verified": {"UMV_equals_D": True, "U_and_V_unimodular": True,
                         "diagonal_divisibility": True},
        }
        certificate_path = out / (name + "_smith.json")
        certificate_path.write_text(json.dumps(cert, separators=(",", ":")) + "\n")
        summary = {
            "name": name, "shape": [M.nrows(), M.ncols()],
            "generic_rank": rank, "generic_kernel_dimension": M.ncols()-rank,
            "rank_at_c_11": int(rank_at_old),
            "smith_nonzero_monic": [polynomial_codes(v) for v in nonzero],
            "maximal_nonzero_minor_gcd": polynomial_codes(maximal_minor_gcd),
            "factors": [{"polynomial": polynomial_codes(f), "exponent": int(e),
                         "degree": int(f.degree())} for f, e in factors],
            "certificate": certificate_path.name,
            "certificate_bytes": certificate_path.stat().st_size,
            "seconds": time.monotonic()-tick,
        }
        summaries.append(summary)
        print(json.dumps({"stage": "smith_done", **summary}), flush=True)

    # Check every rank-drop prime by direct specialization over its field.
    specializations = []
    for f, _ in all_exceptional.factor():
        if f.degree() == 1:
            residue = K
            root = -f[0]/f[1]
        else:
            residue = K.extension(f, "r")
            root = residue.gen()
        ranks = []
        for _, M in blocks:
            specialized = matrix(residue, [[p(root) for p in row] for row in M.rows()])
            ranks.append(int(specialized.rank()))
        h0 = 67-sum(ranks)
        specializations.append({"prime": polynomial_codes(f), "degree": int(f.degree()),
                                "ranks": ranks, "h0": h0})

    result = {
        "status": "EXACT_SECOND_FROBENIUS_SECTION_LOCUS",
        "sage": version(), "coefficient_field": "F25, a^2=a+3",
        "frobenius_convention": "absolute; twice-relative coefficient transport agrees since F25 is fixed",
        "height": 2, "parameter": "t=c^25", "P_codes": P_codes,
        "extension_a_codes": a_codes, "extension_b_codes": b_codes,
        "blocks": summaries, "generic_h0": int(generic_h0),
        "h0_at_c_11": int(special_h0),
        "rank_drop_locus_squarefree_t": polynomial_codes(all_exceptional.monic()),
        "rank_drop_prime_specializations": specializations,
        "elapsed_seconds": time.monotonic()-started,
        "scope": "Section locus of F^2 L_c only; no semistability, all-height, common-descent or cover-existence assertion.",
    }
    (out / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"stage": "complete", "generic_h0": int(generic_h0),
                      "h0_at_c_11": int(special_h0),
                      "rank_drop_locus_squarefree_t": polynomial_codes(all_exceptional.monic()),
                      "specializations": specializations,
                      "elapsed_seconds": time.monotonic()-started}), flush=True)


if __name__ == "__main__":
    main()
