"""Exact complete geometric square test in characteristic five.

For deg R=2n, at most the least e with 5**e>2*n steps are required.
All finite-field arithmetic uses the original archive's exact K codes.
This is an evaluator and a universal matrix circuit, NOT a global solver.
"""
from __future__ import annotations
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'src'))
import field as F
import poly as U


def ident(n):
    return [[int(i == j) for j in range(n)] for i in range(n)]


def shape(a):
    return (len(a), len(a[0]) if a else 0)


def matmul(a, b):
    """Small exact matrices; b may have zero columns."""
    if not a:
        return []
    if len(a[0]) != len(b):
        raise ValueError('Matrix shape mismatch')
    n = len(b[0]) if b else 0
    out = [[0] * n for _ in a]
    bs = [[(j, v) for j, v in enumerate(row) if v] for row in b]
    for i, row in enumerate(a):
        for k, u in enumerate(row):
            if u:
                for j, v in bs[k]:
                    out[i][j] = F.add(out[i][j], F.mul(u, v))
    return out


def twist(a, p):
    return [[F.powk(v, p) for v in row] for row in a]


def kernel(a):
    """Return a matrix whose columns form the right kernel, and pivot rows.

    Pivot row indices refer to the ORIGINAL matrix. For full column rank
    their selected square minor is invertible. No parameter localization
    is inferred from any particular evaluation or pivot selection.
    """
    m, n = shape(a)
    r = [row[:] for row in a]
    labels = list(range(m))
    pivots, pivot_rows = [], []
    k = 0
    for j in range(n):
        p = next((i for i in range(k, m) if r[i][j]), None)
        if p is None:
            continue
        r[k], r[p] = r[p], r[k]
        labels[k], labels[p] = labels[p], labels[k]
        inv = F.inv(r[k][j])
        for t in range(j, n):
            r[k][t] = F.mul(r[k][t], inv)
        for i in range(k + 1, m):
            v = r[i][j]
            if v:
                r[i][j] = 0
                for t in range(j + 1, n):
                    r[i][t] = F.sub(r[i][t], F.mul(v, r[k][t]))
        pivots.append(j)
        pivot_rows.append(labels[k])
        k += 1
        if k == m:
            break
    free = [j for j in range(n) if j not in pivots]
    ans = [[0] * len(free) for _ in range(n)]
    for c, j in enumerate(free):
        ans[j][c] = 1
        for i in range(len(pivots) - 1, -1, -1):
            p = pivots[i]
            val = 0
            for t in range(p + 1, n):
                val = F.add(val, F.mul(r[i][t], ans[t][c]))
            ans[p][c] = F.neg(val)
    assert all(not v for row in matmul(a, ans) for v in row)
    return ans, pivot_rows


def determinant(a):
    n, m = shape(a)
    if n != m:
        raise ValueError('Determinant requires a square matrix')
    b = [row[:] for row in a]
    out = 1
    for j in range(n):
        p = next((i for i in range(j, n) if b[i][j]), None)
        if p is None:
            return 0
        if p != j:
            b[j], b[p] = b[p], b[j]
            out = F.neg(out)
        pivot = b[j][j]
        out = F.mul(out, pivot)
        inv = F.inv(pivot)
        for i in range(j + 1, n):
            v = F.mul(b[i][j], inv)
            if v:
                for k in range(j + 1, n):
                    b[i][k] = F.sub(b[i][k], F.mul(v, b[j][k]))
                b[i][j] = 0
    return out


def matrices(R, half_degree=None):
    """Coefficient matrices, with an optional FIXED degree bound.

    The fixed-bound form retains specialized degree drops, e.g. after
    reversing a residual with zero constant coefficient.
    """
    R = U.trim(R[:])
    if half_degree is None:
        if not R or (len(R) - 1) % 2:
            raise ValueError('A nonzero polynomial of even degree is required')
        n = (len(R) - 1) // 2
    else:
        n=int(half_degree)
        if n<0 or n!=half_degree or len(R)-1>2*n:
            raise ValueError('Invalid fixed half-degree bound')
    r2 = U.mul(R, R)
    nonfive = [i for i in range(5 * n + 1) if i % 5]
    N = [[U.coeff(r2, i - j) for j in range(n + 1)] for i in nonfive]
    M = [[U.coeff(r2, 5 * i - j) for j in range(n + 1)] for i in range(n + 1)]
    return N, M, nonfive


def differential_matrix(R, half_degree=None):
    """Matrix for R*J' + 2*R'*J with deg J<=deg(R)/2.

    Equivalent to N after localizing only the already nonzero leading
    coefficient. Its entries have degree ONE in residual coefficients.
    """
    R=U.trim(R[:])
    if half_degree is None:
        if not R or (len(R)-1)%2:
            raise ValueError('A nonzero polynomial of even degree is required')
        n=(len(R)-1)//2
    else:
        n=int(half_degree)
        if n<0 or n!=half_degree or len(R)-1>2*n:
            raise ValueError('Invalid fixed half-degree bound')
    return [[F.scale(U.coeff(R,i+1-j),2*(i+1)-j)
             for j in range(n+1)] for i in range(3*n)]


def frobenius_image(R, J):
    """Return (R**2*J)**(1/5) when this is polynomial, otherwise raise."""
    p = U.mul(U.mul(R, R), J)
    if any(c for i, c in enumerate(p) if i % 5):
        raise ValueError('Polynomial is not a fifth power')
    # K has cardinality 5**8, so a^(5**7) is its unique fifth root.
    return U.trim([F.powk(U.coeff(p, 5 * i), 5**7) for i in range((len(p)+4)//5)])


def solve(R, verify_images=True, keep_bases=False, constraint="coefficient"):
    R = U.trim(R[:])
    if not R:
        raise ValueError('The requested degree is positive and exact')
    deg = len(R) - 1
    if deg % 2:
        return {'degree': deg, 'geometric_square': False, 'stages': []}
    n = deg // 2
    emax, Q = 0, 1
    while Q <= deg:
        emax += 1
        Q *= 5
    N, M, nonfive = matrices(R)
    if constraint == 'differential':
        N=differential_matrix(R)
    elif constraint != 'coefficient':
        raise ValueError("constraint must be 'coefficient' or 'differential'")
    V = ident(n + 1)
    W = ident(n + 1)  # W=P_e*V, P_e=M^[5^(e-1)] ... M
    stages = []
    for e in range(1, emax + 1):
        power = 5**(e - 1)
        test = matmul(twist(N, power), W)
        T, pivots = kernel(test)
        V = matmul(V, T)
        W = matmul(W, T)
        dim = len(V[0])
        assert dim <= n // (5**e) + 1
        stage = {'stage': e, 'Q': 5**e, 'kernel_dimension': dim,
                 'tested_matrix_rows': len(test),
                 'tested_matrix_columns': len(test[0]),
                 'selected_pivot_rows': pivots}
        if verify_images:
            for col in range(dim):
                J = U.trim([V[i][col] for i in range(n+1)])
                for j in range(e):
                    J = frobenius_image(R, J)
                    assert len(J) - 1 <= n
            stage['all_basis_columns_checked_by_iterated_fifth_roots'] = True
        if keep_bases:
            stage['kernel_basis_columns'] = [[V[i][j] for i in range(n+1)] for j in range(dim)]
        stages.append(stage)
        if not dim:
            break
        W = matmul(twist(M, power), W)
    square = bool(len(V[0]))
    out = {'degree': deg, 'maximum_stages': emax, 'geometric_square': square,
           'stages': stages}
    if square:
        assert len(V[0]) == 1
        J = U.trim([row[0] for row in V])
        assert len(J) == n + 1 and J[-1]
        J = U.scale(J, F.inv(J[-1]))
        assert R == U.scale(U.mul(J, J), R[-1])
        out['monic_normalized_root'] = J
        out['scalar'] = R[-1]
        out['verified_identity'] = 'R = scalar * monic_normalized_root^2'
    return out
