# The fixed-bundle extension fibre is immersed with constant normal bundle

Use `rank_two_extension_space`: C is smooth projective of genus g>=2,
W is stable of rank two with fixed determinant O, deg L=ell>2g,
A=H0(WL), E=H1(L^-2). Let U subset P(A) consist of nowhere-zero sections.

The map f:U->P(E), [u]->[eta_u], is a locally closed immersion, closed
in the open subset where the extension middle bundle is stable. This
is scheme-theoretic, including nonreduced test bases, in any characteristic.

If char k !=2, there is a natural exact tangent sequence

    0 -> T_U -> f* T_P(E) -> H1(End_0 W) tensor O_U ->0.

Thus its actual normal bundle is constant of rank3g-3. No universal
bundle on the stable coarse moduli space or Brauer-class trivialization
is assumed. The scalar line in the universal Hom family is retained.

For the fixed genus-nine extension pencil, U subset P31 immerses in
P55 with normal rank24. Intersecting with ANY linear P31 has local
dimension at least7 AT EACH ADMISSIBLE POINT. Independent differentials
of its24 equations give smooth dimension7 there. Nonemptiness and
transversality at the relevant special fiber are NOT conclusions.
In particular, the weak atlas incidence is not proved smooth or nonempty.

At an admissible eta_u in J subset E, transversality with P(J) is
equivalent to injectivity of

    H0(End_0 W omega) -> E^vee/J^perp,
    phi |-> det(u,phi(u)) mod J^perp.

A kernel of dimension d gives tangent dimension7+d in the fixed case.
For the Bol subspace this is the exact Q(det(u,phi(u))) vanishing test;
injectivity of that particular operator remains unproved.

In characteristic p, the weaker incidence N(u)F(b)=0 on the admissible
locus is scheme-theoretically the Frobenius preimage of the classical
linear section Z=f(U) intersect P(J). Its reduction is the inverse
coefficient-Frobenius twist of Z_red. At a smooth codimension-c point,
the formal local ring is k[[z_1,...,z_m]]/(z_1^p,...,z_c^p). Thus a
transverse genus-nine weak point has transverse length5^24, not that
many distinct points. This conditional multiplicity is NOT an assertion
that the full atlas scheme, which is reduced, has multiplicities.

Version2. Status: author proof,2026-09-07; not independently audited. This is
parameterized extension geometry, not an atlas/common-cover exclusion.
[Proof](../Solutions/Sol_extension_fiber_geometry.md).
