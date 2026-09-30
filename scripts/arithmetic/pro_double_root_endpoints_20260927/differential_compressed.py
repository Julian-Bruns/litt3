"""Fourteen-auxiliary, fraction-free exact square presentation.

A has 141 coefficients and L=A[0] is a unit. Put C3=A^3 mod T^71.
For c0=1 and c1,...,c14, P=(C3*sum(cj*T^(5j))) mod T^71.
The normalized candidate root is B=P/L^3.

Complete equations: 56 linear coefficients of 2*A*P'-A'*P in indices
71..140 not divisible by five, and 28 quadratic coefficients of
P^2-L^5*A in indices 5,10,...,140. No additional localization occurs.
This module supplies a circuit, not expanded global polynomial arrays.
"""
from extension import Poly
from residual import sm,sf
from differential_square import differential_values
LINEAR_INDICES=tuple(m for m in range(71,141) if m%5)
QUADRATIC_INDICES=tuple(range(5,141,5))

def build(A):
    if len(A)!=141 or A[0].degree()!=0:
        raise ValueError('Expected all141 coefficients and scale-independent leading coefficient')
    L=A[0][0]
    # Inversion is only of the original leading-coefficient unit.
    L.inv()
    C3=sm(sm(A,A,71),A,71)
    return {'A':A,'L':L,'C3':C3}

def numerator(model,c):
    if len(c)!=15:raise ValueError('Expected c0,...,c14; c0 is fixed to one for the square scheme')
    C3=model['C3']
    return [sum((C3[n-5*j]*c[j] for j in range(min(14,n//5)+1)),Poly())
            for n in range(71)]

def equations(model,c):
    if c[0]!=Poly(1):raise ValueError('The square scheme fixes c0=1')
    A,L=model['A'],model['L'];P=numerator(model,c)
    DD=differential_values(A,P)
    QQ=sm(P,P,141)
    return ([DD[m-1] for m in LINEAR_INDICES],
            [QQ[m]-A[m]*(L**5) for m in QUADRATIC_INDICES])

def candidate_root(model,c):return [p/(model['L']**3) for p in numerator(model,c)]

def canonical_auxiliaries(model):
    al=[p/model['L'] for p in model['A'][:15]]
    a2=sm(al,al,15);a12=sm(a2,sf(a2,1,15),15)
    c=[p.frob() for p in a12]
    assert c[0]==Poly(1)
    return c

def linear_matrix(model,full=False):
    """56x15 or139x15 homogeneous linear matrix, with c0 later fixed to1.
    full=True uses every D_m for71<=m<=209, including dependent rows.
    No parameter coefficient is inverted to build this matrix.
    """
    indices=tuple(range(71,210)) if full else LINEAR_INDICES
    rows=[[Poly() for _ in range(15)] for _ in indices]
    A,C3=model['A'],model['C3']
    for j in range(15):
        P=[Poly() for _ in range(5*j)]+C3[:71-5*j]
        D=differential_values(A,P,full=full)
        assert not any(D[:70]),'The A^3-Cartier parametrization must kill the first70 differential coefficients'
        for i,m in enumerate(indices):rows[i][j]=D[m-1]
    return indices,rows
