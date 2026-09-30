"""Linear algebra over F25[z]/(f), with ascending coefficient lists.

The verifier separately checks irreducibility of f. All operations are exact;
there is no integer-mod-25 arithmetic and no floating-point arithmetic.
"""
from ff25poly import add, sub, scale, mul, mod, invmod

def transpose(A):
    return [list(row) for row in zip(*A)]

def rref(A, f):
    A = [[list(a) for a in row] for row in A]
    n, m = len(A), len(A[0])
    labels, pivots, rows, r = list(range(n)), [], [], 0
    for j in range(m):
        i = next((i for i in range(r, n) if A[i][j]), None)
        if i is None:
            continue
        A[r], A[i] = A[i], A[r]
        labels[r], labels[i] = labels[i], labels[r]
        c = invmod(A[r][j], f)
        A[r] = [mod(mul(a, c), f) for a in A[r]]
        for i in range(n):
            if i != r and A[i][j]:
                c = A[i][j]
                A[i] = [sub(a, mod(mul(c, b), f)) for a, b in zip(A[i], A[r])]
        pivots.append(j)
        rows.append(labels[r])
        r += 1
        if r == n:
            break
    return A, pivots, rows

def kernel(A, f):
    R, pivots, _ = rref(A, f)
    n = len(A[0])
    vectors = []
    for j in range(n):
        if j in pivots:
            continue
        v = [[] for _ in range(n)]
        v[j] = [1]
        for i, c in enumerate(pivots):
            v[c] = scale(R[i][j], 4)
        vectors.append(v)
    return vectors

def matmul(A, B, f):
    C = [[[] for _ in B[0]] for _ in A]
    for i, row in enumerate(A):
        for k, a in enumerate(row):
            if a:
                for j, b in enumerate(B[k]):
                    if b:
                        C[i][j] = add(C[i][j], mod(mul(a, b), f))
    return C

def determinant(A, f):
    A = [[list(a) for a in row] for row in A]
    n = len(A)
    assert all(len(row) == n for row in A)
    d = [1]
    for j in range(n):
        i = next((i for i in range(j, n) if A[i][j]), None)
        if i is None:
            return []
        if i != j:
            A[j], A[i] = A[i], A[j]
            d = scale(d, 4)
        pivot = A[j][j]
        d = mod(mul(d, pivot), f)
        inv = invmod(pivot, f)
        for i in range(j + 1, n):
            c = mod(mul(A[i][j], inv), f)
            if c:
                for k in range(j + 1, n):
                    A[i][k] = sub(A[i][k], mod(mul(c, A[j][k]), f))
                A[i][j] = []
    return d

def eval_linear(blocks, v):
    A = [[[] for _ in row] for row in blocks[0]]
    for i, c in enumerate(v):
        for r, row in enumerate(A):
            for j in range(len(row)):
                A[r][j] = add(A[r][j], scale(c, blocks[i][r][j]))
    return A

def normalize(v, f):
    first = next(x for x in v if x)
    c = invmod(first, f)
    return [mod(mul(x, c), f) for x in v]

def rank_certificate(A, f):
    R, cols, rows = rref(A, f)
    minor = [[A[i][j] for j in cols] for i in rows]
    det = determinant(minor, f)
    assert det
    K = kernel(A, f)
    assert len(K) == len(A[0]) - len(cols)
    if K:
        assert not any(x for row in matmul(A, transpose(K), f) for x in row)
    return {"rank": len(cols), "minor_rows": rows, "minor_columns": cols,
            "minor_determinant": det, "kernel_basis": K}

def tangent_matrix(blocks, v, f):
    assert v[0] == [1]
    A = eval_linear(blocks, v)
    K = kernel(A, f)
    L = kernel(transpose(A), f)
    assert len(K) == 1 and len(L) == 9
    C = [[[] for _ in range(5)] for _ in range(23)]
    for i in range(5):
        for r in range(23):
            for j in range(15):
                C[r][i] = add(C[r][i], scale(K[0][j], blocks[i + 1][r][j]))
    return matmul(L, C, f)
