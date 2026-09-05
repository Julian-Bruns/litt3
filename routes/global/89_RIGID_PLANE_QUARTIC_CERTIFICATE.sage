# Exact certificate for file 89. Run:
# sage -c "load('routes/global/89_RIGID_PLANE_QUARTIC_CERTIFICATE.sage')"

R.<x,y,z> = PolynomialRing(GF(5))
F = x^4 + y^4 + z^4 + x^3*y + y^3*z + z^3*x + x*y*z^2
derivatives = [F.derivative(v) for v in R.gens()]
for v in R.gens():
    assert R.ideal([F] + derivatives + [v-1]).is_one()

def number_of_projective_points(n):
    field = GF(5^n, name='a')
    # Disjoint charts: z=1; z=0,y=1; and (1:0:0).
    total = sum(1 for a in field for b in field
                if a^4 + b^4 + 1 + a^3*b + b^3 + a + a*b == 0)
    total += sum(1 for a in field if a^4 + 1 + a^3 == 0)
    # F(1,0,0)=1, so the last projective point is absent.
    return ZZ(total)

counts = [number_of_projective_points(n) for n in [1,2,3]]
assert counts == [4,18,160]
power_sums = [5^n + 1 - counts[n-1] for n in [1,2,3]]
leading = [ZZ(1)]
for i in [1,2,3]:
    numerator = -sum(leading[i-j]*power_sums[j-1] for j in [1..i])
    assert numerator % i == 0
    leading.append(ZZ(numerator // i))

S.<T> = PolynomialRing(QQ)
P = T^6 + sum(leading[i]*T^(6-i) for i in [1..3])
P += sum(leading[6-i]*5^(i-3)*T^(6-i) for i in [4..6])
assert P == T^6 - 2*T^5 - 2*T^4 + 18*T^3 - 10*T^2 - 50*T + 125
assert P.change_ring(GF(17)).is_irreducible()
assert ZZ(P[3]) % 5 != 0

K.<pi> = NumberField(P)
assert K.discriminant() == -11^5 * 13^2
assert S((pi^2).minpoly()) == (
    T^6 - 8*T^5 + 56*T^4 - 234*T^3 + 1400*T^2 - 5000*T + 15625
)
assert (pi^2).minpoly().degree() == 6

print('PASS: smooth genus-three plane quartic; counts', counts)
print('PASS: Frobenius polynomial, irreducibility, and ordinarity')
print('PASS: discriminant and full-degree square of Frobenius')
print('Howe-Zhu plus Torelli gives absolute simplicity and Aut(X_0)=1.')
