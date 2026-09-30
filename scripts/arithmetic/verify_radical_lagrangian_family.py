#!/usr/bin/env python3
"""Independent bounded check of the actual radical Lagrangian family.

Run with Sage's Python. Output is JSON on stdout; save generated receipts
outside the research repository. The geometric stability proof is separate.
"""
import json

from sage.all import GF, PolynomialRing, matrix


def main():
    F5 = GF(5)
    K = GF(25, "a", modulus=PolynomialRing(F5, "z")([2, 4, 1]))
    a = K.gen()
    code = lambda n: K(n % 5) + (n // 5) * a
    R = PolynomialRing(K, "c")
    c = R.gen()
    S = PolynomialRing(R, "x")
    x = S.gen()
    poly = lambda row: S([code(n) for n in row])
    r2 = [poly([19, 1]), -poly([16, 1]), poly([20, 14, 15])]
    r3 = [S(1), -poly([18, 24, 24, 18]), poly([3, 7, 23, 14])]
    v0 = [poly(row) for row in
          ([22, 16, 0, 4, 10], [7, 4, 0, 21], [8, 19, 1, 1])]
    v1 = [poly(row) for row in
          ([14, 5, 0, 12, 13], [10, 12, 0, 14], [3, 4, 18, 18])]
    dot = lambda u, v: sum(i*j for i, j in zip(u, v))
    assert (dot(r2, v0), dot(r3, v0)) == (x, S(1))
    assert (dot(r2, v1), dot(r3, v1)) == (S(1), S(0))
    kernel0 = r2[1]*r3[2] - r2[2]*r3[1]
    assert kernel0 == poly([3, 9, 9, 7, 7, 17])
    # Long division at infinity of (v0[0]-c*v1[0])/kernel0.
    numerator = v0[0] - c*v1[0]
    ext = []
    # The numerator has degree <=4 and kernel0 has degree5.
    for j in range(1, 6):
        previous = sum(ext[i-1]*kernel0[5-j+i] for i in range(1, j))
        coefficient = (numerator[5-j]-previous) / kernel0[5]
        ext.append(R(coefficient))
    # Compare this expansion with the independently supplied extension row.
    av = [code(n) for n in [19, 9, 15, 6, 16]]
    bv = [code(n) for n in [4, 16, 17, 22, 14]]
    expected = [av[j] - c*bv[j] for j in range(5)]
    assert ext == expected
    assert code(16)**2-code(4)*code(17) == code(15) != 0

    hankel = matrix(R, [[expected[i+j] for j in range(3)]
                        for i in range(3)])
    assert hankel.det() == (a+4)*(c+2*a+2)*(c+3*a+4)**2
    assert hankel.subs(c=code(11)).rank() == 1
    assert hankel.subs(c=code(18)).rank() == 2

    # Direct Cech calculation: H^1(O(kO)) has basis y^j x^-m,
    # 1 <= m <= -floor((k-10j)/3)-1. Multiplication reduces y^3=P.
    P = [code(n) for n in [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]]
    # Use c now for c_original^5, so all matrices are linear in c.
    full = {}
    for j in range(1, 6):
        for i, p in enumerate(P):
            exp = i-5*j
            full[exp] = full.get(exp, R(0)) + p*(av[j-1]**5-c*bv[j-1]**5)
    reduced = {exp: coeff for exp, coeff in full.items() if -16 <= exp <= -1}

    def coefficient(exp):
        return reduced.get(exp, R(0))

    block0 = matrix(R, [[coefficient(-k-j) for j in range(6)]
                        for k in range(11, 0, -1)])
    product = {}
    for exp, coefficient_value in reduced.items():
        for i, p in enumerate(P):
            product[exp+i] = product.get(exp+i, R(0)) + p*coefficient_value
    block1 = matrix(R, [[product.get(-k-j, R(0)) for j in range(2)]
                        for k in range(4, 0, -1)])
    tests = [
        (block0, [0, 1, 2, 3, 4, 5], [24, 5, 16, 9, 5, 13]),
        (block0, [0, 1, 2, 3, 4, 6], [14, 23, 22, 6, 2, 2, 16]),
        (block1, [0, 1], [6, 0, 8]),
        (block1, [0, 2], [10, 10, 10]),
    ]
    minors = []
    for block, rows, expected_codes in tests:
        minor = block.matrix_from_rows(rows).det()
        assert minor == R([code(n) for n in expected_codes])
        minors.append(minor)
    assert minors[0].gcd(minors[1]).monic() == (c-code(18))**4
    assert minors[2].gcd(minors[3]).monic() == c-code(18)
    assert code(11)**5 == code(18)
    print(json.dumps({
        "coefficient_field": "F25, a^2=a+3; absolute Frobenius",
        "local_lifts": "PASS", "extension_class": "PASS",
        "stability_exception_character_test": "PASS",
        "abstract_nonisomorphism_Hankel": "PASS",
        "first_Frobenius_Cech_blocks": "PASS",
        "minor_gcds": ["(c^5-[18])^4", "c^5-[18]"],
        "scope": "No geometry of a second endpoint is asserted."
    }, indent=2))


if __name__ == "__main__":
    main()
