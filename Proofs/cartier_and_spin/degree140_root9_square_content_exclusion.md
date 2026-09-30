# Four local scales close the entire positive-content square locus

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_square_content_exclusion.md).
Use the original source, field conventions and curve coordinates in the
[actual-content proof](degree140_root9_actual_content_exclusion.md). Only
the implication selecting a rational scale changes here. The subsequent
global exclusions concern those graphs themselves and require no actual
etale cover.

## Why four rational graphs cover every possible square

The [endpoint-content theorem](degree140_root9_endpoint_content_structure.md)
already excludes the marked branch, common-critical content, two content
sheets above one endpoint, B=C1=0, and every leading-H boundary fibre.
Remaining content is simple on exactly one sheet of a labelled endpoint.
The other sheets have nonzero affine-linear endpoint values in the scale.

Write the translated source near that sheet as
\[
F_\mu=(W^5+Q)(g_0W^3+g_1W^2+g_2W+g_3)
       +\mu V(W^5+Q)^2+E,
\]
with Q beginning mT^3, A=3g_0(0), B=2g_1(0), D_0=g_3(0), and
C1=[T]g_2. On the content curve B, m and V(0) are units. The selected
sheet's first residual coefficient is a quadratic in mu. Its two roots
are the actual small-collision scale mu0 from the earlier proof, and
\[
\mu_1=\frac{A^3B^3+A^5D_0}{V(0)B^5}.
\]
These identities hold in the entire content-curve function field. The
two other sheets have affine-linear residual values, with roots mu2,
mu3 obtained from the same formula by replacing the sheet coordinate Z
by zeta Z and zeta^2 Z. The content equation itself is not rotated.

If none of these four values is chosen, the selected residual has order
one and the other two residuals have order zero at this endpoint.
Their product, the cubic norm, has odd order and cannot be a square.
Thus a square lies on at least one of the four rational graphs. A zero
denominator in an other-sheet formula either prevents that sheet value
from vanishing, or makes it identically zero in mu; the latter is a
second content sheet and was already excluded. Coincident graph values
are retained. No division by their differences is made.

The [four-scale verifier](../../scripts/arithmetic/root9_four_content_scales_20260929.sage)
checks both coefficient identities of the selected quadratic, the two
other-sheet affine identities and their cubic rotations, modulo the
full content equation. Its
[receipt](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/four_scale_factorization.json)
passes at all three endpoints. This is a polynomial identity check,
not a parameter sample.

## Exact global exclusion of the other nine graphs

For each graph mu=N/D, multiply the regular residual by D^2 before
taking its cubic norm. This multiplies the degree140 polynomial by D^6
and preserves squareness on D!=0. In the full rank-twelve content
algebra, the two raw square-tail equations remain the coefficients71
and72 of A(T)^63, where A=T^140 R(1/T). The calculation retains scalar
contents of both equations before projecting in H.

The three mu0 graphs and their74 retained irreducible base fibres are
excluded by the [earlier proof](degree140_root9_actual_content_exclusion.md).
For each of the other nine graphs, the two primitive Sylvester-resultant
degree bounds are1277622 and1278342. Eight Hasse coefficients at every
nonzero element of F_(5^8) uniquely reconstruct them: both bounds are
less than8*(5^8-1). This is global polynomial interpolation with a proved
degree bound, not a finite-field point search. The large interpolation
and raw-support routines were checked against direct arithmetic and
fresh full Sylvester determinants, including all eight Hasse coefficients.

Each of the nine primitive norm pairs has degrees1262106 and1262826.
After restoring scalar contents, their raw gcd has degree1575252;
removing only original poles leaves degree325350. Its whole remaining
support lies in the explicitly retained numerator, denominator and
leading-coefficient norms. Every such base fibre is checked with the
FULL polynomial J(H), both raw tails and the actual H-dependent units.
The following are the numbers of irreducible base fibres:

| Endpoint | mu0 | mu1 | mu2 | mu3 |
| --- | ---: | ---: | ---: | ---: |
| 0 |31|37|36|35|
| 1 |23|25|36|37|
| 2 |20|29|34|28|

Every allowed H-gcd is one. The total base-degree sums are828,1260,1404,
1404 for the four graphs at each endpoint; the largest retained factor
has degree517. The calculation does not discard a whole fibre merely
because one H sheet has a vanishing graph denominator. Consequently no
geometric point remains. An empty geometric support also makes the
localized finite-type square scheme empty, including nilpotents.

## Evidence and limits

The [driver](../../scripts/arithmetic/run_root9_content_square_branches_20260929.py)
and [eight-jet projection source](../../scripts/arithmetic/root9_multijet_projection_20260929.cpp)
are retained locally. For endpoint i, exact data, projection identities,
factorizations and complete fibre outcomes are under i/homogeneous_j
in the [evidence tree](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/),
with j=1,2,3. Each decision.json records excluded=true and no outside
projection support. Branch0 is in homogeneous_0_compact.
The independent
[eight-jet check](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/1/homogeneous_1/hermite_independent_checks.json)
compares fresh complete Sylvester determinants with the reconstructed
polynomials. Prior accepted source and boundary results are reused.

This replaces a possible cancellation between cubic sheets by a finite
union of four exact scale graphs, and excludes the whole union. It does
not address a residual with zero fixed content.
