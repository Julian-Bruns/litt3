"""
Exact scalar-window certificate for file 79.

Run with

    sage 79_M7_CROSS_IMAGE_AND_SCALAR_WINDOW_CERTIFICATE.sage

For the explicit genus-nine curve X of file 76, the Rosati-fixed
endomorphisms embed in the full ring of integers of the real trace field
K^+.  This script enumerates the larger lattice O_{K^+} through trace
square norm 441.  It verifies that every algebraic integer whose nine real
conjugates lie in [-7,7] is a rational integer.
"""

ZZx.<x> = PolynomialRing(ZZ)
QX = (
    x^9 - 2*x^8 - 254*x^7 + 457*x^6 + 21826*x^5
    - 29834*x^4 - 703917*x^3 + 354810*x^2
    + 6210225*x + 6613875
)

ZZT.<T> = PolynomialRing(ZZ)
PX = (
    T^18 - 2*T^17 - 29*T^16 + 57*T^15 - 124*T^14
    + 3716*T^13 + 3083*T^12 - 94215*T^11 + 141450*T^10
    + 601875*T^9 + 3536250*T^8 - 58884375*T^7
    + 48171875*T^6 + 1451562500*T^5 - 1210937500*T^4
    + 13916015625*T^3 - 177001953125*T^2
    - 305175781250*T + 3814697265625
)
assert T^9 * QX(T + 25/T) == PX

E.<theta> = NumberField(QX)
OE = E.ring_of_integers()
expected_discriminant = (
    3^3 * 29 * 10589 * 16451926081 * 24415659240899
)
assert OE.discriminant() == expected_discriminant

basis = OE.basis()
G = matrix(ZZ, 9, 9, lambda i, j: (basis[i] * basis[j]).trace())
assert G.is_positive_definite()

# Sage's QuadraticForm convention is q(v)=v^T A v/2.  LLL merely changes
# the integral basis; `transform` is unimodular.
transform = (2 * G).LLL_gram()
assert abs(transform.det()) == 1
Gred = transform.transpose() * G * transform
qform = QuadraticForm(ZZ, 2 * Gred)
vectors_by_norm = qform.short_vector_list_up_to_length(442)

scalar_norms = {9*n^2 for n in range(-7, 8)}
nonscalar_norms = set()
number_tested = 0

for norm, vectors in enumerate(vectors_by_norm):
    for coords in vectors:
        number_tested += 1
        original = transform * vector(ZZ, coords)
        elt = sum(original[i] * basis[i] for i in range(9))
        assert ZZ((elt^2).trace()) == norm

        roots = elt.minpoly().roots(AA, multiplicities=False)
        bounded = all(abs(root) <= 7 for root in roots)
        if elt in QQ:
            integer = ZZ(elt)
            assert -7 <= integer <= 7
            assert norm == 9 * integer^2
        else:
            nonscalar_norms.add(norm)
            assert not bounded

assert nonscalar_norms == {387, 394, 398, 419, 427, 433, 440}
assert scalar_norms.issubset(
    {norm for norm, vectors in enumerate(vectors_by_norm) if vectors}
)

print("trace-field discriminant:", OE.discriminant())
print("enumerated short vectors:", number_tested)
print("nonscalar trace-square norms:", sorted(nonscalar_norms))
print("verified: only integers -7,...,7 have all conjugates in [-7,7]")
