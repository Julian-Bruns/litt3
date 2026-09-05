# Exact scalar certificate for FIXED_Y_NONORDINARY_ETALE_DOUBLE_COVER.md
# Run from the repository root with:
#   sage -c "load('routes/global/FIXED_Y_NONORDINARY_ETALE_DOUBLE_COVER_CERTIFICATE.sage')"
#
# This deliberately uses lists of scalars for all 2-by-2 calculations.
# It does not call finite-field dense-matrix rank, kernel, or solve.

F5 = GF(5)
Ru.<r> = PolynomialRing(F5)
F125.<b> = GF(125, modulus=r^3 + 3*r + 3)
Rt.<t> = PolynomialRing(F125)

L = t^25 + t^5 + t
f = L*(L - 1)*(t - 4)

g = (
    t^5 + (2*b^2 + b + 3)*t^4 + (2*b + 1)*t^3
    + (3*b^2 + 4*b)*t^2 + (4*b^2 + 3)*t + b^2
)

assert f % g == 0
h = f // g
assert g.degree() == 5 and h.degree() == 46
assert gcd(g, g.derivative()) == 1
assert gcd(h, h.derivative()) == 1
assert gcd(g, h) == 1

# For y^2=g(t), p=5, genus 2, H_ij=c_(5i-j), where g^2=sum c_j t^j.
gg = g^2
c3, c4, c8, c9 = gg[3], gg[4], gg[8], gg[9]
H = [[c4, c3], [c9, c8]]

def scalar_det(A):
    return A[0][0]*A[1][1] - A[0][1]*A[1][0]

def scalar_mul(A, B):
    return [[sum(A[i][k]*B[k][j] for k in range(2))
             for j in range(2)] for i in range(2)]

def scalar_frob(A, exponent):
    return [[entry^(5^exponent) for entry in row] for row in A]

assert H == [
    [b^2 + 2*b, 3*b^2 + 4*b + 2],
    [4*b^2 + 2*b + 1, b^2 + b + 4],
]
assert scalar_det(H) == 0
assert any(entry != 0 for row in H for entry in row)

Q = scalar_mul(scalar_mul(H, scalar_frob(H, 1)), scalar_frob(H, 2))
assert Q == [
    [3*b^2 + 4*b, 4*b^2 + 4],
    [b^2 + 3, 2*b^2 + b + 1],
]
assert scalar_det(Q) == 0
assert Q[0][0] + Q[1][1] == 1
assert scalar_mul(Q, Q) == Q

# The five finite roots of g are branch roots of f; odd degree adds infinity.
assert len(g.roots(F125)) == 5
assert all(mult == 1 for unused_root, mult in g.roots(F125))

print("verified an explicit genus-2 branch factor of 5-rank one")
print("verified the complementary biquadratic data for an etale double cover of Y")

