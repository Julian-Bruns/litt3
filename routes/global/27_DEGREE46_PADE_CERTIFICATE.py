"""Exact Sage certificate for Lemma 27.2."""

from sage.all import GF, PolynomialRing, binomial, matrix, vector


field = GF(5)
ring = PolynomialRing(field, "t")
t = ring.gen()

# Columns are a_0,...,a_15,b_0,...,b_15. Rows kill degrees 16,...,46
# in t^31 A - (t-1)^31 B.
system = matrix(field, 31, 32)
for row, degree in enumerate(range(16, 47)):
    for i in range(16):
        if degree == 31 + i:
            system[row, i] = 1
        j = degree - i
        if 0 <= j <= 31:
            system[row, 16 + i] = -((-1) ** (31 - j)) * binomial(31, j)

rows = [0, 1, 2, 3, 4, 5] + list(range(9, 31))
columns = list(range(22)) + list(range(26, 32))
assert system.matrix_from_rows_and_columns(rows, columns).det() == 1
assert system.rank() == 28


def coefficient_vector(P):
    A = (t - 1) ** 6 * P
    B = t**6 * P
    C = t**6 * (t - 1) ** 6 * P
    assert t**31 * A - (t - 1) ** 31 * B == C
    return vector(
        field,
        [A[i] for i in range(16)] + [B[i] for i in range(16)],
    )


claimed_kernel = matrix(field, [coefficient_vector(t**i) for i in range(4)])
assert claimed_kernel.rank() == 4
assert claimed_kernel.row_space() == system.right_kernel()

print("verified: every degree-46 Padé solution cancels to t^25")
