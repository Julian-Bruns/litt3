# The fixed-bundle extension fibre is immersed with constant normal bundle

Let C/k be smooth projective connected of genus g>=2 over an
algebraically closed field. Let W be stable of rank two with fixed
determinant O, and let L have degree ell>0. Put A=H0(WL), E=H1(L^-2),
and let U subset P(A) consist of nowhere-zero sections; U may be empty.
Write eta_u for the class of 0 -> L^-2 -> WL^-1 -> O_C -> 0,
whose maps are u and det(u,-).

The map f:U->P(E), [u]->[eta_u], is a locally closed immersion, closed
in the open subset where the extension middle bundle is stable. This
is scheme-theoretic, including nonreduced test bases, in any characteristic.

If char k!=2 and H1(WL)=0 (in particular if ell>=2g-2), there is a
natural exact tangent sequence

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

Under these normal-bundle hypotheses, at eta_u in J subset E,
transversality with P(J) is
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

Version3,2026-09-14. The immersion uses only positive deg L; the normal
formula uses the stated cohomology vanishing.
[Proof](../../Proofs/atlases/extension_fiber_geometry.md).
