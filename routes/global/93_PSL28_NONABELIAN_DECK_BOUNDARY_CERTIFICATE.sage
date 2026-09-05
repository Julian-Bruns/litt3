# Exact finite-group checks for file 93.
#
# Run from the repository root with
#   sage -c "load('routes/global/93_PSL28_NONABELIAN_DECK_BOUNDARY_CERTIFICATE.sage')"

G = libgap.Image(libgap.IsomorphismPermGroup(libgap.PSL(2, 8)))
assert ZZ(libgap.Size(G)) == 504
assert ZZ(libgap.DegreeAction(G)) == 9
assert ZZ(libgap.Size(libgap.Centre(G))) == 1

H = libgap.Stabilizer(G, 1)
assert ZZ(libgap.Size(H)) == 56
assert str(libgap.StructureDescription(H)) == "(C2 x C2 x C2) : C7"
assert ZZ(libgap.Size(libgap.Normalizer(G, H))) == 56

# HAP computes the Schur multiplier.  The harmless path warnings printed by
# HAP concern optional graph-drawing programs, not this calculation.
assert bool(libgap.LoadPackage("hap"))
assert list(libgap.AbelianInvariantsMultiplier(G)) == []

ct = libgap.CharacterTable(G)
irr = list(libgap.Irr(ct))
degrees = [ZZ(chi[0]) for chi in irr]
perm = libgap.PermutationCharacter(G, H)
fixed_H = [ZZ(libgap.ScalarProduct(ct, chi, perm)) for chi in irr]

assert degrees == [1, 7, 7, 7, 7, 8, 9, 9, 9]
assert fixed_H == [1, 0, 0, 0, 0, 1, 0, 0, 0]

classes9 = [c for c in libgap.ConjugacyClasses(G)
            if ZZ(libgap.Order(libgap.Representative(c))) == 9]
assert len(classes9) == 3

for C in classes9:
    representative = libgap.Representative(C)
    # An order-nine permutation of nine letters moving all letters is a
    # single nine-cycle.
    assert ZZ(libgap.NrMovedPoints(representative)) == 9
    elements = list(libgap.AsList(C))
    assert libgap.Inverse(representative) in elements

# The first order-nine class contains two generators of the full group.
elements = list(libgap.AsList(classes9[0]))
a = elements[0]
assert any(ZZ(libgap.Size(libgap.Group([a, b]))) == 504 for b in elements)

# For inertia I=C9, the unique 8-dimensional H-visible representation has
# no I-fixed vectors.
I = libgap.Subgroup(G, [libgap.Representative(classes9[0])])
ind_I = libgap.InducedClassFunction(libgap.TrivialCharacter(I), G)
fixed_I = [ZZ(libgap.ScalarProduct(ct, chi, ind_I)) for chi in irr]
assert fixed_I == [1, 1, 1, 1, 1, 0, 1, 1, 1]

# The PSL_2(7), D8 boundary calculation in Proposition 93.4.
G7 = libgap.Image(libgap.IsomorphismPermGroup(libgap.PSL(2, 7)))
H7 = libgap.SylowSubgroup(G7, 2)
assert ZZ(libgap.Size(G7)) == 168
assert ZZ(libgap.Size(H7)) == 8
assert str(libgap.StructureDescription(H7)) == "D8"
assert ZZ(libgap.Size(libgap.Normalizer(G7, H7))) == 8

ct7 = libgap.CharacterTable(G7)
irr7 = list(libgap.Irr(ct7))
degrees7 = [ZZ(chi[0]) for chi in irr7]
perm7 = libgap.PermutationCharacter(G7, H7)
fixed_H7 = [ZZ(libgap.ScalarProduct(ct7, chi, perm7)) for chi in irr7]
assert degrees7 == [1, 3, 3, 6, 7, 8]
assert fixed_H7 == [1, 0, 0, 2, 0, 1]

inertia_fixed = {}
for order in [3, 7]:
    C = next(c for c in libgap.ConjugacyClasses(G7)
             if ZZ(libgap.Order(libgap.Representative(c))) == order)
    subgroup = libgap.Subgroup(G7, [libgap.Representative(C)])
    induced = libgap.InducedClassFunction(libgap.TrivialCharacter(subgroup), G7)
    inertia_fixed[order] = [
        ZZ(libgap.ScalarProduct(ct7, chi, induced)) for chi in irr7
    ]

assert inertia_fixed[3] == [1, 1, 1, 2, 3, 2]
assert inertia_fixed[7] == [1, 0, 0, 0, 1, 2]

# Symbolic check of the two multiplicity formulas and the residual cases.
R_ab = PolynomialRing(QQ, names=("a", "b"))
a_var, b_var = R_ab.gens()
m6 = (a_var + b_var - 2)*6 - 2*a_var
m8 = (a_var + b_var - 2)*8 - 2*a_var - 2*b_var
assert m6 == -12 + 4*a_var + 6*b_var
assert m8 == -16 + 6*a_var + 6*b_var
assert [(aa, bb) for aa in range(4) for bb in range(3)
        if 2*aa + 3*bb == 6] == [(0, 2), (3, 0)]
assert m8.subs({a_var: 0, b_var: 2}) == -4
assert (-42 + 14*3 + 18*0) == 0

print("verified: PSL2(8) rank-two counterexample data and PSL2(7)/D8 boundary")
