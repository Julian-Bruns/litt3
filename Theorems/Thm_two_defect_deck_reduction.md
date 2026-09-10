# Two-section etale covers have cyclic five-part and controlled defect carriers

Version1,2026-09-10. Focused medium audit PASS for the nontrivial-action
case and a separate scoped PASS for the trivial-action extension.
Inherited symplectic growth and Witt-descent inputs were not re-audited.
No Lean verification or common-cover exclusion is claimed.

Let k=bar(F5), and let q:Z→Y be a connected finite etale Galois cover
of smooth projective connected curves of genus at least two, with
ACTUAL group G. Let E be a vector bundle on Y with a perfect
omega_Y-valued alternating pairing. Assume

    H0(Y,E)=0,  U=H0(Z,q*E),  dim_k U=2.

Set rho:G→GL(U) and Gamma=rho(G). Every Sylow5 subgroup of G is
cyclic. There is a normal subgroup K of G, of order prime to five,
contained in ker rho, with the following two descriptions.

## Nontrivial five-action

If 5 divides |Gamma|, write |P|=5^a for an actual Sylow subgroup
P of G. Then a>=1, and Gamma is one of

    C10, D10, C2×D10.

Here Dn denotes the dihedral group of ORDER n. The corresponding
quotients G/K are

    C_(2*5^a), D_(2*5^a), C2×D_(2*5^a).

The actual intermediate T_a=Z/K has two sections. Its quotient
Y'=T_a/(PK/K) has one section and is an elementary abelian2 cover
of Y of degree2 or4. There is a distinguished degree-two intermediate
C→Y with one section; Y'→C has degree1 or2 and adds no sections.

In particular, for g(Y)=2 the genera are

    g(C)=3,  g(Y')=3 or5,
    g(T_a)=2*5^a+1 or4*5^a+1.

The faithful image has order at most20, but the CYCLIC exponent a
is not bounded. At a=1, the C10 case is the fiber product of the
double C→Y and an actual cyclic5 cover of Y. The dihedral cases
need not be such a fiber product.

## Trivial five-action

If 5 does not divide |Gamma|, write |P|=5^a, allowing a=0. One may
take K to be the normal prime-to5 complement in ker rho. Then

    G/K ≅ C_(5^a) ⋊ Gamma,

where Gamma acts on C_(5^a) by its determinant character: +1 acts
trivially and -1 by inversion. The faithful two-dimensional
Gamma-representation is semisimple and self-dual, and has no invariant
vectors. Its determinant is quadratic. Its order need not be bounded:
reciprocal characters and dihedral representations allow unbounded
prime-to-five orders.

## Actual indigenous application

For E=E_r, the actual tangent bundle of an admissible active connection,
the section dimensions are the indigenous defects. The map Z→T=Z/K
has prime-to5 degree and preserves the TWO defects. The audited
[descent theorem](Thm_defect_preserving_etale_descent.md) therefore
descends every EXISTING compatible Witt tower along this ORIGINAL map.

Over the selected ordinary genus-two family, the C in the nontrivial
case is one of its ten known bad doubles. If a common span X←Z→Y
has r_X ordinary, its canonical X-source descends to T. Its further
map T→Y is not thereby lifted. Descent through the remaining cyclic
five-power tower, and bounding the remaining prime-to5 image in the
trivial-action branch, are open. A nonordinary opposite connection
or a non-Galois Y-leg is not treated by this application.

[Proof](../Solutions/Sol_two_defect_deck_reduction.md) ·
[Scoped audit](../Research/audits/TWO_DEFECT_FIVE_MONODROMY_AUDIT_2026_09_10.md).
