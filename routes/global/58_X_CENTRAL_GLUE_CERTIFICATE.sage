"""
Exact finite-field certificate for file 58.

Run with

    sage 58_X_CENTRAL_GLUE_CERTIFICATE.sage

The random seed only makes the search for generators reproducible.  Each
answer is certified after the search: the subgroup found has order equal to
the full l-primary part of the known Jacobian order.
"""

from sage.groups.additive_abelian.additive_abelian_wrapper import (
    AdditiveAbelianGroupWrapper,
)

set_random_seed(20260904)

ZZT.<T> = PolynomialRing(ZZ)
P = (T^2 - 3*T + 5) * (T^2 + T + 5) * (T^2 + 4*T + 5)


def sylow_invariants(n, ell, expected, max_trials=80):
    """Compute the ell-Sylow subgroup of J_X(F_(5^n))."""
    order = abs(P.resultant(T^n - 1))
    exponent = valuation(order, ell)
    cofactor = order // ell^exponent

    K.<a> = GF(5^n)
    Kx.<x> = PolynomialRing(K)
    curve = HyperellipticCurve(x^7 - x + 1)
    jacobian_points = curve.jacobian()(K)

    def random_curve_point():
        while True:
            x0 = K.random_element()
            rhs = x0^7 - x0 + 1
            if rhs == 0:
                return curve([x0, K(0), K(1)])
            if rhs.is_square():
                return curve([x0, rhs.sqrt(), K(1)])

    def random_jacobian_point():
        ans = jacobian_points(0)
        for _ in range(3):
            ans += jacobian_points(random_curve_point())
        return ans

    subgroup = AdditiveAbelianGroupWrapper(jacobian_points, [], [])
    for _ in range(max_trials):
        point = cofactor * random_jacobian_point()
        if point in subgroup:
            continue
        subgroup = AdditiveAbelianGroupWrapper.from_generators(
            subgroup._gen_elements + (point,)
        )
        if subgroup.order() == ell^exponent:
            break

    # This equality, rather than the random search, is the certificate that
    # the whole Sylow subgroup has been found.
    assert subgroup.order() == ell^exponent
    assert tuple(subgroup.invariants()) == expected
    print("n =", n, "ell =", ell, "Sylow invariants =", expected)


sylow_invariants(3, 2, (2, 16, 16))
sylow_invariants(8, 3, (3, 9, 9, 9))
sylow_invariants(48, 7, (7, 7, 49, 49))


# The original audited genus-two check: generate its full finite spectrum,
# impose first the mod-4 and mod-7 congruences, and then mod 3.
spectra_e1 = set()
spectra_e3 = set()
for killed in range(3):
    live = [i for i in range(3) if i != killed]
    for total in (-9, -8, -7):
        for a0 in range(-9, 10):
            b0 = total + 9 - a0
            lam = [0, 0, 0]
            lam[killed] = -9
            lam[live[0]] = a0
            lam[live[1]] = b0
            if a0^2 + b0^2 <= 18:
                spectra_e1.add(tuple(lam))
    for a0 in (-3, 0, 3):
        lam = [0, 0, 0]
        lam[killed] = -9
        lam[live[0]] = a0
        lam[live[1]] = -a0
        spectra_e3.add(tuple(lam))


def first_two_congruences(lam):
    return (lam[0] - lam[1]) % 4 == 0 and (lam[0] - lam[2]) % 7 == 0


remaining_e1 = sorted(filter(first_two_congruences, spectra_e1))
remaining_e3 = sorted(filter(first_two_congruences, spectra_e3))
assert remaining_e1 == [(-9, 3, -2), (-2, 2, -9)]
assert remaining_e3 == []
assert all((lam[1] - lam[2]) % 3 != 0 for lam in remaining_e1)
print("remaining spectra after all congruences: none")

# Author v2 proof: the congruences alone leave one triple, then adjunction
# rules it out. This does not change the audited subgroup calculations.
from itertools import product

short_survivors = [
    lam for lam in product(range(-9, 10), repeat=3)
    if -9 in lam and -9 <= sum(lam) <= -7
    and first_two_congruences(lam)
    and (lam[1] - lam[2]) % 3 == 0
]
assert short_survivors == [(5, -3, -9)]
assert gcd([9] + list(short_survivors[0])) == 1
assert sum(x^2 for x in short_survivors[0]) == 115 > 81 + 18
print("short genus-two proof: sole congruence survivor violates adjunction")
