"""Independent exact F_5^14 arithmetic (Python standard library only).

The native engine uses F_25[q]/(degree 7 polynomial). This module instead
uses fourteen F_5 coefficients. All returned tuples are reduced field elements.
"""
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FIELD = json.loads((ROOT / 'inputs' / 'field.json').read_text())
MOD = FIELD['reference_F5_extension_modulus_ascending']
ZERO = (0,) * 14
ONE = (1,) + (0,) * 13
Q = (0, 1) + (0,) * 12
A = tuple(FIELD['reference_a_embedding_ascending'])
SIZE = 5**14
MU_CODES = tuple(FIELD['mu8_codes_ordered'])
Element = tuple[int, ...]

def scalar(a: int) -> Element:
    return (a % 5,) + (0,) * 13

def add(a: Element, b: Element) -> Element:
    return tuple((x + y) % 5 for x, y in zip(a, b))

def neg(a: Element) -> Element:
    return tuple((-x) % 5 for x in a)

def sub(a: Element, b: Element) -> Element:
    return tuple((x - y) % 5 for x, y in zip(a, b))

def scale(a: Element, c: int) -> Element:
    return tuple((x * c) % 5 for x in a)

def mul(a: Element, b: Element) -> Element:
    c = [0] * 27
    for i, x in enumerate(a):
        if x:
            for j, y in enumerate(b):
                if y:
                    c[i + j] += x * y
    for i in range(26, 13, -1):
        v = c[i] % 5
        if v:
            for j in range(14):
                c[i - 14 + j] -= v * MOD[j]
    return tuple(x % 5 for x in c[:14])

def power(a: Element, e: int) -> Element:
    if e < 0:
        return power(inv(a), -e)
    b = ONE
    while e:
        if e & 1:
            b = mul(b, a)
        e >>= 1
        if e:
            a = mul(a, a)
    return b

def inv(a: Element) -> Element:
    if a == ZERO:
        raise ZeroDivisionError('inverse of zero')
    return power(a, SIZE - 2)

def div(a: Element, b: Element) -> Element:
    return mul(a, inv(b))

def dot(a: list[Element] | tuple[Element, ...], b: list[Element] | tuple[Element, ...]) -> Element:
    z = ZERO
    for x, y in zip(a, b):
        z = add(z, mul(x, y))
    return z

def base(code: int) -> Element:
    if not 0 <= code < 25:
        raise ValueError('F_25 code out of range')
    return add(scalar(code % 5), scale(A, code // 5))

ROOTS = tuple(power(Q, i) for i in range(29))
MU = tuple(base(c) for c in MU_CODES)
BASIS_IMAGES = tuple(tuple(mul(base(c), ROOTS[j]) for c in range(25)) for j in range(7))

def from_code(code: int) -> Element:
    if not 0 <= code < SIZE:
        raise ValueError('extension-field code out of range')
    z = ZERO
    for j in range(7):
        code, digit = divmod(code, 25)
        z = add(z, BASIS_IMAGES[j][digit])
    return z

_inverse_change_basis: list[list[int]] | None = None

def to_code(a: Element) -> int:
    """Return the native seven-F_25-digit code via a checked change of basis."""
    global _inverse_change_basis
    if _inverse_change_basis is None:
        cols = []
        for j in range(7):
            cols.extend([ROOTS[j], mul(A, ROOTS[j])])
        M = [[cols[j][i] for j in range(14)] + [int(i == j) for j in range(14)] for i in range(14)]
        for j in range(14):
            p = next(i for i in range(j, 14) if M[i][j])
            M[j], M[p] = M[p], M[j]
            z = pow(M[j][j], -1, 5)
            M[j] = [(v * z) % 5 for v in M[j]]
            for i in range(14):
                if i != j:
                    z = M[i][j]
                    M[i] = [(v - z * w) % 5 for v, w in zip(M[i], M[j])]
        _inverse_change_basis = [row[14:] for row in M]
    digits = [sum(x * y for x, y in zip(row, a)) % 5 for row in _inverse_change_basis]
    out = sum((digits[2*j] + 5*digits[2*j+1]) * 25**j for j in range(7))
    if from_code(out) != a:
        raise ArithmeticError('change-of-basis round trip failed')
    return out

def nullspace(matrix: list[list[Element]]) -> list[list[Element]]:
    """Exact row reduction; chooses the last available pivot row, unlike C++."""
    if not matrix:
        raise ValueError('empty matrix')
    original = [row[:] for row in matrix]
    M = [row[:] for row in matrix]
    rows, cols = len(M), len(M[0])
    if any(len(row) != cols for row in M):
        raise ValueError('ragged matrix')
    r, pivots = 0, []
    for j in range(cols):
        candidates = [i for i in range(r, rows) if M[i][j] != ZERO]
        if not candidates:
            continue
        i = candidates[-1]
        M[r], M[i] = M[i], M[r]
        z = inv(M[r][j])
        M[r] = [mul(v, z) for v in M[r]]
        for i in range(rows):
            if i != r and M[i][j] != ZERO:
                z = M[i][j]
                M[i] = [sub(v, mul(z, w)) for v, w in zip(M[i], M[r])]
        pivots.append(j)
        r += 1
        if r == rows:
            break
    out = []
    for j in range(cols):
        if j not in pivots:
            v = [ZERO] * cols
            v[j] = ONE
            for i, p in enumerate(pivots):
                v[p] = neg(M[i][j])
            if any(dot(row, v) != ZERO for row in original):
                raise ArithmeticError('nullspace residual is nonzero')
            out.append(v)
    return out

def row_coefficients(rows: list[list[Element]], target: list[Element]) -> list[Element]:
    """Solve sum_i c_i rows[i] = target, requiring a unique solution."""
    m, n = len(rows), len(target)
    M = [[rows[i][j] for i in range(m)] + [target[j]] for j in range(n)]
    r, pivots = 0, []
    for j in range(m):
        p = next((i for i in range(r, n) if M[i][j] != ZERO), None)
        if p is None:
            continue
        M[r], M[p] = M[p], M[r]
        z = inv(M[r][j]); M[r] = [mul(z, v) for v in M[r]]
        for i in range(n):
            if i != r and M[i][j] != ZERO:
                z = M[i][j]; M[i] = [sub(v, mul(z, w)) for v, w in zip(M[i], M[r])]
        pivots.append(j); r += 1
    if r != m or any(all(x == ZERO for x in row[:m]) and row[m] != ZERO for row in M):
        raise ArithmeticError('row-span solve failed')
    out = [ZERO] * m
    for i, j in enumerate(pivots):
        out[j] = M[i][m]
    for j in range(n):
        if dot(out, [rows[i][j] for i in range(m)]) != target[j]:
            raise ArithmeticError('row-span residual')
    return out
