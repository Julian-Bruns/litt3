# Short infinity jets and one complete finite parameter algebra

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_degree_six_leading_exception_exclusion.md).
All incoming normalized-curve and trace constructions are reused as
scoped inputs; their verification programs were not replayed.

The pole orders of x^3 and y at O are9 and10. The reciprocal bound in
[normalized traces](degree140_normalized_critical_trace.md) makes both
traces have scale degree at most six. Finite points contribute only
through degree five, by the
[proper polar replacement](degree140_fixed_endpoint_residue_traces.md).
Their degree-six coefficients therefore use only O4 and O7, through
\[
[\ell^6]Q_f=-\sum_{P=O_4,O_7}
\operatorname{Res}_P\bigl(f\eta\delta(z)(\Lambda')^2
                         \phi^{-1}\Lambda^{-7}dz\bigr).
\]
This is also why the leading calculation has no moving endpoint
denominator. The exact Laurent-series calculation retains the coefficient
Frobenius and the prescribed sign of eta. Its precision is asserted at
each extracted residue, rather than inferred from a fixed array cutoff.

Normalize the two coefficients by w^6 and w^5 respectively, to obtain
functions of H and q. The new short-series source is
[symbolic_leading_six](../../scripts/arithmetic/degree140_symbolic_leading_six_20260930.sage).
After removing only chart-unit numerator factors, their numerators have
51 and220 terms, of bidegrees(11,39) and(12,47). Their denominator factors
are H^11*Psi^5 and H^11*Psi^6, up to nonzero constants. The omitted
numerator factor is q^4 in each case; it is invertible on the original
open. Twenty-five new independent local-residue fixtures agree with
these expressions. They check this new calculation, not old programs.

Let I be the ideal of these two numerators saturated at
\[
Hq\Psi\,a_0(q)(q-1)(q-\langle15383\rangle).
\]
The [leading-ideal source](../../scripts/arithmetic/degree140_leading_six_ideal_20260930.sage)
computes this exact ideal. It has dimension zero and vector-space
dimension187. Conversion of its reduced basis to lexicographic order
gives
\[
I=(H-h(q),F(q)),\qquad \deg F=187,\quad \deg h\le186.
\]
The polynomial F is squarefree and its irreducible factors have degrees
1,1,5,23,157. Thus all geometric parameter points, including those outside
K, are retained. There is no bounded finite-field point search here.
The exact basis, factors and receipt are produced by
[finite_algebra](../../scripts/arithmetic/degree140_leading_six_finite_algebra_20260930.sage).

For each complete factor field K[q]/(F_i), substitute H=h(q) in the
two already constructed global traces Tr(t*v), Tr(x*t*v). Their
coefficient denominators involve only H,q,Psi, all units in these fields.
The [exception-trace source](../../scripts/arithmetic/degree140_leading_six_exception_traces_20260930.sage)
evaluates those actual rational coefficients, computes their polynomial
gcd in the scale, and saves an explicit extended-gcd identity. In all five
fields the nonzero-scale gcd is one. These identities exclude every
scale over every algebraic extension of those fields, not just rational
scales. The five computations together took approximately87 seconds on
one calculation core.

The exact sources and outputs are under
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/`:
`reciprocal_degree6_invariant.sobj`,
`reciprocal_degree6_leading_locus.sobj`,
`reciprocal_degree6_leading_factors.sobj`,
`reciprocal_degree6_leading_finite_algebra.json`, and
`reciprocal_degree6_exception_0.sobj` through
`reciprocal_degree6_exception_4.sobj`.
The summary `reciprocal_degree6_exception_traces.json` records all five
completed exclusions. The early leading-ideal run saved its mathematical
outputs but failed while serializing a Sage integer in its summary; the
source serialization is corrected, and the separate finite-algebra
receipt is complete. This logging issue does not alter the saved ideal.

Necessity of these two multiplied traces at any entirely ramified
nonzero fibre now excludes the whole leading exception scheme. At every
remaining candidate one of Q_3,Q_y has nonzero degree-six coefficient;
dividing by it gives the claimed chartwise monic equation. Neither that
division nor the finite-stratum exclusion settles the remaining open
parameter locus.
