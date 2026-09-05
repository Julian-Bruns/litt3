# Exact certificate for file 72.

F = GF(5)
P2.<x,y,z> = ProjectiveSpace(F, 2)

f = (3*x^4 + 2*x^2*y^2 + x*y^3 + 3*x^3*z + 4*x^2*y*z
     + 3*y^3*z + x^2*z^2 + 2*x*y*z^2 + 2*y^2*z^2
     + x*z^3 + 2*y*z^3 + 3*z^4)
X = Curve(f)

assert X.is_smooth()
point_counts = X.count_points(3)
assert point_counts == [7, 31, 145]

R.<T> = QQ[]
P = T^6 + T^5 + 3*T^4 + 9*T^3 + 15*T^2 + 25*T + 125
power_sums = [None] + [5^n + 1 - point_counts[n-1] for n in (1,2,3)]
elementary = [ZZ(1)]
for n in (1,2,3):
    elementary.append(sum((-1)^(i-1) * elementary[n-i] * power_sums[i]
                          for i in range(1, n+1)) // n)
P_from_counts = (T^6 - elementary[1]*T^5 + elementary[2]*T^4
                 - elementary[3]*T^3 + 5*elementary[2]*T^2
                 - 25*elementary[1]*T + 125)
assert P_from_counts == P
assert P.is_irreducible()
assert P.is_weil_polynomial(return_q=True) == (True, 5)

S.<u,v> = PolynomialRing(QQ, 2)
Pu = u^6 + u^5 + 3*u^4 + 9*u^3 + 15*u^2 + 25*u + 125
Pvu = ((v*u)^6 + (v*u)^5 + 3*(v*u)^4 + 9*(v*u)^3
       + 15*(v*u)^2 + 25*v*u + 125)

A = (125*v^6 + 125*v^5 + 105*v^4 + 209*v^3
     + 105*v^2 + 125*v + 125)
B = (125*v^12 + 300*v^11 + 495*v^10 + 604*v^9 + 739*v^8
     + 878*v^7 + 967*v^6 + 878*v^5 + 739*v^4 + 604*v^3
     + 495*v^2 + 300*v + 125)

ratio_resultant = Pu.resultant(Pvu, u)
assert ratio_resultant == 5^9 * (v - 1)^6 * A * B^2
U.<w> = QQ[]
Au = (125*w^6 + 125*w^5 + 105*w^4 + 209*w^3
      + 105*w^2 + 125*w + 125)
Bu = (125*w^12 + 300*w^11 + 495*w^10 + 604*w^9 + 739*w^8
      + 878*w^7 + 967*w^6 + 878*w^5 + 739*w^4 + 604*w^3
      + 495*w^2 + 300*w + 125)
assert Au.is_irreducible() and Bu.is_irreducible()
# Primitive irreducible cyclotomic polynomials are monic.  The primitive
# integral associates of A and B have leading coefficient 125.
assert gcd(Au.coefficients()) == 1 and Au.leading_coefficient() == 125
assert gcd(Bu.coefficients()) == 1 and Bu.leading_coefficient() == 125

# Honda-screen data for Y_71.
ell = 71
assert Mod(5, ell).multiplicative_order() == 5
assert Mod(7, ell).multiplicative_order() == 70
H = {power_mod(5, j, ell) for j in range(5)}
Phi = set(range(1, 36))
counts = []
for i in range(14):
    coset = {(power_mod(7, i, ell) * h) % ell for h in H}
    counts.append(len(coset.intersection(Phi)))

assert counts == [3, 4, 4, 2, 3, 0, 2, 2, 1, 1, 3, 2, 5, 3]
assert all(counts[j:] + counts[:j] != counts for j in range(1, 14))

print("file 72 certificate: PASS")
