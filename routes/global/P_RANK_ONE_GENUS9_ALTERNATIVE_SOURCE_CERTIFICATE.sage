# Exact certificate for one OPTIONAL source curve; does not replace file 76.
# Run from the repository root:
# sage -c "load('routes/global/P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE_CERTIFICATE.sage')"
# See P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md for the group-theoretic proof.

F5 = GF(5)
R.<x> = PolynomialRing(F5)
f = x^19 + x^14 + 1
assert f.degree() == 19
assert gcd(f, f.derivative()) == 1
C = HyperellipticCurve(f)
assert C.genus() == 9

# Hasse--Witt matrix. Over F_5, the Frobenius twists of this matrix are
# identical, so its stable rank is the geometric p-rank.
h = f^2
HW = matrix(F5, 9, 9, lambda i, j: h[5*(i+1)-(j+1)])
assert [(HW^j).rank() for j in range(1, 10)] == [5, 4, 3, 2, 1, 1, 1, 1, 1]

Z.<T> = PolynomialRing(ZZ)
P = (
    T^18 - T^17 - 10*T^15 + 30*T^14 - 50*T^13 + 130*T^12
    - 435*T^11 + 925*T^10 - 700*T^9 + 4625*T^8 - 10875*T^7
    + 16250*T^6 - 31250*T^5 + 93750*T^4 - 156250*T^3
    - 390625*T + 1953125
)
assert Z(C.frobenius_polynomial_pari()) == P
assert P.is_weil_polynomial()
P5 = P.change_ring(F5)
T5 = P5.parent().gen()
assert P5 == T5^17*(T5-1)

Q = (
    T^9 - T^8 - 45*T^7 + 30*T^6 + 705*T^5 - 250*T^4
    - 4370*T^3 + 315*T^2 + 8350*T + 2400
)
S.<z> = LaurentPolynomialRing(ZZ)
assert S(P) == z^9*S(Q)(z+5/z)

def factor_degrees(poly, prime):
    reduced = poly.change_ring(GF(prime))
    assert gcd(reduced, reduced.derivative()) == 1
    return sorted([ff.degree() for ff, exponent in reduced.factor()
                   for unused in range(exponent)], reverse=True)

assert factor_degrees(Q, 11) == [9]
assert factor_degrees(P, 11) == [18]
assert factor_degrees(Q, 3) == [8, 1]
assert factor_degrees(Q, 229) == [7, 2]
assert factor_degrees(P, 229) == [14, 4]

# Signed-cycle witnesses; reciprocal pairs are i and i+9.
G = SymmetricGroup(18)
cycle18 = G(tuple(range(1, 19)))
element229 = G(tuple(list(range(1, 8))+list(range(10, 17)))) * G((8, 9, 17, 18))
switch_all = cycle18^9
switch_two = element229^14
assert len(switch_all.cycle_tuples()) == 9
assert all(len(c) == 2 for c in switch_all.cycle_tuples())
assert set(switch_two.cycle_tuples()) == {(8, 17), (9, 18)}

V = VectorSpace(GF(2), 9)
even_vectors = [V.basis()[i]+V.basis()[j] for i in range(9) for j in range(i+1, 9)]
assert V.subspace(even_vectors).dimension() == 8
assert V.subspace(even_vectors+[V([1]*9)]).dimension() == 9

print('PASS: optional genus-9 source y^2=x^19+x^14+1 is smooth and has p-rank 1')
print('PASS: exact PARI Frobenius polynomial and square-free small-prime factorizations')
print('PASS: signed witnesses; the accompanying proof gives the full signed group W_9')
print('Consequently its Jacobian is geometrically absolutely simple with geometric End^0 a degree-18 field')
print('The current pair in file 76 is unchanged')
