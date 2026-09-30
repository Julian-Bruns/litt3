"""Exact linear square model on the proved unimodular-coefficient locus.

Let A have degree <=140 and A[0]=L a unit. The model is exact only when
A[16],...,A[23] generate the unit ideal after localizing L; this is certified
for the ACTUAL Rstar by evidence/late_linear_global.json.gz.

Rows are polynomial in the actual A coefficients, affine-linear in the
normalized root B[1],...,B[70], with B[0]=1. No root or scale is specialized.
There are 147 rows; the first 70 have determinant 3*L^166 on B[1..70].
The remaining 77 rows give the complete square scheme, not a relaxation.
"""
from math import comb
from extension import Poly
from residual import sm,sf

INDICES=tuple(n for n in range(1,149) if n!=125)

def order(n):
    if n<=0 or n%125==0:raise ValueError('Index must not be a multiple of 125')
    if n%5:return 1
    if n%25:return 5
    return 25

def hasse(a,r,N):
    return [a[i+r]*(comb(i+r,r)%5) if i+r<len(a) else Poly() for i in range(N)]

def pad(a,N):return list(a[:N])+[Poly() for _ in range(max(0,N-len(a)))]

def power(a,e,N):
    """Exact truncated power using the characteristic-five base-five digits."""
    ans=[Poly(1)]+[Poly() for _ in range(N-1)];k=0
    while e:
        digit=e%5
        if digit:
            f=sf(a,k,N)
            for _ in range(digit):ans=sm(ans,f,N)
        e//=5;k+=1
    return ans

def build(A):
    if len(A)!=141:raise ValueError('All 141 coefficients are required')
    if A[0].degree()!=0:raise ValueError('The leading coefficient must be scale-independent')
    # Building the polynomial rows does not invert L. Interpreting the model
    # uses the original-open leading unit and the separate global certificate.
    P2=sm(A,A,149);P3=sm(P2,A,149)
    H1=[p*3 for p in hasse(A,1,148)]
    H5=sm(P2,hasse(P3,5,141),141)
    term=sf(hasse(A,1,29),1,141)
    H5=[a+2*b for a,b in zip(H5,term)]
    # H25 = A^12 sum_i D^(25-5i)(A^3) (D^i(A^2))^5 + 2(A')^25.
    A12=sm(P2,sf(P2,1,76),76);total=[Poly() for _ in range(76)]
    for i in range(6):
        term=sm(hasse(P3,25-5*i,76),sf(hasse(P2,i,16),1,76),76)
        total=[a+b for a,b in zip(total,term)]
    H25=sm(A12,total,76)
    term=sf(hasse(A,1,4),2,76)
    H25=[a+2*b for a,b in zip(H25,term)]
    H={1:H1,5:H5,25:H25};Ar={1:pad(A,149),5:sf(A,1,149),25:sf(A,2,149)}
    rows=[]
    for n in INDICES:
        r=order(n);row=[]
        for j in range(71):
            a=Ar[r][n-j]*(comb(j,r)%5) if j>=r and 0<=n-j<len(Ar[r]) else Poly()
            if 0<=n-r-j<len(H[r]):a=a-H[r][n-r-j]
            row.append(a)
        rows.append(row)
    return {'A':A,'H':H,'powers':Ar,'rows':rows,'indices':INDICES,
            'hypothesis':'A0 unit and ideal(A16,...,A23)=1 after localizing A0'}

def canonical_root(A):
    L=A[0][0];alpha=[p/L for p in A]
    A2=sm(alpha,alpha,71);A3=sm(A2,alpha,71)
    return sm(sm(A3,sf(A2,1,71),71),sf(A2,2,71),71)

def evaluate(model,B):
    if len(B)!=71 or B[0]!=Poly(1):raise ValueError('Normalized root length must be 71')
    return [sum((a*b for a,b in zip(row,B)),Poly()) for row in model['rows']]

def eliminated(model):
    B=canonical_root(model['A']);values=evaluate(model,B)
    assert not any(values[:70])
    return B,values[70:]

def bordered_minor(model,n):
    """Return the literal 71x71 determinant circuit (not its expansion).
    Rows: first 70 triangular equations, followed by the specified late row.
    Columns: B0,...,B70. On the original open all 77 such minors generate
    exactly the complete square ideal.
    """
    if n not in INDICES[70:]:raise ValueError('Choose one of the 77 late indices')
    return model['rows'][:70]+[model['rows'][INDICES.index(n)]]

def check_pivot(model):
    L=model['A'][0][0];p=1
    for n,row in zip(range(1,71),model['rows'][:70]):
        r=order(n);assert row[n]==Poly((comb(n,r)%5)*(L**r))
        assert not any(row[n+1:]);p=p*(comb(n,r)%5)%5
    assert p==3 and sum(order(n) for n in range(1,71))==166
    return '3*L^166'

def check_hasse_factors(model):
    """Independent series check of the three cleared logarithmic operators."""
    A=model['A']
    C=power(A,63,149)
    for r,N in [(1,148),(5,141),(25,76)]:
        left=sm(power(A,63-r,N),model['H'][r],N)
        right=hasse(C,r,N)
        assert left==right,('cleared Hasse factor',r)
    return True

def polynomial_generators(model):
    """The 77 unit-stripped polynomial circuits G_n, with no L inversion.
    C_j=[T^j]A^63 for j<=70 and G_n=sum_j M_nj C_j.
    The corresponding bordered determinant is exactly 3*L^103*G_n.
    Returns coefficient-ring expressions, not global expanded arrays.
    """
    C=power(model['A'],63,71)
    values=[sum((a*b for a,b in zip(row,C)),Poly()) for row in model['rows']]
    assert not any(values[:70])
    return C,values[70:]
