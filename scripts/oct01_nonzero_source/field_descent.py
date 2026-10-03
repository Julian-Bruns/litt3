"""Exact batch descent to the alpha-generated degree-eight subfield."""
import numpy as np
from sage.all import GF,matrix


def descend(elements,E,alpha):
    prime=GF(5);B=GF(5**8,'a',modulus=alpha.minimal_polynomial())
    def vector(c):
        out=c.polynomial().list()
        return out+[prime.zero()]*(24-len(out))
    powers=[vector(alpha**i) for i in range(8)]
    A=matrix(prime,24,8,lambda i,j:powers[j][i])
    pivots=list(A.transpose().pivots());assert len(pivots)==8
    inverse=A.matrix_from_rows(pivots).inverse()
    aa=np.array([[int(v) for v in row] for row in A.rows()],dtype=np.uint16)
    ii=np.array([[int(v) for v in row] for row in inverse.rows()],dtype=np.uint16)
    values=np.array([[int(v) for v in vector(c)] for c in elements],dtype=np.uint16)
    coordinates=(values[:,pivots]@ii.T)%5
    assert np.array_equal((coordinates@aa.T)%5,values)
    output=[B([int(v) for v in row]) for row in coordinates]
    return B,output,{'subfield_minimal_polynomial':alpha.minimal_polynomial(),
                     'absolute_basis_matrix':A,'pivot_rows':pivots,'coordinate_inverse':inverse}
