#!/usr/bin/env python3
"""Reconstruct the degree160 geometric matrix using only standard Python.

This complements the sparse-polynomial identity checker: no Sage objects,
Groebner calculations, sampling, or serialized geometric matrix are used
to construct the inputs. Field and curve conventions match the fixed X.
"""
import argparse
from itertools import permutations
import json
from pathlib import Path
import time

from verify_degree160_normality_identity import (
    ADD, MUL, NEG, add, mul, readpoly, scale,
)


ONE = {(0, 0): 1}


def const(c):
    return {(0, 0): c} if c else {}


def neg(p):
    return scale(p, 4)


def trim(p):
    while p and not p[-1]:
        p.pop()
    return p


def padd(p, q):
    return trim([add(p[i] if i < len(p) else {},
                     q[i] if i < len(q) else {})
                 for i in range(max(len(p), len(q)))])


def pneg(p):
    return [neg(c) for c in p]


def pmul(p, q):
    if not p or not q:
        return []
    out = [{} for _ in range(len(p) + len(q) - 1)]
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i+j] = add(out[i+j], mul(a, b))
    return trim(out)


def pscale(p, a):
    return trim([mul(c, a) for c in p])


def prem(p, q):
    assert q and q[-1] == ONE
    out = list(p)
    while len(out) >= len(q):
        d = len(out) - len(q)
        c = out[-1]
        for j, b in enumerate(q):
            out[d+j] = add(out[d+j], neg(mul(c, b)))
        trim(out)
    return out


def pdiff(p):
    return trim([scale(p[i], i % 5) for i in range(1, len(p))])


def ppow(p, n):
    out = [ONE]
    while n:
        if n & 1:
            out = pmul(out, p)
        p = pmul(p, p)
        n >>= 1
    return out


def coeff(p, i):
    return p[i] if i < len(p) else {}


def determinant(matrix):
    n = len(matrix)
    out = {}
    for perm in permutations(range(n)):
        term = ONE
        for i, j in enumerate(perm):
            term = mul(term, matrix[i][j])
            if not term:
                break
        inversions = sum(perm[i] > perm[j]
                         for i in range(n) for j in range(i+1, n))
        out = add(out, neg(term) if inversions % 2 else term)
    return out


def adjugate(matrix):
    n = len(matrix)
    out = [[{} for _ in range(n)] for _ in range(n)]
    for i in range(n):
        for j in range(n):
            minor = [[matrix[r][c] for c in range(n) if c != i]
                     for r in range(n) if r != j]
            value = determinant(minor)
            out[i][j] = neg(value) if (i+j) % 2 else value
    return out


def multiplication_matrix(p, h):
    n = len(h)-1
    columns = [prem([{}]*j + p, h) for j in range(n)]
    return [[coeff(columns[j], i) for j in range(n)] for i in range(n)]


def matvec(matrix, vector):
    out = []
    for row in matrix:
        value = {}
        for a, b in zip(row, vector):
            value = add(value, mul(a, b))
        out.append(value)
    return out


def field_pow(a, n):
    out = 1
    for _ in range(n):
        out = MUL[out][a]
    return out


def field_inverse(a):
    assert a
    return next(b for b in range(1, 25) if MUL[a][b] == 1)


def field_solve(matrix, rhs):
    n = len(matrix)
    a = [row[:] + [b] for row, b in zip(matrix, rhs)]
    for col in range(n):
        pivot = next(r for r in range(col, n) if a[r][col])
        a[col], a[pivot] = a[pivot], a[col]
        inv = field_inverse(a[col][col])
        a[col] = [MUL[c][inv] for c in a[col]]
        for r in range(n):
            if r != col and a[r][col]:
                factor = NEG[a[r][col]]
                a[r] = [ADD[b][MUL[factor][c]]
                        for b, c in zip(a[r], a[col])]
    return [row[-1] for row in a]


def field_coefficient(p):
    assert not p or set(p) == {(0, 0)}
    return p.get((0, 0), 0)


def reconstruct(certificate):
    data = json.loads(certificate.read_text())
    assert data['field_modulus_ascending'] == [2, 4, 1]
    P = [const(c) for c in [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]]
    hs = [[const(c) for c in cs] for cs in
          [[24, 2, 1], [5, 16, 0, 1], [5, 20, 0, 0, 8, 1]]]
    js = []
    for hi in hs:
        product = pmul(hi, P)
        primitive = [{}]
        for i, c in enumerate(product, 1):
            if i % 5:
                primitive.append(scale(c, field_inverse(i % 5)))
            else:
                assert not c
                primitive.append({})
        assert pdiff(primitive) == product
        js.append(trim(primitive))

    frobenius_columns = [prem([{}]*(5*j) + [ONE], P) for j in range(10)]
    frobenius_matrix = [
        [field_coefficient(coeff(column, i)) for column in frobenius_columns]
        for i in range(10)]
    roots = []
    for j in js:
        remainder = prem(j, P)
        rhs = [field_coefficient(coeff(remainder, i)) for i in range(10)]
        fifth_coefficients = field_solve(frobenius_matrix, rhs)
        root = trim([const(field_pow(c, 5)) for c in fifth_coefficients])
        assert prem(ppow(root, 5), P) == remainder
        roots.append(root)

    u, v = {(1, 0): 1}, {(0, 1): 1}
    h = padd(padd(pscale(hs[0], u), pscale(hs[1], v)), hs[2])
    hp, hpp = pdiff(h), pdiff(pdiff(h))
    matrix = multiplication_matrix(P, h)
    denominator = determinant(matrix)
    assert denominator == readpoly(data['denominator'])
    # Monic degree five has discriminant (-1)^10 Norm(h') = Norm(h').
    discriminant = determinant(multiplication_matrix(hp, h))
    assert discriminant == readpoly(data['discriminant'])
    print('PASS: reconstructed J_i, R_i, D, and discriminant', flush=True)

    adj = adjugate(matrix)
    for i in range(5):
        column = [matrix[r][i] for r in range(5)]
        assert matvec(adj, column) == [denominator if j == i else {}
                                      for j in range(5)]
    correction = padd(pscale(pmul(pmul(P, hp), hpp), const(4)),
                      pscale(pmul(pdiff(P), pmul(hp, hp)), const(3)))
    columns = []
    for root in roots:
        r0 = prem(pneg(pmul(pmul(h, h), root)), P)
        remainder = prem(r0, h)
        t = trim(matvec(adj, [coeff(remainder, i) for i in range(5)]))
        c = scale(coeff(t, 4), 3)  # -2 in characteristic five.
        r = padd(pscale(r0, denominator), pmul(P, padd(pscale(hp, c), pneg(t))))
        assert not prem(padd(r, pneg(pscale(pmul(P, hp), c))), h)
        normality = prem(padd(pmul(hp, pdiff(r)), pneg(pscale(correction, c))), h)
        columns.append([coeff(normality, i) for i in range(5)])
    normality_matrix = [[columns[j][i] for j in range(3)] for i in range(5)]
    assert normality_matrix == [[readpoly(p) for p in row] for row in data['matrix']]
    return {
        'verified': 'PASS',
        'scope': 'Exact standard-library reconstruction of J_i, R_i, D, disc(h), and N.',
        'matrix_total_degree': max(i+j for row in normality_matrix for p in row for i, j in p),
        'denominator_total_degree': max(i+j for i, j in denominator),
        'discriminant_total_degree': max(i+j for i, j in discriminant),
        'Frobenius': 'R_i^5 = J_i mod P checked; U,V remain independent root coordinates.',
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificate', type=Path)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    start = time.monotonic()
    result = reconstruct(args.certificate)
    result['elapsed_seconds'] = round(time.monotonic()-start, 3)
    body = json.dumps(result, indent=2) + '\n'
    print(body)
    if args.output:
        args.output.write_text(body)
