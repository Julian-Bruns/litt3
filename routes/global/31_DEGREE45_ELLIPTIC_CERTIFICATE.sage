# Exact certificate for a degree-45 generalized-profile leg in characteristic 5.
# Run with: sage routes/global/31_DEGREE45_ELLIPTIC_CERTIFICATE.sage

F5 = GF(5)
Rz.<Z> = PolynomialRing(F5)
k.<z> = GF(25, modulus=Z^2 + 4*Z + 2)

K.<u> = FunctionField(k)
RT.<T> = PolynomialRing(K)
F.<v> = K.extension(T^2 - (u^3 + 1))

# The curve is E: v^2=u^3+1.  The two functions below have divisors
# 6(P_0-O) and 6(P_1-O), respectively.
f0 = v + 2*u^3 + 4
f1 = ((4*z + 3)*u + 2*z + 2)*v \
     + (2*z + 4)*u^3 + z*u^2 + (2*z + 1)*u + 4*z + 2

a = ((2*z + 2)*u^6 + (z + 4)*u^3 + 3*z + 2)*v \
    + 2*u^7 + (2*z + 1)*u^5 + 2*u^4 + 4*u + 2*z + 3
b = (4*z*u^6 + (4*z + 4)*u^3 + (z + 1)*u + 2*z + 2)*v \
    + (z + 2)*u^7 + (3*z + 4)*u^5 + (z + 2)*u^4 \
    + (2*z + 4)*u + 4*z
c = (4*z*u^3 + (z + 3)*u + 2*z)*v \
    + (z + 3)*u^7 + 2*u^5 + (z + 3)*u^4 \
    + (2*z + 1)*u + z + 3

A = f0^5*a
B = f1^5*b
C = c

assert A + B + C == 0
h = -A/C
assert h - 1 == B/C

O = F.places_infinite(1)[0]
Odiv = O.divisor()

df0 = f0.divisor()
df1 = f1.divisor()
P0 = next(P for P, n in df0.dict().items() if n == 6)
P1 = next(P for P, n in df1.dict().items() if n == 6)
assert df0 == 6*P0.divisor() - 6*Odiv
assert df1 == 6*P1.divisor() - 6*Odiv
assert u.valuation(P0) == 1 and (v - 1).valuation(P0) == 3
assert (u - z).valuation(P1) == 1 and (v - (z + 4)).valuation(P1) >= 1
assert len({P0, P1, O}) == 3

# Regard A,B,C as sections of O_E(45O).
DA = A.divisor() + 45*Odiv
DB = B.divisor() + 45*Odiv
DC = C.divisor() + 45*Odiv

def residual(D, high):
    assert D.dict().get(high, 0) == 31
    R = D - 31*high.divisor()
    assert R.degree() == 14
    assert all(n == 1 for n in R.dict().values())
    return R

D0 = residual(DA, P0)
D1 = residual(DB, P1)
Dinf = residual(DC, O)

# There are no base points, and all three residual divisors are geometrically
# reduced (closed points over a finite field are separable).
supports = [set(D.dict()) for D in (DA, DB, DC)]
assert supports[0].isdisjoint(supports[1])
assert supports[0].isdisjoint(supports[2])
assert supports[1].isdisjoint(supports[2])

assert F.derivation()(h) != 0
assert sum(-n*P.degree() for P, n in h.divisor().dict().items() if n < 0) == 45

# This equality verifies the full different, hence also verifies that there
# is no ramification outside the three index-31 points.
Omega = F.space_of_differentials()
assert Omega(h).divisor() == \
       30*P0.divisor() + 30*P1.divisor() - 32*Odiv - 2*Dinf

assert EllipticCurve(F5, [0, 1]).is_supersingular()

print("PASS: a separable degree-45 map on E: v^2=u^3+1 over F_25")
print("P0 = (0,1), P1 = (z,z+4), Pinf = O, z^2+4z+2 = 0")
print("residual closed-point degree patterns:",
      sorted(P.degree() for P in D0.dict()),
      sorted(P.degree() for P in D1.dict()),
      sorted(P.degree() for P in Dinf.dict()))

