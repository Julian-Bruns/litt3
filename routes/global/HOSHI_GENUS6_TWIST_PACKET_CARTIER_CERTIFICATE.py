"""All fifteen unramified quadratic twists: exact scalar Cartier computation.

Run with sage -python. No extension-field matrix backend is used.
The geometric basis justification is the same divisor calculation as in
HOSHI_GENUS6_SINGLE_TWIST_P_RANK.md, with q any pair of branch roots.
The reusable twist_data(q) returns the four anti-invariant holomorphic
basis pairs, their Cartier matrix, and four semilinear-image ranks.
"""

from itertools import combinations
from sage.all import GF, PolynomialRing

k = GF(25, "r", modulus=[2, 0, 1])
r = k.gen()
R = PolynomialRing(k, "t")
t = R.gen()
F = 2*t**6 + 2*t**4 + 3*t**2 + 4
A = 2*t**8 + 4*t**6 + 2
d = t**2 + 4
v_jet = 2 + 2*t**2 + 2*t**4


def scalar_rref(rows):
    a = [list(row) for row in rows]
    n, m = len(a), len(a[0])
    pivots = []
    for column in range(m):
        position = len(pivots)
        choices = [j for j in range(position, n) if a[j][column]]
        if not choices:
            continue
        j = choices[0]
        a[position], a[j] = a[j], a[position]
        inverse = 1/a[position][column]
        a[position] = [x*inverse for x in a[position]]
        for i in range(n):
            if i != position:
                coefficient = a[i][column]
                a[i] = [x-coefficient*y for x, y in zip(a[i], a[position])]
        pivots.append(column)
        if len(pivots) == n:
            break
    return a, pivots


def cartier_polynomial(f):
    """Cartier of f(t) dt, coefficients in F25; fifth root equals fifth power."""
    length = max(0, (f.degree()-4)//5 + 1)
    return R(sum(f[5*j+4]**5*t**j for j in range(length)))


def twist_data(q):
    q = R(q)
    assert q.degree() == 2 and F % q == 0 and q[0] != 0
    # A holomorphic anti-form is (a+b*v)dt/(v*h), where h^2=q*e.
    # Write a=q*c, deg c<=4, deg b<=3, and require a+b*v=0 mod t^5
    # at Q0=(0,2). Vanishing at the two Weierstrass points is q|a.
    columns = [[((q*t**j) % t**5)[i] for i in range(5)] for j in range(5)]
    columns += [[((v_jet*t**j) % t**5)[i] for i in range(5)] for j in range(4)]
    rows = [[columns[j][i] for j in range(9)] for i in range(5)]
    echelon, pivots = scalar_rref(rows)
    free = [j for j in range(9) if j not in pivots]
    assert len(free) == 4
    kernel = []
    for j in free:
        c = [k(0)]*9
        c[j] = k(1)
        for i, pivot in enumerate(pivots):
            c[pivot] = -echelon[i][j]
        assert all(sum(c[j]*row[j] for j in range(9)) == 0 for row in rows)
        kernel.append(c)
    basis = [(q*sum(c[j]*t**j for j in range(5)),
              sum(c[5+j]*t**j for j in range(4))) for c in kernel]

    # (q*e)^2=ee0+ee1*v, with e=A+d*v and v^2=F.
    ee0 = q*q*(A*A+d*d*F)
    ee1 = 2*q*q*A*d
    images = []
    for a, b in basis:
        ac = cartier_polynomial(F*F*(a*ee0+b*ee1*F))
        bc = cartier_polynomial(a*ee1+b*ee0)
        assert ac % q == 0 and ac.degree() <= 6 and bc.degree() <= 3
        coordinates = [(ac//q)[i] for i in range(5)] + [bc[i] for i in range(4)]
        image = [coordinates[j] for j in free]
        assert all(sum(image[j]*kernel[j][i] for j in range(4)) == coordinates[i]
                   for i in range(9))
        images.append(image)
    C = [[images[j][i] for j in range(4)] for i in range(4)]
    iterate = [[k(i == j) for j in range(4)] for i in range(4)]
    ranks = []
    for unused in range(4):
        iterate = [[sum(C[i][j]*iterate[j][ell]**5 for j in range(4))
                    for ell in range(4)] for i in range(4)]
        ranks.append(len(scalar_rref(iterate)[1]))
    assert ranks[-1] == ranks[-2]
    return basis, C, ranks


if __name__ == "__main__":
    roots = [x for x in k if F(x) == 0]
    assert len(roots) == 6
    distribution = {}
    lower_rank = set()
    for a, b in combinations(roots, 2):
        q = (t-a)*(t-b)
        basis, C, ranks = twist_data(q)
        gamma_X = 1+ranks[-1]
        distribution[gamma_X] = distribution.get(gamma_X, 0)+1
        if gamma_X == 3:
            lower_rank.add(q)
        complementary_quartic = F//q
        gamma_B_prime = 1+int((complementary_quartic**2)[4] != 0)
        print(q, "p-rank(X)=", gamma_X,
              "anti ranks=", ranks, "p-rank(B')=", gamma_B_prime)
    assert distribution == {5: 13, 3: 2}
    assert lower_rank == {t*t+2*t+4, t*t+3*t+4}
    print("PASS: thirteen twists have p-rank five; two have p-rank three.")
