# A forced actual scale and the complete three-curve exclusion

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_actual_content_exclusion.md).
The argument preserves the actual local etale splitting condition. The
full square-norm locus is a weaker condition and is not asserted empty
by this proof.

## Reduction to three curves with one scale each

Use the proved [common-critical exclusion](degree140_root9_common_critical_exclusion.md),
[marked-branch exclusion](degree140_root9_marked_content_exclusion.md),
and [endpoint-content structure](degree140_root9_endpoint_content_structure.md).
Any remaining positive content is simple and occurs on one sheet
above a root b_i of t. The exceptional B=C1=0 incidences and the
leading-H degree-drop fibres have all-scale exclusions already. For
the latter, the exact source is the
[leading-boundary script](../../scripts/arithmetic/root9_endpoint_leading_boundary_20260929.sage);
its retained fieldwise identities and independent receipts are under
each endpoint's `leading_fibres` directory in the evidence below.

Write H=u/q, q=P(b_i)/Z^3 and J_i(H,Z)=0 for the actual content
curve. Each J_i has degrees(12,90). The selected content sheet is
z=Z on q*z^3=P(x); no arbitrary residue-field identification replaces
these coordinate functions.

The [local etale-scale theorem](root9_content_etale_scale.md) gives
mu=N_i/D_i, with D_i=V0*m^2*B^3 nonzero. Its compact numerator has
H-degree at most8, its denominator at most6, and both arise from
the actual translated source. The exact exporter verifies this
Frobenius fold modulo the FULL content equation. Nonzero scale also
requires N_i nonzero. Thus every actual candidate lies on this one
rational graph, with all required units retained.

## Two polynomial-square equations on the full curve

Work in the rank-twelve algebra K(Z)[H]/(J_i). Substitute the
homogeneous pair(N_i,D_i) into the quadratic residual e(mu). The new
regular function is D_i^2*e(N_i/D_i), and its cubic norm is the
original residual multiplied by D_i^6. This changes no square test
on D_i!=0. The source and the quotient algebra retain all twelve
H sheets.

Let R_i(x) be that degree140 norm and put A_i(T)=T^140*R_i(1/T).
Its leading coefficient is nonzero on the degree140 chart. A square
R_i has the unique normalized square-root expansion, and in
characteristic five this expansion agrees, through order124, with
a nonzero scalar times A_i^63. Therefore the two raw coefficients
[T^71]A_i^63 and [T^72]A_i^63 must vanish. No denominator in the
leading coefficient is introduced by taking these raw powers.

The exact function-field calculation is accelerated by the identity
A^63=A^3*(A^2)^5*(A^2)^25. Only nine A^13 coefficients and three
final tails are needed. This identity is valid in the full quotient
algebra, including specializations with nilpotents. The saved residual
is constructed first; no finite parameter sample is used to infer it.

For each raw tail, clear only the specified original curve poles.
Write the resulting polynomial as c_k(Z)*P_k(H,Z), with scalar
content c_k RETAINED. Form the fixed-degree Sylvester resultant of
J_i and P_k. The determinant identity is valid when leading
coefficients drop; the degree in H of J_i is twelve, so the raw
resultant is c_k^12*Res_H(J_i,P_k). Scalar contents are restored
before computing the gcd of the two projection polynomials.

## Degree-certified projection and every exceptional fibre

The determinant degree bounds for k=71,72 are923814 and924534.
Three Hasse jets at all390624 nonzero elements of K=F_(5^8)
determine each polynomial uniquely, because both bounds are below
3*390624. The interpolation is in powers of Z^390624-1. It computes
global polynomials; it is not a search confined to K-valued parameters.
Fixed Sylvester determinants over the truncated jet ring retain
degree drops and rank defects. The resulting data are:

| Endpoint | Two primitive norm degrees | Raw norm-gcd degree | Degree after original poles | Retained fibre factors |
| --- | --- | ---: | ---: | ---: |
| 0 | 914346,915066 | 1153620 | 237870 | 31 |
| 1 | 914346,915066 | 1153620 | 237870 | 23 |
| 2 | 914346,915066 | 1153620 | 237870 | 20 |

Only original units and the already excluded leading-H fibres are
removed unconditionally. The ENTIRE remaining projection support
lies among the norms of N_i,D_i and the leading coefficient of R_i.
A zero of such a norm is not treated as a unit failure on every sheet.
Instead factor this retained support and examine the whole H fibre
over each irreducible factor. Their total base degrees are828 for
each endpoint; the largest irreducible degrees are176,120,256.

In each residue field, take the full polynomial gcd of J_i and
both RAW tails, including their scalar contents. Remove only the
H factors supported on H*N_i*D_i*leading(R_i), which are genuine
units at the candidate itself. Every one of the31+23+20 fibres
has allowed H-gcd1. Thus no geometric point remains. The projection
retains factor multiplicities; together with the fibre unit tests,
it also leaves no hidden nonreduced component. Equivalently apply
Nakayama to the finite projected algebra. No restriction to rational
H roots or to rational Z values has entered the calculation.

## Reproduction and focused checks

All essential inputs, exact projection coefficients, raw-gcd Bezout
identities, factorization data, complete fibre outcomes and execution
logs are in the [endpoint evidence tree](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/),
under `0`, `1`, `2`, each with `homogeneous_0_compact`.
The [driver](../../scripts/arithmetic/run_root9_actual_content_projection_20260929.py)
records the complete command sequence. Its underlying source includes:

- [homogeneous scale reconstruction](../../scripts/arithmetic/root9_endpoint_homogeneous_scales_20260929.sage),
  [full residual](../../scripts/arithmetic/root9_endpoint_function_field_20260929.cpp),
  and [Frobenius-sparse tails](../../scripts/arithmetic/root9_endpoint_sparse_tails_20260929.cpp);
- [content-preserving rows](../../scripts/arithmetic/root9_curve_gap_content_20260929.cpp),
  [three-jet projection](../../scripts/arithmetic/root9_hermite_projection_20260929.cpp),
  and [raw support reduction](../../scripts/arithmetic/root9_projection_support_20260929.cpp);
- [boundary factorization](../../scripts/arithmetic/root9_gap_boundary_factors_20260929.sage)
  and [complete fibre arithmetic](../../scripts/arithmetic/root9_gap_boundary_fibres_20260929.cpp).

New arithmetic controls include exact Fourier round trips and Horner
comparisons, split-root Sylvester identities including collisions,
three-jet interpolation round trips, and fresh determinant comparisons
after global reconstruction. Independently, Sage compared the sparse
tails with literal exponentiation on three complete degree-twelve
fibres, and compared six full Sylvester determinants in all three
Hasse coefficients. These focused checks passed. Two first attempts
to write the independent JSON receipts failed only on Sage-integer
serialization after their assertions had passed; the serialization
was fixed and the receipts were then produced successfully.
Previously established source and boundary certificates were reused,
not replayed wholesale.

The auxiliary cross-endpoint comparison theorem is not needed here:
each single content point already leads to one of these empty graphs.
The conclusion applies to every positive-content actual cover in
this root-nine chart. It makes no realization or exclusion claim
for a content-free cover.
