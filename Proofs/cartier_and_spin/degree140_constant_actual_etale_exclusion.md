# Exact elimination after the actual inverse-discriminant trace reduction

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_constant_actual_etale_exclusion.md).
The input is the actual source in the fixed constant degree140 family,
not a freely chosen critical curve or an abstract square norm.

## The small necessary system

The [divided endpoint trace theorem](degree140_divided_endpoint_traces.md)
and [seven-trace reduction](degree140_chartwise_monic_quadratic_actual_trace.md)
give three quadratic equations and the original cubic. The uniform
[leading-cubic line exclusion](degree140_uniform_monic_cubic_actual_trace.md)
justifies every pivot used here. Their actual vanishing follows either
from the proved collision analysis or from the new
[source-root residue argument](actual_split_critical_residue_integrality.md).

In the coefficient matrix M of the seven-trace reduction, use the unit
coordinate v=q^13*Psi^6*H^-5*mu. The three quadratics are exactly
\[
Q_i(v)=M_{i0}+M_{i1}v+H^4M_{i2}v^2,\qquad i=0,1,2.
\]
The fourth polynomial C(v) is the original cubic expressed in the same
coordinate, after clearing only original unit denominators. Thus every
actual parameter would annihilate all four. Taking three fixed-size
Sylvester resultants gives necessary equations
Res_v(Q0,Q1)=Res_v(Q0,Q2)=Res_v(Q0,C)=0. Coefficient degree drops are
retained by the fixed-size construction; no leading coefficient is
silently inverted.

After removing only powers of H and of the already excluded cubic
leading line, their bidegrees in H,q are
\[
(166,856),\qquad(168,878),\qquad(145,792).
\]
The [exporter](../../scripts/arithmetic/degree140_inverse_eta_export_scale_resultants_20260930.sage)
retains all four source polynomials and proves the support bounds by
the Sylvester determinant. The
[small resultant engine](../../scripts/arithmetic/bivariate_small_resultants_20260930.cpp)
reconstructs these three polynomials by exact rectangular interpolation.
The [importer](../../scripts/arithmetic/degree140_inverse_eta_scale_resultants_import_20260930.sage)
records every removed unit power.

## A finite projection without a geometric sampling assumption

Let the three bivariate equations be R0,R1,R2. Their two H-resultants
have q-degree bounds289556 and255592. These are below390624=5^8-1.
The [projection engine](../../scripts/arithmetic/bivariate_projected_resultants_dft_20260930.cpp)
therefore evaluates on the entire multiplicative group of the explicitly
embedded F_(5^8) and uses its invertible discrete Fourier transform.
The proved degree bounds make this the global polynomial identity,
not a finite-field search. The parameter q=0 is checked separately,
though it is already excluded by the original chart.

At a specialized leading drop the fixed-degree resultant is retained.
If only the first polynomial loses d degrees, multiply the actual
resultant by (-1)^(n*d)*lc(B)^d; if only the second loses d degrees,
multiply by lc(A)^d. If both lose degrees the fixed resultant is zero.
This includes all fourteen degree-drop occurrences in the grid.

The resulting q-polynomials have degrees215693 and189696. Their gcd
has degree74042. An exact Bezout identity is retained. Its two product
degrees are below390624, so a full Fourier evaluation verifies the
identity exactly without expanding large temporary products. The
[FLINT source](../../scripts/arithmetic/projected_resultant_gcd_flint_20260930.cpp)
uses the same explicit field and a single calculation thread.

Remove only factors of q*a0(q)*(q-1)*(q-<15383>), then take the radical
to describe geometric support. The resulting squarefree polynomial
has degree195. Its complete factor degrees over F_(5^8) are
\[
1,1,1,2,2,5,5,6,7,10,20,46,89.
\]
Taking this radical is used only for geometric emptiness; no nilpotent
multiplicity is identified with its reduced value.

## Every projected value lifts only to an excluded boundary

For each factor g, work over the WHOLE field K[q]/(g), specialize the
three bivariate equations, and take their common gcd in H. The
[complete lifting source](../../scripts/arithmetic/degree140_inverse_eta_scale_projection_lift_20260930.sage)
records the specialized equations, raw gcd and all subsequent removed
factors. The raw H-degrees, in the factor order above, are
\[
39,39,0,1,2,1,2,1,1,39,1,1,1.
\]
In every case the raw gcd is supported entirely on factors already
forbidden by the original chart, the proved leading-cubic exclusion,
or the fixed endpoint-content norm. After removing those factors all
thirteen H-gcds are one. This exhausts all195 geometric q-values,
including arbitrary extension fields and specialized coefficient drops.
There is consequently no common zero of R0,R1,R2 on the allowed chart,
and hence no common actual scale for Q0,Q1,Q2,C.

All original constant-family square candidates outside this primitive
chart were already excluded: the nonzero-pivot boundary and the
specified q fibres by
[nonzero-pivot reconstruction](degree140_nonzero_pivot_reduction.md),
a0=0 by [its complete boundary proof](degree140_constant_a0_boundary.md),
and positive fixed content by
[the complete content exclusion](degree140_positive_content_exclusion.md).
Every actual etale source has the required square norm. Thus their
exclusions combine with the new primitive actual-trace exclusion to
give the stated whole constant-degree140 conclusion.

## Evidence and cost

Exact data are under
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/`.
The principal records are `inverse_eta_scale_resultant_inputs.sobj`,
`inverse_eta_scale_resultants.sobj`,
`inverse_eta_scale_projection_resultant_0.bin` and `_1.bin`, the
`inverse_eta_scale_projection_gcd_*` Bezout and squarefree records,
`inverse_eta_scale_projection.sobj`, and all thirteen
`inverse_eta_scale_projection_fibre_*.sobj` files. The compact receipts
are `inverse_eta_scale_resultants.json`,
`inverse_eta_scale_projection.json`,
`inverse_eta_scale_projection_gcd.json`, and
`inverse_eta_scale_projection_lift.json`.

The small scale-resultant construction took5.22 seconds; the full
projection took307.50 seconds on one core. Final gcd, exact Fourier
Bezout verification and squarefree support extraction took259.43
seconds on one core, including removal of the large chart factors.
Factoring the degree195 support and lifting all thirteen complete
fields took210.72 seconds. These are new necessary-system calculations;
no incoming verifier or large historical square ideal was replayed.

Focused review: the same scale coordinate is used in all four equations;
only proved units are removed; fixed resultants keep leading drops;
Fourier interpolation has strict global degree bounds; every irreducible
projected factor is lifted over its complete residue field; and the
conclusion is restricted to actual etale sources in this family.
