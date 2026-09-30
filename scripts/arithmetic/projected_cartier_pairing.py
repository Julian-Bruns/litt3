#!/usr/bin/env python3
"""Exact projected pairing of the fixed X; no two-leg closure claim.

Standard-library calculation. Coefficients use n0+5*n1 for n0+n1*a,
a^2=a+3. The Cartier-bijective summand is im(C), since a_infinity=a=3.
Write generated output outside the research repository.
"""
import json
import cartier_two_form_certificate as f


def dot(a, b):
    z = 0
    for x, y in zip(a, b):
        z = f.add(z, f.mul(x, y))
    return z


def transpose(a):
    return [list(row) for row in zip(*a)]


def mm(a, b):
    return [[dot(row, col) for col in zip(*b)] for row in a]


def identity(n):
    return [[int(i == j) for j in range(n)] for i in range(n)]


def inverse(a):
    n = len(a)
    rr, piv = f.rref([a[i] + identity(n)[i] for i in range(n)])
    assert piv == list(range(n))
    assert [row[:n] for row in rr] == identity(n)
    out = [row[n:] for row in rr]
    assert mm(a, out) == mm(out, a) == identity(n)
    return out


def mp(a, n):
    z = identity(len(a))
    while n:
        if n & 1:
            z = mm(z, a)
        a = mm(a, a)
        n //= 2
    return z


def main():
    p = [11,22,18,5,19,20,15,16,9,22,1]
    h = [[24,2,1,0,0,0], [5,16,0,1,0,0], [5,20,0,0,8,1]]
    raw = [[4,16,3,18,21,0], [10,13,0,10,6,0], [15,3,3,18,18,4]]
    p3 = f.p_mul(f.p_mul(p, p), p)
    stable = []
    for j in range(3):
        row = f.cartier_polynomial([0]*j + p3)
        stable.append(row + [0]*(6-len(row)))
    coordinates = mm(raw, inverse(h + stable))
    projected = [row[:3] for row in coordinates]
    assert projected == [[9,11,3], [3,18,18], [18,20,2]]
    assert f.determinant(projected) == 5
    assert mm(coordinates, h + stable) == raw
    # Columns correspond to the standard cross product (12,20,01).
    b = transpose([projected[2], [f.neg(x) for x in projected[1]], projected[0]])
    q = [[f.power(x, 5) for x in row] for row in b]
    d = mm([[f.power(x, 5) for x in row] for row in q], inverse(transpose(q)))
    assert mp(d, 24) == identity(3)
    assert mp(d, 12) != identity(3) and mp(d, 8) != identity(3)
    print(json.dumps({
        'field': 'F25, a^2=a+3; code n0+5*n1',
        'stable_sector_rows': stable,
        'projected_beta_rows_01_02_12': projected,
        'projected_determinant_code': 5,
        'cross_product_B': b, 'fifth_power_Q': q,
        'D_Q5_Q_inverse_transpose': d, 'D_exact_order': 24,
        'checks': 'projection, invertibility, and exact order PASS',
        'scope': 'intrinsic global tensor on X; no finite two-leg transport follows'
    }, indent=2))


if __name__ == '__main__':
    main()
