# Exact small-prime certificate for file 98.
# Run: sage -c "load('routes/global/98_SIGNED_FROBENIUS_CERTIFICATE.sage')"
# The polynomial is copied from file 76; no large number-field computation.

R.<T> = PolynomialRing(ZZ)
Q = (
    T^25 - 2*T^24 - 120*T^23 + 236*T^22 + 6300*T^21
    - 12172*T^20 - 190024*T^19 + 360412*T^18 + 3635782*T^17
    - 6767504*T^16 - 45967432*T^15 + 84017092*T^14
    + 387818812*T^13 - 697588276*T^12 - 2152004856*T^11
    + 3830395252*T^10 + 7526742721*T^9 - 13422653422*T^8
    - 15169333376*T^7 + 27936617472*T^6 + 14306622112*T^5
    - 29892350656*T^4 - 2589320704*T^3 + 11661025280*T^2
    - 962499328*T - 933754368
)
S.<z> = LaurentPolynomialRing(ZZ)
P = R(z^25*S(Q)(z+5/z))

def degrees(poly, prime):
    f = poly.change_ring(GF(prime))
    assert gcd(f, f.derivative()) == 1
    return sorted([factor.degree() for factor, exponent in f.factor()
                   for unused in range(exponent)], reverse=True)

assert degrees(Q,47) == [25]
assert degrees(P,47) == [50]
assert degrees(Q,173) == [24,1]
assert degrees(Q,467) == [23,2]
assert degrees(P,467) == [46,4]

# Model the two signed Frobenius cycle types on 50 roots.
# Pairs are i and i+25, with i in {0,...,24}.
G = SymmetricGroup(50)
cycle50 = G(tuple(list(range(1,26)) + list(range(26,51))))
cycle46 = tuple(list(range(1,24)) + list(range(26,49)))
cycle4 = (24,25,49,50)
element467 = G(cycle46)*G(cycle4)
switch_all = cycle50^25
switch_two = element467^46
assert len(switch_all.cycle_tuples()) == 25
assert all(len(c) == 2 for c in switch_all.cycle_tuples())
assert set(switch_two.cycle_tuples()) == {(24,49),(25,50)}

V = VectorSpace(GF(2),25)
pair_vectors = [V.basis()[i]+V.basis()[j]
                for i in range(25) for j in range(i+1,25)]
assert V.subspace(pair_vectors).dimension() == 24
assert V.subspace(pair_vectors+[V([1]*25)]).dimension() == 25

print('PASS: square-free Frobenius factorization degrees')
print('PASS: power 46 switches two pairs; power 25 switches all 25')
print('PASS: conjugate pair switches plus all-pairs switch span rank 25')
print('Together with the proof: full signed group and K_ab = Q.')
