# Exact finite-group and character checks for file 85.

G = AlternatingGroup(5)
one = G.one()

branch = [
    G('(1,3)(2,5)'),
    G('(1,2)(3,4)'),
    G('(1,4)(2,5)'),
    G('(3,4,5)'),
]
assert [g.order() for g in branch] == [2, 2, 2, 3]
assert prod(branch, one) == one
assert G.subgroup(branch).order() == 60

H = G.subgroup([G('(1,2,3,4,5)')])
N = G.normalizer(H)
assert H.order() == 5
assert N.order() == 10

# Exhibit a distinct conjugate C5 which, together with H, generates A5.
H2 = None
for x in G:
    Hx = H.conjugate(x)
    if Hx != H and G.subgroup(list(H.gens()) + list(Hx.gens())).order() == 60:
        H2 = Hx
        break
assert H2 is not None

# Riemann--Hurwitz for signature (2,2,2,3), then the free C5 quotient.
delta = -2 + 3*QQ(1)/2 + QQ(2)/3
gD = 1 + G.order()*delta/2
gX = 1 + (gD - 1)/H.order()
assert (gD, gX) == (6, 2)

classes = G.conjugacy_classes()
table = G.character_table()

def class_index(x):
    for i, C in enumerate(classes):
        if x in C:
            return i
    raise ValueError('element not in a conjugacy class')

def char_value(row, x):
    return row[class_index(x)]

def fixed_dimension(row, subgroup):
    return sum(char_value(row, x) for x in subgroup) / subgroup.order()

# For a nontrivial real character, the H^1 multiplicity is
# (b-2)dim(V)-sum dim(V^I); half of it is the canonical multiplicity.
positive = []
for row in table.rows():
    degree = ZZ(row[0])
    if degree == 1:
        continue
    inertia_fixed = [fixed_dimension(row, G.subgroup([g])) for g in branch]
    h1_multiplicity = (len(branch)-2)*degree - sum(inertia_fixed)
    assert h1_multiplicity in ZZ and h1_multiplicity >= 0
    canonical_multiplicity = ZZ(h1_multiplicity)/2
    if canonical_multiplicity:
        positive.append((
            degree, canonical_multiplicity,
            fixed_dimension(row, H), fixed_dimension(row, N)
        ))

# Exactly the two Galois-conjugate icosahedral 3-dimensional characters
# occur, once each; each has a one-dimensional C5-fixed line and no
# normalizer-fixed line.
assert positive == [(3, 1, 1, 0), (3, 1, 1, 0)]

print('branch orders:', [g.order() for g in branch])
print('generated group order:', G.subgroup(branch).order())
print('|H|, |N_G(H)|:', H.order(), N.order())
print('g(D), g(D/H):', gD, gX)
print('positive canonical packets:', positive)
print('PASS')
