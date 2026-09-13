"""Exact six-chain section coordinates for acyclic genus-nine V.

pi_*V(O)=O^2 + O(-1)^4; consequently H0(V(16O)) consists of
two polynomial chains of length6 and four of length5. Scalar horizontal
functions use x^5 for one multiplication by the base coordinate x.
"""
from sage.all import matrix, vector


def chain_coordinates(k, su, monomials):
    assert su.nrows() == 32 and su.rank() == 32
    where = {tuple(p): i for i, p in enumerate(monomials)}

    def low(n):
        high = [i for i, (a, b) in enumerate(monomials) if 3*a+10*b > n]
        return su.matrix_from_columns(high).left_kernel().basis_matrix()*su

    def shift(row, n=1):
        out = vector(k, su.ncols())
        for c, (a, b) in zip(row, monomials):
            if c:
                assert (a+5*n, b) in where
                out[where[a+5*n, b]] = c
        return out

    first = low(37)
    level = low(52)
    assert first.nrows() == 2 and level.nrows() == 8
    occupied = matrix(k, first.rows()+[shift(row) for row in first.rows()])
    assert occupied.rank() == 4
    generators = first.rows()
    for row in level.rows():
        test = occupied.stack(matrix(k, [row]))
        if test.rank() > occupied.rank():
            generators.append(row)
            occupied = test
    assert len(generators) == 6 and occupied.rank() == 8
    new = matrix(k, [shift(row, j) for i, row in enumerate(generators)
                    for j in range(6 if i < 2 else 5)])
    piv = list(su.pivots())
    change = new.matrix_from_columns(piv)*su.matrix_from_columns(piv).inverse()
    assert change.rank() == 32 and change*su == new
    return change
