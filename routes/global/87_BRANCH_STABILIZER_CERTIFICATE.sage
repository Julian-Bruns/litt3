# Exact certificate for the branch-set computation in Proposition 87.10.
#
# Run from the repository root with
#   sage -c "load('routes/global/87_BRANCH_STABILIZER_CERTIFICATE.sage')"

F5 = GF(5)
Ru.<u> = PolynomialRing(F5)
F25.<a> = GF(25, modulus=u^2 + 4*u + 2)
Rx.<x> = PolynomialRing(F25)

f = (
    x^10 + (4*a + 2)*x^9 + (a + 4)*x^8 + (3*a + 1)*x^7
    + 3*a*x^6 + 4*a*x^5 + (3*a + 4)*x^4 + a*x^3
    + (3*a + 3)*x^2 + (4*a + 2)*x + (2*a + 1)
)
assert gcd(f, f.derivative()) == 1

# The two linear and two irreducible quartic factors show that F_(5^8) is
# a splitting field.  Requesting the embedding avoids any implicit choice
# of a copy of F_25 inside it.
K, inclusion = f.splitting_field('b', map=True)
fK = f.map_coefficients(inclusion)
roots = fK.roots(multiplicities=False)
assert len(roots) == 10

# A point of P^1 is represented by a nonzero column (z0,z1).
branch_points = [(z, K.one()) for z in roots] + [(K.one(), K.zero())]
assert len(branch_points) == 11


def projective_matrix(source_triple, target_triple):
    """Return the unique PGL2 matrix carrying one ordered triple to the other."""
    rows = []
    for (p0, p1), (q0, q1) in zip(source_triple, target_triple):
        # det(M*p,q)=0 for M=(A B; C D).
        rows.append([p0*q1, p1*q1, -p0*q0, -p1*q0])
    kernel = Matrix(K, rows).right_kernel()
    assert kernel.dimension() == 1
    A, B, C, D = kernel.basis()[0]
    M = Matrix(K, [[A, B], [C, D]])
    assert M.det() != 0
    return M


def same_projective_point(p, q):
    return p[0]*q[1] == p[1]*q[0]


def acts_on_point(M, p):
    return (M[0, 0]*p[0] + M[0, 1]*p[1],
            M[1, 0]*p[0] + M[1, 1]*p[1])


# A projective transformation is determined by the images of any fixed
# ordered triple.  Therefore the 11*10*9 cases below exhaust the stabilizer
# over the algebraic closure: any such transformation has coefficients in K
# because both triples consist of K-rational points.
source = branch_points[:3]
stabilizers = []
for i in range(11):
    for j in range(11):
        if j == i:
            continue
        for h in range(11):
            if h == i or h == j:
                continue
            target = [branch_points[i], branch_points[j], branch_points[h]]
            M = projective_matrix(source, target)
            if all(any(same_projective_point(acts_on_point(M, p), q)
                       for q in branch_points)
                   for p in branch_points):
                stabilizers.append(M)

assert len(stabilizers) == 1
M = stabilizers[0]
assert M[0, 1] == 0 and M[1, 0] == 0 and M[0, 0] == M[1, 1]

print("verified: the eleven-point branch set has trivial PGL2 stabilizer")
