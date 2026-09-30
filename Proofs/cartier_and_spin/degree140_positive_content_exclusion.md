# Proof: twelve whole branches and their complete exceptional fibres

[Statement](../../Theorems/cartier_and_spin/degree140_positive_content_exclusion.md).
Use the established [one-sheet chart](degree140_single_content_chart.md)
and [four rational scales](degree140_content_scale_reduction.md).
The received human-readable
[REPORT](../../../litt3-computation-data/one_sheet_content_reply_20260927/extracted/one_sheet_content/REPORT.md)
proves the common algebraic framework and certifies nine branches. The
three missing branches were generated and checked locally without
altering that framework. The [combined coverage record](../../../litt3-computation-data/one_sheet_content_reply_20260927/local_complete_coverage.json)
distinguishes the received evidence from the new certificates.

## The whole-locus reduction

The common-critical and multiple-sheet exclusions make fixed content
squarefree and supported over the three specified endpoints. The
exceptional chart denominator was already completely excluded. On the
remaining chart, endpoint parity restricts the scale to exactly the
four listed rational functions, called small,large0,large1,large2.
A large-branch denominator zero does not give a missed finite scale.

Two additional coordinate boundaries are excluded by exact finite-algebra
unit identities: B1=0 at all three endpoints, and the J=0 degree-drop
boundary at all four scales. These use13 and12 certificates respectively;
the retained B1 algebra dimension is45 and the retained J dimension90.
Their independent local verification passed before the branch calculations.

The surviving one-sheet ring has an integral monic sextic presentation
\[
F(v,S)=S^6+A(v)S^2+B(v)S+C(v),
\qquad (\deg A,\deg B,\deg C)\le(24,29,34).
\]
No irreducibility of F is required. All actual chart and scale denominators
are recorded as opens. The compact residual is exactly
\[
\widehat E=w^{28}D(w\mu)/t^5,\qquad
R=q^{-28}\operatorname{Nm}(\widehat E),\quad q=w^3\ne0.
\]
Universal fixed-degree resultant scaling proves these identities even at
coefficient-degree drops. It preserves the fixed content before selecting
the scale; it does not invert a critical leading coefficient or P.

## Two necessary tails suffice for exclusion

Normalize the degree140 residual at infinity to U(s), with U(0)=1.
Modulo s^73 its unique square root with constant term one is U^63:
\[
(U^{63})^2=U^{126}=U(1+O(s^{125})).
\]
A polynomial square root of degree70 therefore forces its two tail
coefficients C71,C72 to vanish. No converse is used.

For each branch, the exact arithmetic supplies identities in the monic
rank-six algebra over K(v) expressing products with C71,C72 as scalar
polynomials. After stripping the COMPLETE recorded denominator support,
the two scalar polynomials have gcd one, with explicit Bezout identity.
This proves emptiness on that localization.

Every irreducible factor of the support is then checked in its complete
finite algebra. Either the original opens exclude the whole fibre, or
the retained algebra has an explicit unit in(C71,C72). Allowed and removed
factors, an inverse of the open on the former, and nilpotence on the latter
are checked. Nilpotents are retained rather than replaced by reduced points.

The resulting conclusion is global, not merely generic. If I is the tail
ideal in the original open coordinate ring and h the product of support
factors, I[1/h]=(1) makes h nilpotent modulo I. The unit identities modulo
each factor make h a unit modulo I. Hence I=(1). This elementary ring
argument proves the full scheme exclusion without irreducibility or
reducedness assumptions.

## All twelve branches are verified

The original nine branches passed a frozen-release replay. All458
manifest files agreed before and after it; both boundaries and every
global and exceptional-fibre identity passed. Source copies are retained
in [the verification directory](../../scripts/arithmetic/pro_one_sheet_content_20260927/src/verify_release.py).

The remaining branches have the following newly generated certificates:

| Branch | Support degree | Complete support factors | Retained algebra dimension |
| --- | ---: | ---: | ---: |
|211895_large1|319|20|1545|
|211895_large2|319|26|1545|
|211959_large1|319|20|1545|

Each was generated directly from the compact residual and exact chart,
through norm series, tail reconstruction, scalar identities, support
factorization and ALL finite fibres. Each then passed the separate
certificate verifier. The local pipeline used unchanged supplied source,
native LLVM with GMP/OpenMP, and two threads, with assertions enabled.
The three complete runs took approximately300,298,301 seconds.

The [new exact evidence](../../../litt3-computation-data/one_sheet_content_reply_20260927/continuation/one_sheet_content/evidence/)
contains source/input hashes, command records, global identities, scalar
Bezout certificates, support factors and finite-fibre units. The combined
record verifies that these three names and the original nine are exactly
the full3-by4 set, with no duplicate or omitted branch. The original
archive and its explicit partial status have been preserved unchanged.

This closes the positive-content task. It supplies no decision on the
content-free locus and no actual etale common-cover construction.
