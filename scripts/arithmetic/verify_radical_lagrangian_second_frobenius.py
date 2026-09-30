#!/usr/bin/env python3
"""Verify the height-two section locus from polynomial rank certificates.

This reconstructs each entry directly from P^8 or P^9, independently of
the builder's Laurent reduction. The identity U M V = D proves full
column rank wherever D has full column rank, even without a second
unimodularity check. Direct ranks at the exceptional point finish the
section-locus proof. The builder separately checks the stronger Smith
statement by exact Bareiss determinants. This is an arithmetic check,
not an independent proof of the geometric cohomology interpretation.
"""

import argparse
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, version


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("directory")
    args = parser.parse_args()
    directory = Path(args.directory).resolve()
    started = time.monotonic()
    result = json.loads((directory / "result.json").read_text())
    K = GF(25, "a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
    a = K.gen()
    decode = lambda n: K(n % 5) + K(n // 5)*a
    R = PolynomialRing(K, "t")
    t = R.gen()
    S = PolynomialRing(K, "x")
    P = S([decode(n) for n in [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]])
    av = [decode(n) for n in [19, 9, 15, 6, 16]]
    bv = [decode(n) for n in [4, 16, 17, 22, 14]]

    def polynomial(row):
        return R([decode(n) for n in row])

    def load_matrix(rows):
        return matrix(R, [[polynomial(v) for v in row] for row in rows])

    checks = []
    total_generic_kernel = 0
    total_old_kernel = 0
    global_exceptional = R(1)
    for summary in result["blocks"]:
        name = summary["name"]
        cert = json.loads((directory / summary["certificate"]).read_text())
        M = load_matrix(cert["matrix"])
        D = load_matrix(cert["smith"])
        U = load_matrix(cert["left_unimodular"])
        V = load_matrix(cert["right_unimodular"])
        source_character = {"domain_1_target_y": 0,
                            "domain_y_target_y2": 1,
                            "domain_y2_target_1": 2}[name]
        target_character = (source_character+1) % 3
        source_count = (75-10*source_character)//3+1
        target_count = -((-75-10*target_character)//3)-1
        power = P**(8+int(source_character == 2))

        def entry(k, j):
            # The endpoint extension has five terms y*x^-i. After F^2
            # and cubic reduction the needed exponent is 25i-k-j.
            return sum((power[25*i-k-j] if 0 <= 25*i-k-j <= power.degree() else K(0))
                       * (av[i-1]-t*bv[i-1]) for i in range(1, 6))

        direct = matrix(R, [[entry(k, j) for j in range(source_count)]
                            for k in range(1, target_count+1)])
        assert direct == M
        assert U*M*V == D
        assert all(not D[i, j] for i in range(D.nrows())
                   for j in range(D.ncols()) if i != j)
        diagonal = [R(D[i, i]) for i in range(min(D.nrows(), D.ncols()))]
        rank = sum(bool(v) for v in diagonal)
        assert rank == source_count
        assert all(diagonal[i] for i in range(rank))
        assert all(not v for v in diagonal[rank:])
        nonzero = [v.monic() for v in diagonal[:rank]]
        assert all(v in (R(1), t-decode(11)) for v in nonzero)
        assert all(nonzero[i+1] % nonzero[i] == 0 for i in range(rank-1))
        assert nonzero == [polynomial(v) for v in summary["smith_nonzero_monic"]]
        gcd_minor = R(1)
        for v in nonzero:
            gcd_minor *= v
        assert gcd_minor == polynomial(summary["maximal_nonzero_minor_gcd"])
        for f, _ in gcd_minor.factor():
            global_exceptional = global_exceptional.lcm(f)
        total_generic_kernel += source_count-rank
        old_rank = M.subs(t=decode(11)).rank()
        assert old_rank == summary["rank_at_c_11"]
        assert old_rank == sum(bool(v(decode(11))) for v in nonzero)
        total_old_kernel += source_count-old_rank
        checks.append({"block": name, "direct_entry_reconstruction": "PASS",
                       "polynomial_UMV_rank_certificate": "PASS",
                       "diagonal_divisibility": "PASS", "generic_rank": rank,
                       "rank_at_c_11": int(old_rank)})
    assert total_generic_kernel == result["generic_h0"]
    assert total_old_kernel == result["h0_at_c_11"]
    assert global_exceptional.monic() == polynomial(result["rank_drop_locus_squarefree_t"])
    assert total_generic_kernel == 0 and total_old_kernel == 42
    assert global_exceptional.monic() == t-decode(11)
    receipt = {"status": "PASS", "sage": version(), "checks": checks,
               "scope": "Exact height-two section locus; Smith unimodularity is verified by the builder and need not be repeated for this rank proof",
               "seconds": time.monotonic()-started}
    (directory / "verification.json").write_text(json.dumps(receipt, indent=2) + "\n")
    print(json.dumps(receipt, indent=2), flush=True)


if __name__ == "__main__":
    main()
