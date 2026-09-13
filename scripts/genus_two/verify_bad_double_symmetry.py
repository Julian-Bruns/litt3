#!/usr/bin/env python3
"""Exact PGL2(F5) orbit check on the ten known bad-double labels."""
from itertools import product


def image(matrix, x):
    a, b, c, d = matrix
    num, den = (a, c) if x is None else ((a*x+b) % 5, (c*x+d) % 5)
    return num * pow(den, -1, 5) % 5 if den else None


matrices = set()
for matrix in product(range(5), repeat=4):
    a, b, c, d = matrix
    if (a*d-b*c) % 5 == 0:
        continue
    inv = pow(next(x for x in matrix if x), -1, 5)
    matrices.add(tuple(x*inv % 5 for x in matrix))
assert len(matrices) == 120
stabilizer = {m for m in matrices if image(m, 4) == 4}
assert len(stabilizer) == 20
expected = {
    (None, frozenset((0, 3))), (None, frozenset((1, 2))),
    (0, frozenset((2, None))), (0, frozenset((1, 3))),
    (1, frozenset((0, None))), (1, frozenset((2, 3))),
    (2, frozenset((3, None))), (2, frozenset((0, 1))),
    (3, frozenset((1, None))), (3, frozenset((0, 2))),
}
orbit = {
    (image(m, None), frozenset((image(m, 0), image(m, 3))))
    for m in stabilizer
}
assert orbit == expected, (orbit, expected)
assert all({image(m, x) for x in (0, 1, 2, 3, None)} ==
           {0, 1, 2, 3, None} for m in stabilizer)
print('PASS: all ten exceptional bad-double labels form one PGL2(F5) orbit.')
print('120 projectivities; 20 fix omitted point4; orbit size10.')
print('Finite labels only; filtered and Witt descent is the geometric proof.')
