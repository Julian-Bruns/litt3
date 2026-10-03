# Exact arithmetic certificate for file 76.
#
# Run from the repository root with
#   sage -c "load('routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage')"
#
# Sage 10.9 has a coercion bug in CyclicCover.frobenius_polynomial() over
# non-prime finite fields when its cohomology matrix has denominators.  The
# helper below performs the final, standard Weil-bound reconstruction from
# the same q-Frobenius matrix at deliberately excessive p-adic precision.

F5 = GF(5)
Ru.<u> = PolynomialRing(F5)
F25.<a> = GF(25, modulus=u^2 + 4*u + 2)
Rx.<x> = PolynomialRing(F25)

fX = (
    x^10 + (4*a + 2)*x^9 + (a + 4)*x^8 + (3*a + 1)*x^7
    + 3*a*x^6 + 4*a*x^5 + (3*a + 4)*x^4 + a*x^3
    + (3*a + 3)*x^2 + (4*a + 2)*x + (2*a + 1)
)
assert gcd(fX, fX.derivative()) == 1
CX = CyclicCover(3, fX)
assert CX.genus() == 9


def cyclic_q_frobenius_polynomial(C, q, desired_precision=32):
    """Recover det(T-Frob_q) from Sage's p-adic cyclic-cover matrix."""
    C._init_frob(desired_precision)
    frob = C.frobenius_matrix(C._N0)
    reverse_cp = frob.charpoly().reverse()
    p = C.base_ring().characteristic()
    n = C.base_ring().degree()
    genus = C.genus()
    assert q == p^n
    assert Integer(q).is_square()
    sqrt_q = Integer(q).sqrt()

    # reverse_cp[i] is the coefficient of T^(2g-i), known p-adically.
    leading = [ZZ(1)]
    for i in range(1, genus + 1):
        bound = ZZ(binomial(2*genus, i) * sqrt_q^i)
        needed = ceil(log(bound, p))
        coefficient = reverse_cp[i].polynomial()
        # A q-Frobenius characteristic polynomial has rational coefficients.
        assert all(c == 0 for c in coefficient.list()[1:])
        c0 = coefficient[0]
        assert c0.precision_absolute() >= needed
        modulus = p^needed
        lift = ZZ(c0.lift())
        value = lift % modulus
        if value > bound:
            value = -((-lift) % modulus)
        assert abs(value) <= bound
        leading.append(value)

    R.<T> = PolynomialRing(ZZ)
    result = T^(2*genus)
    for i in range(1, genus + 1):
        result += leading[i] * T^(2*genus-i)
    # Functional equation for a q-Weil polynomial.
    for i in range(genus + 1, 2*genus + 1):
        result += leading[2*genus-i] * q^(i-genus) * T^(2*genus-i)
    return result


RZ.<T> = PolynomialRing(ZZ)
PX = (
    T^18 - 2*T^17 - 29*T^16 + 57*T^15 - 124*T^14
    + 3716*T^13 + 3083*T^12 - 94215*T^11 + 141450*T^10
    + 601875*T^9 + 3536250*T^8 - 58884375*T^7
    + 48171875*T^6 + 1451562500*T^5 - 1210937500*T^4
    + 13916015625*T^3 - 177001953125*T^2
    - 305175781250*T + 3814697265625
)
assert cyclic_q_frobenius_polynomial(CX, 25) == PX
assert PX.is_weil_polynomial()
assert PX.change_ring(GF(2)).is_irreducible()

KX.<piX> = NumberField(PX)
disc_KX = -3^11 * 29^2 * 10589^2 * 16451926081^2 * 24415659240899^2
assert KX.discriminant() == disc_KX
for d in [2, 3, 6]:
    assert (piX^d).minpoly().degree() == 18

# The branch-rational genus-25 curve.
Rt.<t> = PolynomialRing(F5)
trace_polynomial = t^25 + t^5 + t
fY = trace_polynomial * (trace_polynomial - 1) * (t - 4)
assert fY.degree() == 51
assert gcd(fY, fY.derivative()) == 1
CY = HyperellipticCurve(fY)
assert CY.genus() == 25

# All finite branch points split over F_125; infinity is the final one.
F125.<b> = GF(125)
facY = fY.change_ring(F125).factor()
assert sum(e*ff.degree() for ff, e in facY) == 51
assert all(ff.degree() == 1 and e == 1 for ff, e in facY)

QY = (
    T^25 - 2*T^24 - 120*T^23 + 236*T^22 + 6300*T^21
    - 12172*T^20 - 190024*T^19 + 360412*T^18 + 3635782*T^17
    - 6767504*T^16 - 45967432*T^15 + 84017092*T^14
    + 387818812*T^13 - 697588276*T^12 - 2152004856*T^11
    + 3830395252*T^10 + 7526742721*T^9 - 13422653422*T^8
    - 15169333376*T^7 + 27936617472*T^6 + 14306622112*T^5
    - 29892350656*T^4 - 2589320704*T^3 + 11661025280*T^2
    - 962499328*T - 933754368
)

# P_Y(T)=T^25 Q_Y(T+5/T), formed without introducing denominators.
Laurent.<z> = LaurentPolynomialRing(ZZ)
PY_laurent = z^25 * Laurent(QY)(z + 5/z)
assert min(PY_laurent.exponents()) >= 0
PY = RZ(PY_laurent)
assert RZ(CY.frobenius_polynomial()) == PY
assert PY.is_weil_polynomial()
assert PY[25] % 5 != 0                    # ordinary
assert PY.change_ring(GF(47)).is_irreducible()


def factor_degrees(poly, prime):
    fp = poly.change_ring(GF(prime))
    assert gcd(fp, fp.derivative()) == 1
    return sorted(
        [factor.degree() for factor, exponent in fp.factor()
                         for unused in range(exponent)],
        reverse=True,
    )


assert factor_degrees(QY, 47) == [25]
assert factor_degrees(QY, 173) == [24, 1]
assert factor_degrees(QY, 467) == [23, 2]

print("verified the explicit genus-9 and genus-25 redesign pair")
print("verified absolute-simplicity certificates for both Jacobians")
print("verified that all 52 hyperelliptic branch points are F_125-rational")
