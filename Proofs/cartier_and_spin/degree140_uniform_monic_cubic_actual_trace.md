# Exclude the unique leading-cubic exception by two univariate resultants

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_uniform_monic_cubic_actual_trace.md).
The new global coefficient construction in
[the divided endpoint proof](degree140_divided_endpoint_traces.md)
retains every parameter and uses only original chart-unit denominators.
Set H=-<156117>/<363030>. Specializing the three equations gives
polynomials in q,mu of mu-degrees2,4,5. A common actual scale would be
a common root of these three polynomials.

Take the resultant of the first with each of the other two in mu.
Remove only factors of the original nonzero chart polynomial
q*Psi*a0*(q-1)*(q-<15383>). The two residual univariate polynomials
have degrees680 and850, and their gcd is ONE. Thus they cannot vanish
simultaneously at any allowed geometric q. This includes coefficient
drops: a common root always makes both resultants zero, regardless of
the specialized leading coefficients.

The [exact source](../../scripts/arithmetic/degree140_inverse_eta_exception_resultants_20260930.sage)
retains the specialized equations, the precise removed chart factors,
the two resultant polynomials and their Bezout identity. Evidence is in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/inverse_eta_cubic_exception_resultants.sobj`
with its adjacent JSON receipt. The calculation took3.23 seconds on one
core. A preliminary three-variable localization ideal was stopped after
retaining its inputs; its unfinished calculation is not used. The
univariate resultants avoid that unnecessarily large elimination.

Outside this line, the known V_0 leading coefficient is nonzero. Dividing
by it proves the stated cubic necessary equation, without deciding the
remaining locus.
