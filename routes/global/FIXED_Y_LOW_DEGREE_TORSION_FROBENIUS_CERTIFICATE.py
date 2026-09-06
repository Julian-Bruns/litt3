"""Exact fixed-Y Weil data used by the small doubled-group certificate.

Input: the trace polynomial Q_Y in file 76, with P_Y(T)=T^25 Q_Y(T+5/T).
No torsion-point enumeration or companion-matrix model is assumed.
"""

from math import comb

Q_DESC = [
    1, -2, -120, 236, 6300, -12172, -190024, 360412, 3635782,
    -6767504, -45967432, 84017092, 387818812, -697588276,
    -2152004856, 3830395252, 7526742721, -13422653422,
    -15169333376, 27936617472, 14306622112, -29892350656,
    -2589320704, 11661025280, -962499328, -933754368,
]

# Descending coefficients of the degree-50 Weil polynomial.
p_desc = [0] * 51
for i, coefficient in enumerate(Q_DESC):
    for j in range(26 - i):
        p_desc[i + 2*j] += coefficient * comb(25-i, j) * 5**j
assert p_desc[:7] == [1, -2, 5, -4, 0, -12, -24]

def valuation_two(number):
    assert number != 0
    result = 0
    while number % 2 == 0:
        number //= 2
        result += 1
    return result

# Resultant(P_Y,T^3-1), using T^3=1 and the quadratic factor T^2+T+1.
remainder = [0, 0, 0]
for i, coefficient in enumerate(p_desc):
    remainder[(50-i) % 3] += coefficient
a, b, c = remainder
u, v = a-c, b-c
j_125 = (a+b+c) * (u*u-u*v+v*v)
assert j_125 == 28401356582148358632129391900914590018369492518699008
assert valuation_two(j_125) == 56
assert valuation_two(sum(p_desc)) == 20

print("PASS: exact fixed-Y Weil data and v2 #J(F125)=56")
