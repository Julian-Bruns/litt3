# Exact certificate for 88_WIMAN_EDGE_CHAR5_DECK_COUNTEREXAMPLE.md.

k = GF(5)
R.<x,y,z> = PolynomialRing(k, order='degrevlex')

A0 = (x^6 + y^6 + z^6
      + (x^2+y^2+z^2)*(x^4+y^4+z^4)
      - 12*x^2*y^2*z^2)
B0 = (x^2-y^2)*(y^2-z^2)*(x^2-z^2)

point_ideals = [
    Ideal([x+z, y-z]),
    Ideal([x-z, y+z]),
    Ideal([x+z, y+z]),
    Ideal([x-z, y-z]),
]
node_radical = Ideal([x^2-z^2, y^2-z^2])
irrelevant = Ideal([x,y,z])
affine_nodes = [(-1,1), (1,-1), (-1,-1), (1,1)]

# Every nonzero F_5-parameter has precisely the four ordinary nodes.
for tt in [1,2,3,4]:
    F = A0 + tt*B0
    jac = Ideal([F.derivative(x), F.derivative(y), F.derivative(z)])
    jac_sat = jac.saturation(irrelevant)[0]
    assert jac_sat.radical() == node_radical

    f = F(x,y,1)
    for aa,bb in affine_nodes:
        hess = matrix(k, [
            [f.derivative(v).derivative(w)(aa,bb,1) for w in (x,y)]
            for v in (x,y)
        ])
        assert hess.det() == 2

# Cremona involution T, the linear four-cycle L, and phi=L*T.
T1 = -x^2+y^2+z^2+x*y+x*z+y*z
T2 =  x^2-y^2+z^2+x*y+x*z+y*z
T3 =  x^2+y^2-z^2+x*y+x*z+y*z
phi = (T3, -T2, -T1)
rho = (y,z,x)
mult = -(x+y)^2*(x+z)^2*(y+z)^2

assert A0(*phi) == mult*A0
assert B0(*phi) == mult*B0
assert A0(*rho) == A0
assert B0(*rho) == B0

# phi has projective order five as a rational transformation.
cur = (x,y,z)
for unused in range(5):
    cur = tuple(q(*cur) for q in phi)
    common = gcd(list(cur))
    cur = tuple(q//common for q in cur)
assert all(cur[i]*(x,y,z)[0] == cur[0]*(x,y,z)[i] for i in range(3))
assert max(q.degree() for q in cur) == 1

# In the plane, the fixed locus consists of the three base points of T
# and P=(0:2:1). The boundary-cycle argument in the theorem removes the
# three base points on the blowup, leaving P as the unique fixed point.
X,Y,Z = phi
fixed = Ideal([X*y-Y*x, X*z-Z*x, Y*z-Z*y])
fixed_sat = fixed.saturation(irrelevant)[0].radical()
fixed_point_ideals = [
    Ideal([x+z, y-z]),
    Ideal([x-z, y+z]),
    Ideal([x+z, y+z]),
    Ideal([x, y-2*z]),
]
fixed_expected = fixed_point_ideals[0]
for ideal in fixed_point_ideals[1:]:
    fixed_expected = fixed_expected.intersection(ideal)
assert fixed_sat == fixed_expected
assert A0(0,2,1) == 0 and B0(0,2,1) == 2

# The boundary permutations are a 5-cycle and a 3-cycle and generate A5.
Gperm = PermutationGroup([[(1,2,3,4,5)], [(1,3,2)]])
assert Gperm.order() == 60
assert Gperm.is_isomorphic(AlternatingGroup(5))

# Tame Chevalley--Weil packet for signature (2,2,2,3).
G = AlternatingGroup(5)
branch = [
    G('(1,3)(2,5)'),
    G('(1,2)(3,4)'),
    G('(1,4)(2,5)'),
    G('(3,4,5)'),
]
H5 = G.subgroup([G('(1,2,3,4,5)')])
classes = G.conjugacy_classes()

def class_index(g):
    for ii,CC in enumerate(classes):
        if g in CC:
            return ii
    raise ValueError

def value(chi,g):
    return chi[class_index(g)]

def fixed_dim(chi,U):
    return sum(value(chi,g) for g in U)/U.order()

packet = []
for chi in G.character_table().rows():
    degree = ZZ(chi[0])
    if degree == 1:
        continue
    h1_mult = ((len(branch)-2)*degree
               - sum(fixed_dim(chi,G.subgroup([g])) for g in branch))
    if h1_mult:
        packet.append((degree,ZZ(h1_mult),ZZ(fixed_dim(chi,H5))))
assert packet == [(3,2,1),(3,2,1)]

# Cartier on the six-dimensional adjoint space. The matrix is invertible
# for all four nonzero parameters (and is the identity for t=1,4).
S.<u,v> = PolynomialRing(k)
adjoints = [
    1-u^2,
    v-u^2*v,
    v^2-u^2,
    v^3-u^2*v,
    u-u^3,
    u*v^2-u^3,
]
monomials = [u^i*v^j for i in range(4) for j in range(4-i)]
adjoint_matrix = matrix(k, [
    [h.monomial_coefficient(mm) for h in adjoints] for mm in monomials
])

def cartier_numerator(g):
    ans = S.zero()
    for (i,j),cc in g.dict().items():
        if i % 5 == 4 and j % 5 == 4:
            ans += cc*u^((i-4)//5)*v^((j-4)//5)
    return ans

cartier_matrices = {}
for tt in [1,2,3,4]:
    ff = S((A0+tt*B0)(u,v,1))
    columns = []
    for h in adjoints:
        image = cartier_numerator(ff^4*h)
        coeffs = vector(k,[image.monomial_coefficient(mm) for mm in monomials])
        columns.append(adjoint_matrix.solve_right(coeffs))
    CM = matrix(k,columns).transpose()
    assert CM.is_invertible()
    cartier_matrices[tt] = CM
assert cartier_matrices[1] == identity_matrix(k,6)
assert cartier_matrices[4] == identity_matrix(k,6)

def point_counts(tt,nn):
    K = GF(5^nn,'aa')
    T.<xx,yy,zz> = PolynomialRing(K)
    AA = (xx^6 + yy^6 + zz^6
          + (xx^2+yy^2+zz^2)*(xx^4+yy^4+zz^4)
          - 12*xx^2*yy^2*zz^2)
    BB = (xx^2-yy^2)*(yy^2-zz^2)*(xx^2-zz^2)
    FF = AA+K(tt)*BB
    els = list(K)
    plane = sum(1 for aa in els for bb in els if FF(aa,bb,1) == 0)
    plane += sum(1 for aa in els if FF(aa,1,0) == 0)
    plane += ZZ(FF(1,0,0) == 0)

    # Each node has two tangent branches over F_25, conjugate over F_5.
    # Thus normalization changes the count by -4 for odd nn and +4 for
    # even nn.
    normalized = plane + (4 if nn % 2 == 0 else -4)
    return (plane,normalized)

count_table = {
    tt:(point_counts(tt,1),point_counts(tt,2)) for tt in [1,2,3,4]
}
assert count_table == {
    1:((4,0),(76,80)),
    2:((4,0),(46,50)),
    3:((4,0),(46,50)),
    4:((4,0),(76,80)),
}

PR.<Tvar> = PolynomialRing(ZZ)
quotient_L = {}
for tt in [1,2,3,4]:
    ND1 = count_table[tt][0][1]
    ND2 = count_table[tt][1][1]
    trace_D_1 = 6-ND1
    trace_D_2 = 26-ND2
    assert trace_D_1 % 3 == 0 and trace_D_2 % 3 == 0
    trace_X_1 = trace_D_1//3
    trace_X_2 = trace_D_2//3
    e2 = (trace_X_1^2-trace_X_2)//2
    quotient_L[tt] = (1-trace_X_1*Tvar+e2*Tvar^2
                      -5*trace_X_1*Tvar^3+25*Tvar^4)

assert quotient_L[1] == (1-Tvar+5*Tvar^2)^2
assert quotient_L[4] == (1-Tvar+5*Tvar^2)^2
simple_L = 1-2*Tvar+6*Tvar^2-10*Tvar^3+25*Tvar^4
assert quotient_L[2] == simple_L and quotient_L[3] == simple_L

# Exact absolute-simplicity check for t=2,3.
U.<uu> = PolynomialRing(QQ)
frobenius = uu^4-2*uu^3+6*uu^2-10*uu+25
assert frobenius.is_irreducible()
assert frobenius.discriminant() == 2^8*5^4*11
GG = frobenius.galois_group()
assert GG.order() == 8 and GG.structure_description() == 'D4'
Kpi.<pi> = NumberField(frobenius)
assert len(Kpi.automorphisms()) == 2
assert (pi+5/pi).minpoly().degree() == 2

print('nonzero-parameter counts:', count_table)
print('Cartier matrices:')
for tt in [1,2,3,4]:
    print('t =',tt)
    print(cartier_matrices[tt])
print('quotient L-polynomials:', quotient_L)
print('simple Frobenius Galois group:',GG.structure_description())
print('PASS')
