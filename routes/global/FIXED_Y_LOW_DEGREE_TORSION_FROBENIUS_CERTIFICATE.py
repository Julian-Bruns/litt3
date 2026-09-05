"""Exact integer checks for the fixed-Y Frobenius applicability boundary.

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

# Newton sums, computed over Z before reduction modulo 64.
traces = [50]
for degree in range(1, 97):
    total = sum(
        p_desc[i] * traces[degree-i]
        for i in range(1, min(degree, 51))
    )
    if degree <= 50:
        total += degree * p_desc[degree]
    traces.append(-total)
assert traces[6] == 282

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

expected_exponents = {3: [6, 54], 5: [18, 66], 7: [36, 84]}
expected_traces = {3: [26, 26], 5: [42, 42], 7: [34, 34]}
survivors = []
for scalar in (3, 5, 7):
    exponents = [
        exponent for exponent in range(96)
        if exponent % 3 == 0
        and pow(5, exponent, 64) == scalar*scalar % 64
    ]
    assert exponents == expected_exponents[scalar]
    residues = [traces[exponent] % 64 for exponent in exponents]
    assert residues == expected_traces[scalar]
    for sign in (1, -1):
        for exponent, residue in zip(exponents, residues):
            if residue == 50 * sign * scalar % 64:
                survivors.append((sign * scalar, exponent))
assert survivors == [(-7, 36), (-7, 84)]

# The note excludes these last two by the integral T_2 argument:
# F^3=I+2A, det(A) even, and F^36,F^84=I+8(A+A^2) (mod 16).
for exponent in (12, 28):
    assert 2*exponent % 16 == 8
    assert 4*comb(exponent, 2) % 16 == 8
    assert 8*comb(exponent, 3) % 16 == 0

print("PASS: v2 #J(F125)=56; all scalar +/-3,+/-5,+/-7 candidates excluded")
print("Last two trace survivors are excluded by the proved singular-A lemma.")
