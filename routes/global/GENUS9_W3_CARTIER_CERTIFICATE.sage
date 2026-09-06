"""Exact certificate for the checked W3 and three-point Cartier theorem."""
R = PolynomialRing(ZZ, 'T')
T = R.gen()
P = (T**18-2*T**17-29*T**16+57*T**15-124*T**14
     +3716*T**13+3083*T**12-94215*T**11+141450*T**10
     +601875*T**9+3536250*T**8-58884375*T**7+48171875*T**6
     +1451562500*T**5-1210937500*T**4+13916015625*T**3
     -177001953125*T**2-305175781250*T+3814697265625)
P2 = P.change_ring(GF(2))
assert P2.is_irreducible()
K = GF(2**18, 'alpha', modulus=P2)
assert K.gen().multiplicative_order() == 171
S4 = PolynomialRing(Zmod(4), 'u')
A4 = S4.quotient(S4(P), 'b')
U = T**17+T**16+T**14+T**10+T**8+T**7+T**6+T**2+T
assert (A4.gen()**171-1).lift() == S4(2*U)
assert gcd(U.change_ring(GF(2)), P2) == 1
assert gcd((U+1).change_ring(GF(2)), P2) == 1
R5 = PolynomialRing(GF(5), 'z')
z = R5.gen()
k = GF(25, 'a', modulus=z**2+4*z+2)
a = k.gen()
Rc = PolynomialRing(k, 'c')
c = Rc.gen()
Rx = PolynomialRing(Rc, 'x')
x = Rx.gen()
F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
     +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2
     +(4*a+2)*x+(2*a+1))
Q = F*(x-c)**32
u, v = Q[34], Q[39]
assert u % v == (2*a+1)*(c+1)
assert v(-1) == 4*a+1 != 0
assert gcd(u, v) == 1
print('PASS: two-step Frobenius criterion and three-point Cartier obstruction.')
