# Exact certificate for 114_HERMITIAN_TWO_LEG_W2_OBSTRUCTION.md.

F5 = GF(5)
PR = PolynomialRing(F5, names=("x",))
x = PR.gen()
F25 = GF(25, name="a", modulus=x**2 + 4*x + 2)
a = F25.gen()

J = matrix(F25, [[0, 0, 1], [0, 1, 0], [1, 0, 0]])
R = matrix(F25, [
    [3, 3*a + 1, 3],
    [4, 4*a + 4, a + 1],
    [4*a + 2, 4*a + 3, a + 3],
])
S = matrix(F25, [
    [4*a + 3, a + 1, 4*a + 2],
    [2*a + 1, 4*a + 2, 3],
    [a + 3, 3*a + 4, 2*a],
])

def conjugate_matrix(M):
    return M.apply_map(lambda z: z**5)

I = identity_matrix(F25, 3)
for M in (R, S):
    assert M.det() == 1
    assert conjugate_matrix(M).transpose() * J * M == J
    assert M**3 == I and M != I
    assert M.charpoly() == x**3 - 1

generated = MatrixGroup([R, S])
assert generated.order() == 378000
assert generated.order() == SU(3, 5).order()
assert generated.order() // 3 == 126000
assert generated(R).is_conjugate(generated(S))

print("PASS: R,S are free-class order-3 unitary elements and generate SU(3,5).")
