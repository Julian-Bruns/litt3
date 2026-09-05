"""Exact single-twist p-rank, using ONLY scalar finite-field linear algebra.

Run: sage -python HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py
Sage's optimized matrix routines with this custom GF25 representation are
deliberately not used: they returned inconsistent kernels/ranks in testing.
Every row operation below uses explicit field-element arithmetic.
"""

from sage.all import GF, PolynomialRing

R0 = PolynomialRing(GF(5),"T")
T = R0.gen()
k = GF(25,name="r",modulus=T**2+2)
r = k.gen()
assert r**2 == 3 and r**5 == -r
R = PolynomialRing(k,"t")
t = R.gen()
F = 2*t**6+2*t**4+3*t**2+4
A = 2*t**8+4*t**6+2
B = t**2+4
q = t**2+r*t+1
jet = 2+2*t**2+2*t**4
branch = t**6+4*t**4+4*t**2+2
assert F.is_squarefree() and branch.is_squarefree()
assert branch.gcd(F) == 1 and branch.gcd(t**2+4) == 1
assert A**2-B**2*F == 4*t**10*branch
assert (jet**2-F) % t**5 == 0
assert (A+B*jet) % t**5 == 0

def scalar_rref(rows):
    """Elementary elimination with no Sage matrices or matrix algorithms."""
    rows = [[k(x) for x in row] for row in rows]
    pivots = []
    if not rows:
        return rows,pivots
    next_row = 0
    for column in range(len(rows[0])):
        candidates = [i for i in range(next_row,len(rows))
                      if rows[i][column] != 0]
        if not candidates:
            continue
        i = candidates[0]
        rows[next_row],rows[i] = rows[i],rows[next_row]
        inverse = 1/rows[next_row][column]
        rows[next_row] = [x*inverse for x in rows[next_row]]
        for i in range(len(rows)):
            if i == next_row:
                continue
            coefficient = rows[i][column]
            if coefficient != 0:
                rows[i] = [a-coefficient*b
                           for a,b in zip(rows[i],rows[next_row])]
        pivots.append(column)
        next_row += 1
        if next_row == len(rows):
            break
    return rows,pivots

def scalar_rank(rows):
    return len(scalar_rref(rows)[1])

def scalar_product(left,right):
    assert len(left[0]) == len(right)
    return [[sum((left[i][s]*right[s][j] for s in range(len(right))),k(0))
             for j in range(len(right[0]))] for i in range(len(left))]

def scalar_nullspace(rows):
    reduced,pivots = scalar_rref(rows)
    width = len(rows[0])
    basis = []
    for free in range(width):
        if free in pivots:
            continue
        c = [k(0)]*width
        c[free] = k(1)
        for i,pivot in enumerate(pivots):
            c[pivot] = -reduced[i][free]
        assert all(sum((x*y for x,y in zip(row,c)),k(0)) == 0
                   for row in rows)
        basis.append(c)
    return basis

# Anti-invariant forms are (a+bv)dt/(vh), with h^2=q(A+Bv),
# deg(a)<=6, deg(b)<=3, q|a, and a+b*jet=0 modulo t^5.
monomials = [(t**i,R(0)) for i in range(7)]
monomials += [(R(0),t**i) for i in range(4)]
constraints = [[((a % q)[i] if i < 2 else (a+b*jet)[i-2])
                for a,b in monomials] for i in range(7)]
raw_basis = scalar_nullspace(constraints)
basis,pivots = scalar_rref(raw_basis)
assert len(basis) == 4 and pivots == [0,1,2,3]

def polynomial_pair(c):
    return (R(sum(c[i]*t**i for i in range(7))),
            R(sum(c[7+i]*t**i for i in range(4))))

def coefficient_vector(a,b):
    assert a.degree() <= 6 and b.degree() <= 3
    return [a[i] for i in range(7)]+[b[i] for i in range(4)]

def Cpoly(poly):
    # In F25 the inverse fifth-power automorphism is again fifth power.
    return R(sum(poly[i]**5*t**((i-4)//5)
                 for i in range(4,poly.degree()+1,5)))

U = q**2*(A**2+B**2*F)
V = q**2*(2*A*B)
columns = []
for c in basis:
    a,b = polynomial_pair(c)
    assert a % q == 0 and (a+b*jet) % t**5 == 0
    AA,BB = a*U+b*V*F, a*V+b*U
    ca,cb = Cpoly(F**2*AA),Cpoly(BB)
    assert ca % q == 0 and (ca+cb*jet) % t**5 == 0
    output = coefficient_vector(ca,cb)
    coordinates = [output[j] for j in pivots]
    reconstructed = [sum((coordinates[i]*basis[i][j] for i in range(4)),k(0))
                     for j in range(11)]
    assert output == reconstructed
    columns.append(coordinates)

M = [[columns[j][i] for j in range(4)] for i in range(4)]
assert M == [[1,0,0,3*r],[2*r,3,4*r,4],
             [1,4*r,4,3*r],[0,0,3*r,3]]
N = [[k(i == j) for j in range(4)] for i in range(4)]
ranks = []
for power in range(1,7):
    N = scalar_product(M,[[x**5 for x in row] for row in N])
    ranks.append(scalar_rank(N))
print("Correct scalar-elimination holomorphic anti-invariant basis:")
for c in basis:
    print(polynomial_pair(c))
print("Cartier matrix (columns are images, inverse-Frobenius semilinear):")
for row in M:
    print(row)
print("Ranks of Cartier iterates 1 through 6:",ranks)
print("Stable anti-invariant rank:",ranks[-1])
print("P-rank of the genus-six twist:",1+ranks[-1])
assert ranks == sorted(ranks,reverse=True)
assert ranks[3:] == [ranks[-1]]*3
assert ranks == [4,4,4,4,4,4]
print("PASS: scalar constraints, Cartier image reconstructions, and stable rank.")
