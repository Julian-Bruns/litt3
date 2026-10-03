#!/usr/bin/env python3
"""Exact certificate that H^0(X, Sym^6 K) = 0 for the specified extension.

Requires Python 3.10+ and only the standard library.
Run: python quadratic_twist_certificate.py

The script reconstructs the full finite linear system, verifies three explicit
full-column-rank minors and independently verifies rank after restriction
of scalars to F_5.
It writes quadratic_twist_certificate.json beside this script.

Coefficient code u+5*v denotes u+v*a, where a^2=a+3 over F_5.
A Laurent polynomial is represented by {(r,m): coefficient}, meaning
sum coefficient*y^r*x^m, with 0 <= r <= 2 and y^3=P(x).
"""
from __future__ import annotations
import json
from math import comb
from pathlib import Path

Poly = dict[tuple[int, int], int]
Matrix = list[list[int]]

ADD = [[(i % 5 + j % 5) % 5 + 5 * ((i // 5 + j // 5) % 5)
        for j in range(25)] for i in range(25)]
NEG = [(-i % 5) + 5 * ((-(i // 5)) % 5) for i in range(25)]
MUL = [[((i % 5) * (j % 5) + 3 * (i // 5) * (j // 5)) % 5
        + 5 * (((i % 5) * (j // 5) + (i // 5) * (j % 5)
                + (i // 5) * (j // 5)) % 5)
        for j in range(25)] for i in range(25)]
INV = [0] + [next(j for j in range(1, 25) if MUL[i][j] == 1)
             for i in range(1, 25)]
P = (11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1)
C = (2, 16, 16, 7, 1, 2, 7, 1, 24, 11)
ONE: Poly = {(0, 0): 1}
E: Poly = {(2, -m): c for m, c in enumerate(C, 1)}


def add(a: Poly, b: Poly, scale: int = 1) -> Poly:
    result = dict(a)
    for key, value in b.items():
        v = ADD[result.get(key, 0)][MUL[scale][value]]
        if v:
            result[key] = v
        else:
            result.pop(key, None)
    return result


def multiply(a: Poly, b: Poly) -> Poly:
    result: Poly = {}
    for (r, m), v in a.items():
        for (s, n), w in b.items():
            coeff = MUL[v][w]
            if r + s < 3:
                key = (r + s, m + n)
                result[key] = ADD[result.get(key, 0)][coeff]
            else:
                for j, p in enumerate(P):
                    key = (r + s - 3, m + n + j)
                    result[key] = ADD[result.get(key, 0)][MUL[coeff][p]]
    return {key: v for key, v in result.items() if v}


def polynomial_basis(bound: int) -> list[tuple[int, int]]:
    """All affine monomials y^r*x^m with pole weight 10*r+3*m <= bound."""
    return [(r, m) for r in range(3)
            for m in range(max(0, (bound - 10 * r) // 3 + 1))]


def rref(matrix: Matrix) -> tuple[Matrix, list[int]]:
    a = [row[:] for row in matrix]
    if not a:
        return a, []
    n, m = len(a), len(a[0])
    pivots: list[int] = []
    h = 0
    for j in range(m):
        i = next((i for i in range(h, n) if a[i][j]), None)
        if i is None:
            continue
        a[h], a[i] = a[i], a[h]
        inv = INV[a[h][j]]
        a[h] = [MUL[inv][v] for v in a[h]]
        for i in range(n):
            if i != h and a[i][j]:
                factor = NEG[a[i][j]]
                a[i] = [ADD[v][MUL[factor][w]] for v, w in zip(a[i], a[h])]
        pivots.append(j)
        h += 1
        if h == n:
            break
    return a, pivots


def determinant(matrix: Matrix) -> int:
    a = [row[:] for row in matrix]
    n = len(a)
    assert all(len(row) == n for row in a)
    value = 1
    for j in range(n):
        i = next((i for i in range(j, n) if a[i][j]), None)
        if i is None:
            return 0
        if i != j:
            a[j], a[i] = a[i], a[j]
            value = NEG[value]
        pivot = a[j][j]
        value = MUL[value][pivot]
        inv = INV[pivot]
        a[j] = [MUL[inv][v] for v in a[j]]
        for i in range(j + 1, n):
            factor = NEG[a[i][j]]
            if factor:
                a[i] = [ADD[v][MUL[factor][w]] for v, w in zip(a[i], a[j])]
    return value


def system(n: int, twist: int = 0):
    """Construct the exact system for H^0(Sym^n K(twist*O)).

    d_i = -5*n + 11*i + twist; infinity requires ord(g_i) >= -d_i.
    Let R_i = sum_{j>i} binom(j,i)*(-e)^(j-i)*f_j.
    Descending recursion: f_i = h_i - (R_i)_+.
    The only free terms h_i are affine monomials of pole weight <= d_i.
    The equations are the forbidden negative-x-power coefficients of R_i.
    """
    d = [-5 * n + 11 * i + twist for i in range(n + 1)]
    columns = [(i, r, m) for i in range(n, -1, -1)
               for r, m in polynomial_basis(d[i])]
    # Include identically zero equations, for a canonical full row set.
    rows = [(i, r, m) for i in range(n + 1) for r in range(3)
            for m in range((d[i] - 10 * r) // 3 + 1, 0)]
    powers = [ONE]
    for _ in range(n):
        powers.append(multiply(powers[-1], E))
    column_values = []
    for source_i, source_r, source_m in columns:
        f: list[Poly] = [{} for _ in range(n + 1)]
        residual: list[Poly] = [{} for _ in range(n + 1)]
        for i in range(n, -1, -1):
            R: Poly = {}
            for j in range(i + 1, n + 1):
                factor = (comb(j, i) * (-1) ** (j - i)) % 5
                if factor:
                    R = add(R, multiply(powers[j - i], f[j]), factor)
            f[i] = {key: NEG[v] for key, v in R.items() if key[1] >= 0}
            if i == source_i:
                f[i] = add(f[i], {(source_r, source_m): 1})
            residual[i] = R
        column_values.append([residual[i].get((r, m), 0) for i, r, m in rows])
    matrix = [[column_values[j][i] for j in range(len(columns))]
              for i in range(len(rows))]
    return columns, rows, matrix


def prime_field_rank(matrix: Matrix) -> int:
    """Independent F_5 elimination, after expanding each F_25 entry to 2x2."""
    expanded: Matrix = []
    for row in matrix:
        upper, lower = [], []
        for code in row:
            u, v = code % 5, code // 5
            upper.extend((u, 3 * v % 5))
            lower.extend((v, (u + v) % 5))
        expanded.extend((upper, lower))
    h = 0
    for j in range(len(expanded[0])):
        i = next((i for i in range(h, len(expanded)) if expanded[i][j]), None)
        if i is None:
            continue
        expanded[h], expanded[i] = expanded[i], expanded[h]
        inv = pow(expanded[h][j], -1, 5)
        expanded[h] = [(v * inv) % 5 for v in expanded[h]]
        for i in range(h + 1, len(expanded)):
            factor = expanded[i][j]
            if factor:
                expanded[i] = [(v - factor * w) % 5
                               for v, w in zip(expanded[i], expanded[h])]
        h += 1
        if h == len(expanded):
            break
    return h


def main() -> None:
    columns, rows, a = system(6)
    assert (len(rows), len(columns)) == (89, 54)
    assert len(rref(a)[1]) == 54
    row_index = {r: i for i, r in enumerate(rows)}
    selected_rows = [
        [(0, 0, m) for m in range(-9, 0)]
        + [(1, 1, m) for m in range(-9, 0)] + [(2, 2, -9)],
        [(0, 1, m) for m in range(-13, 0)]
        + [(1, 2, m) for m in range(-12, -7)],
        [(0, 2, m) for m in range(-16, 0)] + [(1, 0, -6)],
    ]
    expected = [(27, 19, 5), (30, 18, 21), (32, 17, 24)]
    blocks = []
    for w in range(3):
        col_ids = [j for j, (i, r, m) in enumerate(columns) if (r - i) % 3 == w]
        row_ids = [j for j, (i, r, m) in enumerate(rows) if (r - i) % 3 == w]
        minor = [[a[row_index[r]][j] for j in col_ids] for r in selected_rows[w]]
        det = determinant(minor)
        assert (len(row_ids), len(col_ids), det) == expected[w]
        # No mixing between the three weight sectors.
        assert all(a[i][j] == 0 for i, row in enumerate(rows)
                   for j in col_ids if (row[1] - row[0]) % 3 != w)
        blocks.append(dict(weight=w, columns=[columns[j] for j in col_ids],
                           selected_rows=selected_rows[w], minor=minor,
                           minor_determinant_code=det))
        print(f'Weight {w}: block {len(row_ids)}x{len(col_ids)}, '
              f'selected minor {len(col_ids)}x{len(col_ids)}, determinant [{det}].')
    assert prime_field_rank(a) == 108
    print('Full rank over F_25: 54. Independent rank over F_5: 108.')
    print('Therefore H^0(X_k, Sym^6 K_k) = 0 over every field extension k/F_25.')
    data = dict(field='F5[a]/(a^2-a-3); code u+5v=u+va',
                P_codes=P, C_codes=C, power=6, twist=0,
                label_convention='(i,r,m): coefficient of y^r*x^m in h_i (column) or R_i (row)',
                columns=columns, rows=rows, matrix=a, blocks=blocks,
                rank_F25=54, rank_F5=108)
    path = Path(__file__).resolve().with_suffix('.json')
    path.write_text(json.dumps(data, indent=2) + '\n', encoding='utf-8')
    print(f'Matrix data written to {path.name}.')


if __name__ == '__main__':
    main()
