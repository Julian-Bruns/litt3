#!/usr/bin/env sage
"""Exact small nonordinary active pair; no Witt lift or span is constructed.

Uses only finite fields and rational differentiation. The output records
the full fixed-curve nilpotent tangent test, not a root-count heuristic.
"""
import json
import time

started = time.monotonic()
P = PolynomialRing(GF(5), 'T')
T = P.gen()
minimal = T**4 + 4*T**3 + T**2 + 4*T + 3
assert minimal.is_irreducible()
k = GF(5**4, 't', modulus=minimal)
t = k.gen()
U = PolynomialRing(k, 'u')
u = U.gen()
S = u*(u-1)*(u-2)*(u-3)
R = u-t
F = R*S
assert gcd(F, F.derivative()) == 1 and t**5 != t
D = R*S**2
J = S+2*R*S.derivative()
K = sum(k(binomial(i, 6))*D[i]*u**(i-6)
        for i in range(6, D.degree()+1))
double = gcd(J, J.derivative())
assert double.degree() == 1
h = -double[0]/double[1]
assert J(h) == J.derivative()(h) == 0
assert J.derivative(2)(h) != 0 and F(h) != 0 and K(h) != 0
assert gcd(J, K) == 1
Q = U.fraction_field()
b = Q(1)/(u-h)+Q(3)/(u-t)-Q(F.derivative())/F
r = b.derivative()+b**2
A = K(h)*R*(u-h)**2
E = r.derivative(2)-3*r**2
N = -(E.derivative())**2-3*E*(E.derivative(2)+3*r*E)
assert N == 0 and E == 3*Q(A)/F**2
base = 2*(Q(F.derivative())/F)**2-Q(F.derivative(2))/F
correction = F*(r-base)
assert correction.denominator() == 1
correction = U(correction)
assert correction.degree() == 3 and correction[3] == 2

# Every regular variation is a linear combination of these three.
variations = [Q(u**i)/F for i in range(3)]
linearized = []
for phi in variations:
    e = phi.derivative(2)-r*phi
    linearized.append(-2*E.derivative()*e.derivative()
        -3*e*(E.derivative(2)+3*r*E)
        -3*E*(e.derivative(2)+3*phi*E+3*r*e))
denom = lcm([q.denominator() for q in linearized])
polys = [U(q*denom) for q in linearized]
rows = 1+max(q.degree() for q in polys)
matrix_N = matrix(k, rows, 3, lambda i,j: polys[j][i])
assert matrix_N.rank() == 2
tangent_numerator, remainder = (4*J).quo_rem((u-h)**2)
assert not remainder and tangent_numerator.degree() == 2
assert matrix_N*vector(k, tangent_numerator.list()) == 0
pivot_rows = matrix_N.transpose().pivots()
minor = matrix_N.matrix_from_rows_and_columns(pivot_rows, [0, 1])
assert minor.det() != 0

# Explicit Serre functional on H1(T_C)=k[z^-3,z^-1,z], z=u^2/v.
# With w=1/u, z^2=w/(1+F[4]w+...+F[0]w^5).
LS = LaurentSeriesRing(k, 'z', default_prec=22)
z = LS.gen()
w = z**2
for _ in range(8):
    w = z**2*(1+sum(F[5-i]*w**i for i in range(1, 6)))
uf = 1/w
eta = -z*w.derivative()
contracted = (uf**2+(t+3)*uf+2*t**2+4)*eta
serre_coeffs = [(z**i*contracted)[-1] for i in [-3,-1,1]]
assert uf[2] == -F[3]
generic_serre = [-2*F[3]-2*F[4]*(t+3)-2*(2*t**2+4),
                -2*(t+3), k(-2)]
assert serre_coeffs == generic_serre
assert serre_coeffs == [3*t**2+t+1,3*t+4,k(3)], serre_coeffs

print(json.dumps(dict(
    status='PASS', field_modulus=str(minimal), curve_F=str(F),
    J=str(J), K=str(K), double_root=str(h),
    remaining_factor=str(J//(u-h)**2),
    quartic_numerator=str(A), connection_correction=str(correction),
    tangent_numerator=str(tangent_numerator),
    linearized_matrix_shape=[matrix_N.nrows(), matrix_N.ncols()],
    linearized_nilpotent_rank=int(matrix_N.rank()),
    nilpotent_tangent_dimension=1,
    rank_two_rows=[int(i) for i in pivot_rows],
    rank_two_minor=[[str(c) for c in row] for row in minor.rows()],
    rank_two_minor_determinant=str(minor.det()),
    jacobian_cartier_determinant=str(3*(t+1)**4),
    serre_basis_orders=[-3,-1,1],
    serre_functional=[str(a) for a in serre_coeffs],
    seconds=float(time.monotonic()-started),
    scope='Actual regular active admissible connection on a smooth genus-two curve; no W3 computation or common-cover construction.'
), indent=2, default=int))
