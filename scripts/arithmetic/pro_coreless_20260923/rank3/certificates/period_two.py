"""Exact necessary-condition matrices for the rank-three return problem.

Python 3.10+ and NumPy are required. Run:
    python period_two.py

This reconstructs the determinant-trivial, period-two cup-product tensor.
It does NOT decide geometric rank drop, produce a strict Frobenius return,
or decide the user's unrestricted existence problem.

Arithmetic uses codes c0+5*c1 for c0+c1*a with a^2=a+3.
Function monomials are indexed by (x exponent, y exponent), 0 <= b <= 2.
All exponents of x may be negative. The relation is y^3=P(x).
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import TypeAlias

import numpy as np

import verify_rank3_first_return as ff

Monomial: TypeAlias = tuple[int, int]
Function: TypeAlias = dict[Monomial, int]
HERE = Path(__file__).resolve().parent
ADD = np.array([[ff.add(i, j) for j in range(25)] for i in range(25)], dtype=np.uint8)
MUL = np.array([[ff.multiply(i, j) for j in range(25)] for i in range(25)], dtype=np.uint8)
NEG = np.array([ff.negative(i) for i in range(25)], dtype=np.uint8)
INV = np.array([0] + [ff.inverse(i) for i in range(1, 25)], dtype=np.uint8)
P = {i: c for i, c in enumerate(ff.P_COEFFICIENTS) if c}
P_POWERS: dict[int, dict[int, int]] = {0: {0: 1}, 1: P}


def p_power(n: int) -> dict[int, int]:
    if n < 0:
        raise ValueError("Polynomial powers must be nonnegative.")
    if n not in P_POWERS:
        P_POWERS[n] = ff.polynomial_power(P, n)
    return P_POWERS[n]


def add_functions(f: Function, g: Function) -> Function:
    h = f.copy()
    for monomial, coefficient in g.items():
        value = ff.add(h.get(monomial, 0), coefficient)
        if value:
            h[monomial] = value
        else:
            h.pop(monomial, None)
    return h


def multiply_functions(f: Function, g: Function) -> Function:
    h: Function = {}
    for (i, b), c in f.items():
        for (j, d), a in g.items():
            power, remainder = divmod(b + d, 3)
            factor = ff.multiply(c, a)
            for u, t in p_power(power).items():
                monomial = (i + j + u, remainder)
                value = ff.add(h.get(monomial, 0), ff.multiply(factor, t))
                if value:
                    h[monomial] = value
                else:
                    h.pop(monomial, None)
    return h


def frobenius(f: Function, exponent: int) -> Function:
    """Raise a function to a power of five, including its coefficients."""
    power = exponent
    while power > 1 and power % 5 == 0:
        power //= 5
    if power != 1 or exponent < 1:
        raise ValueError("The exponent must be a nonnegative power of five.")
    h: Function = {}
    for (i, b), c in f.items():
        n, remainder = divmod(b * exponent, 3)
        coefficient = ff.power(c, exponent)
        term = {(i * exponent + j, remainder): ff.multiply(coefficient, a)
                for j, a in p_power(n).items()}
        h = add_functions(h, term)
    return h


def section_monomials(degree: int) -> list[Monomial]:
    """Basis of H^0(O(degree*O)), using weights 3*a+10*b."""
    return [(a, b) for b in range(3)
            for a in range(max(0, (degree - 10 * b) // 3 + 1))]


def cech_monomials(degree: int) -> list[Monomial]:
    """Negative-x monomials representing H^1(O(degree*O))."""
    return [(a, b) for b in range(3)
            for a in range((degree - 10 * b) // 3 + 1, 0)]


def rref_nullspace(matrix: np.ndarray) -> tuple[int, np.ndarray, list[int]]:
    a = np.asarray(matrix, dtype=np.uint8).copy()
    if a.ndim != 2 or np.any(a >= 25):
        raise ValueError("Expected a matrix of F_25 codes from 0 through 24.")
    n, m = a.shape
    pivots: list[int] = []
    r = 0
    for column in range(m):
        candidates = np.flatnonzero(a[r:, column])
        if not len(candidates):
            continue
        pivot_row = r + int(candidates[0])
        if pivot_row != r:
            a[[r, pivot_row]] = a[[pivot_row, r]]
        a[r] = MUL[a[r], INV[a[r, column]]]
        rows = np.flatnonzero(a[:, column])
        rows = rows[rows != r]
        a[rows] = ADD[a[rows], NEG[MUL[a[rows, column, None], a[r, None, :]]]]
        pivots.append(column)
        r += 1
        if r == n:
            break
    free = [i for i in range(m) if i not in pivots]
    nullspace = np.zeros((m, len(free)), dtype=np.uint8)
    for j, column in enumerate(free):
        nullspace[column, j] = 1
        nullspace[pivots, j] = NEG[a[:r, column]]
    return r, nullspace, pivots


def determinant(matrix: np.ndarray) -> int:
    a = np.asarray(matrix, dtype=np.uint8).copy()
    n, m = a.shape
    if n != m:
        raise ValueError("Determinants require a square matrix.")
    result = 1
    for col in range(n):
        choices = np.flatnonzero(a[col:, col])
        if not len(choices):
            return 0
        pivot = col + int(choices[0])
        if pivot != col:
            a[[col, pivot]] = a[[pivot, col]]
            result = ff.negative(result)
        value = int(a[col, col])
        result = ff.multiply(result, value)
        if col + 1 < n:
            factors = MUL[a[col + 1:, col], INV[value]]
            a[col + 1:] = ADD[a[col + 1:], NEG[MUL[factors[:, None], a[col, None, :]]]]
    return result


def matrix_product(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    if a.ndim != 2 or b.ndim != 2 or a.shape[1] != b.shape[0]:
        raise ValueError("Matrix dimensions do not match.")
    result = np.zeros((a.shape[0], b.shape[1]), dtype=np.uint8)
    for i in range(a.shape[1]):
        result = ADD[result, MUL[a[:, i, None], b[i, None, :]]]
    return result


def kernel_sections(q: int, e: Function):
    eq = frobenius(e, q)
    bottom_basis = section_monomials(6 * q + 1)
    obstruction_rows = cech_monomials(1 - 5 * q)
    products = [multiply_functions(eq, {m: 1}) for m in bottom_basis]
    matrix = np.array([[f.get(m, 0) for f in products]
                       for m in obstruction_rows], dtype=np.uint8)
    rank, kernel, pivots = rref_nullspace(matrix)
    assert not np.any(matrix_product(matrix, kernel))
    sections: list[tuple[Function, Function]] = []
    for j in range(kernel.shape[1]):
        bottom = {m: int(kernel[i, j]) for i, m in enumerate(bottom_basis)
                  if kernel[i, j]}
        product = multiply_functions(eq, bottom)
        top = {m: c for m, c in product.items() if m[0] >= 0}
        # The remaining negative-x terms must be regular on the V chart
        # with the required divisor bound. Distinct reduced monomials have
        # distinct infinity weights, so there is no hidden leading cancellation.
        assert all(3 * a + 10 * b <= 1 - 5 * q
                   for (a, b), c in product.items() if a < 0 and c)
        sections.append((top, bottom))
    return matrix, kernel, pivots, bottom_basis, obstruction_rows, sections


def construct() -> None:
    ff.verify()
    e: Function = {(-m, 2): c for m, c in enumerate(ff.C_COEFFICIENTS, 1)}

    # A separate three-column certificate for h^0(K(O)) = 0.
    small_minor = np.array([[e.get((r - j, 2), 0) for j in range(3)]
                            for r in range(-7, -4)], dtype=np.uint8)
    small_det = determinant(small_minor)
    assert small_det == 18
    print(f"h^0(K(O)) = 0: 3 x 3 minor determinant [{small_det}].")

    q = 25
    m, kernel, pivots, bottom_basis, m_rows, sections = kernel_sections(q, e)
    assert m.shape == (132, 143)
    assert len(pivots) == 132 and kernel.shape == (143, 11)
    maximal_minor = determinant(m[:, pivots])
    assert maximal_minor != 0
    print(f"K period-two section matrix: {m.shape}, rank 132; h^0 = 11.")
    print(f"Its pivot-column maximal minor has determinant [{maximal_minor}].")

    # Extension transition:
    # n_V=n_U-u*a_U-v*b_U; a_V=a_U-e*b_U; b_V=b_U.
    # u is in H^1(O(4O)); v is in H^1(O(-7O))/(e, x*e).
    u_basis = cech_monomials(4)
    v_full = cech_monomials(-7)
    xe = multiply_functions({(1, 0): 1}, e)
    relation_matrix = np.array([[e.get(mon, 0), xe.get(mon, 0)]
                                for mon in v_full], dtype=np.uint8)
    relation_rank, _, removed_rows = rref_nullspace(relation_matrix.T)
    assert relation_rank == 2
    v_basis = [mon for i, mon in enumerate(v_full) if i not in removed_rows]
    assert len(u_basis) == 6 and len(v_basis) == 13
    extensions = [({mon: 1}, {}) for mon in u_basis]
    extensions += [({}, {mon: 1}) for mon in v_basis]
    cup_rows = cech_monomials(1 - q)
    tensor = np.zeros((len(cup_rows), len(sections), len(extensions)), dtype=np.uint8)
    for t, (u, v) in enumerate(extensions):
        uq, vq = frobenius(u, q), frobenius(v, q)
        for j, (top, bottom) in enumerate(sections):
            product = add_functions(multiply_functions(uq, top),
                                    multiply_functions(vq, bottom))
            tensor[:, j, t] = [product.get(mon, 0) for mon in cup_rows]
    assert tensor.shape == (32, 11, 19)

    # The associated cup matrix is sum_t xi_t^25 * tensor[:,:,t].
    # When evaluating only F_25 points, xi_t^25=xi_t. Over k, it is
    # essential not to confuse the Frobenius-twisted parameters with a
    # finite-field point restriction.
    digest = hashlib.sha256(tensor.tobytes(order="C")).hexdigest()
    np.savez_compressed(HERE / "period_two_data.npz",
                        cup_tensor=tensor, section_matrix=m,
                        section_kernel=kernel, section_pivots=np.array(pivots),
                        section_bottom_basis=np.array(bottom_basis),
                        section_matrix_rows=np.array(m_rows),
                        cup_rows=np.array(cup_rows), u_basis=np.array(u_basis),
                        v_basis=np.array(v_basis), ADD=ADD, MUL=MUL,
                        NEG=NEG, INV=INV)
    certificate = {
        "scope": "Necessary-condition computation only; no existence decision.",
        "field": "F_5[a]/(a^2-a-3), code c0+5*c1",
        "determinant_line": "O_X", "Frobenius_exponent": 25,
        "h0_K_O": 0, "h0_K_O_minor": small_minor.tolist(),
        "h0_K_O_minor_det": small_det,
        "section_matrix_shape": list(m.shape), "section_matrix_rank": 132,
        "section_pivot_columns_zero_based": pivots,
        "section_maximal_minor_det": maximal_minor,
        "h0_F2K_O": 11, "cup_tensor_shape": list(tensor.shape),
        "cup_tensor_sha256_raw_uint8_C_order": digest,
        "u_monomial_basis": u_basis, "v_monomial_basis": v_basis,
        "cup_row_basis": cup_rows,
        "necessary_rank_for_strict_second_return": 10,
        "geometric_rank_drop_decided": False,
        "strict_return_certified": False,
    }
    (HERE / "certificate.json").write_text(json.dumps(certificate, indent=2) + "\n")
    print(f"Cup tensor shape: {tensor.shape}; SHA256: {digest}")
    print("No geometric rank-drop decision or strict-return certificate is claimed.")


if __name__ == "__main__":
    construct()
