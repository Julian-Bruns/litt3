# Exact certificate for the real trace field of the genus-nine curve in
# file 76. Run from the repository root:
# sage -c "load('routes/global/EXPLICIT_GENUS9_ENDOMORPHISM_FIELD_ABELIAN_PART_CERTIFICATE.sage')"
#
# Only three square-free modular factorizations are used. This script does
# not invoke a general number-field Galois-group computation.

Z.<U> = PolynomialRing(ZZ)
QX = (
    U^9 - 2*U^8 - 254*U^7 + 457*U^6 + 21826*U^5 - 29834*U^4
    - 703917*U^3 + 354810*U^2 + 6210225*U + 6613875
)

def factor_degrees(poly, prime):
    reduced = poly.change_ring(GF(prime))
    assert gcd(reduced, reduced.derivative()) == 1
    return sorted(
        [factor.degree() for factor, exponent in reduced.factor()
                         for unused in range(exponent)],
        reverse=True,
    )

assert factor_degrees(QX, 2) == [9]
assert factor_degrees(QX, 107) == [8, 1]
assert factor_degrees(QX, 11) == [7, 2]

# Optional consistency check against the Frobenius polynomial already
# certified in files 76 and 79.
R.<T> = LaurentPolynomialRing(ZZ)
PX = (
    T^18 - 2*T^17 - 29*T^16 + 57*T^15 - 124*T^14
    + 3716*T^13 + 3083*T^12 - 94215*T^11 + 141450*T^10
    + 601875*T^9 + 3536250*T^8 - 58884375*T^7
    + 48171875*T^6 + 1451562500*T^5 - 1210937500*T^4
    + 13916015625*T^3 - 177001953125*T^2
    - 305175781250*T + 3814697265625
)
assert T^9*R(QX)(T+25/T) == PX

print("PASS: Q_X has good-prime cycle types (9), (8,1), and (7,2)")
print("PASS: these force Gal(Q_X)=S_9 by transitivity, primitivity, and a transposition")
print("Together with the visible C3 action: K intersect Q^ab = Q(zeta_3), so a0=2")
