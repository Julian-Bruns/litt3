#!/usr/bin/env python3
"""Small exact certificate for U/U-perp on the fixed genus-nine curve.

Uses the finite-field conventions of cartier_two_form_certificate.py.
All output belongs in ../litt3-computation-data/, not this repository.
The bundle and local-lattice implications are proved in the linked proof.
"""
from cartier_two_form_certificate import (
    determinant, mul, p_add, p_gcd, p_mul, p_scale, p_sub, rref,
)


def main():
    beta = [
        [4, 16, 3, 18, 21],
        [10, 13, 0, 10, 6],
        [15, 3, 3, 18, 18, 4],
    ]
    low = [[20, 14, 15], [16, 1], [19, 1]]
    high = [[3, 7, 23, 14], [18, 24, 24, 18], [1]]
    sylvester = []
    for polynomial in beta[:2]:
        for shift in range(4):
            sylvester.append([0] * shift + polynomial + [0] * (3-shift))
    assert determinant(sylvester) == 12
    assert p_gcd(beta[0], beta[1]) == [1]
    for syzygy in (low, high):
        total = []
        for a, b in zip(syzygy, beta):
            total = p_add(total, p_mul(a, b))
        assert total == []
    cross = [
        p_sub(p_mul(low[(i+1) % 3], high[(i+2) % 3]),
              p_mul(low[(i+2) % 3], high[(i+1) % 3]))
        for i in range(3)
    ]
    assert cross == [p_scale(b, 13) for b in beta]
    dimensions = []
    for degree in range(4):
        matrix = [
            [b[row-shift] if 0 <= row-shift < len(b) else 0
             for b in beta for shift in range(degree+1)]
            for row in range(6+degree)
        ]
        dimensions.append(3*(degree+1)-len(rref(matrix)[1]))
    assert dimensions == [0, 0, 1, 3]
    # Homogeneous values at infinity: the cross product has nonzero
    # third coordinate. The relation for the original ordered sections
    # is (beta_12,-beta_02,beta_01), and the low covector is
    # (low_2,-low_1,low_0); at infinity it is (0,0,[15]).
    assert mul(low[0][2], high[1][3]) == mul(13, beta[2][5]) != 0
    assert low[2][-1] == low[1][-1] == 1
    assert low[0][2] == 15
    print("Coefficient field: F25, a^2=a+3; ascending code convention")
    print("Resultant(beta01,beta02) = [12]: PASS")
    print("Syzygy dimensions in degrees 0,1,2,3:", dimensions)
    print("Degree-two syzygy:", low)
    print("Degree-three syzygy:", high)
    print("Homogeneous cross product = [13] * beta: PASS")
    print("Q = O_P1(2) + O_P1(3): certified polynomial input")
    print("High-line quotient at infinity = (0,0,[15]): PASS")


if __name__ == "__main__":
    main()
