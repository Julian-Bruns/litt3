# Extend the local pole bound through the normal parameter surface

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_global_content_denominator_bound.md).
Use the accepted local coefficient construction in Section14.1 of the
[normalization report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md),
the finite common-critical incidence in
[the common-critical exclusion](degree140_common_critical_exclusion.md),
and the new [uniform type-A pole bound](degree140_endpoint_top_trace_formulas.md).
No incoming verification program is replayed.

## The coordinate boundary does not contain a content component

Pass to a finite constant extension splitting all nine endpoint sheets.
At one sheet, R restricted to b=0 is2e*chi^5. Thus a divisorial
component of R=0 could fail to have b invertible only if b and chi
had a common divisorial component. It is enough to exclude a common
factor of their cubic norms at each x-endpoint.

The [new short calculation](../../scripts/arithmetic/degree140_endpoint_coordinate_poles_20260930.sage)
extracts b and chi from the first two source jets, scaling both by w^5.
Each of their cubic norms has bidegree(3,48) in H,w. Their gcd is a
nonzero constant times w^3, at each of the three endpoints. Since w
is already a unit, no common component exists. Coprimality remains true
after a constant field extension: any common geometric component would
give a common factor over a finite extension, and its conjugate product
would contradict the computed gcd over K. This calculation takes about
0.15 seconds on one core. Its exact two norms and gcds are retained in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/endpoint_coordinate_poles.sobj`,
with the adjacent JSON receipt.

Consequently every height-one component of the endpoint-content divisor
has a type-A neighborhood at each sheet responsible for that component.
This is a statement about generic points of parameter divisors. It does
not discard their intersections with the type-B boundary.

## Check valuations at every parameter divisor

Away from N=0, the coefficients of the generic trace are regular at
every parameter point where the critical model has the stated degree
and no common critical-coefficient zero. To recall why, choose sufficiently
many constant scales where the degree140 quotient presentation and its
required inversions are valid. Such scales exist at each relevant ratio.
They remain valid on a neighborhood. Interpolation using the proved
uniform scale-degree bound then constructs each coefficient regularly
there. This argument applies equally to t^k*f*phi^m*v. It is independent
of a type-A local-coordinate choice.

The common-critical incidence is finite over K, so its projection to the
two-dimensional ratio surface has codimension at least two. It therefore
does not remove the generic point of any remaining parameter divisor.
The source presentation and the incoming interpolation argument show that
c_n has no divisorial pole outside N and the units already inverted in B.
In particular the apparent b-denominators cannot persist there.

At a generic point of a component of N=0, the preceding gcd calculation
makes each affected endpoint type A. The local residue bound gives
pole order at most r times the multiplicity of its local factor R.
The proper polar-replacement contribution has no R-denominator. Infinity
introduces only the already inverted H,w,Psi factors. Summing endpoint
contributions cannot increase the largest pole order, while the valuation
of the product Norm(R) is the sum of the nonnegative sheet valuations.
It follows that
\[
\operatorname{ord}_{\mathfrak p}(c_n)
 \ge-r\operatorname{ord}_{\mathfrak p}(N)
\]
at every height-one prime of B, also when several content sheets contribute
to the same parameter divisor.

The localization B of a polynomial ring is normal, and equals the
intersection of its height-one valuation rings inside its fraction field.
The displayed inequalities prove N^r*c_n belongs to B. They also supply
the unique extension across the remaining codimension-two points. The
claim at such points concerns these coefficient functions; no assertion
about a degenerate model's normalization is needed.

The extension B over the corresponding ring in H,q is finite étale with
w^3=q and its cubic action. For any of the accepted homogeneous trace
normalizations, N^r*c_n is invariant after multiplication by its prescribed
power of the unit w. Taking invariants gives the asserted H,q version.

## Why this is a quintic discriminant

In characteristic five, p'(Z)=2u*b*Z+u*chi. On b!=0 its root is
2chi/b and
\[
b^5p(2\chi/b)=\kappa b^5+u\chi^2b^4+2e\chi^5=R.
\]
Therefore Res(p,p')=-(2ub)^5*p(2chi/b)=3u^5R, and division by the
leading coefficient e gives the discriminant. Both sides are polynomial
identities after multiplication by e, so the formula also holds at b=0,
where the derivative is a constant. The fixed-degree convention retains
that boundary automatically.

This result replaces unknown moving denominators by a proved fixed one.
It does not compute all the numerator coefficients, prove their joint
vanishing locus empty, or construct either actual map of a common cover.
