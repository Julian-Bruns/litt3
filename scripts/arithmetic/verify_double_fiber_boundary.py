"""Small endpoint certificates replacing large collision matrices at n=10,11."""
import json
import math
import sys
from pathlib import Path
import verify_pole_ten_norm_support as f

P, A = f.P, f.A
Q = [0, 11, 6, 21, 22, 0, 15, 21, 9, 4, 0, 1, 1, 24, 14, 0, 3, 9, 8, 24]
L = [18, 20, 20, 15]
B0 = [8, 14, 19, 2, 10, 19, 3, 24, 18, 16]


def scale(a, c):
    return [f.mul(x, c) for x in a]


def remainder(a, b):
    a = f.trim(a)
    while len(a) >= len(b):
        c = f.mul(a[-1], f.inv(b[-1]))
        a = f.psub(a, [0] * (len(a) - len(b)) + scale(b, c))
    return a


def fifth(a):
    out = [0] * (5 * (len(a) - 1) + 1)
    for i, c in enumerate(a):
        out[5 * i] = f.power(c, 5)
    return out


def derivative(a):
    return [f.mul(i % 5, c) for i, c in enumerate(a)][1:]


def hasse(a, r, j):
    value = 0
    for i in range(j, len(a)):
        term = f.mul(math.comb(i, j) % 5, f.mul(a[i], f.power(r, i - j)))
        value = f.add(value, term)
    return value


def determinant(matrix):
    a = [row[:] for row in matrix]
    value = 1
    for i in range(len(a)):
        k = next((j for j in range(i, len(a)) if a[j][i]), None)
        if k is None:
            return 0
        if k != i:
            a[k], a[i] = a[i], a[k]
            value = f.neg(value)
        pivot = a[i][i]
        value = f.mul(value, pivot)
        for j in range(i + 1, len(a)):
            c = f.mul(a[j][i], f.inv(pivot))
            a[j] = [f.sub(x, f.mul(c, y)) for x, y in zip(a[j], a[i])]
    return value


assert not remainder(f.psub(Q, fifth(L)), f.pmul(f.pmul(A, A), A))
assert not remainder(f.psub(Q, fifth(B0)), f.pmul(P, P))
alpha = f.roots[0]
p = f.mul(f.peval(derivative(P), alpha), f.inv(f.peval(P, alpha)))
a = f.mul(f.peval(derivative(derivative(A)), alpha),
          f.inv(f.peval(derivative(A), alpha)))
d3 = hasse(Q, alpha, 3)
d4 = hasse(Q, alpha, 4)
assert d3 and f.mul(d4, f.inv(d3)) == f.mul(2, f.add(p, a))
log_derivatives = []
for root in f.roots[1:]:
    value = f.add(f.mul(3, f.inv(f.sub(alpha, root))), f.add(f.mul(4, p), a))
    assert value
    log_derivatives.append(f.digits(value))

residues = [remainder([0] * i + B0, P) for i in range(4)]
matrix = [[row[j] if j < len(row) else 0 for row in residues] for j in (8, 9)]
matrix.append([f.power(alpha, i) for i in range(4)])
matrix.append([f.peval(row, alpha) for row in residues])
det = determinant(matrix)
assert f.digits(det) == [11, 8, 17, 2]
data = {
    "scope": "repeated complete-fiber support at actual degrees ten and eleven",
    "n10_nonzero_log_derivatives": log_derivatives,
    "n11_trace_matrix_base25": [[f.digits(c) for c in row] for row in matrix],
    "n11_trace_determinant_base25": f.digits(det),
    "root_modulus_codes": list(f.MOD),
}
if len(sys.argv) > 1:
    Path(sys.argv[1]).write_text(json.dumps(data, indent=2) + "\n")
print("PASS: primitive corrections and local cubic/quartic ratio.")
print("PASS: n=10, three nonzero local derivatives; n=11, invertible 4x4 trace matrix.")
