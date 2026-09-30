# Exact projection and all eighteen complete-field lifts

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_root9_actual_etale_exclusion.md).
The accepted source coefficients and earlier boundary exclusions are
inputs. Their historical verification programs were not rerun.

## Necessary equations from actual splitting

The [divided-trace proof](root9_actual_divided_traces.md) gives seven
polynomial scale equations of degrees4,5,5,6,6,7,7. Actual necessity
uses split integral roots on the completion of the actual etale source,
including the factor v at its marked cubic branch. It is stronger than
the square-norm condition alone. The finite endpoint correction is
explicit and uses no new parameter denominator.

For the first four equations use the common unit change
\[
\mu=H^3q^{-7}\Psi^{-3}D^{-3}z.
\]
Clear only original powers of H,q,Psi,D. Pair the quartic with each of
the next three equations and take fixed-degree Sylvester determinants.
Every common scale is a zero of all three resulting bivariate
polynomials. Fixed-degree determinants preserve coefficient drops.
After removing only original unit factors, their (H,q)-bidegrees are
\[
(529,1183),\qquad(597,1331),\qquad(688,1534).
\]
Their exact reconstruction, removed factors and48 fresh coefficient
comparisons are retained. No inference from a generic parameter slice
is made.

## Global projection, including multiplicities

Take two fixed-degree H-resultants, always pairing the first bivariate
polynomial with another. Newton polygon bounds at q=infinity and q=0
prove, after dividing the guaranteed powers q^243506 and q^279540,
degree bounds947414 and1092396. Both are less than
3(5^8-1)=1171872. Three Euler jets at every nonzero element of F_(5^8)
therefore reconstruct the entire polynomials uniquely. The three
Fourier transforms are combined using the invertible three-by-three
Hasse/Euler Vandermonde system for exponents congruent modulo5^8-1.
This is a polynomial identity over the geometric parameter line,
not a search for rational solutions.

At1067 nodes a leading coefficient loses degree. Weierstrass preparation
over the three-jet algebra retains the unit factor and its determinant
norm. No such node is skipped. The exact resulting degrees are
942772 and1087022. After removing the original forbidden q-values
0,118020,10149,64426, the degrees are851169 and981217. Their monic
gcd has degree280352. A retained Bezout identity was verified by four
Hasse/Euler jets on the complete multiplicative group, with a strict
degree bound making this an exact identity.

The squarefree support of that gcd has degree257. Its extraction uses
the new characteristic-five multiplicity-digit recurrence: for monic f,
put g=gcd(f,f'), w=f/g and u=f'/g. The squarefree factors
gcd(w,u-jw'),1<=j<=4, retain precisely the nonzero multiplicity digits.
Remove their j-th powers, take the fifth root, and recurse; combine
supports by lcm. The successive input degrees are
280352,55940,11173,2202,407,70. Exact quotients and roots are retained.
The [algorithm note](../../Research/experiments/projected_radical_digits_20260930.md)
proves this recurrence and records its1.45-second one-core execution.
The preceding generic squarefree routine was stopped after its completed
gcd and Bezout stages; its unfinished stage is not credited.

The degree257 squarefree support factors over F_(5^8) with degrees
\[
1,1,1,1,1,2,2,2,3,3,3,7,10,14,21,35,58,92.
\]
The exact factorization is retained, including every geometric root.

## Every projected field gives only an excluded boundary

For every irreducible q-factor work over its WHOLE residue field,
specialize all three bivariate polynomials, and compute their common
gcd in H. The raw H-degrees, in the factor order displayed above, are
\[
47,1,72,47,46,1,1,1,46,1,47,72,46,46,46,1,1,1.
\]
Every one becomes the unit polynomial after removing only the original
units H,q,Psi,D and the separately excluded H=42135 line. In particular
H=356769 is not removed. Each field record retains the specialized
equations, raw gcd, actual removed factors and final unit. No positive-
degree H factor, whole H-fibre or unknown extension is left untreated.

Thus the three bivariate equations have no common allowed geometric
point, and the first four actual trace equations have no allowed common
scale. The original exceptional-pivot and leading-degree boundaries
were already excluded by the
[nonzero-pivot theorem](degree140_nonzero_pivot_reduction.md) and its
dependencies; the additional fixed q-fibre is covered by
[the full linear-fibre exclusion](degree140_linear_fixed_fibre_exclusion.md).
All positive fixed content is excluded for actual covers by
[the actual content theorem](degree140_root9_actual_content_exclusion.md),
including its marked-branch input. Together these cover the whole
specified root-nine residual-degree140 family.

## Evidence and reproducibility

New exact data are in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/root9_traces/`.
The compact terminal receipt is `actual_scale_projection_lift.json`:
`complete=true`, `complete_exclusion=true`, all18 fields excluded.
Principal evidence comprises the47 rational trace coefficients,
`actual_resultant_inputs.sobj`, `actual_scale_resultants_compressed.sobj`,
the two `actual_scale_projection_resultant_*.bin` files,
the normalized gcd/Bezout binaries,
the `actual_scale_projection_gcd_digits_*` recurrence records,
`actual_scale_projection_factorization.sobj` and all18
`actual_scale_projection_fibre_*.sobj` records.

The [projection notes](../../Research/experiments/root9_small_actual_projection_20260930.md)
give the degree-bound, degree-drop and reconstruction arguments.
Sources are `root9_projection_three_jet_20260930.cpp`,
`projected_resultant_gcd_wide_flint_20260930.cpp`,
`projected_radical_digits_20260930.cpp` and
`root9_actual_scale_projection_lift_20260930.sage`, under scripts/arithmetic.
The projection used two cores for3677.87 seconds; gcd and its exact
Bezout check completed on one core in59.43 seconds; the replacement
radical took1.45 seconds. Complete-field lifting was split into two
disjoint one-core ranges and finished in about19 minutes. At no point
did this continuation use more than the allowed two calculation cores.

The result is a complete actual-source exclusion in one family, not a
solution to the unmarked two-map problem. No new source, endpoint map,
common Galois closure or recognition implication is presumed.
