# Exact certificate for Proposition 65.3.

F = GF(5)
R.<x> = PolynomialRing(F)
f = x^5 + 4*x^4 + 1
assert gcd(f, f.derivative()) == 1

def point_count(poly, field):
    S.<u> = PolynomialRing(field)
    poly_field = S([field(c) for c in poly.list()])
    count = 1                    # the point at infinity
    for a in field:
        value = poly_field(a)
        if value == 0:
            count += 1
        elif value.is_square():
            count += 2
    return count

N1 = point_count(f, F)
N2 = point_count(f, GF(25))
assert (N1, N2) == (7, 31)

Q.<T> = PolynomialRing(QQ)
s1 = 5 + 1 - N1
s2 = (N2 - 5^2 - 1 + s1^2) // 2
P = T^4 - s1*T^3 + s2*T^2 - 5*s1*T + 5^2
assert P == T^4 + T^3 + 3*T^2 + 5*T + 25

F2 = GF(2)
R2.<T2> = PolynomialRing(F2)
assert R2(P).is_irreducible()

F13 = GF(13)
R13.<T13> = PolynomialRing(F13)
assert R13(P) == (T13 + 3)*(T13 + 6)*(T13^2 + 5*T13 + 5)
assert not F13(5).is_square()

print("smooth genus-two model; point counts:", N1, N2)
print("Weil polynomial:", P)
print("mod-2 irreducible and mod-13 factorization (1,1,2): verified")
