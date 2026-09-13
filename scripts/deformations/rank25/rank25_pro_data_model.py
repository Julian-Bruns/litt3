"""Load the finite family data; standard library only. No higher-Witt engine."""
import json
from math import prod
from pathlib import Path

ZERO = (0, 0, 0, 0)
ONE = (1, 0, 0, 0)


def digits(code):
    return tuple((code // 5**i) % 5 for i in range(4))


def unpack(value):
    if isinstance(value, dict) and set(value) == {'shape', 'nonzero'}:
        flat = [ZERO] * prod(value['shape'])
        for i, code in value['nonzero']:
            flat[i] = digits(code)
        iterator = iter(flat)
        def nest(shape):
            return [nest(shape[1:]) for _ in range(shape[0])] if shape else next(iterator)
        return nest(value['shape'])
    if isinstance(value, dict):
        return {k: unpack(v) for k, v in value.items()}
    if isinstance(value, list):
        return [unpack(v) for v in value]
    return value


def load(directory=None):
    root = Path(directory) if directory else Path(__file__).resolve().parent
    data, fourth = [unpack(json.loads((root/name).read_text()))
                    for name in ['data.json', 'fourth.json']]
    records = json.loads((root/'first_repairs.json').read_text())
    repairs = [[(*r[:4], digits(r[4])) for r in row] for row in records]
    return data, fourth, repairs


def add(x, y):
    return tuple((a+b) % 5 for a, b in zip(x, y))


def neg(x):
    return tuple(-a % 5 for a in x)


def mul(x, y):
    if x == ZERO or y == ZERO:
        return ZERO
    z = [0]*7
    for i, a in enumerate(x):
        for j, b in enumerate(y):
            z[i+j] += a*b
    for i in range(6, 3, -1):
        for j, a in enumerate((3, 4, 1, 4)):
            z[i-4+j] -= a*z[i]
    return tuple(a % 5 for a in z[:4])


def power(x, n):
    out = ONE
    while n:
        if n & 1:
            out = mul(out, x)
        x = mul(x, x)
        n //= 2
    return out


def total(values):
    out = ZERO
    for v in values:
        out = add(out, v)
    return out


def mv(matrix, vector):
    assert all(len(row) == len(vector) for row in matrix)
    return [total(mul(a, b) for a, b in zip(row, vector)) for row in matrix]


def rank(matrix):
    a = [list(row) for row in matrix]
    r = 0
    for c in range(len(a[0])):
        pivot = next((j for j in range(r, len(a)) if a[j][c] != ZERO), None)
        if pivot is None:
            continue
        a[r], a[pivot] = a[pivot], a[r]
        inverse = power(a[r][c], 623)
        a[r] = [mul(inverse, x) for x in a[r]]
        for j in range(r+1, len(a)):
            if a[j][c] != ZERO:
                factor = a[j][c]
                a[j] = [add(x, neg(mul(factor, y))) for x, y in zip(a[j], a[r])]
        r += 1
        if r == len(a):
            break
    return r


def evaluate_fourth(x, fourth, normal=False):
    assert len(x) == 9
    if normal:
        assert x[7:] == [ZERO, ZERO], 'normal representative is restricted to candidates'
    block = fourth['normal_on_candidates' if normal else 'obstruction']
    y = [power(v, 5) for v in x]
    result = list(block['constant'])
    def include(vector, factor):
        result[:] = [add(v, mul(factor, c)) for v, c in zip(result, vector)]
    for i, row in enumerate(block['ordinary']):
        include(row, x[i])
    for i, row in enumerate(block['frobenius']):
        include(row, y[i])
    for i, j, row in block['quadratic']:
        include(row, mul(y[i], y[j]))
    return result


def jacobian_fourth(y, fourth):
    """Differential in the independent y=x^[5] variables, not in x."""
    block = fourth['obstruction']
    assert all(c == ZERO for row in block['ordinary'] for c in row)
    result = [list(row) for row in zip(*block['frobenius'])]
    for i, j, row in block['quadratic']:
        for k, coefficient in enumerate(row):
            result[k][i] = add(result[k][i], mul(coefficient, y[j]))
            result[k][j] = add(result[k][j], mul(coefficient, y[i]))
    return result


def check():
    d, fourth, repairs = load()
    M, N, dual = d['hodge_matrix'], d['kernel_basis'], d['obstruction_dual_rows']
    assert rank(M) == 66 and rank(N) == rank(dual) == 9
    for vector in N:
        assert mv(M, [power(c, 5) for c in vector]) == [ZERO]*75
        assert mv(dual, vector) == [ZERO]*9
    for column in zip(*M):
        assert mv(dual, column) == [ZERO]*9
    full, normal = fourth['obstruction'], fourth['normal_on_candidates']
    assert mv(dual, normal['constant']) == full['constant']
    for name in ['ordinary', 'frobenius']:
        for i, row in enumerate(normal[name]):
            assert mv(dual, row) == full[name][i]
    coefficients = {(i, j): row for i, j, row in full['quadratic']}
    normal_coefficients = {(i, j): row for i, j, row in normal['quadratic']}
    for i in range(7):
        for j in range(i, 7):
            assert mv(dual, normal_coefficients.get((i, j), [ZERO]*75)) == coefficients.get((i, j), [ZERO]*9)
    x = [ZERO]*9
    x[3], x[4] = (3, 0, 0, 3), (0, 3, 1, 4)
    assert evaluate_fourth(x, fourth) == [ZERO]*9
    assert mv(dual, evaluate_fourth(x, fourth, normal=True)) == [ZERO]*9
    assert rank(jacobian_fourth([power(v, 5) for v in x], fourth)) == 5
    assert len(repairs) == 8 and all(i+j <= 3 for row in repairs for i, j, _, _, _ in row)
    print('PASS: ranks, all kernel/dual identities, all retained normal projections, known W4 point, repair degrees.')
    print('These are finite input checks, not a new fifth-obstruction computation.')


if __name__ == '__main__':
    check()
