# Complete two-sheet tests and the remaining simple content

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_endpoint_content_structure.md).
The [common-critical theorem](degree140_root9_common_critical_exclusion.md)
and [marked-content theorem](degree140_root9_marked_content_exclusion.md)
already confine possible fixed content to the nine points over t=0.

Fix a root b of t and put H=u/q and q=P(b)/Z3. The actual endpoint
sheet is z=Z, where z3=P(x)/q. The two other sheets replace Z by
zeta*Z and zeta2*Z. The exact local coefficient construction is in
the [endpoint source script](../../scripts/arithmetic/root9_endpoint_content_20260929.sage).
Its retained translated coefficients define A,B,C1 and the local
quintic collision polynomial used in the
[étale-scale proof](root9_content_etale_scale.md).

## The content curves and their exceptional loci

The two constant-in-T residual rows have a common irreducible factor
J(H,Z) of H/Z degrees(12,90), one such curve for each endpoint. Their
other nonunit factors can vanish simultaneously only on the already
excluded common-critical locus. Thus J=0 is exhaustive on the remaining
original chart. The third scale row has order six before dividing
by the fixed T5 factor and adds no constant coefficient equation.

When B=0, the first-jet quintic has derivative m*C1. Hence content
requires C1=0. The complete B=C1=0 incidence, localized only at
Z and the original source denominator, has reduced length36 at
each endpoint. Its irreducible residue degrees are
\[
(2,2,8,10,14),\qquad(1,5,30),\qquad(3,8,25).
\]
All eleven residue blocks have all-scale unit identities. The
[incidence construction](../../scripts/arithmetic/root9_endpoint_B_boundary_20260929.sage)
retains the actual q,u functions; no isomorphism between abstract
residue fields replaces them.

## Excluding two content sheets

For each endpoint solve both J(H,Z)=0 and J(H,zeta*Z)=0. The resultant
in H has degree1688 in Z. Its exact factorization is retained, with
the product checked. On every factor the actual polynomial fibre gcd
is computed, including coefficient drops; original-unit failures are
removed explicitly. The retained H-gcd is linear on every component.
The resulting marked incidence has length1110 at each endpoint, with
residue degrees
\[
\begin{aligned}
b_0:&\quad6,27,60,171,846,\\
b_1:&\quad1,4,11,60,62,972,\\
b_2:&\quad1,2,7,68,74,154,158,183,463.
\end{aligned}
\]
The fixed cyclic orientation covers every unordered pair of distinct
cubic sheets. A point with three content sheets is included as well.
The number1110 counts marked incidences, not presumed distinct ratios.

On each of these twenty complete residue fields, the actual source
is evaluated with q,u as retained coordinate functions. The first
three necessary square tails C71,C72,C73 have a polynomial combination
equal to1 in the free scale. This excludes every geometric scale,
not just scales in the residue field. The identities also exclude
nilpotents. The exact fields and full source are used throughout.

The [projection](../../scripts/arithmetic/root9_endpoint_pair_projection_20260929.sage),
[fibre export](../../scripts/arithmetic/root9_endpoint_pair_fibres_20260929.cpp),
[scale test](../../scripts/arithmetic/root9_fast_scale_test_20260929.cpp),
and [literal identity checker](../../scripts/arithmetic/verify_root9_common_critical_20260929.sage)
are retained. The large-field reduction optimization is checked against
ordinary polynomial arithmetic inside every new residue field. Earlier
completed blocks were preserved when the large-field implementation was
improved. All data and receipts are in the
[three endpoint evidence directories](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/).

## Exact content order

At a remaining content point B is nonzero. In translated coordinates
phi has order three and the critical linear coefficient has order at
least one. The coefficient of mu2 before division by T5 is
V2*Res(phi,D)2. Its leading term is
\[
V(0)^2m^2B^{10}T^6,
\]
which is nonzero. Thus after dividing by T5 the coefficient of T is
a quadratic polynomial in mu with nonzero leading coefficient. The
fixed content is exactly simple. On every noncontent sheet the
constant residual is a nonzero polynomial of degree at most one
in mu, since the quadratic row has no constant term.

This gives the stated structure but does not exclude the single-sheet
curve J=0. All whole-curve computation attempts remain separate from
the completed incidence certificates above.
