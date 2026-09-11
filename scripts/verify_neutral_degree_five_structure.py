"""Exact checks for the accompanying N5 partial analysis.

Run: sage -python scripts/verify_neutral_degree_five_structure.py
Dependencies: numpy, sympy.

These checks verify algebraic identities, not a geometric counterexample.
"""
from __future__ import annotations

import itertools
import json
from functools import reduce

try:
    import numpy as np
    import sympy as sp
except ImportError as exc:
    raise SystemExit("This verification requires numpy and sympy.") from exc


def rank_mod5(matrix: np.ndarray) -> int:
    mat = np.array(matrix, dtype=np.int64) % 5
    rank = 0
    for col in range(mat.shape[1]):
        pivots = np.flatnonzero(mat[rank:, col])
        if not len(pivots):
            continue
        pivot = rank + int(pivots[0])
        mat[[rank, pivot]] = mat[[pivot, rank]]
        mat[rank] = mat[rank] * pow(int(mat[rank, col]), -1, 5) % 5
        factors = mat[:, col].copy()
        factors[rank] = 0
        mat = (mat - factors[:, None] * mat[rank]) % 5
        rank += 1
        if rank == mat.shape[0]:
            break
    return rank


def main() -> None:
    z = sp.symbols("z")
    u, v, r = [sp.Function(name)(z) for name in ("u", "v", "r")]

    def bol(f):
        return sp.diff(f, z, 3) - 4 * r * sp.diff(f, z) - 2 * sp.diff(r, z) * f

    concomitant = (u * sp.diff(v, z, 2) - sp.diff(u, z) * sp.diff(v, z)
                   + sp.diff(u, z, 2) * v - 4 * r * u * v)
    bol_identity = sp.simplify(u * bol(v) + v * bol(u) - sp.diff(concomitant, z)) == 0

    # Cartier pairing at z^(1)=0, with basis 1,z,...,z^4.
    rs = sp.symbols("r0:5")
    rt = sum(rs[i] * z**i for i in range(5))
    pairing = sp.zeros(5)
    for i in range(5):
        for j in range(5):
            dv = (sp.diff(z**j, z, 3) - 4 * rt * sp.diff(z**j, z)
                  - 2 * sp.diff(rt, z) * z**j)
            coeff = sp.expand(z**i * dv).coeff(z, 4)
            pairing[i, j] = sp.Poly(coeff, *rs, modulus=5).as_expr()
    c = sp.Poly(sp.expand(rt**2 + 3 * sp.diff(rt, z, 2)), z, *rs, modulus=5).as_expr()
    pfaffian_checks = []
    for omit in range(5):
        i, j, k, ell = [s for s in range(5) if s != omit]
        pf = (pairing[i, j] * pairing[k, ell] - pairing[i, k] * pairing[j, ell]
              + pairing[i, ell] * pairing[j, k])
        discrepancy = (-1)**omit * pf - 2 * sp.expand(c).coeff(z, omit)
        pfaffian_checks.append(sp.Poly(sp.expand(discrepancy), *rs, modulus=5).is_zero)

    # A = 24 I - R_{N_H} + R_{N_G} on the regular S5 lattice.
    # A/24 is J on W[G]e_H and identity on its complementary summand.
    permutations = list(itertools.permutations(range(5)))
    index = {g: i for i, g in enumerate(permutations)}
    order = len(permutations)
    H = {g for g in permutations if g[0] == 0}

    def compose(g, h):
        return tuple(g[h[i]] for i in range(5))

    def cycle(*entries):
        g = list(range(5))
        for i, t in enumerate(entries):
            g[t] = entries[(i + 1) % len(entries)]
        return tuple(g)

    def left_matrix(g):
        result = np.zeros((order, order), dtype=np.int64)
        for j, h in enumerate(permutations):
            result[index[compose(g, h)], j] = 1
        return result

    right_norm_H = np.zeros((order, order), dtype=np.int64)
    for j, g in enumerate(permutations):
        for h in H:
            right_norm_H[index[compose(g, h)], j] += 1
    identity = np.eye(order, dtype=np.int64)
    A = 24 * identity - right_norm_H + np.ones((order, order), dtype=np.int64)

    def invariant_kernel_dimension(generators):
        return order - rank_mod5(np.vstack([A] + [left_matrix(g) - identity for g in generators]))

    w = np.array([1 - 5 * (g in H) for g in permutations], dtype=np.int64)
    change = left_matrix(cycle(0, 1)) @ w - w

    # F25 = F5[a]/(a^2+4a+2), so a^2=a+3.
    def add25(x, y):
        return ((x[0] + y[0]) % 5, (x[1] + y[1]) % 5)

    def mul25(x, y):
        a, b = x
        c_, d = y
        return ((a * c_ + 3 * b * d) % 5, (a * d + b * c_ + b * d) % 5)

    def pow25(x, exponent):
        result = (1, 0)
        while exponent:
            if exponent & 1:
                result = mul25(result, x)
            x = mul25(x, x)
            exponent >>= 1
        return result

    alpha5 = pow25((0, 1), 5)
    frobenius_norm = reduce(add25, [mul25((c_ % 5, 0), alpha5) for c_ in (-4, 1, 1, 1, 1)], (0, 0))
    results = {
        "Bol_skew_adjoint_identity": bool(bol_identity),
        "all_five_Pfaffian_identities": all(pfaffian_checks),
        "regular_lattice_rank": order,
        "kernel_dimension_mod5": order - rank_mod5(A),
        "G_fixed_kernel_dimension": invariant_kernel_dimension([cycle(0, 1), cycle(0, 1, 2, 3, 4)]),
        "H_fixed_kernel_dimension": invariant_kernel_dimension([cycle(1, 2), cycle(1, 2, 3, 4)]),
        "S3_fixed_kernel_dimension": invariant_kernel_dimension([cycle(2, 3), cycle(2, 3, 4)]),
        "regular_operator_self_adjoint": bool(np.array_equal(A, A.T)),
        "integral_norm_mode": bool(np.all(A @ w == 0)),
        "25w_fixed_mod125": bool(np.all((25 * change) % 125 == 0)),
        "25w_fixed_mod625": bool(np.all((25 * change) % 625 == 0)),
        "alpha_to_5_in_F25": alpha5,
        "alpha_to_25_in_F25": pow25((0, 1), 25),
        "F25_Frobenius_norm": frobenius_norm,
        "geometric_counterexample_constructed": False,
    }
    assert results["Bol_skew_adjoint_identity"] and results["all_five_Pfaffian_identities"]
    assert [results[key] for key in ("kernel_dimension_mod5", "G_fixed_kernel_dimension", "H_fixed_kernel_dimension", "S3_fixed_kernel_dimension")] == [4, 1, 1, 2]
    assert results["integral_norm_mode"] and results["regular_operator_self_adjoint"]
    assert results["25w_fixed_mod125"] and not results["25w_fixed_mod625"]
    assert alpha5 == (1, 4) and frobenius_norm == (0, 0)
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
