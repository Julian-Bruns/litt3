"""Exact low-coefficient-degree presentation of the complete square scheme.

A is the reversed degree-140 polynomial; A[0]=L is a unit. B[0]=1.
There are 112 linear differential equations in B[1],...,B[70], and
28 quadratic equations. Coefficients are LINEAR in the actual A_i.
The original ratio and scale parameters remain variables throughout.
"""
N=140
DEGREE_ROOT=70
LINEAR_INDICES=tuple(m for m in range(1,N+1) if m%5)
QUADRATIC_INDICES=tuple(range(5,N+1,5))
assert len(LINEAR_INDICES)==112 and len(QUADRATIC_INDICES)==28

def linear_rows(A):
    """Returns 112 rows on (B_0,...,B_70), where B_0 is fixed to one."""
    if len(A)!=141:
        raise ValueError('A must have all 141 coefficients, including zeros.')
    zero=A[0]*0
    return [[A[m-j]*((3*j-m)%5) if 0<=m-j<=N else zero
             for j in range(DEGREE_ROOT+1)] for m in LINEAR_INDICES]

def root_residual(A,B):
    """E=L*B^2-A, all 141 coefficients. B_0 must be one."""
    if len(A)!=141 or len(B)!=71:
        raise ValueError('Wrong polynomial length.')
    zero=A[0]*0
    return [A[0]*sum((B[i]*B[m-i] for i in
            range(max(0,m-70),min(70,m)+1)),zero)-A[m]
            for m in range(141)]

def differential_values(A,B,full=False):
    """D_m=[T^(m-1)](2*A*B'-A'*B), with fixed degrees.
    full=True returns m=1,...,210, including all degree-drop zeros.
    """
    zero=A[0]*0
    return [sum((A[m-j]*B[j]*((3*j-m)%5) for j in
              range(max(0,m-N),min(70,m)+1)),zero)
              for m in range(1,211 if full else 141)]

def equations(A,B):
    E=root_residual(A,B)
    D=differential_values(A,B)
    return [D[m-1] if m%5 else E[m] for m in range(1,141)]

def verify_transfer(A,B):
    """Checks D=B*E'-2*B'*E and L*B*D=A*E'-A'*E.
    This is an exact check in the supplied coefficient ring, not a field
    inversion or a radical comparison. The universal proof is in REPORT.
    """
    E=root_residual(A,B)
    D=differential_values(A,B,full=True)
    zero=A[0]*0
    assert not E[0], 'This presentation fixes B_0=1.'
    for m in range(1,211):
        rhs=sum((B[i]*E[m-i]*((m-3*i)%5) for i in
             range(max(0,m-N),min(70,m)+1)),zero)
        if D[m-1]!=rhs:
            raise AssertionError(('direct triangular identity',m))
    for m in range(1,281):
        lhs=A[0]*sum((B[i]*D[m-i-1] for i in
             range(max(0,m-210),min(70,m-1)+1)),zero)
        rhs=sum((A[i]*E[m-i]*((m-2*i)%5)
                  for i in range(max(0,m-N),min(N,m)+1)),zero)
        if lhs!=rhs:
            raise AssertionError(('coefficient transfer',m))
    return E,D
